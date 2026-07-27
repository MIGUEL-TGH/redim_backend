<?php
  require_once 'controllers/ActuamosAccionesController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/actuamos_acciones', [ActuamosAccionesController::class, 'get']);
  $router->add('POST', $basePath . '/actuamos_acciones', [ActuamosAccionesController::class, 'post']);
?>
