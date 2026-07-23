<?php
require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once __DIR__ . '/../services/RecursosStudiesService.php';

class RecursosStudiesController extends BaseController {
  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      switch ($type) {
        case 'getdata':
          AuthMiddleware::authorize('recursos', 'read-only');
          return RecursosStudiesService::getAllData();
        case 'getactive':
          return RecursosStudiesService::getActiveData();
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
          return RecursosStudiesService::setCRUD($body);
        default:
          throw new ValidationException(['type' => 'Invalid type parameter']);
      }
    });
  }
}
?>
