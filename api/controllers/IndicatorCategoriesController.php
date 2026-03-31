<?php
require_once __DIR__ . '/../services/IndicatorCategoriesService.php';

class IndicatorCategoriesController extends BaseController {
  public static function get() {
    self::handle(function () {

      // $type = Request::query('type');
      // return match ($type) {
      //   'getdata'         => IndicatorCategoriesService::getAllData(),
      //   'getactive'       => IndicatorCategoriesService::getAllDataActive(),
      //   default      => throw new ValidationException([
      //     'type' => 'Invalid type parameter'
      //   ])
      // };

      $type = Request::query('type') ?? 'default';

      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'getdata':
          $userLogueado = AuthMiddleware::authorize('states', 'read-only');
          return IndicatorCategoriesService::getAllData();
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
        
        default:
          throw new ApiException("Operación GET no válida.", 400);
      }
    });
  }

  public static function post() {
    self::handle(function () {

      // return match ($type) {
      //   'crud'      => IndicatorCategoriesService::setCRUD($body),
      //   'getnode'      => IndicatorCategoriesService::getCategoriesNode($body),
      //   'getactivenode'      => IndicatorCategoriesService::getActiveCategoriesNode($body),
      //   // 'getactivenode'   => $body,
      //   default      => throw new ValidationException([
      //     'type' => 'Invalid type parameter'
      //   ])
      // };
      
      $type = Request::query('type') ?? 'default';
      $body = Request::body();

      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'crud':
          $userLogueado = AuthMiddleware::authorize('indicator_categories', 'read-write');
          return IndicatorCategoriesService::setCRUD($body);
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
        case 'categoriesnode':
          return IndicatorCategoriesService::getCategoriesNode($body);
        default:
          throw new ApiException("Operación GET no válida.", 400);
      }
    });
  }
}
?>