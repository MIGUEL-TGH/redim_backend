<?php
  require_once 'controllers/VocesPodcastsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/voces_podcasts', [VocesPodcastsController::class, 'get']);
  $router->add('POST', $basePath . '/voces_podcasts', [VocesPodcastsController::class, 'post']);
?>
