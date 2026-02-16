<?php
  require_once 'controllers/CountriesController.php';

  $router->add('GET',  '/redim_backend/api/countries', [CountriesController::class, 'get']);
  $router->add('POST', '/redim_backend/api/countries', [CountriesController::class, 'post']);
?>