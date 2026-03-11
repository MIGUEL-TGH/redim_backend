<?php
require_once BASE_PATH . '/models/AuthModel.php';
require_once BASE_PATH . '/core/exceptions/ApiException.php';

class AuthMiddleware {

  public static function authenticate() {
    // 1. Obtener los headers de la petición (soporte cruzado para Apache/Nginx)
    $headers = null;
    if (isset($_SERVER['Authorization'])) {
        $headers = trim($_SERVER["Authorization"]);
    } else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { // Nginx o fast CGI
        $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
    } elseif (function_exists('apache_request_headers')) {
        $requestHeaders = apache_request_headers();
        $requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders), array_fill(0, count($requestHeaders), '-')), array_values($requestHeaders));
        if (isset($requestHeaders['Authorization'])) {
            $headers = trim($requestHeaders['Authorization']);
        }
    }

    // 2. Verificar que el header exista y tenga el formato "Bearer {token}"
    if (empty($headers) || !preg_match('/Bearer\s(\S+)/', $headers, $matches)) {
      throw new ApiException("Acceso denegado. No se proporcionó un token de autorización.", 401);
    }

    // 3. Extraer el token
    $token = $matches[1];

    // 4. Validar el token. Si es inválido, parseJWT lanzará una excepción
    // $decodedData = AuthModel::parseJWT($token);
    $decodedData = AuthModel::verifyJWT($token);

    // 5. Retornamos la información del token por si el controlador necesita saber quién es el usuario logueado
    return clone $decodedData; 
  }
}
?>