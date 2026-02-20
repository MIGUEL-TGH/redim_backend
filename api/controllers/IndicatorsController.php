<?php
require_once __DIR__ . '/../services/IndicatorsService.php';

class IndicatorsController extends BaseController {
  public static function get() {
    self::handle(function () {
      
      $type = Request::query('type');
      
      return match ($type) {
        'getdata'    => IndicatorsService::getAllData(),
        'getactive'    => IndicatorsService::getActiveData(),
        'getwithdata'    => IndicatorsService::getIndicatorsWithData(),
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
        'crud' => IndicatorsService::setCRUD($body),
        // 'crud' => $body,
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };
    });
  }
}
?>