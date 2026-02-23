<?php
// SRP (Single Responsibility Principle)
declare(strict_types=1); // Modo estricto de tipos
require_once "models/BaseModel.php";

class StatesService {
  private const TABLE = 'states';
  //--------------------private access-------------------------------------------
  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      if (!preg_match("/^[\p{L}\d\s._,-]{1,250}$/u", $data['params']['name'])) {
        throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el nombre del indicador');
      }
      if (!preg_match("/^[\p{L}\d\s._,-]{1,50}$/u", $data['params']['demonym'])) {
        throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el gentilicio');
      }
      if (!preg_match("/^[\p{L}\d\s._,-]{1,3}$/u", $data['params']['iso_code'])) {
        throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el código ISO');
      }
    }
  }
  private static function getById(int $id): array {
    $sql = 
    " SELECT s.id, s.name, s.country_id,
            c.name AS country_name,
            s.demonym, s.iso_code, s.status
      FROM states s
      LEFT JOIN countries c ON s.country_id = c.id
      WHERE s.id = ?
    ";

    $item = BaseModel::query($sql, [$id], 'one');

    if (!$item) {
      throw new NotFoundException('Item not found');
    }

    return [
      'id' => (int) $item['id'],
      'name' => $item['name'],
      'country_id' => (int) $item['country_id'],
      'country_name' => $item['country_name'],
      'demonym' => $item['demonym'],
      'iso_code' => $item['iso_code'],
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
      // 'id' => $params['id'],
      // 'status' => $params['status']
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
      "SELECT s.id, s.name, s.country_id, c.name AS country_name, s.demonym, s.iso_code, s.status
        FROM states s
        LEFT JOIN `countries` c ON s.country_id = c.id
        ORDER BY s.id ASC
      ";

      $items = BaseModel::query($sql, [], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name'],
          'country_id' => $item['country_id'],
          'country_name' => $item['country_name'],
          'demonym' => $item['demonym'],
          'iso_code' => $item['iso_code'],
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
        FROM states
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
  public static function getActiveDataById($id): array {
    try {
      $sql = 
      " SELECT id, name
        FROM states
        WHERE status = ? AND country_id = ?
        ORDER BY id ASC
      ";

      $items = BaseModel::query($sql, [1, $id['country_id']], 'all');

      if (empty($items)) {
        throw new NotFoundException('Elementos no encontrados'); // Items not found
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
  //-----------------------------------------------------------------------------
}
?>