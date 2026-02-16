<?php
class Router {
  private array $routes = [];

  public function add($method, $path, $handler) {
    $this->routes[] = compact('method', 'path', 'handler');
  }

  public function dispatch() {
    $uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
    $method = $_SERVER['REQUEST_METHOD'];

    foreach ($this->routes as $route) {
      if ($route['method'] === $method && $route['path'] === $uri) {
        call_user_func($route['handler']);
        return;
      }
    }

    Response::error('Not Found', 404);
  }
}
?>