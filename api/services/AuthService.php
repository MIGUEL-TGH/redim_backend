<?php
require_once BASE_PATH . '/models/UserModel.php';
require_once BASE_PATH . '/models/AuthModel.php';
// require_once BASE_PATH . '/core/exceptions/ApiException.php';
 
class AuthService {
  
  public function login($identifier, $password) {
    // 1. Buscar usuario
    $rows = UserModel::findByEmailOrUsername($identifier);
    
    if (empty($rows)) {
      throw new ApiException("Credenciales incorrectas.", 401);
    }

    // Tomamos los datos principales del usuario desde la primera fila devuelta
    $user = $rows[0];

    // 2. Verificar estatus
    if ($user['status'] == 0) {
      throw new ApiException("El usuario se encuentra inactivo.", 403);
    }

    // 3. Verificar contraseña
    if (!password_verify($password, $user['password'])) {
      throw new ApiException("Credenciales incorrectas.", 401);
    }

    // 4. Procesar y agrupar los permisos
    $permissions = [];
    foreach ($rows as $row) {
      // Solo agregamos si el módulo no es nulo (por si el rol no tiene permisos)
      if (!empty($row['module'])) {
        $permissions[] = [
          'module' => $row['module'],
          'permission' => $row['permission_type']
        ];
      }
    }

    // 5. Generar Payload para el JWT (Estructura plana, como solicitaste)
    $expMinutes = isset($_ENV['JWT_EXP_MINUTES']) ? (int)$_ENV['JWT_EXP_MINUTES'] : 5;
    $payload = [
      'iss' => "ninez-primero-api",
      'iat' => time(),
      'exp' => time() + (60 * $expMinutes),
      'data' => [
        'id' => $user['id'],
        'name' => $user['name'],
        'email' => $user['email'],
        'role' => $user['role_name'],
        'permissions' => $permissions,
      ]
    ];

    // 6. Generar y retornar el token y datos básicos
    $token = AuthModel::generateJWT($payload);

    return [
      'token' => $token,
      'user' => [
        'id' => $user['id'],
        'name' => $user['name'],
        'username' => $user['username'],
        'role' => $user['role_name'] // Opcional: útil para que el front lo sepa sin decodificar el JWT
      ]
    ];

  }

  public function register($data) {
    // 1. Verificar si el correo ya está registrado
    $existingEmail = UserModel::findByEmailOrUsername($data['email']);
    if ($existingEmail && $existingEmail['email'] === $data['email']) {
      throw new ApiException("El correo electrónico ya se encuentra registrado.", 400);
    }

    // 2. Verificar si el nombre de usuario ya está en uso
    $existingUsername = UserModel::findByEmailOrUsername($data['username']);
    if ($existingUsername && $existingUsername['username'] === $data['username']) {
      throw new ApiException("El nombre de usuario ya está en uso.", 400);
    }

    // 3. Encriptar la contraseña de forma segura
    // PASSWORD_BCRYPT genera un hash de 60 caracteres (por eso en la BD usamos VARCHAR 255)
    $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);

    // 4. Guardar en la base de datos
    UserModel::create($data);

    return [
      "success" => true,
      "message" => "Usuario registrado exitosamente."
    ];
  }

  public function refresh($token) {
    // 1. Decodificar y verificar la firma del token actual
    // Asegúrate de que AuthModel::verifyJWT lance una excepción si la firma es inválida
    try {
      $decoded = AuthModel::verifyJWT($token);
    } catch (Exception $e) {
      throw new ApiException("Token inválido o alterado.", 401);
    }

    // 2. Extraer el identificador (usamos el email guardado en el token)
    $identifier = $decoded->data->email;

    // 3. Volver a consultar la BD. Esto es vital por seguridad:
    // ¿Qué tal si el administrador desactivó a este usuario hace 10 minutos?
    $rows = UserModel::findByEmailOrUsername($identifier);
    
    if (empty($rows)) {
      throw new ApiException("El usuario ya no existe.", 401);
    }

    $user = $rows[0];

    if ($user['status'] == 0) {
      throw new ApiException("El usuario ha sido desactivado.", 403);
    }

    // 4. Reconstruir los permisos (por si le asignaron o quitaron accesos)
    $permissions = [];
    foreach ($rows as $row) {
      if (!empty($row['module'])) {
        $permissions[] = [
          'module' => $row['module'],
          'permission' => $row['permission_type']
        ];
      }
    }

    // 5. Generar Nuevo Payload extendiendo la vida otra hora más
    $expMinutes = isset($_ENV['JWT_EXP_MINUTES']) ? (int)$_ENV['JWT_EXP_MINUTES'] : 5;
    $payload = [
      'iss' => "ninez-primero-api",
      'iat' => time(),
      'exp' => time() + (60 * $expMinutes), // Nueva hora de vida a partir de ahora
      'data' => [
        'id' => $user['id'],
        'name' => $user['name'],
        'email' => $user['email'],
        'role' => $user['role_name'],
        'permissions' => $permissions,
      ]
    ];

    // 6. Generar el nuevo token
    $newToken = AuthModel::generateJWT($payload);

    return [
      'token' => $newToken,
      'message' => 'Token renovado exitosamente',
      'user' => [
        'id' => $user['id'],
        'name' => $user['name'],
        'username' => $user['username'],
        'role' => $user['role_name'] // Opcional: útil para que el front lo sepa sin decodificar el JWT
      ]
    ];

    // return [
    //   'success' => true,
    //   'message' => 'Token renovado exitosamente',
    //   'result' => [
    //     'token' => $newToken,
    //     'user' => [
    //       'id' => $user['id'],
    //       'name' => $user['name'],
    //       'username' => $user['username'],
    //       'role' => $user['role_name']
    //     ]
    //   ]
    // ];
  }

}
?>