<?php
  require_once 'controllers/IndicatorCategoryDetailsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('POST', $basePath . '/indicator_category_details', [IndicatorCategoryDetailsController::class, 'post']);
?>