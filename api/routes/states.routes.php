<?php
  require_once 'controllers/StatesController.php';

  $router->add('GET',  '/redim_backend/api/states', [StatesController::class, 'get']);
  $router->add('POST', '/redim_backend/api/states', [StatesController::class, 'post']);
?>