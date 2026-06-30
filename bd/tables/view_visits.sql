-- =====================================================================
-- Contador de visitas de vistas públicas (escalable / auto-registrable)
-- =====================================================================
-- Identidad inmutable de cada vista = view_key (NUNCA cambia).
-- El label y el path SÍ pueden cambiar sin perder el histórico.
-- Granularidad: por día. Dedupe de "visita única" por IP + día.
-- =====================================================================

-- 1) Catálogo de vistas. Se auto-registra en el primer hit.
CREATE TABLE IF NOT EXISTS view_pages (
  id          INT(11)      NOT NULL AUTO_INCREMENT,
  view_key    VARCHAR(50)  NOT NULL,                 -- identidad inmutable (ej: 'miradas')
  label       VARCHAR(150) DEFAULT NULL,             -- título visible (puede cambiar)
  path        VARCHAR(191) DEFAULT NULL,             -- última URL conocida (puede cambiar)
  first_seen  TIMESTAMP    NOT NULL DEFAULT current_timestamp(),
  last_seen   TIMESTAMP    NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (id),
  UNIQUE KEY uq_view_key (view_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2) Agregado diario (lectura rápida para el panel).
CREATE TABLE IF NOT EXISTS view_visit_daily (
  id          INT(11)     NOT NULL AUTO_INCREMENT,
  view_key    VARCHAR(50) NOT NULL,
  visit_date  DATE        NOT NULL,
  hits        INT(11)     NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_view_date (view_key, visit_date),
  KEY idx_date (visit_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3) Log de dedupe: una IP cuenta una sola vez por vista por día.
--    Se guarda el hash de la IP (privacidad), no la IP en claro.
CREATE TABLE IF NOT EXISTS view_visit_log (
  id          BIGINT(20)  NOT NULL AUTO_INCREMENT,
  view_key    VARCHAR(50) NOT NULL,
  visit_date  DATE        NOT NULL,
  ip_hash     CHAR(64)    NOT NULL,
  created_at  TIMESTAMP   NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (id),
  UNIQUE KEY uq_view_date_ip (view_key, visit_date, ip_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
