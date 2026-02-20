<?php
require_once __DIR__ . '/../services/CentersService.php';

class CentersController extends BaseController {
  public static function get() {
    self::handle(function () {
      
      $type = Request::query('type');
      
      return match ($type) {
        'getdata'      => CentersService::getAllData(),
        'getactive'    => CentersService::getActiveData(),
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
        'crud'            => CentersService::setCRUD($body),
        'getactivebyid'   => CentersService::getActiveDatataById($body),
        // 'crud' => $body,
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };
    });
  }
}
?>