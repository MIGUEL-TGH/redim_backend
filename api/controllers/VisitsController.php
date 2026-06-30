<?php
require_once BASE_PATH . '/services/VisitsService.php';
require_once BASE_PATH . '/middleware/AuthMiddleware.php';

class VisitsController extends BaseController {

  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';

      switch ($type) {
        // 🔒 Protegido: resumen para el panel
        case 'getdata':
          AuthMiddleware::authorize('visits', 'read-only');
          return VisitsService::getSummary();

        // 🔒 Protegido: serie diaria para gráficas
        case 'series':
          AuthMiddleware::authorize('visits', 'read-only');
          $days = (int) (Request::query('days') ?? 30);
          return VisitsService::getDailySeries($days);

        default:
          throw new ApiException("Operación GET no válida.", 400);
      }
    });
  }

  public static function post() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      $body = Request::body();

      switch ($type) {
        // 🔓 Público: registrar una visita. Sin AuthMiddleware (lo golpean visitantes anónimos).
        case 'hit':
          return VisitsService::registerHit($body);

        default:
          throw new ValidationException(["type" => "Tipo de operación no válida o ausente."], "Error de petición");
      }
    });
  }
}
?>
