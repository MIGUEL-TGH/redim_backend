<?php
require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once 'services/MapService.php';

class MapController extends BaseController {

  public static function get() {
    self::handle(function () {
      
      $type = Request::query('type');
      
      return match ($type) {
        // 'indicators' => MapService::getIndicators(),
        // 'states' => MapService::getStates(),
        // 'years'      => MapService::getYears(),
        // 'genders'      => MapService::getGenders(),
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
        // 'categories' => MapService::getIndicatorCategories($body),
        'categories' => MapService::getCategoriesNode($body),
        'getdata' => MapService::getData($body),
        // 'getdata' => $body,
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };

      // if ($type !== 'getdata') {
      //   throw new ValidationException([
      //     'type' => 'Invalid type parameter'
      //   ]);
      // }

      // return MapService::getData($body);
    });
  }


}
?>