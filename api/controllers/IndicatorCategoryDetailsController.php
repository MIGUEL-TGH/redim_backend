<?php
require_once __DIR__ . '/../services/IndicatorCategoryDetailsService.php';

class IndicatorCategoryDetailsController extends BaseController {
  public static function get() {
    self::handle(function () {
      
      $type = Request::query('type');
      
      return match ($type) {
        'getalldata'    => IndicatorCategoryDetailsService::getAllData(),
        'getdata'       => IndicatorCategoryDetailsService::getAllData(),
        // 'getdata'    => $type,
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
        'crud'            => IndicatorCategoryDetailsService::setCRUD($body),
        'getdatabyid'     => IndicatorCategoryDetailsService::getAllDataByID($body),
        // 'getactivebyid'   => IndicatorCategoryDetailsService::getActiveDatataById($body),
        // 'getdatabyid' => $body,
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };
    });
  }
}
?>