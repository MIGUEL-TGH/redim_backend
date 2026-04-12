<?php
require_once BASE_PATH . '/models/AuthModel.php';
require_once BASE_PATH . '/core/exceptions/ApiException.php';
 
class AuthMiddleware {

  public static function authenticate() {
    // 1. Obtener los headers de la petición (soporte cruzado para Apache/Nginx)
    $headers = null;
    // =======================================================================================================================
    // if (isset($_SERVER['Authorization'])) {
    //     $headers = trim($_SERVER["Authorization"]);
    // } else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { // Nginx o fast CGI
    //     $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
    // } elseif (function_exists('apache_request_headers')) {
    //     $requestHeaders = apache_request_headers();
    //     $requestHeaders = array_combine(array_map('ucwords', array_keys($requestHeaders), array_fill(0, count($requestHeaders), '-')), array_values($requestHeaders));
    //     if (isset($requestHeaders['Authorization'])) {
    //         $headers = trim($requestHeaders['Authorization']);
    //     }
    // }
  
    // =======================================================================================================================
    // =======================================================================================================================
    if (isset($_SERVER['HTTP_X_AUTHORIZATION'])) {
        $headers = trim($_SERVER["HTTP_X_AUTHORIZATION"]);
    } else if (isset($_SERVER['Authorization'])) {
        $headers = trim($_SERVER["Authorization"]);
    } else if (isset($_SERVER['HTTP_AUTHORIZATION'])) { 
        $headers = trim($_SERVER["HTTP_AUTHORIZATION"]);
    } else if (isset($_SERVER['REDIRECT_HTTP_AUTHORIZATION'])) { 
        $headers = trim($_SERVER["REDIRECT_HTTP_AUTHORIZATION"]);
    }

    // =======================================================================================================================
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

  public static function authorize($module, $requiredLevel = 'read-only') {
    // 1. Primero autenticamos para asegurar que el token es válido
    $decodedData = self::authenticate();
    $user = $decodedData->data;

    $hasAccess = false;
    $userPermissionLevel = null;

    // 2. Buscamos el módulo dentro del arreglo de permisos del usuario
    if (isset($user->permissions) && is_array($user->permissions)) {
      foreach ($user->permissions as $perm) {
        if ($perm->module === $module) {
          $hasAccess = true;
          $userPermissionLevel = $perm->permission;
          break;
        }
      }
    }

    // 3. Validar si ni siquiera tiene el módulo asignado
    if (!$hasAccess) {
      throw new ApiException("Acceso denegado. No tienes permisos para acceder al módulo: {$module}", 403);
    }

    // 4. Validar el nivel de permiso (Si la ruta exige read-write, y el usuario tiene read-only)
    if ($requiredLevel === 'read-write' && $userPermissionLevel !== 'read-write') {
      throw new ApiException("Acceso denegado. Solo tienes permisos de lectura para realizar esta acción.", 403);
    }

    // 5. Si pasa todas las validaciones, retornamos los datos del usuario para el controlador
    return $decodedData;
  }
}
?>