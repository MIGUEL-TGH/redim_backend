<?php
  require_once 'controllers/MapaStatePostsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/mapa_state_posts', [MapaStatePostsController::class, 'get']);
  $router->add('POST', $basePath . '/mapa_state_posts', [MapaStatePostsController::class, 'post']);
?>
