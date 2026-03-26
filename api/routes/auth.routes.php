<?php
  require_once 'controllers/AuthController.php';
  
  // Ruta base del entorno, o por defecto usamos '/api'
  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';

  // Ruta para iniciar sesión
  $router->add('POST', $basePath . '/auth/login', [AuthController::class, 'login']);

  // Ruta para reiniciar token
  $router->add('POST', $basePath . '/auth/refresh', [AuthController::class, 'refresh']);

  // Ruta para registrar (crear) un usuario
  $router->add('POST', $basePath . '/auth/register', [AuthController::class, 'register']);

  // ==========================================================================================================
  
  // // Ruta para iniciar sesión
  // $router->add('POST', '/redim_backend/api/auth/login', [AuthController::class, 'login']);

  // // Ruta para reiniciar token
  // $router->add('POST', '/redim_backend/api/auth/refresh', [AuthController::class, 'refresh']);

  // // Ruta para registrar (crear) un usuario
  // $router->add('POST', '/redim_backend/api/auth/register', [AuthController::class, 'register']);
?>