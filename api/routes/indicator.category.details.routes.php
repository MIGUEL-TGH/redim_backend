<?php
  require_once 'controllers/IndicatorCategoryDetailsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/indicator_category_details', [IndicatorCategoryDetailsController::class, 'get']);
  $router->add('POST', $basePath . '/indicator_category_details', [IndicatorCategoryDetailsController::class, 'post']);
?>