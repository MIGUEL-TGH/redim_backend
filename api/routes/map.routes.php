<?php
require_once 'controllers/MapController.php';

$router->add('GET',  '/redim_backend/api/map', [MapController::class, 'get']);
$router->add('POST', '/redim_backend/api/map', [MapController::class, 'post']);
?>