<?php
require_once __DIR__ . '/../services/YearsService.php';

class YearsController extends BaseController {
  public static function get() {
    self::handle(function () {
      // $type = Request::query('type');
      // return match ($type) {
      //   'getdata'    => YearsService::getAllData(),
      //   'getactive'    => YearsService::getActiveData(),
      //   default      => throw new ValidationException([
      //     'type' => 'Invalid type parameter'
      //   ])
      // };

      $type = Request::query('type') ?? 'default';
      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'getdata':
          $userLogueado = AuthMiddleware::authorize('years', 'read-only');
          return YearsService::getAllData();
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
        case 'getdatabysector':
          return YearsService::getDataBySelector();
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
      //   'crud' => YearsService::setCRUD($body),
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
          $userLogueado = AuthMiddleware::authorize('years', 'read-write');
          return YearsService::setCRUD($body);
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
       
        default:
          throw new ApiException("Operación GET no válida.", 400);
      }
    });
  }
}
?>