<?php
  require_once 'controllers/TransparenciaSectionsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/transparencia_sections', [TransparenciaSectionsController::class, 'get']);
  $router->add('POST', $basePath . '/transparencia_sections', [TransparenciaSectionsController::class, 'post']);
?>
