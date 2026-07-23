<?php
declare(strict_types=1);
require_once "models/BaseModel.php";
require_once BASE_PATH . '/core/FileUpload.php';

class MiradasWorksService {
  private const TABLE = 'miradas_works';
  private const IMG_DIR = 'miradas/works';
  private const IMG_EXT = ['jpg','png','webp','gif'];

  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      $p = $data['params'];
      if (!empty($p['section']) && !in_array($p['section'], ['carousel','gallery'], true)) {
        throw new ValidationException(['section' => 'Sección inválida']);
      }
    }
  }

  private static function prepareParams(array $params, ?string $oldImage = null): array {
    if (array_key_exists('image_url', $params)) {
      $incoming = $params['image_url'];
      $saved = FileUpload::saveBase64($incoming ?? null, self::IMG_DIR, self::IMG_EXT);
      if ($oldImage && is_string($incoming) && strncmp($incoming, 'data:', 5) === 0) {
        FileUpload::delete($oldImage);
      }
      $params['image_url'] = $saved;
    }
    return $params;
  }

  private static function mapItem(array $i): array {
    return [
      'id' => (int) $i['id'],
      'section' => $i['section'],
      'title' => $i['title'],
      'author_name' => $i['author_name'],
      'age' => isset($i['age']) ? (int) $i['age'] : null,
      'image_url' => $i['image_url'],
      'sort_order' => (int) $i['sort_order'],
      'status' => (bool) $i['status'],
    ];
  }

  private static function cols(): string {
    return "id, section, title, author_name, age, image_url, sort_order, status";
  }

  private static function getById(int $id): array {
    $item = BaseModel::query("SELECT " . self::cols() . " FROM " . self::TABLE . " WHERE id = ?", [$id], 'one');
    if (!$item) throw new NotFoundException('Item not found');
    return self::mapItem($item);
  }

  private static function insert(array $params): array {
    $params = self::prepareParams($params);
    $insert = BaseModel::setInsert(self::TABLE, $params);
    if ($insert['status'] !== 200) throw new ValidationException([], 'Error al guardar');
    return ['task' => 'saved_item', 'item' => self::getById((int)$insert['lastInsertId'])];
  }

  private static function update(array $params): array {
    $current = self::getById((int)$params['id']);
    $params = self::prepareParams($params, $current['image_url'] ?? null);
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
      $items = BaseModel::query("SELECT " . self::cols() . " FROM " . self::TABLE . " ORDER BY section ASC, sort_order ASC, id ASC", [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }

  public static function getActiveData(): array {
    try {
      $items = BaseModel::query("SELECT " . self::cols() . " FROM " . self::TABLE . " WHERE status = ? ORDER BY section ASC, sort_order ASC, id ASC", [1], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
}
?>
