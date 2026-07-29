<?php
declare(strict_types=1);
require_once "models/BaseModel.php";

class StateDescriptionsService {
  private const TABLE = 'state_descriptions';

  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      $p = $data['params'];
      if (empty($p['description'])) {
        throw new ValidationException(['description' => 'Descripción requerida']);
      }
      if (empty($p['state_id'])) {
        throw new ValidationException(['state_id' => 'Estado requerido']);
      }
    }
  }

  private static function selectSql(): string {
    return "SELECT d.id, d.state_id, d.description, d.status, s.name AS state_name
            FROM " . self::TABLE . " d
            LEFT JOIN states s ON d.state_id = s.id";
  }

  private static function mapItem(array $i): array {
    return [
      'id' => (int) $i['id'],
      'state_id' => (int) $i['state_id'],
      'state_name' => $i['state_name'] ?? null,
      'description' => $i['description'],
      'status' => (bool) $i['status'],
    ];
  }

  private static function getById(int $id): array {
    $item = BaseModel::query(self::selectSql() . " WHERE d.id = ?", [$id], 'one');
    if (!$item) throw new NotFoundException('Item not found');
    return self::mapItem($item);
  }

  private static function insert(array $params): array {
    $insert = BaseModel::setInsert(self::TABLE, $params);
    if ($insert['status'] !== 200) throw new ValidationException([], 'Error al guardar');
    return ['task' => 'saved_item', 'item' => self::getById((int)$insert['lastInsertId'])];
  }

  private static function update(array $params): array {
    self::updateInternal($params);
    return ['task' => 'updated_item', 'item' => self::getById((int)$params['id'])];
  }

  private static function changeStatus(array $params): array {
    self::updateInternal($params);
    return ['task' => 'status_updated', 'id' => (int)$params['id'], 'status' => (bool)$params['status']];
  }

  private static function updateInternal(array $params): void {
    $update = BaseModel::setUpdate(self::TABLE, $params);
    if ($update['status'] !== 200) throw new ValidationException([], 'Error en actualización');
  }

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
      $items = BaseModel::query(self::selectSql() . " ORDER BY s.name ASC", [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }

  public static function getActiveData(): array {
    try {
      $items = BaseModel::query(self::selectSql() . " WHERE d.status = ? ORDER BY s.name ASC", [1], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
}
?>
