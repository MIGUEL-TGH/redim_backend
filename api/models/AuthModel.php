<?php
  use Firebase\JWT\JWT;
  use Firebase\JWT\Key;

  class AuthModel {

    // Sugerencia: En un futuro, pasa este string a un archivo de entorno (.env)
    // private static $secret_key = "appi-key"; 

    public static function generateJWT($data) {
      // return JWT::encode($data, self::$secret_key, 'HS256');
      return JWT::encode($data, $_ENV['JWT_SECRET'], 'HS256');
    }

    public static function parseJWT($token) {
      try {
        // En la versión 6 de php-jwt, se debe instanciar la clase Key
        // $decoded = JWT::decode($token, new Key(self::$secret_key, 'HS256'));
        $decoded = JWT::decode($token, new Key($_ENV['JWT_SECRET'], 'HS256'));
        return $decoded; 
      } catch (\Firebase\JWT\ExpiredException $e) {
        throw new ApiException("El token ha expirado. Por favor, inicie sesión de nuevo.", 401);
      } catch (\Exception $e) {
        throw new ApiException("Token inválido o no autorizado.", 401);
      }
    }
  }

?>