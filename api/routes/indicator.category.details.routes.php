<?php
  require_once 'controllers/IndicatorCategoryDetailsController.php';

  $router->add('GET',  '/redim_backend/api/indicator_category_details', [IndicatorCategoryDetailsController::class, 'get']);
  $router->add('POST', '/redim_backend/api/indicator_category_details', [IndicatorCategoryDetailsController::class, 'post']);
?>