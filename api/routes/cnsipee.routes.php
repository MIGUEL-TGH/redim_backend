<?php
  require_once 'controllers/CNSIPEEController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';

  $router->add('GET', $basePath . '/cnsipee', [CNSIPEEController::class, 'get']);
  $router->add('POST', $basePath . '/cnsipee', [CNSIPEEController::class, 'post']);

?>
