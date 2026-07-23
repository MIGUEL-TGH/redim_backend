<?php
require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once __DIR__ . '/../services/RecursosDownloadsService.php';

class RecursosDownloadsController extends BaseController {
  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      switch ($type) {
        case 'getdata':
          AuthMiddleware::authorize('recursos', 'read-only');
          return RecursosDownloadsService::getAllData();
        case 'getactive':
          return RecursosDownloadsService::getActiveData();
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
          AuthMiddleware::authorize('recursos', 'read-write');
          return RecursosDownloadsService::setCRUD($body);
        default:
          throw new ValidationException(['type' => 'Invalid type parameter']);
      }
    });
  }
}
?>
