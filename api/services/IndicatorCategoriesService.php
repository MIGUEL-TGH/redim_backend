<?php
// SRP (Single Responsibility Principle)
declare(strict_types=1); // Modo estricto de tipos
require_once "models/BaseModel.php";

class IndicatorCategoriesService {
  private const TABLE = 'indicator_categories';
  //--------------------private access CURD-------------------------------------------
  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      if (!preg_match("/^[-\w\s_.,\/():;%&áéíóúÁÉÍÓÚñÑ]{1,250}$/", $data['params']['name'])) {
        throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el nombre del indicador');
      }

      $level = $data['params']['level'] ?? null;
      if ($level !== null) {

        $level = (int) $level;

        // Límite máximo de caracteres
        if (($level) > 50) {
          throw new ValidationException([
            'level' => 'Máximo 50 caracteres permitidos'
          ]);
        }

        // Validar estructura estricta: numero,numero (sin espacios)
        if (!preg_match('/^\d+$/', (string)$level)) {
          throw new ValidationException([
            'level' => 'El formato del nivel jerárquico no cumple con el formato requerido (solo números sin espacios) [0-99]'
          ]);
        }
      }
    }
  }
  private static function getById(int $id): array {
    $sql = 
    " SELECT 
        ic.id,
        ic.name,
        
        i.name AS indicator_name,
        ic.indicator_id,

        parent.name AS parent_name,
        ic.parent_id,

        ic.level,
        ic.status

      FROM indicator_categories AS ic

      INNER JOIN indicators AS i 
        ON i.id = ic.indicator_id

      LEFT JOIN indicator_categories AS parent 
        ON parent.id = ic.parent_id

      WHERE ic.id = ?
    ";

    $item = BaseModel::query($sql, [$id], 'one');

    if (!$item) {
      throw new NotFoundException('Item not found');
    }

    return [
      'id' => (int) $item['id'],
      'name' => $item['name'],
      
      'indicator_id' => (int) $item['indicator_id'],
      'indicator_name' => $item['indicator_name'],

      'parent_id' => (int) $item['parent_id'],
      'parent_name' => $item['parent_name'],
      
      'level' => $item['level'],
      'status' => (bool) $item['status']
    ];
  }
  private static function insert(array $params): array {
    // -------------------------------------------------------------------------
    $tz = new DateTimeZone('America/Mexico_City');
    $now = new DateTime('now', $tz);
    $created_at = $now->format('Y-m-d H:i:s');

    $params['created_at'] = $created_at;
    // -------------------------------------------------------------------------

    $insert = BaseModel::setInsert(self::TABLE, $params);

    if ($insert['status'] !== 200) {
      throw new ValidationException([], $insert['alert'] ?? 'Error');
    }

    return [
      'task' => 'saved_item',
      'item' => self::getById((int)$insert['id'])
    ];
  }
  private static function update(array $params): array {
    // -------------------------------------------------------------------------
    $parentId = isset($params['parent_id']) && (int)$params['parent_id'] > 0
    ? (int)$params['parent_id']
    : null;

    $params['parent_id'] = $parentId;
    // -------------------------------------------------------------------------

    self::updateInternal($params);

    return [
      'task' => 'updated_item',
      'item' => self::getById((int)$params['id'])
    ];
  }
  private static function changeStatus(array $params): array {
    self::updateInternal($params);

    return [
      'task' => 'status_updated',
      'id' => (int)$params['id'],
      'status' => (bool)$params['status']
    ];
  }
  private static function updateInternal(array $params): void {
    $update = BaseModel::setUpdate(self::TABLE, $params);

    if ($update['status'] !== 200) {
      throw new ValidationException([], $update['alert'] ?? 'Error en actualización');
    }
  }
  //--------------------private access Constructor de nodos de indicadores-------------------------------------------
  //--------------------------------------------------------------- 
  private static function getCategories($indicatorId): array {
      $sql = 
        "SELECT
          i.id   AS indicator_id,
          i.name AS indicator_name,

          ic.id        AS category_id,
          ic.parent_id,
          ic.name      AS category_name,
          ic.level,
          ic.sort_order

        FROM indicators i
        INNER JOIN indicator_categories ic
          ON ic.indicator_id = i.id
        WHERE
          i.status = ?
          AND ic.status = ?
          AND i.id = ?
        ORDER BY
          i.id,
          ic.level,
          ic.sort_order,
          ic.name;
      ";

      // $sql = 
      // "SELECT
      //   i.id   AS indicator_id,
      //   i.name AS indicator_name,

      //   ic.id        AS category_id,
      //   ic.parent_id,
      //   ic.name      AS category_name,
      //   ic.level,
      //   ic.sort_order

      // FROM indicators i
      // INNER JOIN indicator_categories ic
      //     ON ic.indicator_id = i.id
      // WHERE i.status = ?
      //   AND ic.status = ?
      //   AND i.id = ?
      //   AND NOT EXISTS (
      //       SELECT 1
      //       FROM indicator_categories child
      //       WHERE child.parent_id = ic.id
      //   )
      // ORDER BY i.name, ic.sort_order;";



      $rows = BaseModel::query($sql, [1, 1, $indicatorId], 'all');
      return $rows;
  }
  private static function getParentsNode($indicatorId): array {
      $sql = 
      " SELECT DISTINCT
          ic.parent_id AS id
        FROM indicator_categories ic
        WHERE ic.indicator_id = ?
          AND ic.parent_id IS NOT NULL
        ORDER BY ic.parent_id;
      ";

      $rows = BaseModel::query($sql, [$indicatorId], 'all');
      return $rows;
  }
  private static function fetchCategoryIdsWithData(): array {
      $sql = 
      "SELECT DISTINCT category_id
        FROM indicator_category_details
        WHERE status = ?
      ";

      $rows = BaseModel::query($sql, [1], 'all');

      return array_column($rows, 'category_id', 'category_id');
  }
  private static function indexCategories(array $rows): array{
      $categories = [];

      foreach ($rows as $row) {
          $id = (int)$row['category_id'];

          if (!isset($categories[$id])) {
              $categories[$id] = [
                  'id'        => $id,
                  'title'     => $row['category_name'],
                  'parent_id' => $row['parent_id'] !== null ? (int)$row['parent_id'] : null,
                  'children'  => []
              ];
          }
      }

      return $categories;
  }
  private static function buildCategoryTree(array &$categories): array {
    $tree = [];

    foreach ($categories as $id => &$node) {
      if ($node['parent_id'] === null) {
        $tree[] = &$node;
      } else {
        if (isset($categories[$node['parent_id']])) {
          $categories[$node['parent_id']]['children'][] = &$node;
        }
      }
    }

    return $tree;
  }
  private static function indexIndicators(array $rows): array {
    $indicators = [];

    foreach ($rows as $row) {
      $id = (int)$row['indicator_id'];

      if (!isset($indicators[$id])) {
        $indicators[$id] = [
          'id'       => $id,
          'title'    => $row['indicator_name'],
          'children' => []
        ];
      }
    }

    return $indicators;
  }
  private static function mapCategoryToIndicator(array $rows): array {
      $map = [];

      foreach ($rows as $row) {
          $map[(int)$row['category_id']] = (int)$row['indicator_id'];
      }

      return $map;
  }
  private static function assignTreeToIndicators( array &$indicators, array $categoryTree, array $categoryToIndicatorMap): array {
    foreach ($categoryTree as $node) {
      $categoryId = $node['id'];

      if (isset($categoryToIndicatorMap[$categoryId])) {
        $indicatorId = $categoryToIndicatorMap[$categoryId];
        $indicators[$indicatorId]['children'][] = $node;
      }
    }
    return array_values($indicators);
  }
  private static function includeParentCategories(array $categories, array $validIds): array {
      foreach ($validIds as $id => $_) {
          $current = $categories[$id]['parent_id'] ?? null;

          while ($current !== null) {
              if (isset($validIds[$current])) break;
              $validIds[$current] = true;
              $current = $categories[$current]['parent_id'] ?? null;
          }
      }

      return $validIds;
  }
  private static function filterCategories(array $categories, array $validIds): array {
    return array_intersect_key($categories, $validIds);
  }

  //--------------------public access--------------------------------------------
  public static function setCRUD(array $data): array {
    self::validate($data);

    return match ($data['task']) {
      'insert' => self::insert($data['params']),
      'update' => self::update($data['params']),
      'status' => self::changeStatus($data['params']),
      default => throw new ValidationException([], 'Tipo de tarea no encontrado')
    };
  }
  public static function getAllData(): array {
    try {
      $sql =
      "SELECT 
          ic.id,
          ic.name,
          
          i.name AS indicator_name,
          ic.indicator_id,

          parent.name AS parent_name,
          ic.parent_id,

          ic.level,
          ic.status

        FROM indicator_categories AS ic

        INNER JOIN indicators AS i 
          ON i.id = ic.indicator_id

        LEFT JOIN indicator_categories AS parent 
          ON parent.id = ic.parent_id

        ORDER BY ic.indicator_id, ic.level, ic.sort_order;
      ";

      $items = BaseModel::query($sql, [], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name'],
          
          'indicator_id' => (int) $item['indicator_id'],
          'indicator_name' => $item['indicator_name'],

          'parent_id' => (int) $item['parent_id'],
          'parent_name' => $item['parent_name'],
          
          'level' => (int) $item['level'],
          'status' => (bool) $item['status']
        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
  public static function getAllDataActive(): array {
    try {
      $sql = 
      " SELECT id, name
        FROM indicators
        WHERE status = ?
        ORDER BY id ASC
      ";

      $items = BaseModel::query($sql, [1], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name']
        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
  
  public static function getCategoriesNode($indicatorId) {
    try {
      $result = [];

      // 1️⃣ Traer TODAS las categorías (sin filtrar por datos aún)
      $rows = self::getCategories($indicatorId);
      
      // 2️⃣ Indexar categorías
      $categories = self::indexCategories($rows);
      
      // 3️⃣ Categorías que sí tienen datos reales
      $categoriesWithData = self::fetchCategoryIdsWithData();

      // 4️⃣ Incluir padres necesarios
      $validCategoryIds = self::includeParentCategories(
        $categories,
        $categoriesWithData
      );

      // 5️⃣ Filtrar categorías válidas
      $filteredCategories = self::filterCategories(
        $categories,
        $validCategoryIds
      );

      // 6️⃣ Construir árbol
      $categoryTree = self::buildCategoryTree($filteredCategories);

      // 7️⃣ Indicadores
      // $indicators = self::indexIndicators($rows);
      // $categoryToIndicatorMap = self::mapCategoryToIndicator($rows);

      // 8️⃣ Asignar árbol a indicadores
      // $dataNode = self::assignTreeToIndicators(
      //   $indicators,
      //   $categoryTree,
      //   $categoryToIndicatorMap
      // );

      // $result = $dataNode;
      $result = $categoryTree;
      // $result = $categoriesWithData;

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
    
    if (empty($result)) {
      // throw new NotFoundException('¡items not found hola!');
      return [];
    }

    return $result;
  }
  public static function getActiveCategoriesNode($indicatorId) {
    try {
      $result = [];

      // 1️⃣ Traer TODAS las categorías (sin filtrar por datos aún)
      $rows = self::getCategories($indicatorId);
      $rowsParents = self::getParentsNode($indicatorId);
      
      // 2️⃣ Indexar categorías
      $categories = self::indexCategories($rows);
      
      // 3️⃣ Categorías que sí tienen datos reales
      $categoriesID = array_column($rows, 'category_id', 'category_id');

      // 4️⃣ Incluir padres necesarios
      // $validCategoryIDs = self::includeParentCategories(
      //   $categories,
      //   $categoriesID
      // );

      // 5️⃣ Filtrar categorías válidas
      $filteredCategories = self::filterCategories(
        $categories,
        // $validCategoryIDs
        $categoriesID
      );

      // 6️⃣ Construir árbol
      $categoryTree = self::buildCategoryTree($filteredCategories);

     $parentIds = array_column($rowsParents, 'id');

      $tree = array_values(array_filter($categoryTree, function ($item) use ($parentIds) {
        // Si NO está en ParentsID → conservar
        if (!in_array($item['id'], $parentIds, true)) {
            return true;
        }

        // Si está en ParentsID → solo conservar si tiene hijos
          return !empty($item['children']);
      }));

      $result = $tree;
      //-------------------------------------------------------------------------------------------------------

      // 7️⃣ Indicadores
      // $indicators = self::indexIndicators($rows);
      // $categoryToIndicatorMap = self::mapCategoryToIndicator($rows);

      // 8️⃣ Asignar árbol a indicadores
      // $dataNode = self::assignTreeToIndicators(
      //   $indicators,
      //   $categoryTree,
      //   $categoryToIndicatorMap
      // );

      // $result = [
      //   '1_rows' => $rows,
      //   '2_categories' =>$categories,
      //   '3_categoriesID' =>$categoriesID,
      //   '4_ParentsID' =>$ParentsID,
      //   // '4_validCategoryIDs' =>$validCategoryIDs,
      //   '5_filteredCategories' =>$filteredCategories,
      //   '6_categoryTree' =>$categoryTree,
      // ];
      // $result = $categoryTree;
      // $result = $parentIds;

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
    
    if (empty($result)) {
      // throw new NotFoundException('¡items not found hola!');
      return [];
    }

    return $result;
  }
  //-----------------------------------------------------------------------------
}
?>