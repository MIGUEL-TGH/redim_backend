<?php
require_once BASE_PATH . '/models/UserModel.php';

class UsersService {

  public function getAll() {
    return UserModel::getAll();
  }

  public function create($data) {
      // 1. Evitar correos o usernames duplicados
      $duplicate = UserModel::checkDuplicate($data['email'], $data['username']);
      if ($duplicate) {
          throw new ValidationException(["campos" => "El correo o nombre de usuario ya están en uso."], "Error de validación");
      }

      // 2. Encriptar la contraseña
      $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);

      // 3. Guardar en base de datos
      UserModel::create($data);

      return ['message' => 'Usuario registrado exitosamente'];
  }

  public function update($id, $data) {
      // 1. Evitar que le roben el correo a otro usuario existente
      $duplicate = UserModel::checkDuplicate($data['email'], $data['username'], $id);
      if ($duplicate) {
          throw new ValidationException(["campos" => "El correo o nombre de usuario ya están en uso por otra persona."], "Error de validación");
      }

      UserModel::update($id, $data);

      return ['message' => 'Datos de usuario actualizados'];
  }

  public function changeStatus($id, $status) {
      // Validación de seguridad adicional si es necesaria
      UserModel::updateStatus($id, $status);
      
      return ['message' => 'Estatus actualizado correctamente', 'status' => $status];
  }
}