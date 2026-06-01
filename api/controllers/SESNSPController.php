<?php
// require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once BASE_PATH . '/services/SESNSPService.php';

class SESNSPController extends BaseController {

  private const MODULE = 'sesnsp';
  // $userAuthenticate = AuthMiddleware::authenticate();
  // $userAuthorize = AuthMiddleware::authorize(self::MODULE, 'read-only');
  // $userAuthorize = AuthMiddleware::authorize(self::MODULE, 'read-write');

  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';

      // return ['message_states' => $type];
      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'getdata':
          $userAuthenticate = AuthMiddleware::authenticate();
          return SESNSPService::getAllData();
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
        case 'getactive':
          return SESNSPService::getActiveData();
        case 'getdatabysector':
          return SESNSPService::getDataBySelector();
        case 'public_data':
          return ["mensaje" => "Cualquiera puede ver esto"];
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
          return SESNSPService::setCRUD($body);
        case 'getactivebyid': // TEST

          // AuthMiddleware::authenticate();
          // return SESNSPService::getActiveDataById($body);
          
          return [
            "success" => true,
            "message" => 'Ruta protegida accedida correctamente. ¡Aquí están los estados activos para el country_id proporcionado!',
            "result" => [
              ["id" => 1, "name" => "Puebla", "country_id" => $body['country_id']],
              ["id" => 2, "name" => "Jalisco", "country_id" => $body['country_id']]
            ]
          ];


        case 'getactivebyid_public':
          // 🔓 RUTA PÚBLICA: No llamamos a AuthMiddleware
          
          if (empty($body['country_id'])) {
            throw new ValidationException(['type' => 'El country_id es requerido.'], '400');
          }
          
          return SESNSPService::getActiveDataById($body);

          // Simulamos la consulta a tu modelo
          // $states = StateModel::getActiveByCountry($body['country_id']);
          
          // return [
          //   "success" => true,
          //   "result" => [
          //     ["id" => 1, "name" => "Puebla", "country_id" => $body['country_id']],
          //     ["id" => 2, "name" => "Jalisco", "country_id" => $body['country_id']]
          //   ]
          // ];

        case 'create':  // TEST
          // 🔒 RUTA PRIVADA: Llamamos al guardia de seguridad
          $userLogueado = AuthMiddleware::authenticate();
          
          return [
            "success" => true,
            "message" => "Ruta protegida accedida correctamente. ¡Estado creado!",
            // "realizado_por" => $userLogueado,
            "realizado_por" => $userLogueado->data->name,
            "email_contacto" => $userLogueado->data->email,
            "datos_recibidos" => $body
          ];
          // return [
          //   "success" => true,
          //   "message" => "Estado creado correctamente por " . $userLogueado->data->username
          // ];

        case 'update':  // TEST
          // 🔒 RUTA PRIVADA: También protegida
          AuthMiddleware::authenticate();
          
          return ["success" => true, "message" => "Estado actualizado"];

        default:
          // throw new ApiException("Tipo de operación no válida.", 400);
          throw new ValidationException(["type" => "Tipo de operación no válida o ausente."], "Error de petición");
      }

    });
  }
}

?>