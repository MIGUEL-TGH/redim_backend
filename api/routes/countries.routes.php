<?php
  require_once 'controllers/CountriesController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/countries', [CountriesController::class, 'get']);
  $router->add('POST', $basePath . '/countries', [CountriesController::class, 'post']);
?>