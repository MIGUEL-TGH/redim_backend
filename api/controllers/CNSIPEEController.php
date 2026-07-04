<?php
// require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once BASE_PATH . '/services/CNSIPEEService.php';

class CNSIPEEController extends BaseController {

  private const MODULE = 'cnsipee';

  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';

      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'getdata':
          $userAuthenticate = AuthMiddleware::authenticate();
          return CNSIPEEService::getAllData();
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
        case 'getactive':
          return CNSIPEEService::getActiveData();
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
        case 'crud': // 🔒 Protegido
          $userAuthorize = AuthMiddleware::authorize(self::MODULE, 'read-write');
          return CNSIPEEService::setCRUD($body);
        default:
          throw new ValidationException(["type" => "Tipo de operación no válida o ausente."], "Error de petición");
      }

    });
  }
}

?>
