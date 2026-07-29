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

-- Investigaciones (con portada) y Otros estudios (sin portada), ver `category`
CREATE TABLE IF NOT EXISTS recursos_studies (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  title       VARCHAR(300) NOT NULL,
  url         VARCHAR(500) DEFAULT NULL,
  category    ENUM('Investigaciones','Otros') NOT NULL DEFAULT 'Otros',
  image_url   VARCHAR(255) DEFAULT NULL,
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

-- ===================================  HISTORIAS  ===================================================
-- `history_categories.block` decide en cuál de las 2 plantillas de HistoriasView.vue aparece:
-- 'reportajes' (fondo degradado, arriba) o 'profundizar' (Para profundizar / Sala de prensa).
CREATE TABLE IF NOT EXISTS history_categories (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(150) NOT NULL,
  block       ENUM('reportajes','profundizar') NOT NULL DEFAULT 'profundizar',
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS history_category_details (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  category_id INT NOT NULL,
  title       VARCHAR(300) NOT NULL,
  url         VARCHAR(500) DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY category_id (category_id),
  CONSTRAINT history_category_details_ibfk_1 FOREIGN KEY (category_id) REFERENCES history_categories (id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ===================================  ¿NECESITAS AYUDA?  ==========================================
-- NecesitasAyudaComp.vue: help_contacts es la lista de tarjetas "¿A quién llamar?";
-- help_settings es una fila única (id=1) con valores globales de la sección (hoy solo el 911).

-- `description` admite HTML simple (<strong>) para resaltar texto dentro del
-- párrafo, en vez de una columna `note` separada.
CREATE TABLE IF NOT EXISTS help_contacts (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  name        VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  phone       VARCHAR(50)  NOT NULL,
  phone_alt   VARCHAR(50)  DEFAULT NULL,
  email       VARCHAR(150) DEFAULT NULL,
  social_text VARCHAR(255) DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS help_settings (
  id              INT PRIMARY KEY,
  emergency_phone VARCHAR(50) NOT NULL DEFAULT '911',
  updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT IGNORE INTO help_settings (id, emergency_phone) VALUES (1, '911');

-- ===================================  TRANSPARENCIA  ===============================================
-- TransparenciaView.vue: transparencia_sections agrupa por `block` (convocatorias/informes);
-- transparencia_docs.redes es JSON [{"label":"Instagram","url":"..."}], mismo patrón que
-- voces_testimonials.badges (repetidor en el dashboard en vez de una tercera tabla).

CREATE TABLE IF NOT EXISTS transparencia_sections (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  block       ENUM('convocatorias','informes') NOT NULL DEFAULT 'convocatorias',
  title       VARCHAR(300) NOT NULL,
  description TEXT DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE IF NOT EXISTS transparencia_docs (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  section_id  INT NOT NULL,
  title       VARCHAR(300) NOT NULL,
  url         VARCHAR(500) NOT NULL,
  redes       LONGTEXT DEFAULT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY section_id (section_id),
  CONSTRAINT transparencia_docs_ibfk_1 FOREIGN KEY (section_id) REFERENCES transparencia_sections (id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ===================================  DESCRIPCIONES POR ESTADO  ====================================
-- StateDetailsDialog.vue (popup del mapa en ArcGISMapView.vue, ruta /mapa): reemplaza las pestañas
-- INFORMACIÓN/GALERÍA/CASOS por este texto único, uno por estado (relación 1:1 vía UNIQUE KEY).

CREATE TABLE IF NOT EXISTS state_descriptions (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  state_id    INT NOT NULL,
  description TEXT NOT NULL,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  UNIQUE KEY state_id (state_id),
  CONSTRAINT state_descriptions_ibfk_1 FOREIGN KEY (state_id) REFERENCES states (id) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ===================================  PERMISOS  ===================================================
-- Un módulo por grupo. Administrador (role_id=1) read-write, Consultor (role_id=2) read-only.
-- Idempotente: limpia estos módulos antes de insertar.

DELETE FROM role_permissions WHERE module IN ('voces','miradas','tv','recursos','actuamos','historias','ayuda','transparencia','state_descriptions');

INSERT INTO role_permissions (role_id, module, permission_type) VALUES
(1, 'voces',     'read-write'),
(1, 'miradas',   'read-write'),
(1, 'tv',        'read-write'),
(1, 'recursos',  'read-write'),
(1, 'actuamos',  'read-write'),
(1, 'historias', 'read-write'),
(1, 'ayuda',     'read-write'),
(1, 'transparencia', 'read-write'),
(1, 'state_descriptions', 'read-write'),
(2, 'voces',     'read-only'),
(2, 'miradas',   'read-only'),
(2, 'tv',        'read-only'),
(2, 'recursos',  'read-only'),
(2, 'actuamos',  'read-only'),
(2, 'historias', 'read-only'),
(2, 'ayuda',     'read-only'),
(2, 'transparencia', 'read-only'),
(2, 'state_descriptions', 'read-only');
