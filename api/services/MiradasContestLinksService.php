<?php
declare(strict_types=1);
require_once "models/BaseModel.php";
require_once BASE_PATH . '/core/FileUpload.php';

class MiradasContestLinksService {
  private const TABLE = 'miradas_contest_links';
  private const FILE_DIR = 'miradas/contest_links';
  private const FILE_EXT = ['pdf'];
  private const MAX_BYTES = 20971520; // 20 MB (PDFs)

  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      $p = $data['params'];
      if (empty($p['label']) || mb_strlen((string)$p['label']) > 150) {
        throw new ValidationException(['label' => 'Etiqueta requerida (máx. 150)']);
      }
    }
  }

  private static function prepareParams(array $params, ?string $oldFile = null): array {
    if (array_key_exists('file_url', $params)) {
      $incoming = $params['file_url'];
      $saved = FileUpload::saveBase64($incoming ?? null, self::FILE_DIR, self::FILE_EXT, self::MAX_BYTES);
      // Borra el archivo anterior siempre que el valor final cambie: subida
      // nueva, cambio a URL externa, o eliminación (campo vacío).
      if ($oldFile && $oldFile !== $saved) {
        FileUpload::delete($oldFile);
      }
      $params['file_url'] = $saved;
    }
    return $params;
  }

  private static function mapItem(array $i): array {
    return [
      'id' => (int) $i['id'],
      'label' => $i['label'],
      'action' => $i['action'],
      'file_url' => $i['file_url'],
      'parent_id' => isset($i['parent_id']) ? (int) $i['parent_id'] : null,
      'parent_label' => $i['parent_label'] ?? null,
      'sort_order' => (int) $i['sort_order'],
      'status' => (bool) $i['status'],
    ];
  }

  private static function selectSql(string $where = ''): string {
    return "SELECT l.id, l.label, l.action, l.file_url, l.parent_id, p.label AS parent_label, l.sort_order, l.status
            FROM " . self::TABLE . " l
            LEFT JOIN " . self::TABLE . " p ON l.parent_id = p.id
            {$where}
            ORDER BY COALESCE(l.parent_id, l.id) ASC, l.parent_id IS NOT NULL, l.sort_order ASC, l.id ASC";
  }

  private static function getById(int $id): array {
    $item = BaseModel::query(
      "SELECT l.id, l.label, l.action, l.file_url, l.parent_id, p.label AS parent_label, l.sort_order, l.status
       FROM " . self::TABLE . " l
       LEFT JOIN " . self::TABLE . " p ON l.parent_id = p.id
       WHERE l.id = ?", [$id], 'one');
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
    $params = self::prepareParams($params, $current['file_url'] ?? null);
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
      $items = BaseModel::query(self::selectSql(), [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }

  public static function getActiveData(): array {
    try {
      $items = BaseModel::query(self::selectSql('WHERE l.status = 1'), [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
}
?>
