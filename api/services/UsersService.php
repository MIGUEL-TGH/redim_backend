<?php
require_once BASE_PATH . '/models/UserModel.php';

class UsersService {
  // ==========================================================================================================
  private const TABLE = 'users';
  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      if (!preg_match("/^[\p{L}\d\s._,-]{1,250}$/u", $data['params']['name'])) {
        throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el nombre del indicador');
      }
      if (!preg_match("/^[\p{L}\d\s._,-]{1,50}$/u", $data['params']['demonym'])) {
        throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el gentilicio');
      }
      if (!preg_match("/^[\p{L}\d\s._,-]{1,3}$/u", $data['params']['iso_code'])) {
        throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el código ISO');
      }
    }
  }
  private static function getById(int $id): array {
    $sql = 
    " SELECT s.id, s.name, s.country_id,
            c.name AS country_name,
            s.demonym, s.iso_code, s.status
      FROM states s
      LEFT JOIN countries c ON s.country_id = c.id
      WHERE s.id = ?
    ";

    $item = BaseModel::query($sql, [$id], 'one');

    if (!$item) {
      throw new NotFoundException('Item not found');
    }

    return [
      'id' => (int) $item['id'],
      'name' => $item['name'],
      'country_id' => (int) $item['country_id'],
      'country_name' => $item['country_name'],
      'demonym' => $item['demonym'],
      'iso_code' => $item['iso_code'],
      'status' => (bool) $item['status'],
    ];
  }
  private static function updateInternal(array $params): void {
    $update = BaseModel::setUpdate(self::TABLE, $params);

    if ($update['status'] !== 200) {
      throw new ValidationException([], $update['alert'] ?? 'Error en actualización');
    }
  }
  private static function insert(array $params): array {
    $insert = BaseModel::setInsert(self::TABLE, $params);

    if ($insert['status'] !== 200) {
      throw new ValidationException([], $insert['alert'] ?? 'Error');
    }

    return [
      'task' => 'saved_item',
      // 'id' => $insert['id']
      'item' => self::getById((int)$insert['id'])
    ];
  }
  private static function update(array $params): array {
    self::updateInternal($params);

    return [
      'task' => 'updated_item',
      // 'id' => $params['id']
      'item' => self::getById((int)$params['id'])
    ];
  }
  private static function changeStatus(array $params): array {
    self::updateInternal($params);

    return [
      'task' => 'status_updated',
      // 'id' => $params['id'],
      // 'status' => $params['status']
      'id' => (int)$params['id'],
      'status' => (bool)$params['status']
    ];
  }
  // ==========================================================================================================

  public static function getRolesBySelector(): array {
    try {
      $sql = "SELECT r.id, r.name, r.description
        FROM roles r
        ORDER BY r.name ASC
      ";

      $items = BaseModel::query($sql, [], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name'],
          'description' => $item['description']
        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
  public static function getAllData(): array {
    try {
      $sql = "SELECT 
          u.id, u.name, u.email, u.username, u.status, 
          u.role_id, r.name AS role_name
      FROM users u
      LEFT JOIN roles r ON u.role_id = r.id
      ORDER BY u.id DESC
      ";

      $items = BaseModel::query($sql, [], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name'],
          'email' => $item['email'],
          'username' => $item['username'],
          'role_id' => $item['role_id'],
          'role_name' => $item['role_name'],
          'status' => (bool) $item['status'],
        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
  public static function setCRUD(array $data): array {
    self::validate($data);

    return match ($data['task']) {
      'insert' => self::insert($data['params']),
      'update' => self::update($data['params']),
      'status' => self::changeStatus($data['params']),
      default => throw new ValidationException([], 'Tipo de tarea no encontrado')
    };
  }

  // ==========================================================================================================

  // public function getAll() {
  //   return UserModel::getAll();
  // }

//   public function create($data) {
//       // 1. Evitar correos o usernames duplicados
//       $duplicate = UserModel::checkDuplicate($data['email'], $data['username']);
//       if ($duplicate) {
//           throw new ValidationException(["campos" => "El correo o nombre de usuario ya están en uso."], "Error de validación");
//       }

//       // 2. Encriptar la contraseña
//       $data['password'] = password_hash($data['password'], PASSWORD_BCRYPT);

//       // 3. Guardar en base de datos
//       UserModel::create($data);

//       return ['message' => 'Usuario registrado exitosamente'];
//   }

//   public function update($id, $data) {
//       // 1. Evitar que le roben el correo a otro usuario existente
//       $duplicate = UserModel::checkDuplicate($data['email'], $data['username'], $id);
//       if ($duplicate) {
//           throw new ValidationException(["campos" => "El correo o nombre de usuario ya están en uso por otra persona."], "Error de validación");
//       }

//       UserModel::update($id, $data);

//       return ['message' => 'Datos de usuario actualizados'];
//   }

//   public function changeStatus($id, $status) {
//       // Validación de seguridad adicional si es necesaria
//       UserModel::updateStatus($id, $status);
      
//       return ['message' => 'Estatus actualizado correctamente', 'status' => $status];
//   }
}