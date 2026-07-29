<?php
  require_once 'controllers/HelpSettingsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/help_settings', [HelpSettingsController::class, 'get']);
  $router->add('POST', $basePath . '/help_settings', [HelpSettingsController::class, 'post']);
?>
