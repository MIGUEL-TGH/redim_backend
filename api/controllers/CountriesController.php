<?php
require_once __DIR__ . '/../services/CountriesService.php';

class CountriesController extends BaseController {
  public static function get() {
    self::handle(function () {
      
      $type = Request::query('type');
      
      return match ($type) {
        'getdata'    => CountriesService::getCountries(),
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
        'crud' => CountriesService::setCRUD($body),
        // 'crud' => $body,
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };
    });
  }
}
?>