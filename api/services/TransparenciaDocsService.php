<?php
declare(strict_types=1);
require_once "models/BaseModel.php";

class TransparenciaDocsService {
  private const TABLE = 'transparencia_docs';

  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      $p = $data['params'];
      if (empty($p['title']) || mb_strlen((string)$p['title']) > 300) {
        throw new ValidationException(['title' => 'Título requerido (máx. 300)']);
      }
      if (empty($p['url']) || mb_strlen((string)$p['url']) > 500) {
        throw new ValidationException(['url' => 'URL requerida (máx. 500)']);
      }
      if (empty($p['section_id'])) {
        throw new ValidationException(['section_id' => 'Sección requerida']);
      }
    }
  }

  // redes: arreglo [{label,url}] <-> columna JSON, mismo patrón que voces_testimonials.badges
  private static function prepareParams(array $params): array {
    if (array_key_exists('redes', $params)) {
      $r = $params['redes'];
      if (is_array($r)) {
        $clean = array_values(array_filter($r, fn($x) => is_array($x) && !empty($x['label']) && !empty($x['url'])));
        $params['redes'] = json_encode($clean, JSON_UNESCAPED_UNICODE);
      }
    }
    return $params;
  }

  private static function decodeRedes($raw): array {
    if (empty($raw)) return [];
    $arr = json_decode((string)$raw, true);
    return is_array($arr) ? $arr : [];
  }

  private static function selectSql(): string {
    return "SELECT d.id, d.section_id, d.title, d.url, d.redes, d.sort_order, d.status, s.title AS section_title
            FROM " . self::TABLE . " d
            LEFT JOIN transparencia_sections s ON d.section_id = s.id";
  }

  private static function mapItem(array $i): array {
    return [
      'id' => (int) $i['id'],
      'section_id' => (int) $i['section_id'],
      'section_title' => $i['section_title'] ?? null,
      'title' => $i['title'],
      'url' => $i['url'],
      'redes' => self::decodeRedes($i['redes']),
      'sort_order' => (int) $i['sort_order'],
      'status' => (bool) $i['status'],
    ];
  }

  private static function getById(int $id): array {
    $item = BaseModel::query(self::selectSql() . " WHERE d.id = ?", [$id], 'one');
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
    $params = self::prepareParams($params);
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
      $items = BaseModel::query(self::selectSql() . " ORDER BY d.section_id ASC, d.sort_order ASC, d.id ASC", [], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }

  public static function getActiveData(): array {
    try {
      $items = BaseModel::query(self::selectSql() . " WHERE d.status = ? ORDER BY d.section_id ASC, d.sort_order ASC, d.id ASC", [1], 'all');
      return array_map(fn($i) => self::mapItem($i), $items);
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
}
?>
