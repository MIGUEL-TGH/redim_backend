<?php
class Cors {
  public static function handle() {
    // Lista blanca de origenes permitidos (configurable en .env):
    //   CORS_ALLOWED_ORIGINS=http://localhost:8080,https://ninezprimero.aularedim.net
    $allowed = array_filter(array_map('trim', explode(',', $_ENV['CORS_ALLOWED_ORIGINS'] ?? '')));
    $origin  = $_SERVER['HTTP_ORIGIN'] ?? '';

    // Solo se refleja el origen si esta en la lista blanca (ya no se usa '*')
    if ($origin !== '' && in_array($origin, $allowed, true)) {
      header('Access-Control-Allow-Origin: ' . $origin);
      header('Vary: Origin');
      header('Access-Control-Allow-Credentials: true');
    }

    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, Authorization, x-authorization, X-Requested-With');
    header('Content-Type: application/json; charset=utf-8');

    if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
      http_response_code(200);
      exit;
    }
  }
}
?>
