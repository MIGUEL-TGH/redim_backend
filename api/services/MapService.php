<?php
require_once "models/BaseModel.php";

class MapService {
  //--------------------private access------------------------------------------- 
  private static function buildInClause(string $field, array $values, array &$params): string {
    if (empty($values)) {
      return '';
    }

    $safeField = str_replace('.', '_', $field);
    $placeholders = [];
    foreach ($values as $index => $value) {
      $key = "{$safeField}_{$index}";
      $placeholders[] = ":{$key}";
      $params[$key] = $value;
    }

    return " AND {$field} IN (" . implode(',', $placeholders) . ")";
  }
  //--------------------Constructor de nodos de indicadores------------------------------------------- 
  
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
  private static function fetchCategoryIdsWithData(): array {
      $sql = 
      "SELECT DISTINCT category_id
        FROM indicator_category_details
        WHERE status = ?
      ";

      $rows = BaseModel::query($sql, [1], 'all');

      return array_column($rows, 'category_id', 'category_id');
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
  //--------------------public access-------------------------------------------        
  public static function getCategoriesNode ($IDs) {
    try {
      $result = [];
      // $indicatorId = $IDs['indicator_ids'];
      $rawIds = isset($IDs['indicator_ids']) ? $IDs['indicator_ids'] : [];
      $indicatorId = array_map('intval', $rawIds);

      // 1️⃣ Traer TODAS las categorías (sin filtrar por datos aún)

      // =========================================== CONSTRUIR SQL ===========================================
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
          i.status = 1
          AND ic.status = 1
      ";

      $params = [];
      if (!empty($indicatorId)) {
        $sql .= self::buildInClause('i.id', $indicatorId, $params);
      }

      // $sql .= " 
      //  ORDER BY
      //   i.id,
      //   ic.level,
      //   ic.sort_order,
      //   ic.name;
      // ";

      $sql .= " 
       ORDER BY
        CAST(SUBSTRING_INDEX(category_name, '.', 1) AS UNSIGNED);
      ";


      // ORDER BY CAST(SUBSTRING_INDEX(i.name, '.', 1) AS UNSIGNED);

      // ==================================================================================================

      // return $sql;


      // $rows = BaseModel::query($sql, [1, 1, $params], 'all');
      $rows = BaseModel::query($sql, $params, 'all');

      // return $rows;
      
      

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

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
    
    if (empty($result)) {
      // throw new NotFoundException('¡items not found hola!');
      return [];
    }

    return $result;
  }
  public static function getStates() {
    try {
      // $sql = 
      //   "SELECT s.id, s.name AS title
      //   FROM states s
      //   WHERE s.status = ? AND s.country_id = ?
      //   ORDER BY s.name ASC;
      // ";
      $sql = 
      " SELECT DISTINCT icd.state_id AS id, s.name AS title
        FROM indicator_category_details icd
        INNER JOIN states s ON s.id = icd.state_id
        WHERE icd.status = ?  
        ORDER BY s.name ASC;
      ";
      $items = BaseModel::query($sql, [1], 'all');
    
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
    
    if (empty($items)) {
      throw new NotFoundException('¡items not found!');
    }

    return $items;
  }
  public static function getYears() {
    try {
      // $sql = 
      //   "SELECT y.id, y.name AS title
      //   FROM years y
      //   WHERE y.status = ?
      //   ORDER BY y.name DESC;
      // ";

      $sql = 
        "SELECT DISTINCT icd.year_id AS id, y.name AS title
        FROM indicator_category_details icd
        INNER JOIN years y ON y.id = icd.year_id
        WHERE icd.status = ?  
        ORDER BY icd.year_id DESC;
      ";

      $items = BaseModel::query($sql, [1], 'all');
    
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
    
    if (empty($items)) {
      throw new NotFoundException('¡items not found!');
    }

    return $items;
  }
  public static function getGenders() {
    try {
      // $sql = 
      //   "SELECT g.id, g.name AS title
      //   FROM genders g
      //   WHERE g.status = ?
      //   ORDER BY g.name ASC;
      // ";
      $sql = 
      "SELECT DISTINCT icd.gender_id AS id, g.name AS title
        FROM indicator_category_details icd
        INNER JOIN genders g ON g.id = icd.gender_id
        WHERE icd.status = ?  
        ORDER BY g.name DESC;
      
      ";
      $items = BaseModel::query($sql, [1], 'all');
    
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
    
    if (empty($items)) {
      throw new NotFoundException('¡items not found!');
    }

    return $items;
  }
  public static function getData($data) {
    $params = [];
    $query = "SELECT
        icd.category_id AS category_id,
        ic.name AS category_name,

        icd.year_id,
        y.name AS year_name,

        icd.gender_id,
        g.name AS gender_name,

        icd.state_id,
        s.name AS state_name,

        icd.PI,
        icd.PS
      FROM indicator_category_details icd
      INNER JOIN indicator_categories ic ON ic.id = icd.category_id
      INNER JOIN years y ON y.id = icd.year_id
      INNER JOIN genders g ON g.id = icd.gender_id
      INNER JOIN states s ON s.id = icd.state_id
      WHERE icd.status = 1
    ";

    // Construcción dinámica de filtros
    if (!empty($data['category_id'])) {
      $query .= self::buildInClause('icd.category_id', $data['category_id'], $params);
    }
    
    if (!empty($data['year_id'])) {
      $query .= self::buildInClause('icd.year_id', $data['year_id'], $params);
    }

    if (!empty($data['gender_id'])) {
      $query .= self::buildInClause('icd.gender_id', $data['gender_id'], $params);
    }

    if (!empty($data['state_id'])) {
      $query .= self::buildInClause('icd.state_id', $data['state_id'], $params);
    }

    // return $query;
    // -------------------------------------------------------------------------------------------------
    try {
      $items = BaseModel::query($query, $params, 'all');
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
    
    if (empty($items)) {
      throw new NotFoundException('¡items not found!');
    }

    return $items;
  }
  //-----------------------------------------------------------------------------
  // public static function getIndicatorCategoriesv1($indicatorId) { // Borrar despues
  //   try {
  //     // $sql = 
  //     //   "SELECT ic.id, ic.name AS title, ic.parent_id
  //     //   FROM indicator_categories ic
  //     //   WHERE ic.indicator_id = ? 
  //     //       AND ic.status = ?
  //     //   ORDER BY ic.name ASC;
  //     // ";

  //     // $items = BaseModel::query($sql, [$indicatorId, 1], 'all');
    
  //     $sql = 
  //       "SELECT ic.id, ic.name AS title, ic.parent_id
  //       FROM indicator_categories ic
  //       INNER JOIN indicator_category_details icd
  //       ON icd.category_id = ic.id
  //       WHERE ic.indicator_id = ? 
  //           AND ic.status = ?
  //       ORDER BY ic.name ASC;
  //     ";

  //     $items = BaseModel::query($sql, [$indicatorId, 1], 'all');
    
  //   } catch (Throwable $e) {
  //     throw new DatabaseException($e->getMessage());
  //   }
    
  //   if (empty($items)) {
  //     throw new NotFoundException('¡items not found!');
  //   }

  //   return $items;
  // }

  // public static function getIndicators() { // Borrar despues
  //   $sql = 
  //     "SELECT DISTINCT
  //       i.id, i.name AS title
  //     FROM indicators i
  //     INNER JOIN indicator_categories ic
  //       ON ic.indicator_id = i.id
  //     INNER JOIN indicator_category_details icd
  //       ON icd.category_id = ic.id
  //     WHERE i.status = ?
  //     ORDER BY i.name;
  //   ";

  //   try {
  //     // $items = BaseModel::query($sql, [1, 1], 'all');
  //     $items = BaseModel::query($sql, [1], 'all');
  //   } catch (Throwable $e) {
  //     throw new DatabaseException($e->getMessage());
  //   }

  //   if (empty($items)) {
  //     throw new NotFoundException('¡items not found!');
  //   }

  //   return $items;
  // }
}
?>