<?php
  require_once 'controllers/IndicatorsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/indicators', [IndicatorsController::class, 'get']);
  $router->add('POST', $basePath . '/indicators', [IndicatorsController::class, 'post']);
?>