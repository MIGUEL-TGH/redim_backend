<?php
declare(strict_types=1);
require_once "models/BaseModel.php";

class HelpSettingsService {
  private const TABLE = 'help_settings';
  private const ROW_ID = 1;

  private static function validate(array $params): void {
    if (empty($params['emergency_phone']) || mb_strlen((string)$params['emergency_phone']) > 50) {
      throw new ValidationException(['emergency_phone' => 'Teléfono de emergencia requerido (máx. 50)']);
    }
  }

  private static function mapItem(array $i): array {
    return [
      'id' => (int) $i['id'],
      'emergency_phone' => $i['emergency_phone'],
    ];
  }

  public static function getSettings(): array {
    $item = BaseModel::query("SELECT id, emergency_phone FROM " . self::TABLE . " WHERE id = ?", [self::ROW_ID], 'one');
    if (!$item) throw new NotFoundException('Settings not found');
    return self::mapItem($item);
  }

  public static function updateSettings(array $params): array {
    self::validate($params);
    $update = BaseModel::setUpdate(self::TABLE, [
      'id' => self::ROW_ID,
      'emergency_phone' => $params['emergency_phone'],
    ]);
    if ($update['status'] !== 200) throw new ValidationException([], 'Error en actualización');
    return ['task' => 'updated_item', 'item' => self::getSettings()];
  }
}
?>
