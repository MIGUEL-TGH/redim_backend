<?php
require_once BASE_PATH . '/services/AuthService.php';

class AuthController extends BaseController {

  public static function login() {
    self::handle(function() {
      $body = Request::body();

      if (empty($body['identifier']) || empty($body['password'])) {
        throw new ValidationException(
          ["campos" => "El identificador (email/usuario) y la contraseña son requeridos."], 
          "Error de validación"
        );
      }

      $authService = new AuthService();
      return $authService->login($body['identifier'], $body['password']);
    });
  }

  public static function register() {
    self::handle(function() {
      $body = Request::body(); 
      
      // 1. Validar que vengan todos los campos obligatorios
      if (empty($body['name']) || empty($body['email']) || empty($body['username']) || empty($body['password'])) {
        // Pasamos el arreglo de errores, y un string como segundo parámetro
        throw new ValidationException(
          ["campos" => "Los campos nombre, email, usuario y contraseña son obligatorios."], 
          "Error de validación de datos"
        );
      }

      // 2. Validación básica de formato de correo
      if (!filter_var($body['email'], FILTER_VALIDATE_EMAIL)) {
        throw new ValidationException(
          ["email" => "El formato del correo electrónico no es válido."], 
          "Error de validación de datos"
        );
      }

      // 3. (Opcional pero recomendado) Medida de seguridad para evitar registros masivos de extraños.
      // Puedes requerir que te envíen un "master_key" en el JSON que coincida con uno en tu .env
      if (empty($body['master_key']) || $body['master_key'] !== $_ENV['MASTER_KEY']) {
        throw new ApiException("No tienes autorización para registrar usuarios.", 403);
      }

      // Respuesta temporal para probar que todo pasa
      // return [
      //   "success" => true,
      //   "message" => "Todas las validaciones pasaron. Master Key correcta: " . $_ENV['MASTER_KEY'],
      //   "data" => $body
      // ];

      // 4. Ejecutar el registro
      $authService = new AuthService();
      return $authService->register($body);
    });
  }

  public static function refresh() {
    self::handle(function() {
      // 1. Obtener los headers de la petición
      $headers = getallheaders();
      
      // Buscar el header de Authorization (soporte para diferentes servidores)
      $authHeader = $headers['Authorization'] ?? $headers['authorization'] ?? '';

      // 2. Validar que exista el Bearer token
      if (empty($authHeader) || !preg_match('/Bearer\s(\S+)/', $authHeader, $matches)) {
        throw new ApiException("Token no proporcionado o formato inválido.", 401);
      }

      $token = $matches[1];

      // 3. Pasar el token al servicio para su renovación
      $authService = new AuthService();
      return $authService->refresh($token);
    });
  }
  
}
?>