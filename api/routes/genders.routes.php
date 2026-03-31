<?php
  require_once 'controllers/GendersController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/genders', [GendersController::class, 'get']);
  $router->add('POST', $basePath . '/genders', [GendersController::class, 'post']);
?>