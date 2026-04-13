<?php
  use Firebase\JWT\JWT;
  use Firebase\JWT\Key;
 
  class AuthModel {

    public static function generateJWT($data) {
      return JWT::encode($data, $_ENV['JWT_SECRET'], 'HS256');
    }

    public static function verifyJWT($token) {
      try {
        // Al instanciar Key, Firebase\JWT verifica automáticamente la firma y la caducidad
        $decoded = JWT::decode($token, new Key($_ENV['JWT_SECRET'], 'HS256'));
        return $decoded; 
      } catch (\Firebase\JWT\ExpiredException $e) {
        // El token superó su tiempo de vida ('exp')
        throw new ApiException("El token ha expirado. Por favor, inicie sesión de nuevo.", 401);
      } catch (\Exception $e) {
        // La firma fue alterada, el token está corrupto o se usó un algoritmo distinto
        throw new ApiException("Token inválido o no autorizado.", 401);
      }
    }

  }

?>