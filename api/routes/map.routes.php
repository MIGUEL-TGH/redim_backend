<?php
    require_once 'controllers/MapController.php';

    $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
    $router->add('GET',  $basePath . '/map', [MapController::class, 'get']);
    $router->add('POST', $basePath . '/map', [MapController::class, 'post']);
?>