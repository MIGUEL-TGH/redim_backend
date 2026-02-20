<?php
require_once __DIR__ . '/../services/IndicatorCategoriesService.php';

class IndicatorCategoriesController extends BaseController {
  public static function get() {
    self::handle(function () {
      
      $type = Request::query('type');
      
      return match ($type) {
        'getdata'         => IndicatorCategoriesService::getAllData(),
        'getactive'       => IndicatorCategoriesService::getAllDataActive(),
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
        'crud'      => IndicatorCategoriesService::setCRUD($body),
        // 'crud'   => $body,
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };
    });
  }
}
?>