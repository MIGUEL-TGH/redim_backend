<?php
  require_once 'controllers/CentersController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/centers', [CentersController::class, 'get']);
  $router->add('POST', $basePath . '/centers', [CentersController::class, 'post']);
?>