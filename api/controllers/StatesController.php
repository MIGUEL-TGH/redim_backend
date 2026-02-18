<?php
require_once __DIR__ . '/../services/StatesService.php';

class StatesController extends BaseController {
  public static function get() {
    self::handle(function () {
      
      $type = Request::query('type');
      
      return match ($type) {
        'getdata'         => StatesService::getAllData(),
        'getactive'    => StatesService::getActiveData(),
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };
    });
  }

  public static function post() {
    self::handle(function () {

      $type = Request::query('type');
      $body = Request::body();

      return match ($type) {
        'crud' => StatesService::setCRUD($body),
        // 'crud' => $body,
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };
    });
  }
}
?>