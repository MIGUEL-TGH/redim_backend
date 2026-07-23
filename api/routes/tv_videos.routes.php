<?php
  require_once 'controllers/TvVideosController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/tv_videos', [TvVideosController::class, 'get']);
  $router->add('POST', $basePath . '/tv_videos', [TvVideosController::class, 'post']);
?>
