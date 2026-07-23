<?php
require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once __DIR__ . '/../services/TvVideosService.php';

class TvVideosController extends BaseController {
  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      switch ($type) {
        case 'getdata':
          AuthMiddleware::authorize('tv', 'read-only');
          return TvVideosService::getAllData();
        case 'getactive':
          return TvVideosService::getActiveData();
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
        case 'crud':
          AuthMiddleware::authorize('tv', 'read-write');
          return TvVideosService::setCRUD($body);
        default:
          throw new ValidationException(['type' => 'Invalid type parameter']);
      }
    });
  }
}
?>
