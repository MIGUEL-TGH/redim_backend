<?php
require_once BASE_PATH . '/models/UserModel.php';
require_once BASE_PATH . '/models/AuthModel.php';
// require_once BASE_PATH . '/core/exceptions/ApiException.php';

class AuthService {

  public function login($identifier, $password) {
    // 1. Buscar usuario
    $user = UserModel::findByEmailOrUsername($identifier);
    
    if (!$user) {
      throw new ApiException("Credenciales incorrectas.", 401);
    }

    // 2. Verificar estatus
    if ($user['status'] == 0) {
      throw new ApiException("El usuario se encuentra inactivo.", 403);
    }

    // 3. Verificar contraseña (asumiendo que al registrar usaste password_hash())
    if (!password_verify($password, $user['password'])) {
      throw new ApiException("Credenciales incorrectas.", 401);
    }

    // 4. Generar Payload para el JWT
    $payload = [
      'iss' => "ninez-primero-api",
      'iat' => time(),
      'exp' => time() + (60 * 60 * 24), // Expira en 24 horas
      'data' => [
        'id' => $user['id'],
        'username' => $user['username'],
        'email' => $user['email'],
        'name' => $user['name']
      ]
    ];

    // 5. Generar y retornar el token y datos básicos
    $token = AuthModel::generateJWT($payload);

    return [
      'token' => $token,
      'user' => [
        'id' => $user['id'],
        'name' => $user['name'],
        'username' => $user['username']
      ]
    ];
  }

  // NUEVO MÉTODO: Registrar usuario
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

}
?>