<?php
declare(strict_types=1);
require_once "models/BaseModel.php";

class VocesPodcastsService {
  private const TABLE = 'voces_podcasts';

  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      $p = $data['params'];
      if (empty($p['title']) || mb_strlen((string)$p['title']) > 250) {
        throw new ValidationException(['title' => 'Título requerido (máx. 250)']);
      }
      if (empty($p['url']) || !preg_match('#^https?://#i', (string)$p['url'])) {
        throw new ValidationException(['url' => 'URL inválida']);
      }
    }
  }

  private static function getById(int $id): array {
    $sql = "SELECT id, title, author, duration, url, sort_order, status
            FROM " . self::TABLE . " WHERE id = ?";
    $item = BaseModel::query($sql, [$id], 'one');
    if (!$item) {
      throw new NotFoundException('Item not found');
    }
    return self::mapItem($item);
  }

  private static function mapItem(array $i): array {
    return [
      'id' => (int) $i['id'],
      'title' => $i['title'],
      'author' => $i['author'],
      'duration' => $i['duration'],
      'url' => $i['url'],
      'sort_order' => (int) $i['sort_order'],
      'status' => (bool) $i['status'],
    ];
  }

  private static function insert(array $params): array {
    $insert = BaseModel::setInsert(self::TABLE, $params);
    if ($insert['status'] !== 200) {
      throw new ValidationException([], 'Error al guardar');
    }
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
    if ($update['status'] !== 200) {
      throw new ValidationException([], 'Error en actualización');
    }
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
      $sql = "SELECT id, title, author, duration, url, sort_order, status
              FROM " . self::TABLE . " ORDER BY sort_order ASC, id ASC";
      $items = BaseModel::query($sql, [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }

  public static function getActiveData(): array {
    try {
      $sql = "SELECT id, title, author, duration, url, sort_order, status
              FROM " . self::TABLE . " WHERE status = ? ORDER BY sort_order ASC, id ASC";
      $items = BaseModel::query($sql, [1], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
}
?>
