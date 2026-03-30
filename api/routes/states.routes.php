<?php
  require_once 'controllers/StatesController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';

  $router->add('GET', $basePath . '/states', [StatesController::class, 'get']);
  $router->add('POST', $basePath . '/states', [StatesController::class, 'post']);


  // $router->add('GET',  '/redim_backend/api/states', [StatesController::class, 'get']);
  // $router->add('POST', '/redim_backend/api/states', [StatesController::class, 'post']);
  // $router->add('POST', '/redim_backend/api/states', [StateController::class, 'post']);
?>