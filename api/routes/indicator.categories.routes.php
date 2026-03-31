<?php
  require_once 'controllers/IndicatorCategoriesController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/indicator_categories', [IndicatorCategoriesController::class, 'get']);
  $router->add('POST', $basePath . '/indicator_categories', [IndicatorCategoriesController::class, 'post']);
?>