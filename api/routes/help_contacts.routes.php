<?php
  require_once 'controllers/HelpContactsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/help_contacts', [HelpContactsController::class, 'get']);
  $router->add('POST', $basePath . '/help_contacts', [HelpContactsController::class, 'post']);
?>
