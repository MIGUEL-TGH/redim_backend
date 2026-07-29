<?php
require_once __DIR__ . '/../services/IndicatorCategoryDetailsService.php';

class IndicatorCategoryDetailsController extends BaseController {
  // No hay endpoint GET sin filtro: la tabla tiene ~95,000 registros y
  // siempre debe consultarse acotada por categoría (ver post() -> getdatabyid).
  public static function post() {
    self::handle(function () {

      $type = Request::query('type');
      $body = Request::body();

      return match ($type) {
        'crud' => (function () use ($body) {
          AuthMiddleware::authorize('indicator_category_details', 'read-write');
          return IndicatorCategoryDetailsService::setCRUD($body);
        })(),
        'getdatabyid' => (function () use ($body) {
          AuthMiddleware::authorize('indicator_category_details', 'read-only');
          return IndicatorCategoryDetailsService::getAllDataByID($body);
        })(),
        default      => throw new ValidationException([
          'type' => 'Invalid type parameter'
        ])
      };
    });
  }
}
?>