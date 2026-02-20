<?php

require_once 'services/MapService.php';

class MapController extends BaseController {
  // -----------------------------------------------------------------
  // public static function get() {
  //   $type = Request::query('type');
  //   $response = new Response();

  //   try {
  //     switch ($type) {
  //       case 'indicators':
  //         $data = MapService::getIndicators();
  //         $response->setResponse($data, null);
  //         break;
  //       case 'years':
  //         $data = MapService::getYears();
  //         $response->setResponse($data, null);
  //         break;
  //       default:
  //         $response->setResponse(null, 'Invalid type', 400);
  //     }

  //   } catch (Exception $e) {
  //     $response->setResponse(null, $e->getMessage(), $e->getCode() ?: 500);
  //   }
  // }
  // public static function post() {
  //   $type = Request::query('type');
  //   $body = Request::body();
  //   $response = new Response();

  //   try {
  //     if ($type === 'getdata') {
  //       $data = MapService::getData($body);
  //       $response->setResponse($data, null);
  //       return;
  //     }

  //     $response->setResponse(null, 'Invalid type', 400);

  //   } catch (Exception $e) {
  //     $response->setResponse(null, $e->getMessage(), $e->getCode() ?: 500);
  //   }
  // }
  
  // -----------------------------------------------------------------
  // public static function post() {
  //   $type = Request::query('type');
  //   $body = Request::body();

  //   if ($type === 'getdata') {
  //     Response::json(MapService::getData($body));
  //   }

  //   Response::error('Invalid type', 400);
  // }

  public static function get() {
    self::handle(function () {
      
      $type = Request::query('type');
      
      return match ($type) {
        // 'indicators' => MapService::getIndicators(),
        'states' => MapService::getStates(),
        'years'      => MapService::getYears(),
        'genders'      => MapService::getGenders(),
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