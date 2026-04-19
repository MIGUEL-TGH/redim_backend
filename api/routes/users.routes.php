<?php
  require_once 'controllers/UsersController.php';

  $basePath = isset($_ENV['API_BASE_PATH']) ? $_ENV['API_BASE_PATH'] : '/api';

  $router->add('GET', $basePath . '/users', [UsersController::class, 'get']);
  $router->add('POST', $basePath . '/users', [UsersController::class, 'post']);

  // ===========================================================================================



  // // Obtener todos los usuarios
  // $router->get('/users', ['UsersController', 'getAll']);

  // // Crear nuevo usuario
  // $router->post('/users', ['UsersController', 'create']);

  // // Actualizar usuario existente (Dependiendo de cómo esté tu crudMixin, puede ser POST o PUT, asumo POST o PUT)
  // $router->put('/users/{id}', ['UsersController', 'update']); 
  // $router->post('/users/{id}', ['UsersController', 'update']); // Alternativa por si usas FormData

  // // Cambiar estatus de usuario
  // $router->put('/users/status/{id}', ['UsersController', 'status']);
  // $router->post('/users/status/{id}', ['UsersController', 'status']); // Alternativa

?>