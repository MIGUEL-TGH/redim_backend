<?php
  require_once 'controllers/VocesTestimonialsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/voces_testimonials', [VocesTestimonialsController::class, 'get']);
  $router->add('POST', $basePath . '/voces_testimonials', [VocesTestimonialsController::class, 'post']);
?>
