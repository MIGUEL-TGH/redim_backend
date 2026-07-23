<?php
  require_once 'controllers/TvSocialButtonsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/tv_social_buttons', [TvSocialButtonsController::class, 'get']);
  $router->add('POST', $basePath . '/tv_social_buttons', [TvSocialButtonsController::class, 'post']);
?>
