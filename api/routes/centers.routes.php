<?php
  require_once 'controllers/CentersController.php';

  $router->add('GET',  '/redim_backend/api/centers', [CentersController::class, 'get']);
  $router->add('POST', '/redim_backend/api/centers', [CentersController::class, 'post']);
?>