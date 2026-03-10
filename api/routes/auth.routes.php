<?php
  require_once 'controllers/AuthController.php';
  
  // Ruta para iniciar sesión
  $router->add('POST', '/redim_backend/api/auth/login', [AuthController::class, 'login']);

  // Ruta para reiniciar token
  $router->add('POST', '/redim_backend/api/auth/refresh', [AuthController::class, 'refresh']);

  // Ruta para registrar (crear) un usuario
  $router->add('POST', '/redim_backend/api/auth/register', [AuthController::class, 'register']);
?>