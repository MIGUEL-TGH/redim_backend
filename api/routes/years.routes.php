<?php
require_once 'controllers/YearsController.php';

$router->add('GET',  '/redim_backend/api/years', [YearsController::class, 'get']);
$router->add('POST', '/redim_backend/api/years', [YearsController::class, 'post']);
?>