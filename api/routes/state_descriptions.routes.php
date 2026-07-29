<?php
  require_once 'controllers/StateDescriptionsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/state_descriptions', [StateDescriptionsController::class, 'get']);
  $router->add('POST', $basePath . '/state_descriptions', [StateDescriptionsController::class, 'post']);
?>
