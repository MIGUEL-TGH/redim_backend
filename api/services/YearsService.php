<?php
// SRP (Single Responsibility Principle)
declare(strict_types=1); // Modo estricto de tipos
require_once "models/BaseModel.php";

class YearsService {
  private const TABLE = 'years';
  //--------------------private access-------------------------------------------
  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      if (!preg_match("/^\d{4}$/", $data['params']['name'])) {
        throw new ValidationException([], 'Formato YYYY inválido');
      }
    }
  }

  private static function getById(int $id): array {
    $sql = 
    " SELECT id, name, status
      FROM " . self::TABLE . "
      WHERE id = ?
      ORDER BY name DESC
    ";

    $item = BaseModel::query($sql, [$id], 'one');

    if (!$item) {
      throw new NotFoundException('Item not found');
    }

    return [
      'id' => (int) $item['id'],
      'name' => $item['name'],
      'status' => (bool) $item['status'],
    ];
  } 

  private static function insert(array $params): array {
    $insert = BaseModel::setInsert(self::TABLE, $params);

    if ($insert['status'] !== 200) {
      throw new ValidationException([], $insert['alert'] ?? 'Error');
    }

    return [
      'task' => 'saved_item',
      // 'id' => $insert['id']
      'item' => self::getById((int)$insert['id'])
    ];
  }

  private static function update(array $params): array {
    self::updateInternal($params);

    return [
      'task' => 'updated_item',
      // 'id' => $params['id']
      'item' => self::getById((int)$params['id'])
    ];
  }

  private static function changeStatus(array $params): array {
    self::updateInternal($params);

    return [
      'task' => 'status_updated',
      'id' => $params['id'],
      'status' => $params['status']
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
      " SELECT id, name, status
        FROM " . self::TABLE . "
        ORDER BY name DESC
      ";

      $items = BaseModel::query($sql, [], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name'],
          'status' => (bool) $item['status'],
        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }

  public static function getActiveData(): array {
    try {
      $sql = 
      " SELECT id, name
        FROM " . self::TABLE . "
        WHERE status = ?
        ORDER BY name DESC
      ";

      $items = BaseModel::query($sql, [1], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name'],
          // 'status' => (bool) $item['status'],
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