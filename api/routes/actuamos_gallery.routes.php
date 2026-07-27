<?php
  require_once 'controllers/ActuamosGalleryController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/actuamos_gallery', [ActuamosGalleryController::class, 'get']);
  $router->add('POST', $basePath . '/actuamos_gallery', [ActuamosGalleryController::class, 'post']);
?>
