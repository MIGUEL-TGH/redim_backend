<?php
require_once 'BaseModel.php';

class UserModel extends BaseModel {
  
  // Permite buscar a un usuario por correo o por nombre de usuario
  public static function findByEmailOrUsername($identifier) {
    $sql = "SELECT * FROM users WHERE email = :id OR username = :id LIMIT 1";
    return self::query($sql, ['id' => $identifier], 'one');
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

}
?>