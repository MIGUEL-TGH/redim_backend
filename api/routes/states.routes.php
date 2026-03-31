<?php
  require_once 'controllers/StatesController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';

  $router->add('GET', $basePath . '/states', [StatesController::class, 'get']);
  $router->add('POST', $basePath . '/states', [StatesController::class, 'post']);
?>