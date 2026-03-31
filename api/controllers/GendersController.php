<?php
require_once __DIR__ . '/../services/GendersService.php';

class GendersController extends BaseController {
  public static function get() {
    self::handle(function () {
      // $type = Request::query('type');
      
      // return match ($type) {
      //   'getdata'    => GendersService::getAllData(),
      //   'getactive'    => GendersService::getActiveData(),
      //   default      => throw new ValidationException([
      //     'type' => 'Invalid type parameter'
      //   ])
      // };
      $type = Request::query('type') ?? 'default';

      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'getdata':
          $userLogueado = AuthMiddleware::authorize('genders', 'read-only');
          return GendersService::getAllData();
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
        case 'getdatabysector':
          return GendersService::getDataBySelector();
        default:
          throw new ApiException("Operación GET no válida.", 400);
      }
    });
  }

  public static function post() {
    self::handle(function () {

      // $type = Request::query('type');
      // $body = Request::body();

      // return match ($type) {
      //   'crud' => GendersService::setCRUD($body),
      //   // 'crud' => $body,
      //   default      => throw new ValidationException([
      //     'type' => 'Invalid type parameter'
      //   ])
      // };

      $type = Request::query('type') ?? 'default';
      $body = Request::body();

      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'crud':
          $userLogueado = AuthMiddleware::authorize('genders', 'read-write');
          return GendersService::setCRUD($body);
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
       
        default:
          throw new ApiException("Operación GET no válida.", 400);
      }

    });
  }
}
?>