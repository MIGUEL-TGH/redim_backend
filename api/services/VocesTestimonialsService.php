<?php
declare(strict_types=1);
require_once "models/BaseModel.php";
require_once BASE_PATH . '/core/FileUpload.php';

class VocesTestimonialsService {
  private const TABLE = 'voces_testimonials';
  private const IMG_DIR = 'voces/testimonials';
  private const IMG_EXT = ['jpg','png','webp','gif'];

  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      $p = $data['params'];
      if (empty($p['name']) || mb_strlen((string)$p['name']) > 150) {
        throw new ValidationException(['name' => 'Nombre requerido (máx. 150)']);
      }
    }
  }

  // Transforma params crudos del front en columnas listas para la BD:
  // - image_url: data URI base64 -> ruta relativa guardada en disco
  // - badges: arreglo -> string JSON
  // - is_main: -> 0/1
  private static function prepareParams(array $params, ?string $oldImage = null): array {
    if (array_key_exists('image_url', $params)) {
      $incoming = $params['image_url'];
      $saved = FileUpload::saveBase64($incoming ?? null, self::IMG_DIR, self::IMG_EXT);
      // Si se subió archivo nuevo (data URI) y había uno anterior distinto, borrarlo
      if ($oldImage && is_string($incoming) && strncmp($incoming, 'data:', 5) === 0) {
        FileUpload::delete($oldImage);
      }
      $params['image_url'] = $saved;
    }
    if (array_key_exists('badges', $params)) {
      $b = $params['badges'];
      if (is_array($b)) {
        $clean = array_values(array_filter($b, fn($x) => is_array($x) && !empty($x['label'])));
        $params['badges'] = json_encode($clean, JSON_UNESCAPED_UNICODE);
      }
    }
    if (array_key_exists('is_main', $params)) {
      $params['is_main'] = !empty($params['is_main']) ? 1 : 0;
    }
    return $params;
  }

  private static function decodeBadges($raw): array {
    if (empty($raw)) return [];
    $arr = json_decode((string)$raw, true);
    return is_array($arr) ? $arr : [];
  }

  private static function getById(int $id): array {
    $sql = "SELECT id, name, country, tagline, image_url, description, is_main, badges, sort_order, status
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
      'name' => $i['name'],
      'country' => $i['country'],
      'tagline' => $i['tagline'],
      'image_url' => $i['image_url'],
      'description' => $i['description'],
      'is_main' => (bool) $i['is_main'],
      'badges' => self::decodeBadges($i['badges']),
      'sort_order' => (int) $i['sort_order'],
      'status' => (bool) $i['status'],
    ];
  }

  // Si el registro quedó marcado como principal, desmarca los demás.
  private static function enforceSingleMain(int $keepId, $isMain): void {
    if (!empty($isMain)) {
      BaseModel::query(
        "UPDATE " . self::TABLE . " SET is_main = 0 WHERE id <> ? AND is_main = 1",
        [$keepId], 'exec'
      );
    }
  }

  private static function insert(array $params): array {
    $params = self::prepareParams($params);
    $insert = BaseModel::setInsert(self::TABLE, $params);
    if ($insert['status'] !== 200) {
      throw new ValidationException([], 'Error al guardar');
    }
    $id = (int) $insert['lastInsertId'];
    self::enforceSingleMain($id, $params['is_main'] ?? 0);
    return ['task' => 'saved_item', 'item' => self::getById($id)];
  }

  private static function update(array $params): array {
    // Recuperamos la imagen anterior para poder reemplazarla/borrarla
    $current = self::getById((int)$params['id']);
    $params = self::prepareParams($params, $current['image_url'] ?? null);
    self::updateInternal($params);
    self::enforceSingleMain((int)$params['id'], $params['is_main'] ?? 0);
    return ['task' => 'updated_item', 'item' => self::getById((int)$params['id'])];
  }

  private static function changeStatus(array $params): array {
    self::updateInternal(['id' => $params['id'], 'status' => $params['status']]);
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
      $sql = "SELECT id, name, country, tagline, image_url, description, is_main, badges, sort_order, status
              FROM " . self::TABLE . " ORDER BY is_main DESC, sort_order ASC, id ASC";
      $items = BaseModel::query($sql, [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }

  public static function getActiveData(): array {
    try {
      $sql = "SELECT id, name, country, tagline, image_url, description, is_main, badges, sort_order, status
              FROM " . self::TABLE . " WHERE status = ? ORDER BY is_main DESC, sort_order ASC, id ASC";
      $items = BaseModel::query($sql, [1], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
}
?>
