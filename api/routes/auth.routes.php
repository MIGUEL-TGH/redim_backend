<?php
  // require_once 'controllers/AuthController.php';
  // $router->add('POST', '/redim_backend/api/auth/login', [AuthController::class, 'login']);

  require_once 'controllers/AuthController.php';
  
  // Ruta para iniciar sesión
  $router->add('POST', '/redim_backend/api/auth/login', [AuthController::class, 'login']);

  // Ruta para registrar (crear) un usuario
  $router->add('POST', '/redim_backend/api/auth/register', [AuthController::class, 'register']);
?>