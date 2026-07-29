<?php
  require_once 'controllers/TransparenciaDocsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/transparencia_docs', [TransparenciaDocsController::class, 'get']);
  $router->add('POST', $basePath . '/transparencia_docs', [TransparenciaDocsController::class, 'post']);
?>
