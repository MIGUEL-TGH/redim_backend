<?php
require_once __DIR__ . '/../services/IndicatorsService.php';

class IndicatorsController extends BaseController {
  public static function get() {
    self::handle(function () {
      
      // $type = Request::query('type');
      $type = Request::query('type') ?? 'default';
      
      // return match ($type) {
      //   'getdata'    => IndicatorsService::getAllData(),
      //   'getactive'    => IndicatorsService::getActiveData(),
      //   'getwithdata'    => IndicatorsService::getIndicatorsWithData(),                ✔✔
      //   'getwithcategories'    => IndicatorsService::getIndicatorsWithCategories(),
      //   default      => throw new ValidationException([
      //     'type' => 'Invalid type parameter'
      //   ])
      // };

      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'getdata':
          $userLogueado = AuthMiddleware::authorize('indicators', 'read-only');
          return IndicatorsService::getAllData();
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
        case 'getwithdata':
          return IndicatorsService::getIndicatorsWithData();
        case 'getdatabysector':
        return IndicatorsService::getDataBySelector();
          // case 'getactive':
        //   return IndicatorsService::getActiveData();

        default:
          throw new ApiException("Operación GET no válida.", 400);
        // default      => throw new ValidationException([
        //   'type' => 'Invalid type parameter'
        // ])
      }

    });
  }

  public static function post() {
    self::handle(function () {

      $type = Request::query('type') ?? 'default';
      $body = Request::body();

      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'crud':
          $userLogueado = AuthMiddleware::authorize('indicators', 'read-write');
          return IndicatorsService::setCRUD($body);
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
        default:
          throw new ValidationException(["type" => "Tipo de operación no válida o ausente."], "Error de petición");
      }
    });
  }
}
?>