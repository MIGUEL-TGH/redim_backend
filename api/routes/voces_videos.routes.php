<?php
  require_once 'controllers/VocesVideosController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/voces_videos', [VocesVideosController::class, 'get']);
  $router->add('POST', $basePath . '/voces_videos', [VocesVideosController::class, 'post']);
?>
