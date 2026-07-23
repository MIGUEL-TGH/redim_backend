<?php
require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once __DIR__ . '/../services/VocesPodcastsService.php';

class VocesPodcastsController extends BaseController {
  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      switch ($type) {
        case 'getdata':
          AuthMiddleware::authorize('voces', 'read-only');
          return VocesPodcastsService::getAllData();
        case 'getactive':
          return VocesPodcastsService::getActiveData();
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
          AuthMiddleware::authorize('voces', 'read-write');
          return VocesPodcastsService::setCRUD($body);
        default:
          throw new ValidationException(['type' => 'Invalid type parameter']);
      }
    });
  }
}
?>
