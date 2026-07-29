-- ============================================================
-- Migración de esquema: local (redim) -> producción (aularedi_redim)
-- Generado a partir de comparar redim_schema.sql vs aularedi_redim_schema.sql
--
-- *** REQUISITOS ANTES DE EJECUTAR ***
-- 1. Backup COMPLETO de producción (schema + datos) ya realizado y verificado.
-- 2. Probado primero contra una copia restaurada de producción (no contra la real).
-- 3. Ejecutar completo, en una sola sesión, en horario de bajo tráfico.
-- ============================================================

SET FOREIGN_KEY_CHECKS=0;
START TRANSACTION;

-- ============================================================
-- 1. TABLAS NUEVAS (contenido administrable agregado en local)
--    Orden respeta dependencias de FK.
-- ============================================================

CREATE TABLE `history_categories` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `block` enum('reportajes','profundizar') NOT NULL DEFAULT 'profundizar',
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `history_category_details` (
  `id` int NOT NULL AUTO_INCREMENT,
  `category_id` int NOT NULL,
  `title` varchar(300) NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `category_id` (`category_id`),
  CONSTRAINT `history_category_details_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `history_categories` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `transparencia_sections` (
  `id` int NOT NULL AUTO_INCREMENT,
  `block` enum('convocatorias','informes') NOT NULL DEFAULT 'convocatorias',
  `title` varchar(300) NOT NULL,
  `description` text DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `transparencia_docs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `section_id` int NOT NULL,
  `title` varchar(300) NOT NULL,
  `url` varchar(500) NOT NULL,
  `redes` longtext DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `section_id` (`section_id`),
  CONSTRAINT `transparencia_docs_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `transparencia_sections` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `state_descriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `state_id` int NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `state_id` (`state_id`),
  CONSTRAINT `state_descriptions_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `mapa_state_posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `state_id` int NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `url` varchar(500) NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `state_id` (`state_id`),
  CONSTRAINT `mapa_state_posts_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `actuamos_acciones` (
  `id` int NOT NULL AUTO_INCREMENT,
  `image_url` varchar(255) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `date_label` varchar(100) DEFAULT NULL,
  `url` varchar(500) NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `actuamos_gallery` (
  `id` int NOT NULL AUTO_INCREMENT,
  `platform` enum('instagram','youtube','facebook','tiktok','linkedin') NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `date_label` varchar(100) DEFAULT NULL,
  `url` varchar(500) NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `actuamos_internacional` (
  `id` int NOT NULL AUTO_INCREMENT,
  `channel` varchar(100) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `date_label` varchar(100) DEFAULT NULL,
  `url` varchar(500) NOT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `help_contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `phone` varchar(50) NOT NULL,
  `phone_alt` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `social_text` varchar(255) DEFAULT NULL,
  `sort_order` int NOT NULL DEFAULT '0',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `help_settings` (
  `id` int NOT NULL AUTO_INCREMENT,
  `emergency_phone` varchar(50) NOT NULL DEFAULT '911',
  `updated_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ============================================================
-- 2. Columna nueva en tabla existente (aditiva, sin riesgo)
-- ============================================================

ALTER TABLE `miradas_contest_links`
  ADD COLUMN `file_url` varchar(255) DEFAULT NULL AFTER `action`;

-- ============================================================
-- 3. miradas_works: el enum `section` gana el valor 'personajes'.
--    NO se quita 'carousel' todavía: producción tiene 3 filas (ids 1,2,3)
--    con section='carousel' y contenido real. Ver decisión pendiente
--    en el mensaje de análisis antes de correr el script 003 que
--    resuelve esas filas y recién ahí quita 'carousel' del enum.
-- ============================================================

ALTER TABLE `miradas_works`
  MODIFY COLUMN `section` enum('carousel','personajes','gallery') NOT NULL DEFAULT 'gallery';

-- ============================================================
-- 4. recursos_studies: category_id (FK débil, SIEMPRE NULL en las
--    12 filas de producción -> sin pérdida de datos posible) se
--    sustituye por category (enum) + se agregan state_id e image_url.
-- ============================================================

ALTER TABLE `recursos_studies`
  ADD COLUMN `category` enum('Investigaciones','Otros') NOT NULL DEFAULT 'Otros' AFTER `url`,
  ADD COLUMN `state_id` int DEFAULT NULL AFTER `category`,
  ADD COLUMN `image_url` varchar(255) DEFAULT NULL AFTER `state_id`,
  ADD KEY `state_id` (`state_id`),
  ADD CONSTRAINT `recursos_studies_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE,
  DROP COLUMN `category_id`;

-- ============================================================
-- 5. Tabla eliminada en local: recursos_study_categories.
--    3 filas en producción, ninguna referenciada (category_id
--    siempre fue NULL) -> se archiva en vez de borrar directo.
-- ============================================================

RENAME TABLE `recursos_study_categories` TO `_archived_recursos_study_categories`;
-- Tras confirmar que no se necesita, en un momento posterior:
-- DROP TABLE `_archived_recursos_study_categories`;

COMMIT;
SET FOREIGN_KEY_CHECKS=1;
