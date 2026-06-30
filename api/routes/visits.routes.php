<?php
  require_once 'controllers/VisitsController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';

  // GET  -> ?type=getdata (resumen, protegido) | ?type=series (protegido)
  $router->add('GET', $basePath . '/visits', [VisitsController::class, 'get']);

  // POST -> ?type=hit (registrar visita, público)
  $router->add('POST', $basePath . '/visits', [VisitsController::class, 'post']);

?>
