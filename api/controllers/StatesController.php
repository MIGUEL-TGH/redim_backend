<?php
require_once BASE_PATH . '/middleware/AuthMiddleware.php';
require_once BASE_PATH . '/services/StatesService.php';

class StatesController extends BaseController {
  public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';

      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'getdata':
          // $userLogueado = AuthMiddleware::authenticate();
          $userLogueado = AuthMiddleware::authorize('states', 'read-only');
          return StatesService::getAllData();
        case 'getactive':
          $userLogueado = AuthMiddleware::authorize('states', 'read-only');
          return StatesService::getActiveData();
        // 🔓 Público, sin AuthMiddleware ==========================================================================================
        case 'getdatabysector':
          return StatesService::getDataBySelector();
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
          $userLogueado = AuthMiddleware::authorize('states', 'read-write');
          return StatesService::setCRUD($body);
        case 'getactivebyid':

          // AuthMiddleware::authenticate();
          // return StatesService::getActiveDataById($body);
          
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
          
          return StatesService::getActiveDataById($body);

          // Simulamos la consulta a tu modelo
          // $states = StateModel::getActiveByCountry($body['country_id']);
          
          // return [
          //   "success" => true,
          //   "result" => [
          //     ["id" => 1, "name" => "Puebla", "country_id" => $body['country_id']],
          //     ["id" => 2, "name" => "Jalisco", "country_id" => $body['country_id']]
          //   ]
          // ];

        case 'create':
          // 🔒 RUTA PRIVADA: Llamamos al guardia de seguridad
          $userLogueado = AuthMiddleware::authenticate();
          
          // Si el código llega a esta línea, el token es válido.
          // Aquí iría tu lógica para insertar un nuevo estado en la BD.
          return [
            "success" => true,
            "message" => "Ruta protegida accedida correctamente. ¡Estado creado!",
            "realizado_por" => $userLogueado->data->username,
            "email_contacto" => $userLogueado->data->email,
            "datos_recibidos" => $body
          ];
          // return [
          //   "success" => true,
          //   "message" => "Estado creado correctamente por " . $userLogueado->data->username
          // ];

        case 'update':
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