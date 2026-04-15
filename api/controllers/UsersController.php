<?php
require_once BASE_PATH . '/services/UsersService.php';

class UsersController extends BaseController {

    public static function getAll() {
        self::handle(function() {
            // Validar que el token sea válido antes de entregar la lista
            AuthMiddleware::authenticate(); 
            
            $service = new UsersService();
            return $service->getAll();
        });
    }

    public static function create() {
        self::handle(function() {
            AuthMiddleware::authenticate();
            
            $body = Request::body();
            
            if (empty($body['name']) || empty($body['email']) || empty($body['username']) || empty($body['password']) || empty($body['role_id'])) {
                throw new ValidationException(["campos" => "Todos los campos son obligatorios"], "Datos incompletos");
            }

            if (!filter_var($body['email'], FILTER_VALIDATE_EMAIL)) {
                throw new ValidationException(["email" => "Formato de correo inválido"], "Error de validación");
            }

            $service = new UsersService();
            return $service->create($body);
        });
    }

    public static function update($id) {
        self::handle(function() use ($id) {
            AuthMiddleware::authenticate();
            
            $body = Request::body();
            
            if (empty($body['name']) || empty($body['email']) || empty($body['username']) || empty($body['role_id'])) {
                throw new ValidationException(["campos" => "Faltan datos requeridos para actualizar"], "Datos incompletos");
            }

            $service = new UsersService();
            return $service->update($id, $body);
        });
    }

    public static function status($id) {
        self::handle(function() use ($id) {
            AuthMiddleware::authenticate();
            
            $body = Request::body();
            
            if (!isset($body['status'])) {
                throw new ValidationException(["campos" => "El nuevo estatus es requerido"], "Datos incompletos");
            }

            $service = new UsersService();
            return $service->changeStatus($id, $body['status']);
        });
    }
}