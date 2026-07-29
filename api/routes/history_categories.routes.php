<?php
  require_once 'controllers/HistoryCategoriesController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/history_categories', [HistoryCategoriesController::class, 'get']);
  $router->add('POST', $basePath . '/history_categories', [HistoryCategoriesController::class, 'post']);
?>
