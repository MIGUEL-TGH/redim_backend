<?php
// SRP (Single Responsibility Principle)
declare(strict_types=1); // Modo estricto de tipos
require_once "models/BaseModel.php";

class CentersService {
  private const TABLE = 'centers';
  //--------------------private access-------------------------------------------
  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      if (!preg_match("/^[\p{L}\d\s._,-]{1,250}$/u", $data['params']['name'])) {
        throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el nombre del indicador');
      }
      // if (!preg_match("/^-?\d{1,3}\.\d+,-?\d{1,3}\.\d+$/", $data['params']['locate'])) {
      //   throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el gentilicio');
      // }
      $locate = $data['params']['locate'] ?? null;

      if ($locate !== null) {

        $locate = trim($locate);

        // Permitir string vacío
        if ($locate === '') {
          return;
        }

        // Límite máximo de caracteres
        if (mb_strlen($locate) > 50) {
          throw new ValidationException([
            'locate' => 'Máximo 50 caracteres permitidos'
          ]);
        }

        // Validar estructura estricta: numero,numero (sin espacios)
        if (!preg_match('/^-?\d+(?:\.\d+)?,-?\d+(?:\.\d+)?$/', $locate)) {
          throw new ValidationException([
            'locate' => 'Formato inválido. Debe ser: latitud,longitud'
          ]);
        }

        // [$lat, $lng] = array_map('floatval', explode(',', $locate));

        // Validar rango real de coordenadas
        // if ($lat < -90 || $lat > 90) {
        //   throw new ValidationException([
        //     'locate' => 'Latitud fuera de rango (-90 a 90)'
        //   ]);
        // }

        // if ($lng < -180 || $lng > 180) {
        //   throw new ValidationException([
        //     'locate' => 'Longitud fuera de rango (-180 a 180)'
        //   ]);
        // }
      }

    }
  }

  private static function getById(int $id): array {
    $sql = 
    " SELECT c.id, c.name, c.locate, c.state_id, s.name AS state_name, s.status
      FROM centers c
      LEFT JOIN `states` s ON c.state_id = s.id
      WHERE c.id = ?
    ";

    $item = BaseModel::query($sql, [$id], 'one');

    if (!$item) {
      throw new NotFoundException('Item not found');
    }

    return [
      'id' => (int) $item['id'],
      'name' => $item['name'],
      'locate' => $item['locate'],
      'state_id' => (int) $item['state_id'],
      'state_name' => $item['state_name'],
      'status' => (bool) $item['status'],
    ];
  }

  private static function insert(array $params): array {
    $insert = BaseModel::setInsert(self::TABLE, $params);

    if ($insert['status'] !== 200) {
      throw new ValidationException([], $insert['alert'] ?? 'Error');
    }

    return [
      'task' => 'saved_item',
      'item' => self::getById((int)$insert['id'])
    ];
  }

  private static function update(array $params): array {
    self::updateInternal($params);

    return [
      'task' => 'updated_item',
      'item' => self::getById((int)$params['id'])
    ];
  }

  private static function changeStatus(array $params): array {
    self::updateInternal($params);

    return [
      'task' => 'status_updated',
      'id' => (int)$params['id'],
      'status' => (bool)$params['status']
    ];
  }

  private static function updateInternal(array $params): void {
    $update = BaseModel::setUpdate(self::TABLE, $params);

    if ($update['status'] !== 200) {
      throw new ValidationException([], $update['alert'] ?? 'Error en actualización');
    }
  }

  //--------------------public access--------------------------------------------
  public static function getStatesActive(): array {
    try {
      $sql = 
      " SELECT id, name
        FROM states
        WHERE status = ?
        ORDER BY id ASC
      ";

      $items = BaseModel::query($sql, [1], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name']
        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
  public static function getCenters(): array {
    try {

      $sql =
      "SELECT c.id, c.name, c.locate, c.state_id, s.name AS state_name, s.status
        FROM centers c
        LEFT JOIN `states` s ON c.state_id = s.id
        ORDER BY c.id ASC
      ";

      $items = BaseModel::query($sql, [], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name'],
          'locate' => $item['locate'],
          'state_id' => (int) $item['state_id'],
          'state_name' => $item['state_name'],
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

}
?>