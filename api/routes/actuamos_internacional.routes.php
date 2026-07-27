<?php
  require_once 'controllers/ActuamosInternacionalController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/actuamos_internacional', [ActuamosInternacionalController::class, 'get']);
  $router->add('POST', $basePath . '/actuamos_internacional', [ActuamosInternacionalController::class, 'post']);
?>
