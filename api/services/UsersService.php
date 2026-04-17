<?php
require_once BASE_PATH . '/models/UserModel.php';
// composer require setasign/fpdf
require_once BASE_PATH . '/vendor/fpdf/fpdf.php'; // Ajusta la ruta a tu librería FPDF

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
  // private static function generateUserPDF($name, $username, $rawPassword): string {
  //   $pdf = new FPDF();
  //   $pdf->AddPage();
  //   $pdf->SetFont('Arial', 'B', 16);
    
  //   // Título
  //   $pdf->Cell(0, 10, utf8_decode('REDIM - Niñez Primero'), 0, 1, 'C');
  //   $pdf->SetFont('Arial', 'B', 14);
  //   $pdf->Cell(0, 10, utf8_decode('Carta Responsiva de Credenciales de Acceso'), 0, 1, 'C');
  //   $pdf->Ln(10);
    
  //   // Cuerpo
  //   $pdf->SetFont('Arial', '', 12);
  //   $texto = "Por medio de la presente, se hace entrega de las credenciales de acceso al sistema \"Niñez Primero\". El usuario se compromete a hacer un uso responsable y confidencial de esta información, la cual es intransferible.";
  //   $pdf->MultiCell(0, 10, utf8_decode($texto));
  //   $pdf->Ln(10);
    
  //   // Datos de la cuenta
  //   $pdf->SetFont('Arial', 'B', 12);
  //   $pdf->Cell(50, 10, 'Nombre Completo:', 0, 0);
  //   $pdf->SetFont('Arial', '', 12);
  //   $pdf->Cell(0, 10, utf8_decode($name), 0, 1);
    
  //   $pdf->SetFont('Arial', 'B', 12);
  //   $pdf->Cell(50, 10, 'Usuario (Username):', 0, 0);
  //   $pdf->SetFont('Arial', '', 12);
  //   $pdf->Cell(0, 10, utf8_decode($username), 0, 1);
    
  //   $pdf->SetFont('Arial', 'B', 12);
  //   $pdf->Cell(50, 10, 'Contrasena Temporal:', 0, 0);
  //   $pdf->SetFont('Arial', '', 12);
  //   $pdf->Cell(0, 10, utf8_decode($rawPassword), 0, 1);
    
  //   $pdf->Ln(30);
    
  //   // Sección de Firmas
  //   $pdf->Cell(90, 10, '_________________________', 0, 0, 'C');
  //   $pdf->Cell(90, 10, '_________________________', 0, 1, 'C');
  //   $pdf->Cell(90, 10, utf8_decode('Firma del Usuario'), 0, 0, 'C');
  //   $pdf->Cell(90, 10, utf8_decode('Recursos Humanos'), 0, 1, 'C');
    
  //   // Guardar archivo en el servidor
  //   // Asegúrate de que la carpeta "uploads/pdfs/" tenga permisos de escritura
  //   $fileName = 'Responsiva_' . preg_replace('/[^a-zA-Z0-9]/', '_', $username) . '_' . time() . '.pdf';
  //   $filePath = BASE_PATH . '/public/uploads/pdfs/' . $fileName;
    
  //   $pdf->Output('F', $filePath);
    
  //   // Retornamos la URL pública para descargar desde Vue
  //   return '/uploads/pdfs/' . $fileName; 
  // }

  private static function generateUserPDF($name, $username, $rawPassword): string {
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
    // Asegúrate de que la carpeta "uploads/pdfs/" tenga permisos de escritura
    $fileName = 'Responsiva_' . preg_replace('/[^a-zA-Z0-9]/', '_', $username) . '_' . time() . '.pdf';
    $filePath = BASE_PATH . '/public/uploads/pdfs/' . $fileName;
    
    $pdf->Output('F', $filePath);
    
    // Retornamos la URL pública para descargar desde Vue
    return '/uploads/pdfs/' . $fileName; 
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

    // return [
    //   'task' => 'saved_item',          // El mixin lee esto para hacer el unshift en la tabla
    //   'item' => $usuarioRecienCreado,  // Los datos del usuario para pintar en la tabla
    //   'message' => 'Usuario registrado exitosamente',
    //   'pdf_url' => $pdfUrl             // <-- Nuestro dato extra para UsersView.vue
    // ];

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

    // ==============================================================================
    // reseteo de contraseña
    // En UsersService.php -> resetPassword($data)
    // $rawPassword = self::generateRandomPassword();
    // // ... actualizas en base de datos la contraseña hasheada ...

    // // Generas el nuevo PDF
    // $pdfUrl = self::generateUserPDF($usuario['name'], $usuario['username'], $rawPassword);

    // return [
    //     'task' => 'updated_item', // O cualquier task vacía si no requieres repintar la tabla
    //     'message' => 'Contraseña reseteada. Imprima la nueva responsiva.',
    //     'pdf_url' => $pdfUrl
    // ];

    // ==============================================================================

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