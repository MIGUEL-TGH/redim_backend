<?php
require_once 'BaseModel.php';

class UserModel extends BaseModel {

  // Modificado para traer usuario, rol y permisos (para el Login)
  public static function findByEmailOrUsername($identifier) {
    $sql = "SELECT 
              u.id, u.name, u.email, u.username, u.password, u.status,
              r.name AS role_name, rp.module, rp.permission_type
            FROM users u
            INNER JOIN roles r ON u.role_id = r.id
            LEFT JOIN role_permissions rp ON r.id = rp.role_id
            WHERE u.email = :identifier OR u.username = :identifier";
            
    // Cambiamos 'one' por 'all' porque ahora devuelve múltiples filas
    return self::query($sql, ['identifier' => $identifier], 'all'); 
  }

  // =============================================================================================
  // Obtener todos los usuarios para la tabla (DataTable)
  // public static function getAll() {
  //   $sql = "SELECT 
  //               u.id, u.name, u.email, u.username, u.status, 
  //               u.role_id, r.name AS role_name
  //           FROM users u
  //           LEFT JOIN roles r ON u.role_id = r.id
  //           ORDER BY u.id DESC";
            
  //   return self::query($sql, [], 'all');
  // }

  // Validar si el correo o usuario ya existen (evitar duplicados)
  public static function checkDuplicate($email, $username, $excludeId = null) {
    $sql = "SELECT id FROM users WHERE (email = :email OR username = :username)";
    $params = ['email' => $email, 'username' => $username];
    
    if ($excludeId) {
        $sql .= " AND id != :id";
        $params['id'] = $excludeId;
    }
    
    return self::query($sql, $params, 'one');
  }

  // Crear usuario
  public static function create($data) {
    $sql = "INSERT INTO users (name, role_id, email, username, password, status) 
            VALUES (:name, :role_id, :email, :username, :password, :status)";
    
    self::query($sql, [
      'name' => $data['name'],
      'role_id' => $data['role_id'],
      'email' => $data['email'],
      'username' => $data['username'],
      'password' => $data['password'],
      'status' => $data['status'] ?? 1
    ], 'insert');

    // Retornamos el último ID insertado (opcional, si usas PDO lastInsertId en BaseModel)
    return true; 
  }

  // Actualizar usuario (sin tocar la contraseña)
  public static function update($id, $data) {
    $sql = "UPDATE users 
            SET name = :name, role_id = :role_id, email = :email, username = :username 
            WHERE id = :id";
            
    self::query($sql, [
      'id' => $id,
      'name' => $data['name'],
      'role_id' => $data['role_id'],
      'email' => $data['email'],
      'username' => $data['username']
    ], 'update');

    return true;
  }

  // Cambiar Estatus
  public static function updateStatus($id, $status) {
    $sql = "UPDATE users SET status = :status WHERE id = :id";
    self::query($sql, ['id' => $id, 'status' => $status], 'update');
    return true;
  }

  // =============================================================================================
  // Insertar usuarios
  // public static function create($data) {
  //   $sql = "INSERT INTO users (name, role_id, email, username, password, status) 
  //           VALUES (:name, :role_id, :email, :username, :password, :status)";
    
  //   // Pasamos un parámetro de fetch como 'none' o 'insert' para que el BaseModel 
  //   // ejecute la consulta y devuelva true (según tu estructura de match en BaseModel)
  //   self::query($sql, [
  //     'name' => $data['name'],
  //     'role_id' => $data['role_id'],
  //     'email' => $data['email'],
  //     'username' => $data['username'],
  //     'password' => $data['password'],
  //     'status' => isset($data['status']) ? $data['status'] : 1
  //   ], 'insert');

  //   return true;
  // }

  // Actualizar contraseña del usuario
  public static function update_password($user_id, $new_password) {
    $params = [ 
      'id' => $user_id, 
      'password' => $new_password 
    ];
    
    self::setUpdate('users', $params);

    return true;
  }


  // =============================================================================================




  // =============================================================================================
  // Permite buscar a un usuario por correo o por nombre de usuario
  // public static function findByEmailOrUsername_V1($identifier) {
  //   $sql = "SELECT * FROM users WHERE email = :id OR username = :id LIMIT 1";
  //   return self::query($sql, ['id' => $identifier], 'one');
  // }
}
?>