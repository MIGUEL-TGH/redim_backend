<?php
require_once 'BaseModel.php';

class VisitModel extends BaseModel {

  /**
   * Registra una visita con dedupe por (view_key, día, IP).
   * - Auto-registra la vista en el catálogo (view_pages) en su primer hit.
   * - Solo incrementa el agregado diario si la IP no había contado hoy.
   *
   * @return bool true si se contó como visita nueva, false si fue duplicada.
   */
  public static function registerHit(string $viewKey, ?string $label, ?string $path, string $ipHash): bool {
    $link = ConnectionBD::CNN();

    try {
      $link->beginTransaction();

      // 1) UPSERT del catálogo (identidad = view_key, inmutable).
      $stmt = $link->prepare(
        "INSERT INTO view_pages (view_key, label, path)
         VALUES (:view_key, :label, :path)
         ON DUPLICATE KEY UPDATE
           label = VALUES(label),
           path  = VALUES(path),
           last_seen = current_timestamp()"
      );
      $stmt->execute([
        'view_key' => $viewKey,
        'label'    => $label,
        'path'     => $path
      ]);

      // 2) Dedupe: intentamos registrar (view_key, hoy, ip_hash).
      //    Si ya existía, INSERT IGNORE no afecta filas y NO incrementamos.
      $logStmt = $link->prepare(
        "INSERT IGNORE INTO view_visit_log (view_key, visit_date, ip_hash)
         VALUES (:view_key, CURDATE(), :ip_hash)"
      );
      $logStmt->execute([
        'view_key' => $viewKey,
        'ip_hash'  => $ipHash
      ]);

      $isNewVisit = $logStmt->rowCount() === 1;

      // 3) Solo si es visita única del día, incrementamos el agregado diario.
      if ($isNewVisit) {
        $dailyStmt = $link->prepare(
          "INSERT INTO view_visit_daily (view_key, visit_date, hits)
           VALUES (:view_key, CURDATE(), 1)
           ON DUPLICATE KEY UPDATE hits = hits + 1"
        );
        $dailyStmt->execute(['view_key' => $viewKey]);
      }

      $link->commit();
      return $isNewVisit;

    } catch (PDOException $e) {
      if ($link->inTransaction()) {
        $link->rollBack();
      }
      throw new DatabaseException("Error registrando visita: " . $e->getMessage());
    }
  }

  /**
   * Resumen por vista: total acumulado, visitas de hoy y última actividad.
   */
  public static function getSummary(): array {
    $sql =
      "SELECT
         p.view_key,
         p.label,
         p.path,
         p.first_seen,
         p.last_seen,
         COALESCE(SUM(d.hits), 0) AS total,
         COALESCE(SUM(CASE WHEN d.visit_date = CURDATE() THEN d.hits ELSE 0 END), 0) AS today
       FROM view_pages p
       LEFT JOIN view_visit_daily d ON d.view_key = p.view_key
       GROUP BY p.view_key, p.label, p.path, p.first_seen, p.last_seen
       ORDER BY total DESC";

    return self::query($sql, [], 'all');
  }

  /**
   * Serie diaria (para gráficas de tendencia) de los últimos N días.
   * Devuelve filas (view_key, visit_date, hits).
   */
  public static function getDailySeries(int $days = 30): array {
    // $days viene casteado a int desde el controlador: seguro para interpolar.
    $days = max(1, $days);
    $sql =
      "SELECT view_key, visit_date, hits
       FROM view_visit_daily
       WHERE visit_date >= (CURDATE() - INTERVAL {$days} DAY)
       ORDER BY visit_date ASC";

    return self::query($sql, [], 'all');
  }
}
?>
