<?php
  require_once 'controllers/MiradasContestLinksController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';
  $router->add('GET',  $basePath . '/miradas_contest_links', [MiradasContestLinksController::class, 'get']);
  $router->add('POST', $basePath . '/miradas_contest_links', [MiradasContestLinksController::class, 'post']);
?>
