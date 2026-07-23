<?php
declare(strict_types=1);
require_once "models/BaseModel.php";

class TvVideosService {
  private const TABLE = 'tv_videos';

  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      $p = $data['params'];
      if (empty($p['youtube_id']) && empty($p['playlist_id'])) {
        throw new ValidationException(['youtube_id' => 'Indica un ID de video o de lista de reproducción']);
      }
    }
  }

  private static function mapItem(array $i): array {
    return [
      'id' => (int) $i['id'],
      'youtube_id' => $i['youtube_id'],
      'playlist_id' => $i['playlist_id'],
      'thumb_id' => $i['thumb_id'],
      'title' => $i['title'],
      'channel' => $i['channel'],
      'date_label' => $i['date_label'],
      'sort_order' => (int) $i['sort_order'],
      'status' => (bool) $i['status'],
    ];
  }

  private static function cols(): string {
    return "id, youtube_id, playlist_id, thumb_id, title, channel, date_label, sort_order, status";
  }

  private static function getById(int $id): array {
    $item = BaseModel::query("SELECT " . self::cols() . " FROM " . self::TABLE . " WHERE id = ?", [$id], 'one');
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
      $items = BaseModel::query("SELECT " . self::cols() . " FROM " . self::TABLE . " ORDER BY sort_order ASC, id ASC", [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }

  public static function getActiveData(): array {
    try {
      $items = BaseModel::query("SELECT " . self::cols() . " FROM " . self::TABLE . " WHERE status = ? ORDER BY sort_order ASC, id ASC", [1], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
}
?>
