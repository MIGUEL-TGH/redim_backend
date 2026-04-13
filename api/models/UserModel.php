<?php
require_once 'BaseModel.php';

class UserModel extends BaseModel {
  
  // Permite buscar a un usuario por correo o por nombre de usuario
  public static function findByEmailOrUsername_V1($identifier) {
    $sql = "SELECT * FROM users WHERE email = :id OR username = :id LIMIT 1";
    return self::query($sql, ['id' => $identifier], 'one');
  }

  // Modificado para traer usuario, rol y permisos
  public static function findByEmailOrUsername($identifier) {
    $sql = "SELECT 
                u.id, 
                u.name, 
                u.email, 
                u.username,
                u.password, 
                u.status,
                r.name AS role_name,
                rp.module,
                rp.permission_type
            FROM users u
            INNER JOIN roles r ON u.role_id = r.id
            LEFT JOIN role_permissions rp ON r.id = rp.role_id
            WHERE u.email = :identifier OR u.username = :identifier";
            
    // Cambiamos 'one' por 'all' porque ahora devuelve múltiples filas
    return self::query($sql, ['identifier' => $identifier], 'all'); 
  }

  // Insertar usuarios
  public static function create($data) {
    $sql = "INSERT INTO users (name, role_id, email, username, password, status) 
            VALUES (:name, :role_id, :email, :username, :password, :status)";
    
    // Pasamos un parámetro de fetch como 'none' o 'insert' para que el BaseModel 
    // ejecute la consulta y devuelva true (según tu estructura de match en BaseModel)
    self::query($sql, [
      'name' => $data['name'],
      'role_id' => $data['role_id'],
      'email' => $data['email'],
      'username' => $data['username'],
      'password' => $data['password'],
      'status' => isset($data['status']) ? $data['status'] : 1
    ], 'insert');

    return true;
  }

  // Actualizar contraseña del usuario
  public static function update_password($user_id, $new_password) {
    $params = [ 
      'id' => $user_id, 
      'password' => $new_password 
    ];
    
    self::setUpdate('users', $params);

    return true;
  }

}
?>