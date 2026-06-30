<?php
require_once BASE_PATH . '/models/VisitModel.php';

class VisitsService {

  // Caracteres válidos para una identidad de vista (igual criterio que un slug).
  private const VIEW_KEY_REGEX = '/^[a-z0-9][a-z0-9_\-]{0,49}$/i';

  /**
   * Registra una visita (endpoint público).
   * El body trae: view_key (obligatorio), label y path (opcionales, informativos).
   */
  public static function registerHit(array $body): array {
    // 1. Validar la identidad de la vista (lo único que importa contar).
    $viewKey = isset($body['viewKey']) ? trim((string)$body['viewKey']) : '';
    if ($viewKey === '' || !preg_match(self::VIEW_KEY_REGEX, $viewKey)) {
      throw new ValidationException(['viewKey' => 'Identidad de vista inválida.'], 'Error de validación');
    }

    // 2. Datos informativos (no son identidad, pueden cambiar libremente).
    $label = isset($body['label']) ? mb_substr(trim((string)$body['label']), 0, 150) : null;
    $path  = isset($body['path'])  ? mb_substr(trim((string)$body['path']), 0, 191) : null;

    // 3. Hash de la IP (privacidad: no guardamos la IP en claro).
    $ipHash = self::hashClientIp();

    $counted = VisitModel::registerHit($viewKey, $label, $path, $ipHash);

    return [
      'view_key' => $viewKey,
      'counted'  => $counted // true = visita única del día; false = ya había contado hoy
    ];
  }

  /**
   * Resumen para el panel (endpoint protegido).
   */
  public static function getSummary(): array {
    $rows = VisitModel::getSummary();

    return array_map(
      fn($r) => [
        'view_key'   => $r['view_key'],
        'label'      => $r['label'],
        'path'       => $r['path'],
        'total'      => (int) $r['total'],
        'today'      => (int) $r['today'],
        'first_seen' => $r['first_seen'],
        'last_seen'  => $r['last_seen']
      ],
      $rows
    );
  }

  /**
   * Serie diaria para gráficas (endpoint protegido).
   */
  public static function getDailySeries(int $days = 30): array {
    $rows = VisitModel::getDailySeries($days);

    return array_map(
      fn($r) => [
        'view_key'   => $r['view_key'],
        'visit_date' => $r['visit_date'],
        'hits'       => (int) $r['hits']
      ],
      $rows
    );
  }

  /**
   * Obtiene y normaliza la IP del cliente, soportando proxys, y la hashea.
   * Se usa JWT_SECRET como sal para que el hash no sea reversible por diccionario.
   */
  private static function hashClientIp(): string {
    $ip = $_SERVER['REMOTE_ADDR'] ?? '0.0.0.0';

    // Si hay proxy/balanceador, tomamos la primera IP de la cadena.
    if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
      $parts = explode(',', $_SERVER['HTTP_X_FORWARDED_FOR']);
      $candidate = trim($parts[0]);
      if (filter_var($candidate, FILTER_VALIDATE_IP)) {
        $ip = $candidate;
      }
    }

    $salt = $_ENV['JWT_SECRET'] ?? 'redim_visit_salt';
    return hash('sha256', $salt . '|' . $ip);
  }
}
?>
