<?php
require_once __DIR__ . '/../services/YearsService.php';

class YearsController extends BaseController {
  public static function get() {
    self::handle(function () {
      
      $type = Request::query('type');
      
      return match ($type) {
        'getdata'    => YearsService::getAllData(),
        'getactive'    => YearsService::getActiveData(),
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
        'crud' => YearsService::setCRUD($body),
        // 'crud' => $body,
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };
    });
  }
}
?>