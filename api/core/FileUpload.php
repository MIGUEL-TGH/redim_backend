<?php
// SRP: helper de subida de archivos para módulos de contenido.
// Recibe un data URI base64 (enviado dentro del JSON del request), lo valida
// y lo escribe en redim_backend/multimedia/<subdir>/. Devuelve la ruta pública
// RELATIVA a multimedia/ (lo único que se guarda en la BD).
declare(strict_types=1);

require_once BASE_PATH . '/core/exceptions/ValidationException.php';
require_once BASE_PATH . '/core/exceptions/ApiException.php';

class FileUpload {
  // Guarda un data URI base64 y devuelve la ruta pública relativa (ej. 'voces/testimonials/ab12.jpg').
  // Si $input NO es un data URI (ej. una ruta ya guardada en una edición sin cambio de archivo),
  // se devuelve intacto. Si viene vacío/null, devuelve null.
  public static function saveBase64(?string $input, string $subdir, array $allowedExt, int $maxBytes = 5242880): ?string {
    if ($input === null || trim($input) === '') {
      return null;
    }

    // No es data URI => ya es una ruta existente o una URL externa: no se reescribe.
    if (!preg_match('/^data:([\w\/\-\.\+]+);base64,(.+)$/s', $input, $m)) {
      return $input;
    }

    $mime = strtolower($m[1]);
    $data = base64_decode($m[2], true);

    if ($data === false) {
      throw new ValidationException(['file' => 'Archivo base64 inválido']);
    }
    if (strlen($data) > $maxBytes) {
      throw new ValidationException(['file' => 'El archivo excede el tamaño máximo permitido']);
    }

    $ext = self::extFromMime($mime);
    if ($ext === null || !in_array($ext, $allowedExt, true)) {
      throw new ValidationException(['file' => 'Tipo de archivo no permitido']);
    }

    $dir = self::baseDir() . '/' . $subdir;
    if (!is_dir($dir) && !mkdir($dir, 0775, true) && !is_dir($dir)) {
      throw new ApiException('No se pudo crear el directorio de destino', 500);
    }

    $fileName = bin2hex(random_bytes(16)) . '.' . $ext;
    $fullPath = $dir . '/' . $fileName;

    if (file_put_contents($fullPath, $data) === false) {
      throw new ApiException('No se pudo guardar el archivo', 500);
    }

    return $subdir . '/' . $fileName;
  }

  // Borra un archivo previo por su ruta relativa. Silencioso; ignora URLs externas.
  public static function delete(?string $relativePath): void {
    if ($relativePath === null || trim($relativePath) === '') {
      return;
    }
    if (preg_match('#^https?://#i', $relativePath)) {
      return; // URL externa: no se toca
    }
    $full = self::baseDir() . '/' . ltrim($relativePath, '/');
    if (is_file($full)) {
      @unlink($full);
    }
  }

  private static function baseDir(): string {
    // BASE_PATH = .../redim_backend/api  =>  multimedia hermano de api
    return BASE_PATH . '/../multimedia';
  }

  private static function extFromMime(string $mime): ?string {
    return match ($mime) {
      'image/jpeg', 'image/jpg' => 'jpg',
      'image/png'  => 'png',
      'image/webp' => 'webp',
      'image/gif'  => 'gif',
      'application/pdf' => 'pdf',
      default => null
    };
  }
}
?>
