-- ==================================================================================================
-- Módulos de contenido administrable para vistas públicas
-- Vistas: Voces, Miradas, TV (Niñez Primero), Recursos
-- Convención: id PK AUTO_INCREMENT, status tinyint(1) DEFAULT 1, sort_order, created_at/updated_at
-- Motor: InnoDB / utf8mb4
-- ==================================================================================================

-- ===================================  VOCES  ======================================================

CREATE TABLE IF NOT EXISTS voces_videos (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  youtube_id  VARCHAR(50)  NOT NULL,
  title       VARCHAR(250) NOT NULL,
  date_label  VARCHAR(100) DEFAULT NULL,
  channel     VARCHAR(150) DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS voces_testimonials (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(150) NOT NULL,
  country     VARCHAR(100) DEFAULT NULL,
  tagline     VARCHAR(250) DEFAULT NULL,
  image_url   VARCHAR(255) DEFAULT NULL,
  description TEXT DEFAULT NULL,
  is_main     TINYINT(1) NOT NULL DEFAULT 0,
  badges      LONGTEXT DEFAULT NULL,           -- JSON: [{"label":"...","url":"..."}]
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS voces_podcasts (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(250) NOT NULL,
  author      VARCHAR(250) DEFAULT NULL,
  duration    VARCHAR(20)  DEFAULT NULL,
  url         VARCHAR(500) NOT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ===================================  MIRADAS  ====================================================

CREATE TABLE IF NOT EXISTS miradas_works (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  section     ENUM('personajes','gallery') NOT NULL DEFAULT 'gallery',
  title       VARCHAR(250) DEFAULT NULL,
  author_name VARCHAR(150) DEFAULT NULL,
  age         INT DEFAULT NULL,
  image_url   VARCHAR(255) DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS miradas_contest_links (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  label       VARCHAR(150) NOT NULL,
  action      VARCHAR(150) DEFAULT NULL,
  parent_id   INT DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ===================================  TV (Niñez Primero)  =========================================

CREATE TABLE IF NOT EXISTS tv_videos (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  youtube_id  VARCHAR(50)  DEFAULT NULL,
  playlist_id VARCHAR(100) DEFAULT NULL,
  thumb_id    VARCHAR(50)  DEFAULT NULL,
  title       VARCHAR(250) DEFAULT NULL,
  channel     VARCHAR(150) DEFAULT NULL,
  date_label  VARCHAR(100) DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS tv_social_buttons (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  label       VARCHAR(100) NOT NULL,
  url         VARCHAR(500) NOT NULL,
  icon        VARCHAR(100) DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ===================================  RECURSOS  ===================================================

CREATE TABLE IF NOT EXISTS recursos_study_categories (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(150) NOT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS recursos_studies (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(300) NOT NULL,
  url         VARCHAR(500) DEFAULT NULL,
  category_id INT DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS recursos_downloads (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(250) NOT NULL,
  subtitle    VARCHAR(250) DEFAULT NULL,
  file_url    VARCHAR(255) DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ===================================  ACTUAMOS  ===================================================
-- 2 tablas independientes (no comparten datos entre sí):
--   1) actuamos_acciones      -> Carrusel pasarela "Acciones" (parte superior de la vista)
--   2) actuamos_internacional -> Carrusel pasarela "Incidencia internacional" (fondo degradado)
-- La tercera vive agrupada con el resto de tablas del mapa: ver `mapa_state_posts` más abajo.

CREATE TABLE IF NOT EXISTS actuamos_acciones (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  image_url   VARCHAR(255) DEFAULT NULL,
  title       VARCHAR(300) NOT NULL,
  date_label  VARCHAR(100) DEFAULT NULL,
  url         VARCHAR(500) NOT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Panel del mapa interactivo (Veracruz / CDMX / Michoacán), discriminado por `state_id`
-- (FK a `states`, mismo patrón que `centers.state_id`)
CREATE TABLE IF NOT EXISTS mapa_state_posts (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  state_id    INT NOT NULL,
  image_url   VARCHAR(255) DEFAULT NULL,
  title       VARCHAR(300) NOT NULL,
  url         VARCHAR(500) NOT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY state_id (state_id),
  CONSTRAINT mapa_state_posts_ibfk_1 FOREIGN KEY (state_id) REFERENCES states (id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS actuamos_internacional (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  channel     VARCHAR(100) NOT NULL,
  image_url   VARCHAR(255) DEFAULT NULL,
  title       VARCHAR(300) NOT NULL,
  date_label  VARCHAR(100) DEFAULT NULL,
  url         VARCHAR(500) NOT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ===================================  PERMISOS  ===================================================
-- Un módulo por grupo. Administrador (role_id=1) read-write, Consultor (role_id=2) read-only.
-- Idempotente: limpia estos módulos antes de insertar.

DELETE FROM role_permissions WHERE module IN ('voces','miradas','tv','recursos','actuamos');

INSERT INTO role_permissions (role_id, module, permission_type) VALUES
(1, 'voces',    'read-write'),
(1, 'miradas',  'read-write'),
(1, 'tv',       'read-write'),
(1, 'recursos', 'read-write'),
(1, 'actuamos', 'read-write'),
(2, 'voces',    'read-only'),
(2, 'miradas',  'read-only'),
(2, 'tv',       'read-only'),
(2, 'recursos', 'read-only'),
(2, 'actuamos', 'read-only');
