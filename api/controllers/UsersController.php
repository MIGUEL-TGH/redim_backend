<?php
require_once BASE_PATH . '/services/UsersService.php';

class UsersController extends BaseController {
    public static function get() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';

      switch ($type) {
        // 🔒 Protegido ============================================================================================================
        case 'getdata':
          // $userLogueado = AuthMiddleware::authorize('users', 'read-only');
          return UsersService::getAllData();
        // case 'getactive':
        //   $userLogueado = AuthMiddleware::authorize('users', 'read-only');
        //   return StatesService::getActiveData();
        // // 🔓 Público, sin AuthMiddleware ==========================================================================================
        // case 'getdatabysector':
        //   return StatesService::getDataBySelector();
        // case 'public_data':
        //   return ["mensaje" => "Cualquiera puede ver esto"];
        default:
          throw new ApiException("Operación GET no válida.", 400);
      }
    });
  }

  public static function post() {
    self::handle(function () {
      $type = Request::query('type') ?? 'default';
      $body = Request::body();
      return ['message' => 'En desarrollo'];
  
      switch ($type) {
        // case 'crud': // 🔒 Protegido
          // $userLogueado = AuthMiddleware::authorize('users', 'read-write');
          // return StatesService::setCRUD($body);
        case 'getactivebyid': // TEST

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

        case 'create':  // TEST
          // 🔒 RUTA PRIVADA: Llamamos al guardia de seguridad
          $userLogueado = AuthMiddleware::authenticate();
          
          // Si el código llega a esta línea, el token es válido.
          // Aquí iría tu lógica para insertar un nuevo estado en la BD.
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


    // public static function getAll() {
    //     self::handle(function() {
    //         // Validar que el token sea válido antes de entregar la lista
    //         AuthMiddleware::authenticate(); 
            
    //         $service = new UsersService();
    //         return $service->getAll();
    //     });
    // }

    // public static function create() {
    //     self::handle(function() {
    //         AuthMiddleware::authenticate();
            
    //         $body = Request::body();
            
    //         if (empty($body['name']) || empty($body['email']) || empty($body['username']) || empty($body['password']) || empty($body['role_id'])) {
    //             throw new ValidationException(["campos" => "Todos los campos son obligatorios"], "Datos incompletos");
    //         }

    //         if (!filter_var($body['email'], FILTER_VALIDATE_EMAIL)) {
    //             throw new ValidationException(["email" => "Formato de correo inválido"], "Error de validación");
    //         }

    //         $service = new UsersService();
    //         return $service->create($body);
    //     });
    // }

    // public static function update($id) {
    //     self::handle(function() use ($id) {
    //         AuthMiddleware::authenticate();
            
    //         $body = Request::body();
            
    //         if (empty($body['name']) || empty($body['email']) || empty($body['username']) || empty($body['role_id'])) {
    //             throw new ValidationException(["campos" => "Faltan datos requeridos para actualizar"], "Datos incompletos");
    //         }

    //         $service = new UsersService();
    //         return $service->update($id, $body);
    //     });
    // }

    // public static function status($id) {
    //     self::handle(function() use ($id) {
    //         AuthMiddleware::authenticate();
            
    //         $body = Request::body();
            
    //         if (!isset($body['status'])) {
    //             throw new ValidationException(["campos" => "El nuevo estatus es requerido"], "Datos incompletos");
    //         }

    //         $service = new UsersService();
    //         return $service->changeStatus($id, $body['status']);
    //     });
    // }
}