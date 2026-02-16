<?php
use Firebase\JWT\JWT;

class AuthModel {

  public static function generateJWT($data) {
    $key = "appi-key";
    return JWT::encode($data, $key, 'HS256');
  }

  public static function parseJWT($token) {
    // lógica de token
  }
}
?>