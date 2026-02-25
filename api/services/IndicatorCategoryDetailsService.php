<?php
// SRP (Single Responsibility Principle)
declare(strict_types=1); // Modo estricto de tipos
require_once "models/BaseModel.php";

class IndicatorCategoryDetailsService {
  private const TABLE = 'indicator_category_details';
  //--------------------private access-------------------------------------------
  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      // ---------------------------------------------------------------------
      foreach (['PI', 'PS'] as $field) {

        if (!isset($data['params'][$field]) || $data['params'][$field] === '') {
          throw new ValidationException(
            [$field => 'Required field'],
            "El campo {$field} es obligatorio"
          );
        }

        $value = $data['params'][$field];

        // 1️⃣ Solo números enteros positivos (incluye 0)
        if (!preg_match('/^\d+$/', (string)$value)) {
          throw new ValidationException(
            [$field => 'Invalid format'],
            "El campo {$field} solo permite números enteros"
          );
        }

        // 2️⃣ Validación de rango 0 - 9999
        $intValue = (int)$value;

        if ($intValue < 0 || $intValue > 9999) {
          throw new ValidationException(
            [$field => 'Out of range'],
            "El campo {$field} debe estar entre 0 y 9999"
          );
        }
      }

      // ---------------------------------------------------------------------
      $centerId = $data['params']['center_id'];

      // Permitir NULL explícito
      if ($centerId === null) {
        return;
      }

      // Debe ser numérico entero
      if (!preg_match('/^\d+$/', (string)$centerId)) {
        throw new ValidationException(
          ['category_id' => 'Invalid format'],
          'El category_id debe ser NULL o un entero válido'
        );
      }

      $intValue = (int)$centerId;

      // Validación rango INT UNSIGNED
      if ($intValue < 0 || $intValue > 4294967295) {
        throw new ValidationException(
          ['category_id' => 'Out of range'],
          'El category_id está fuera del rango permitido'
        );
      }

      // ---------------------------------------------------------------------
      $status = $data['params']['status'];

      // Solo permitir 0 o 1 (como entero real)
      if (!in_array($status, [0, 1], true)) {
        throw new ValidationException(
          ['status' => 'Invalid value'],
          'El status solo permite los valores 0 (Inactivo) o 1 (Activo)'
        );
      }
    }
  }
  private static function getById(int $id): array {
    $sql = 
    " SELECT 
          icd.id, icd.PI, icd.PS, icd.status,
          
          icd.category_id,  ic.name AS category_name,
          icd.year_id,      y.name AS year_name,
          icd.gender_id,    g.name AS gender_name,
          icd.state_id,     s.name AS state_name,
          icd.center_id,    COALESCE(c.name, 'Sin centro') AS center_name

        FROM indicator_category_details AS icd

        INNER JOIN indicator_categories AS ic ON ic.id = icd.category_id
        INNER JOIN years AS y ON y.id = icd.year_id
        INNER JOIN genders AS g ON g.id = icd.gender_id
        INNER JOIN states AS s ON s.id = icd.state_id
        LEFT JOIN centers AS c ON c.id = icd.center_id
      WHERE icd.id = ?
    ";

    $item = BaseModel::query($sql, [$id], 'one');

    if (!$item) {
      throw new NotFoundException('Item not found');
    }

    return [
      'id' => (int) $item['id'],
      'PI' => (int) $item['PI'],
      'PS' => (int) $item['PS'],
      'status' => $item['status'],
      
      'category_id' => (int) $item['category_id'],
      'category_name' => $item['category_name'],

      'year_id' => (int) $item['year_id'],
      'year_name' => $item['year_name'],
      
      'gender_id' => (int) $item['gender_id'],
      'gender_name' => $item['gender_name'],

      'state_id' => (int) $item['state_id'],
      'state_name' => $item['state_name'],

      'center_id' => (int) $item['center_id'],
      'center_name' => $item['center_name']
    ];
  }
  private static function insert(array $params): array {
    // -------------------------------------------------------------------------
    // $tz = new DateTimeZone('America/Mexico_City');
    // $now = new DateTime('now', $tz);
    // $created_at = $now->format('Y-m-d H:i:s');

    // $params['created_at'] = $created_at;
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
    // $parentId = isset($params['parent_id']) && (int)$params['parent_id'] > 0
    // ? (int)$params['parent_id']
    // : null;

    // $params['parent_id'] = $parentId;
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
          icd.category_id AS category_id,
          ic.name AS category_name,

          icd.year_id,
          y.name AS year_name,

          icd.gender_id,
          g.name AS gender_name,

          icd.state_id,
          s.name AS state_name,

          icd.center_id,
          -- c.name AS center_name,
          COALESCE(c.name, 'Sin centro') AS center_name,

          icd.id,
          icd.PI,
          icd.PS,
          icd.status

        FROM indicator_category_details icd
        INNER JOIN indicator_categories ic ON ic.id = icd.category_id
        INNER JOIN years y ON y.id = icd.year_id
        INNER JOIN genders g ON g.id = icd.gender_id
        INNER JOIN states s ON s.id = icd.state_id
        LEFT JOIN centers c ON c.id = icd.center_id
        ";
      //  WHERE icd.status = 1

      $items = BaseModel::query($sql, [], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'PI' => $item['PI'],
          'PS' => $item['PS'],
          'status' => $item['status'],
          
          'category_id' => (int) $item['category_id'],
          'category_name' => $item['category_name'],

          'year_id' => (int) $item['year_id'],
          'year_name' => $item['year_name'],
          
          'gender_id' => (int) $item['gender_id'],
          'gender_name' => $item['gender_name'],

          'state_id' => (int) $item['state_id'],
          'state_name' => $item['state_name'],

          'center_id' => (int) $item['center_id'],
          'center_name' => $item['center_name'],
        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
  public static function getActiveDatataById($id): array {
    try {
      $sql = 
      " SELECT
          icd.category_id AS category_id,
          ic.name AS category_name,

          icd.year_id,
          y.name AS year_name,

          icd.gender_id,
          g.name AS gender_name,

          icd.state_id,
          s.name AS state_name,

          icd.center_id,
          COALESCE(c.name, 'Sin centro') AS center_name,

          icd.id,
          icd.PI,
          icd.PS,
          icd.status

        FROM indicator_category_details icd
        INNER JOIN indicator_categories ic ON ic.id = icd.category_id
        INNER JOIN years y ON y.id = icd.year_id
        INNER JOIN genders g ON g.id = icd.gender_id
        INNER JOIN states s ON s.id = icd.state_id
        LEFT JOIN centers c ON c.id = icd.center_id
        WHERE icd.category_id = ?
      ";

      $items = BaseModel::query($sql, [$id['category_id']], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          // 'PI' => $item['PI'],
          // 'PS' => $item['PS'],
          // 'status' => $item['status'],
          
          // 'category_id' => (int) $item['category_id'],
          // 'category_name' => $item['category_name'],

          // 'year_id' => (int) $item['year_id'],
          // 'year_name' => $item['year_name'],
          
          // 'gender_id' => (int) $item['gender_id'],
          // 'gender_name' => $item['gender_name'],

          // 'state_id' => (int) $item['state_id'],
          // 'state_name' => $item['state_name'],

          // 'center_id' => (int) $item['center_id'],
          // 'center_name' => $item['center_name'],
        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
  public static function getAllDataByID($id): array {
    try {
      $sql = 
      " SELECT 
          icd.id, icd.PI, icd.PS, icd.status,
          
          icd.category_id,  ic.name AS category_name,
          icd.year_id,      y.name AS year_name,
          icd.gender_id,    g.name AS gender_name,
          icd.state_id,     s.name AS state_name,
          icd.center_id,    COALESCE(c.name, 'Sin centro') AS center_name

        FROM indicator_category_details AS icd

        INNER JOIN indicator_categories AS ic ON ic.id = icd.category_id
        INNER JOIN years AS y ON y.id = icd.year_id
        INNER JOIN genders AS g ON g.id = icd.gender_id
        INNER JOIN states AS s ON s.id = icd.state_id
        LEFT JOIN centers AS c ON c.id = icd.center_id

        WHERE icd.category_id = ?
      ";

      $items = BaseModel::query($sql, [(int)$id['category_id']], 'all');

      if (!$items) {
        // throw new NotFoundException('Elementos no encontrados'); // Items not found
       return []; 
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'PI' => (int) $item['PI'],
          'PS' => (int) $item['PS'],
          'status' => $item['status'],
          
          'category_id' => (int) $item['category_id'],
          'category_name' => $item['category_name'],

          'year_id' => (int) $item['year_id'],
          'year_name' => $item['year_name'],
          
          'gender_id' => (int) $item['gender_id'],
          'gender_name' => $item['gender_name'],

          'state_id' => (int) $item['state_id'],
          'state_name' => $item['state_name'],

          'center_id' => (int) $item['center_id'],
          'center_name' => $item['center_name']
        ],
        $items
      );
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }

  }
  //-----------------------------------------------------------------------------
}
?>