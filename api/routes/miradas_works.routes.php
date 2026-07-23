<?php
  require_once 'controllers/MiradasWorksController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/miradas_works', [MiradasWorksController::class, 'get']);
  $router->add('POST', $basePath . '/miradas_works', [MiradasWorksController::class, 'post']);
?>
