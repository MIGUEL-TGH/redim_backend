<?php
  require_once 'controllers/ActuamosStatePostsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/actuamos_state_posts', [ActuamosStatePostsController::class, 'get']);
  $router->add('POST', $basePath . '/actuamos_state_posts', [ActuamosStatePostsController::class, 'post']);
?>
