<?php
require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once __DIR__ . '/../services/MiradasWorksService.php';

class MiradasWorksController extends BaseController {
  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      switch ($type) {
        case 'getdata':
          AuthMiddleware::authorize('miradas', 'read-only');
          return MiradasWorksService::getAllData();
        case 'getactive':
          return MiradasWorksService::getActiveData();
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
          AuthMiddleware::authorize('miradas', 'read-write');
          return MiradasWorksService::setCRUD($body);
        default:
          throw new ValidationException(['type' => 'Invalid type parameter']);
      }
    });
  }
}
?>
