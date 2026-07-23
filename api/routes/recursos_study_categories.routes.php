<?php
  require_once 'controllers/RecursosStudyCategoriesController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/recursos_study_categories', [RecursosStudyCategoriesController::class, 'get']);
  $router->add('POST', $basePath . '/recursos_study_categories', [RecursosStudyCategoriesController::class, 'post']);
?>
