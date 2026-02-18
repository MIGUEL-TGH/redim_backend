<?php
  require_once 'controllers/IndicatorCategoriesController.php';

  $router->add('GET',  '/redim_backend/api/indicator_categories', [IndicatorCategoriesController::class, 'get']);
  $router->add('POST', '/redim_backend/api/indicator_categories', [IndicatorCategoriesController::class, 'post']);
?>