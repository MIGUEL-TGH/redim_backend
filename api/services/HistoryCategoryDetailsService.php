<?php
declare(strict_types=1);
require_once "models/BaseModel.php";

class HistoryCategoryDetailsService {
  private const TABLE = 'history_category_details';

  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      $p = $data['params'];
      if (empty($p['title']) || mb_strlen((string)$p['title']) > 300) {
        throw new ValidationException(['title' => 'Título requerido (máx. 300)']);
      }
      if (empty($p['category_id'])) {
        throw new ValidationException(['category_id' => 'Categoría requerida']);
      }
    }
  }

  private static function mapItem(array $i): array {
    return [
      'id' => (int) $i['id'],
      'category_id' => (int) $i['category_id'],
      'category_name' => $i['category_name'] ?? null,
      'title' => $i['title'],
      'url' => $i['url'],
      'sort_order' => (int) $i['sort_order'],
      'status' => (bool) $i['status'],
    ];
  }

  private static function selectSql(string $where = ''): string {
    return "SELECT d.id, d.category_id, c.name AS category_name, d.title, d.url, d.sort_order, d.status
            FROM " . self::TABLE . " d
            LEFT JOIN history_categories c ON d.category_id = c.id
            {$where}
            ORDER BY d.category_id ASC, d.sort_order ASC, d.id ASC";
  }

  private static function getById(int $id): array {
    $item = BaseModel::query(
      "SELECT d.id, d.category_id, c.name AS category_name, d.title, d.url, d.sort_order, d.status
       FROM " . self::TABLE . " d
       LEFT JOIN history_categories c ON d.category_id = c.id
       WHERE d.id = ?", [$id], 'one');
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
    self::updateInternal(['id' => $params['id'], 'status' => $params['status']]);
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
      $items = BaseModel::query(self::selectSql(), [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }

  public static function getActiveData(): array {
    try {
      $items = BaseModel::query(self::selectSql('WHERE d.status = 1'), [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
}
?>
