<?php
  require_once 'controllers/IndicatorsController.php';

  $router->add('GET',  '/redim_backend/api/indicators', [IndicatorsController::class, 'get']);
  $router->add('POST', '/redim_backend/api/indicators', [IndicatorsController::class, 'post']);
?>