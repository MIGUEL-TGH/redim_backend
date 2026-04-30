<?php
  require_once 'controllers/SESNSPController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';

  $router->add('GET', $basePath . '/sesnsp', [SESNSPController::class, 'get']);
  $router->add('POST', $basePath . '/sesnsp', [SESNSPController::class, 'post']);

?>