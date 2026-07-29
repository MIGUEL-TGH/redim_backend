<?php
  require_once 'controllers/HistoryCategoryDetailsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/history_category_details', [HistoryCategoryDetailsController::class, 'get']);
  $router->add('POST', $basePath . '/history_category_details', [HistoryCategoryDetailsController::class, 'post']);
?>
