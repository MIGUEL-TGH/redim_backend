<?php
require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once __DIR__ . '/../services/VocesVideosService.php';

class VocesVideosController extends BaseController {
  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      switch ($type) {
        case 'getdata': // 🔒 admin
          AuthMiddleware::authorize('voces', 'read-only');
          return VocesVideosService::getAllData();
        case 'getactive': // 🔓 público
          return VocesVideosService::getActiveData();
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
        case 'crud': // 🔒 escritura
          AuthMiddleware::authorize('voces', 'read-write');
          return VocesVideosService::setCRUD($body);
        default:
          throw new ValidationException(['type' => 'Invalid type parameter']);
      }
    });
  }
}
?>
