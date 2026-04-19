<?php
require_once BASE_PATH . '/models/UserModel.php';
// composer require setasign/fpdf
require_once BASE_PATH . '/vendor/setasign/fpdf/fpdf.php'; // Ajusta la ruta a tu librería FPDF

class UsersService {
  // ==========================================================================================================
  private const TABLE = 'users';
  private static function validate(array $data): void {
    if (in_array($data['task'], ['insert','update'], true)) {
      $p = $data['params'];

      // 1. Validar Nombre (Alfanumérico, acentos, espacios y -_.,)
      // \p{L} detecta letras con acentos y eñes correctamente en PHP
      if (empty($p['name']) || !preg_match("/^[\p{L}0-9\s\-_.,]{1,100}$/u", $p['name'])) {
        throw new ValidationException(['campos' => 'name'], 'Nombre inválido o excede los 100 caracteres.');
      }

      // 2. Validar Rol
      if (empty($p['role_id']) || !is_numeric($p['role_id'])) {
        throw new ValidationException(['campos' => 'role_id'], 'El rol es obligatorio y debe ser válido.');
      }

      // 3. Validar Correo (Formato estricto y max 50 chars)
      if (empty($p['email']) || strlen($p['email']) > 50 || !filter_var($p['email'], FILTER_VALIDATE_EMAIL)) {
        throw new ValidationException(['campos' => 'email'], 'Correo inválido o excede los 50 caracteres.');
      }

      // 4. Validar Username (Alfanuméricos y -_.)
      if (empty($p['username']) || !preg_match("/^[a-zA-Z0-9\-_.]+$/", $p['username']) || strlen($p['username']) > 25) {
        throw new ValidationException(['campos' => 'username'], 'Usuario inválido. Máx 25 caracteres, solo alfanuméricos y (-_.).');
      }
    }
  }
  private static function generateRandomPassword(): string {
    $chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,/';
    $password = '';
    $max = strlen($chars) - 1;
    for ($i = 0; $i < 6; $i++) {
        $password .= $chars[random_int(0, $max)]; // random_int es criptográficamente seguro en PHP
    }
    return $password;
  }
  private static function generateUserPDF($name, $username, $rawPassword): array {
    // 1. Establecer la zona horaria correcta para que la hora sea exacta (ajusta si tu servidor está en otra región)
    date_default_timezone_set('America/Mexico_City');
    $fechaHora = date('d/m/Y H:i:s'); // Formato: Día/Mes/Año Hora:Minuto:Segundo

    $pdf = new FPDF();
    $pdf->AddPage();
    
    // Título
    $pdf->SetFont('Arial', 'B', 16);
    $pdf->Cell(0, 10, utf8_decode('REDIM - Niñez Primero'), 0, 1, 'C');
    $pdf->SetFont('Arial', 'B', 14);
    $pdf->Cell(0, 10, utf8_decode('Carta Responsiva de Credenciales de Acceso'), 0, 1, 'C');
    
    // 2. Insertar la Fecha y Hora de emisión (Letra itálica, tamaño 10, alineado a la derecha 'R')
    $pdf->SetFont('Arial', 'I', 10);
    $pdf->Cell(0, 10, utf8_decode('Fecha y hora de emisión: ' . $fechaHora), 0, 1, 'R');
    $pdf->Ln(5);
    
    // Cuerpo
    $pdf->SetFont('Arial', '', 12);
    $texto = "Por medio de la presente, se hace entrega de las credenciales de acceso al sistema \"Niñez Primero\". El usuario se compromete a hacer un uso responsable y confidencial de esta información, la cual es intransferible.";
    $pdf->MultiCell(0, 10, utf8_decode($texto));
    $pdf->Ln(10);
    
    // Datos de la cuenta
    $pdf->SetFont('Arial', 'B', 12);
    $pdf->Cell(50, 10, 'Nombre Completo:', 0, 0);
    $pdf->SetFont('Arial', '', 12);
    $pdf->Cell(0, 10, utf8_decode($name), 0, 1);
    
    $pdf->SetFont('Arial', 'B', 12);
    $pdf->Cell(50, 10, 'Usuario (Username):', 0, 0);
    $pdf->SetFont('Arial', '', 12);
    $pdf->Cell(0, 10, utf8_decode($username), 0, 1);
    
    $pdf->SetFont('Arial', 'B', 12);
    $pdf->Cell(50, 10, 'Contrasena Temporal:', 0, 0);
    $pdf->SetFont('Arial', '', 12);
    $pdf->Cell(0, 10, utf8_decode($rawPassword), 0, 1);
    
    $pdf->Ln(30);
    
    // Sección de Firmas
    $pdf->Cell(90, 10, '_________________________', 0, 0, 'C');
    $pdf->Cell(90, 10, '_________________________', 0, 1, 'C');
    $pdf->Cell(90, 10, utf8_decode('Firma del Usuario'), 0, 0, 'C');
    $pdf->Cell(90, 10, utf8_decode('Recursos Humanos'), 0, 1, 'C');
    
    // Guardar archivo en el servidor
    $fileName = 'Responsiva_' . preg_replace('/[^a-zA-Z0-9]/', '_', $username) . '_' . time() . '.pdf';
    $filePath = BASE_PATH . '/multimedia/pdfs/users/' . $fileName;
    
    $pdf->Output('F', $filePath);
    
    return [
      // 'url' => 'multimedia/pdfs/users/' . $fileName,
      'fileName' => $fileName,
      'newFileName' => $username . '.pdf'
    ];
  }
  private static function getById(int $id): array {
    $sql = 
    " SELECT 
          u.id, u.name, u.email, u.username, u.status, 
          u.role_id, r.name AS role_name
      FROM users u
      LEFT JOIN roles r ON u.role_id = r.id
      WHERE u.id = ?
    ";

    $item = BaseModel::query($sql, [$id], 'one');

    if (!$item) {
      throw new NotFoundException('Item not found');
    }

    return [
      'id' => (int) $item['id'],
      'name' => $item['name'],
      'email' => $item['email'],
      'username' => $item['username'],
      'role_id' => $item['role_id'],
      'role_name' => $item['role_name'],
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
    // 1. Evitar correos o usernames duplicados
    $duplicate = UserModel::checkDuplicate($params['email'], $params['username']);
    if ($duplicate) {
      throw new ValidationException(["input" => "email / username"], "Error de validación: El correo o nombre de usuario ya están en uso por otra persona.");
    }

    // 2. Encriptarla para guardarla en la BD
    $rawPassword = self::generateRandomPassword();
    $params['password'] = password_hash($rawPassword, PASSWORD_BCRYPT);

    // 3. Generas el nuevo PDF
    $pdfData = self::generateUserPDF($params['name'], $params['username'], $rawPassword);

    // ========================================================================================================================================
    // 4. Guardar en base de datos
    $insert = BaseModel::setInsert(self::TABLE, $params);
    if ($insert['status'] !== 200) {
      throw new ValidationException([], $insert['alert'] ?? 'Error');
    }

    // 5. Retornar la información
    return [
      'task' => 'saved_item',
      // 'data_insert' => $insert,
      'item' => self::getById((int)$insert['lastInsertId']),
      'message' => 'Usuario registrado exitosamente',
      'pdf_data' => $pdfData
    ];

  }
  private static function update(array $params): array {
    // 1. Evitar correos o usernames duplicados
    $duplicate = UserModel::checkDuplicate($params['email'], $params['username'], $params['id']);
    if ($duplicate) {
      throw new ValidationException(["input" => "email / username"], "Error de validación: El correo o nombre de usuario ya están en uso por otra persona.");
    }

    // 2. Actualizar datos del usuario
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
      // 'id' => $params['id'],
      // 'status' => $params['status']
      'id' => (int)$params['id'],
      'status' => (bool)$params['status']
    ];
  }
  private static function resetPassword(array $params): array {

    // 1. Encriptarla para guardarla en la BD
    $rawPassword = self::generateRandomPassword();
    $params['password'] = password_hash($rawPassword, PASSWORD_BCRYPT);

    // 2. Generas el nuevo PDF
    $pdfData = self::generateUserPDF($params['name'], $params['username'], $rawPassword);

    // 3. Actualizar datos del usuario
    $newParams = [
      'id' => $params['id'],
      'password' => $params['password']
    ];
    self::updateInternal($newParams);

    return [
      'task' => 'updated_item',
      'item' => self::getById((int)$params['id']),
      'pdf_data' => $pdfData
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
      'password' => self::resetPassword($data['params']),
      default => throw new ValidationException([], 'Tipo de tarea no encontrado')
    };
  }
  public static function downloadPDF(array $data): array {
    // 1. Validar si el archivo existe
    $filepath = __DIR__ . '/../multimedia/pdfs/users/' . $data['filename'];
    if (!file_exists($filepath)) {
      throw new NotFoundException("El archivo no existe");
    }

    // return [
    //   'message' => 'Service-->downloadPDF()'
    // ];

    // 2. PHP envía las cabeceras simulando ser un archivo
    header('Content-Description: File Transfer');
    header('Content-Type: application/pdf');
    header('Content-Disposition: attachment; filename="'.basename($filepath).'"');
    header('Expires: 0');
    header('Cache-Control: must-revalidate');
    header('Pragma: public');
    header('Content-Length: ' . filesize($filepath));

    // 3. Imprime el contenido del PDF y termina el script
    readfile($filepath);
    exit;
  }
}