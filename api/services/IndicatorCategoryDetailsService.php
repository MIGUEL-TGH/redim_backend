<?php
// SRP (Single Responsibility Principle)
declare(strict_types=1); // Modo estricto de tipos
require_once "models/BaseModel.php";

class IndicatorCategoryDetailsService {
  private const TABLE = 'indicator_category_details';
  //--------------------private access-------------------------------------------
  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      if (!preg_match("/^[\p{L}\d\s._,-]{1,255}$/u", $data['params']['name'])) {
        throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el nombre del indicador');
      }

      // $level = $data['params']['level'] ?? null;
      // if ($level !== null) {

      //   $level = trim($level);

      //   // Permitir string vacío
      //   if ($level === '') {
      //     return;
      //   }

      //   // Límite máximo de caracteres
      //   if (mb_strlen($level) > 50) {
      //     throw new ValidationException([
      //       'level' => 'Máximo 50 caracteres permitidos'
      //     ]);
      //   }

      //   // Validar estructura estricta: numero,numero (sin espacios)
      //   if (!preg_match('/^\d+$/', $level)) {
      //     throw new ValidationException([
      //       'level' => 'El formato del nivel jerárquico no cumple con el formato requerido (solo números sin espacios) [0-99]'
      //     ]);
      //   }
      // }
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
          
          'level' => $item['level'],
          'status' => (bool) $item['status']
        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
  //-----------------------------------------------------------------------------

  // public static function getIndicatorsActive(): array {
  //   try {
  //     $sql = 
  //     " SELECT id, name
  //       FROM indicators
  //       WHERE status = ?
  //       ORDER BY id ASC
  //     ";

  //     $items = BaseModel::query($sql, [1], 'all');

  //     if (empty($items)) {
  //       throw new NotFoundException('Items not found');
  //     }

  //     return array_map(
  //       fn($item) => [
  //         'id' => (int) $item['id'],
  //         'name' => $item['name']
  //       ],
  //       $items
  //     );

  //   } catch (Throwable $e) {
  //     throw new DatabaseException($e->getMessage());
  //   }
  // }
  // public static function getStatesActive(): array {
  //   try {
  //     $sql = 
  //     " SELECT id, name
  //       FROM states
  //       WHERE status = ?
  //       ORDER BY id ASC
  //     ";

  //     $items = BaseModel::query($sql, [1], 'all');

  //     if (empty($items)) {
  //       throw new NotFoundException('Items not found');
  //     }

  //     return array_map(
  //       fn($item) => [
  //         'id' => (int) $item['id'],
  //         'name' => $item['name']
  //       ],
  //       $items
  //     );

  //   } catch (Throwable $e) {
  //     throw new DatabaseException($e->getMessage());
  //   }
  // }
  
  
}
?>