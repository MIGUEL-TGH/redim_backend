<?php
require_once 'controllers/YearsController.php';

$basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
$router->add('GET',  $basePath . '/years', [YearsController::class, 'get']);
$router->add('POST', $basePath . '/years', [YearsController::class, 'post']);
?>