<?php
  require_once 'controllers/GendersController.php';

  $router->add('GET',  '/redim_backend/api/genders', [GendersController::class, 'get']);
  $router->add('POST', '/redim_backend/api/genders', [GendersController::class, 'post']);
?>