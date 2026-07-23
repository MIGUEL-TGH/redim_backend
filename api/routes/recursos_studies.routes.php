<?php
  require_once 'controllers/RecursosStudiesController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/recursos_studies', [RecursosStudiesController::class, 'get']);
  $router->add('POST', $basePath . '/recursos_studies', [RecursosStudiesController::class, 'post']);
?>
