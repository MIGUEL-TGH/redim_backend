<?php
require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once __DIR__ . '/../services/HelpSettingsService.php';

class HelpSettingsController extends BaseController {
  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      switch ($type) {
        case 'getdata':
          AuthMiddleware::authorize('ayuda', 'read-only');
          return HelpSettingsService::getSettings();
        case 'getactive':
          return HelpSettingsService::getSettings();
        default:
          throw new ValidationException(['type' => 'Invalid type parameter']);
      }
    });
  }

  public static function post() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      $body = Request::body();
      switch ($type) {
        case 'update':
          AuthMiddleware::authorize('ayuda', 'read-write');
          return HelpSettingsService::updateSettings($body['params'] ?? []);
        default:
          throw new ValidationException(['type' => 'Invalid type parameter']);
      }
    });
  }
}
?>
