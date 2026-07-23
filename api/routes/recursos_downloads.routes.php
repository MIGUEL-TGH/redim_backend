<?php
  require_once 'controllers/RecursosDownloadsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/recursos_downloads', [RecursosDownloadsController::class, 'get']);
  $router->add('POST', $basePath . '/recursos_downloads', [RecursosDownloadsController::class, 'post']);
?>
