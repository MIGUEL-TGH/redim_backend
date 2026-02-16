<?php
class Request {
  public static function method() {
    return $_SERVER['REQUEST_METHOD'];
  }

  public static function body() {
    $raw = file_get_contents('php://input');
    return json_decode($raw, true) ?? [];
  }

  public static function query($key = null) {
    return $key ? ($_GET[$key] ?? null) : $_GET;
  }
}
?>