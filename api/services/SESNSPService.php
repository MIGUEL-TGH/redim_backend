<?php
// SRP (Single Responsibility Principle)
declare(strict_types=1); // Modo estricto de tipos
require_once "models/BaseModel.php";

class SESNSPService {
  private const TABLE = 'sesnsp';
  //--------------------private access-------------------------------------------
  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      // if (!preg_match("/^[\p{L}\d\s._,-]{1,250}$/u", $data['params']['name'])) {
      //   throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el nombre del indicador');
      // }
      // if (!preg_match("/^[\p{L}\d\s._,-]{1,50}$/u", $data['params']['demonym'])) {
      //   throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el gentilicio');
      // }
      // if (!preg_match("/^[\p{L}\d\s._,-]{1,3}$/u", $data['params']['iso_code'])) {
      //   throw new ValidationException(['type' => 'Invalid type parameter'], 'Formato inválido en el código ISO');
      // }

      // ====================================================================================================================
      foreach (['woman', 'man'] as $field) {

        if (!isset($data['params'][$field]) || $data['params'][$field] === '') {
          throw new ValidationException(
            [$field => 'Required field'],
            "El campo {$field} es obligatorio"
          );
        }

        $value = $data['params'][$field];

        // 1️⃣ Solo números enteros positivos (incluye 0)
        if (!preg_match('/^\d+$/', (string)$value)) {
          throw new ValidationException(
            [$field => 'Invalid format'],
            "El campo {$field} solo permite números enteros"
          );
        }

        // 2️⃣ Validación de rango 0 - 9999
        $intValue = (int)$value;

        if ($intValue < 0 || $intValue > 9999) {
          throw new ValidationException(
            [$field => 'Out of range'],
            "El campo {$field} debe estar entre 0 y 9999"
          );
        }
      }

    }
  }
  private static function getById(int $id): array {
    $sql = 
    " SELECT se.id, se.woman, se.man, se.state_id AS state_id, s.name AS state_name, se.status
        FROM sesnsp se
        LEFT JOIN `states` s ON se.state_id = s.id
        -- ORDER BY se.id ASC
      WHERE se.id = ?
    ";

    $item = BaseModel::query($sql, [$id], 'one');

    if (!$item) {
      throw new NotFoundException('Item not found');
    }

    return [
      // 'id' => (int) $item['id'],
      // 'name' => $item['name'],
      // 'country_id' => (int) $item['country_id'],
      // 'country_name' => $item['country_name'],
      // 'demonym' => $item['demonym'],
      // 'iso_code' => $item['iso_code'],
      // 'status' => (bool) $item['status'],
      
      'id' => (int) $item['id'],
      'woman' => $item['woman'],
      'man' => $item['man'],

      'state_id' => $item['state_id'],
      'state_name' => $item['state_name'],
      'status' => (bool) $item['status']
    ];
  }
  private static function updateInternal(array $params): void {
    $update = BaseModel::setUpdate(self::TABLE, $params);

    if ($update['status'] !== 200) {
      throw new ValidationException([], $update['alert'] ?? 'Error en actualización');
    }
  }

  private static function checkDuplicate($stateID, $excludeId = null) {
    $sql = "SELECT id FROM sesnsp WHERE (state_id = :state_id)";
    $params = ['state_id' => $stateID];
    
    if ($excludeId) {
        $sql .= " AND id != :id";
        $params['id'] = $excludeId;
    }
    
    // return self::query($sql, $params, 'one');
    return BaseModel::query($sql, $params, 'one');
  }

  private static function insert(array $params): array {
    // 1. Evitar estado duplicados
    $duplicate = self::checkDuplicate($params['state_id']);
    if ($duplicate) {
      throw new ValidationException(["input" => "state"], "Error de validación: El estado ya existe.");
    }

    // 2. Guardar en base de datos   
    $insert = BaseModel::setInsert(self::TABLE, $params);

    if ($insert['status'] !== 200) {
      throw new ValidationException([], $insert['alert'] ?? 'Error');
    }

    return [
      'task' => 'saved_item',
      'item' => self::getById((int)$insert['lastInsertId'])
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

  //--------------------public access--------------------------------------------
  public static function setCRUD(array $data): array {
    self::validate($data);

    return match ($data['task']) {
      'insert' => self::insert($data['params']),
      'update' => self::update($data['params']),
      'status' => self::changeStatus($data['params']),
      default => throw new ValidationException([], 'Tipo de tarea no encontrado')
    };
  }
  public static function getAllData(): array {
    try {
      $sql = 
      "SELECT se.id, se.woman, se.man, se.state_id AS state_id, s.name AS state_name, se.status
        FROM sesnsp se
        LEFT JOIN `states` s ON se.state_id = s.id
        ORDER BY se.id ASC
      ";

      $items = BaseModel::query($sql, [], 'all');

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }

    if (empty($items)) {
      throw new NotFoundException('Elementos no encontrados');
    }

    return array_map(
      fn($item) => [
        'id' => (int) $item['id'],
        'woman' => $item['woman'],
        'man' => $item['man'],

        'state_id' => $item['state_id'],
        'state_name' => $item['state_name'],
        'status' => (bool) $item['status']
      ],
      $items
    );

  }
  public static function getActiveData(): array {
    try {
      $sql = 
      " SELECT se.id, s.name AS name, se.woman, se.man, se.state_id AS cve_ent
        FROM sesnsp se
        LEFT JOIN `states` s ON se.state_id = s.id
        WHERE se.status = ?
        ORDER BY s.id ASC;
      ";

      $items = BaseModel::query($sql, [1], 'all');

      if (empty($items)) {
        throw new NotFoundException('Items not found');
      }

      return array_map(
        fn($item) => [
          'id' => (int) $item['id'],
          'name' => $item['name'],
          'woman' => (int) $item['woman'],
          'man' => (int) $item['man'],
          'cve_ent' => (int) $item['cve_ent']

        ],
        $items
      );

    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
  }
  public static function getActiveDataById($id): array {
    try {
      $sql = 
      " SELECT id, name
        FROM states
        WHERE status = ? AND country_id = ?
        ORDER BY id ASC
      ";

      $items = BaseModel::query($sql, [1, $id['country_id']], 'all');

      if (empty($items)) {
        throw new NotFoundException('Elementos no encontrados'); // Items not found
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
  public static function getDataBySelector() {
    try {
      $sql = 
      " SELECT DISTINCT icd.state_id AS id, s.name AS title, s.iso_code
        FROM indicator_category_details icd
        INNER JOIN states s ON s.id = icd.state_id
        WHERE icd.status = ?  
        ORDER BY s.name ASC;
      ";
      $items = BaseModel::query($sql, [1], 'all');
    
    } catch (Throwable $e) {
      throw new DatabaseException($e->getMessage());
    }
    
    if (empty($items)) {
      throw new NotFoundException('¡items not found!');
    }

    return $items;
  }
  //-----------------------------------------------------------------------------
} 
?>