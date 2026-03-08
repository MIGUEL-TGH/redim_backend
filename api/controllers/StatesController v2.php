<?php
// require_once __DIR__ . '/../services/StatesService.php';
require_once BASE_PATH . '/middleware/AuthMiddleware.php';

class StatesController extends BaseController {
  public static function get() {
    self::handle(function () {
      
      // $type = Request::query('type');
      
      // return match ($type) {
      //   'getdata'         => StatesService::getAllData(),
      //   'getactive'    => StatesService::getActiveData(),
      //   default      => throw new ValidationException([
      //     'type' => 'Invalid type parameter'
      //   ])
      // };
      $type = isset($_GET['type']) ? $_GET['type'] : 'default';

      switch ($type) {
        case 'public_data':
          // 🔓 No llamamos al middleware
          return ["mensaje" => "Cualquiera puede ver esto"];

        case 'private_data':
          // 🔒 Protegido
          $usuario = AuthMiddleware::authenticate();
          return ["mensaje" => "Hola " . $usuario->data->name . ", esta es tu información privada"];
          
        default:
          throw new ApiException("Operación GET no válida.", 400);
      }
    });
  }

  public static function post() {
    self::handle(function () {

      // Obtenemos el tipo de operación de la URL (?type=...)
      $type = Request::query('type');
      $body = Request::body();

      // 3. Evaluamos qué acción se quiere realizar
      switch ($type) {
        
        case 'getactivebyid':
          // 🔓 RUTA PÚBLICA: No llamamos a AuthMiddleware
          
          if (empty($body['country_id'])) {
            throw new ValidationException(['type' => 'El country_id es requerido.'], 400);
          }
          
          // Simulamos la consulta a tu modelo
          // $states = StateModel::getActiveByCountry($body['country_id']);
          
          return [
            "success" => true,
            "result" => [
              ["id" => 1, "name" => "Puebla", "country_id" => $body['country_id']],
              ["id" => 2, "name" => "Jalisco", "country_id" => $body['country_id']]
            ]
          ];

        case 'create':
          // 🔒 RUTA PRIVADA: Llamamos al guardia de seguridad
          $usuarioLogueado = AuthMiddleware::authenticate();
          
          // Si el código llega a esta línea, el token es válido.
          // Aquí iría tu lógica para insertar un nuevo estado en la BD.
          
          return [
            "success" => true,
            "message" => "Estado creado correctamente por " . $usuarioLogueado->data->username
          ];

        case 'update':
          // 🔒 RUTA PRIVADA: También protegida
          AuthMiddleware::authenticate();
          
          return ["success" => true, "message" => "Estado actualizado"];

        default:
          throw new ApiException("Tipo de operación no válida.", 400);
      }


    });
  }
}

?>