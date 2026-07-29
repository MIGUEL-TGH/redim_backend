-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 29-07-2026 a las 12:08:16
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `redim`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actuamos_acciones`
--

CREATE TABLE `actuamos_acciones` (
  `id` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `date_label` varchar(100) DEFAULT NULL,
  `url` varchar(500) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actuamos_gallery`
--

CREATE TABLE `actuamos_gallery` (
  `id` int(11) NOT NULL,
  `platform` enum('instagram','youtube','facebook','tiktok','linkedin') NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `date_label` varchar(100) DEFAULT NULL,
  `url` varchar(500) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actuamos_internacional`
--

CREATE TABLE `actuamos_internacional` (
  `id` int(11) NOT NULL,
  `channel` varchar(100) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `date_label` varchar(100) DEFAULT NULL,
  `url` varchar(500) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `centers`
--

CREATE TABLE `centers` (
  `id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `locate` varchar(50) DEFAULT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cnsipee`
--

CREATE TABLE `cnsipee` (
  `id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `woman` int(5) NOT NULL,
  `man` int(5) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Reclutamiento de adolescentes en México';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `countries`
--

CREATE TABLE `countries` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `iso_code` varchar(3) NOT NULL,
  `demonym` varchar(50) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genders`
--

CREATE TABLE `genders` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `help_contacts`
--

CREATE TABLE `help_contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `phone` varchar(50) NOT NULL,
  `phone_alt` varchar(50) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `social_text` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `help_settings`
--

CREATE TABLE `help_settings` (
  `id` int(11) NOT NULL,
  `emergency_phone` varchar(50) NOT NULL DEFAULT '911',
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `history_categories`
--

CREATE TABLE `history_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `block` enum('reportajes','profundizar') NOT NULL DEFAULT 'profundizar',
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `history_category_details`
--

CREATE TABLE `history_category_details` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `title` varchar(300) NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicators`
--

CREATE TABLE `indicators` (
  `id` int(11) NOT NULL,
  `name` varchar(250) NOT NULL,
  `team` int(1) NOT NULL,
  `map` int(1) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicator_categories`
--

CREATE TABLE `indicator_categories` (
  `id` int(11) NOT NULL,
  `indicator_id` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `level` int(11) NOT NULL,
  `sort_order` int(11) DEFAULT 0,
  `status` tinyint(4) DEFAULT 1,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `indicator_category_details`
--

CREATE TABLE `indicator_category_details` (
  `id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `year_id` int(11) NOT NULL,
  `gender_id` int(11) NOT NULL,
  `center_id` int(11) DEFAULT NULL,
  `state_id` int(11) NOT NULL,
  `PI` int(4) NOT NULL COMMENT 'Población Internada',
  `PS` int(4) NOT NULL COMMENT 'Población Señalada',
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mapa_state_posts`
--

CREATE TABLE `mapa_state_posts` (
  `id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `title` varchar(300) NOT NULL,
  `url` varchar(500) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `miradas_contest_links`
--

CREATE TABLE `miradas_contest_links` (
  `id` int(11) NOT NULL,
  `label` varchar(150) NOT NULL,
  `action` varchar(150) DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `miradas_works`
--

CREATE TABLE `miradas_works` (
  `id` int(11) NOT NULL,
  `section` enum('personajes','gallery') NOT NULL DEFAULT 'gallery' COMMENT '''personajes'' ; ''gallery''',
  `title` varchar(250) DEFAULT NULL,
  `author_name` varchar(150) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos_downloads`
--

CREATE TABLE `recursos_downloads` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `subtitle` varchar(250) DEFAULT NULL,
  `file_url` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos_studies`
--

CREATE TABLE `recursos_studies` (
  `id` int(11) NOT NULL,
  `title` varchar(300) NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `category` enum('Investigaciones','Otros') NOT NULL DEFAULT 'Otros',
  `state_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `role_permissions`
--

CREATE TABLE `role_permissions` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `module` varchar(50) NOT NULL,
  `permission_type` enum('read-only','read-write') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sesnsp`
--

CREATE TABLE `sesnsp` (
  `id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `woman` int(4) NOT NULL,
  `man` int(4) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Trata de personas de 0 a 17 años en México';

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `states`
--

CREATE TABLE `states` (
  `id` int(11) NOT NULL,
  `country_id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `demonym` varchar(50) NOT NULL,
  `iso_code` varchar(3) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `state_descriptions`
--

CREATE TABLE `state_descriptions` (
  `id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `description` text NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transparencia_docs`
--

CREATE TABLE `transparencia_docs` (
  `id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `title` varchar(300) NOT NULL,
  `url` varchar(500) NOT NULL,
  `redes` longtext DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `transparencia_sections`
--

CREATE TABLE `transparencia_sections` (
  `id` int(11) NOT NULL,
  `block` enum('convocatorias','informes') NOT NULL DEFAULT 'convocatorias',
  `title` varchar(300) NOT NULL,
  `description` text DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tv_social_buttons`
--

CREATE TABLE `tv_social_buttons` (
  `id` int(11) NOT NULL,
  `label` varchar(100) NOT NULL,
  `url` varchar(500) NOT NULL,
  `icon` varchar(100) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tv_videos`
--

CREATE TABLE `tv_videos` (
  `id` int(11) NOT NULL,
  `youtube_id` varchar(50) DEFAULT NULL,
  `playlist_id` varchar(100) DEFAULT NULL,
  `thumb_id` varchar(50) DEFAULT NULL,
  `title` varchar(250) DEFAULT NULL,
  `channel` varchar(150) DEFAULT NULL,
  `date_label` varchar(100) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `resetpassword` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `view_pages`
--

CREATE TABLE `view_pages` (
  `id` int(11) NOT NULL,
  `view_key` varchar(50) NOT NULL,
  `label` varchar(150) DEFAULT NULL,
  `path` varchar(191) DEFAULT NULL,
  `first_seen` timestamp NOT NULL DEFAULT current_timestamp(),
  `last_seen` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `view_visit_daily`
--

CREATE TABLE `view_visit_daily` (
  `id` int(11) NOT NULL,
  `view_key` varchar(50) NOT NULL,
  `visit_date` date NOT NULL,
  `hits` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `view_visit_log`
--

CREATE TABLE `view_visit_log` (
  `id` bigint(20) NOT NULL,
  `view_key` varchar(50) NOT NULL,
  `visit_date` date NOT NULL,
  `ip_hash` char(64) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voces_podcasts`
--

CREATE TABLE `voces_podcasts` (
  `id` int(11) NOT NULL,
  `title` varchar(250) NOT NULL,
  `author` varchar(250) DEFAULT NULL,
  `duration` varchar(20) DEFAULT NULL,
  `url` varchar(500) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voces_testimonials`
--

CREATE TABLE `voces_testimonials` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `country` varchar(100) DEFAULT NULL,
  `tagline` varchar(250) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `is_main` tinyint(1) NOT NULL DEFAULT 0,
  `badges` longtext DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `voces_videos`
--

CREATE TABLE `voces_videos` (
  `id` int(11) NOT NULL,
  `youtube_id` varchar(50) NOT NULL,
  `title` varchar(250) NOT NULL,
  `date_label` varchar(100) DEFAULT NULL,
  `channel` varchar(150) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `years`
--

CREATE TABLE `years` (
  `id` int(11) NOT NULL,
  `name` varchar(4) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actuamos_acciones`
--
ALTER TABLE `actuamos_acciones`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `actuamos_gallery`
--
ALTER TABLE `actuamos_gallery`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `actuamos_internacional`
--
ALTER TABLE `actuamos_internacional`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `centers`
--
ALTER TABLE `centers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indices de la tabla `cnsipee`
--
ALTER TABLE `cnsipee`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `genders`
--
ALTER TABLE `genders`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `help_contacts`
--
ALTER TABLE `help_contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `help_settings`
--
ALTER TABLE `help_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `history_categories`
--
ALTER TABLE `history_categories`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `history_category_details`
--
ALTER TABLE `history_category_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indices de la tabla `indicators`
--
ALTER TABLE `indicators`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `indicator_categories`
--
ALTER TABLE `indicator_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `indicator_id` (`indicator_id`);

--
-- Indices de la tabla `indicator_category_details`
--
ALTER TABLE `indicator_category_details`
  ADD PRIMARY KEY (`id`),
  ADD KEY `indicator_category_id` (`category_id`),
  ADD KEY `year_id` (`year_id`),
  ADD KEY `gender_id` (`gender_id`),
  ADD KEY `center_id` (`center_id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indices de la tabla `mapa_state_posts`
--
ALTER TABLE `mapa_state_posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indices de la tabla `miradas_contest_links`
--
ALTER TABLE `miradas_contest_links`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `miradas_works`
--
ALTER TABLE `miradas_works`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recursos_downloads`
--
ALTER TABLE `recursos_downloads`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recursos_studies`
--
ALTER TABLE `recursos_studies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`);

--
-- Indices de la tabla `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_role_permissions_role` (`role_id`);

--
-- Indices de la tabla `sesnsp`
--
ALTER TABLE `sesnsp`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`) USING BTREE;

--
-- Indices de la tabla `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`);

--
-- Indices de la tabla `state_descriptions`
--
ALTER TABLE `state_descriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `state_id` (`state_id`);

--
-- Indices de la tabla `transparencia_docs`
--
ALTER TABLE `transparencia_docs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `section_id` (`section_id`);

--
-- Indices de la tabla `transparencia_sections`
--
ALTER TABLE `transparencia_sections`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tv_social_buttons`
--
ALTER TABLE `tv_social_buttons`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tv_videos`
--
ALTER TABLE `tv_videos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `fk_users_role` (`role_id`);

--
-- Indices de la tabla `view_pages`
--
ALTER TABLE `view_pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_view_key` (`view_key`);

--
-- Indices de la tabla `view_visit_daily`
--
ALTER TABLE `view_visit_daily`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_view_date` (`view_key`,`visit_date`),
  ADD KEY `idx_date` (`visit_date`);

--
-- Indices de la tabla `view_visit_log`
--
ALTER TABLE `view_visit_log`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uq_view_date_ip` (`view_key`,`visit_date`,`ip_hash`);

--
-- Indices de la tabla `voces_podcasts`
--
ALTER TABLE `voces_podcasts`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voces_testimonials`
--
ALTER TABLE `voces_testimonials`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `voces_videos`
--
ALTER TABLE `voces_videos`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `years`
--
ALTER TABLE `years`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actuamos_acciones`
--
ALTER TABLE `actuamos_acciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `actuamos_gallery`
--
ALTER TABLE `actuamos_gallery`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `actuamos_internacional`
--
ALTER TABLE `actuamos_internacional`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `centers`
--
ALTER TABLE `centers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cnsipee`
--
ALTER TABLE `cnsipee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `genders`
--
ALTER TABLE `genders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `help_contacts`
--
ALTER TABLE `help_contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `history_categories`
--
ALTER TABLE `history_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `history_category_details`
--
ALTER TABLE `history_category_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indicators`
--
ALTER TABLE `indicators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indicator_categories`
--
ALTER TABLE `indicator_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `indicator_category_details`
--
ALTER TABLE `indicator_category_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `mapa_state_posts`
--
ALTER TABLE `mapa_state_posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `miradas_contest_links`
--
ALTER TABLE `miradas_contest_links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `miradas_works`
--
ALTER TABLE `miradas_works`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recursos_downloads`
--
ALTER TABLE `recursos_downloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `recursos_studies`
--
ALTER TABLE `recursos_studies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `sesnsp`
--
ALTER TABLE `sesnsp`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `state_descriptions`
--
ALTER TABLE `state_descriptions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `transparencia_docs`
--
ALTER TABLE `transparencia_docs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `transparencia_sections`
--
ALTER TABLE `transparencia_sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tv_social_buttons`
--
ALTER TABLE `tv_social_buttons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `tv_videos`
--
ALTER TABLE `tv_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `view_pages`
--
ALTER TABLE `view_pages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `view_visit_daily`
--
ALTER TABLE `view_visit_daily`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `view_visit_log`
--
ALTER TABLE `view_visit_log`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `voces_podcasts`
--
ALTER TABLE `voces_podcasts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `voces_testimonials`
--
ALTER TABLE `voces_testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `voces_videos`
--
ALTER TABLE `voces_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `years`
--
ALTER TABLE `years`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `centers`
--
ALTER TABLE `centers`
  ADD CONSTRAINT `centers_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `history_category_details`
--
ALTER TABLE `history_category_details`
  ADD CONSTRAINT `history_category_details_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `history_categories` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `indicator_categories`
--
ALTER TABLE `indicator_categories`
  ADD CONSTRAINT `indicator_categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `indicator_categories` (`id`),
  ADD CONSTRAINT `indicator_categories_ibfk_2` FOREIGN KEY (`indicator_id`) REFERENCES `indicators` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `indicator_category_details`
--
ALTER TABLE `indicator_category_details`
  ADD CONSTRAINT `indicator_category_details_ibfk_1` FOREIGN KEY (`center_id`) REFERENCES `centers` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `indicator_category_details_ibfk_3` FOREIGN KEY (`year_id`) REFERENCES `years` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `indicator_category_details_ibfk_4` FOREIGN KEY (`gender_id`) REFERENCES `genders` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `indicator_category_details_ibfk_5` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `indicator_category_details_ibfk_6` FOREIGN KEY (`category_id`) REFERENCES `indicator_categories` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `mapa_state_posts`
--
ALTER TABLE `mapa_state_posts`
  ADD CONSTRAINT `mapa_state_posts_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `recursos_studies`
--
ALTER TABLE `recursos_studies`
  ADD CONSTRAINT `recursos_studies_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  ADD CONSTRAINT `fk_role_permissions_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `states`
--
ALTER TABLE `states`
  ADD CONSTRAINT `states_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `state_descriptions`
--
ALTER TABLE `state_descriptions`
  ADD CONSTRAINT `state_descriptions_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `transparencia_docs`
--
ALTER TABLE `transparencia_docs`
  ADD CONSTRAINT `transparencia_docs_ibfk_1` FOREIGN KEY (`section_id`) REFERENCES `transparencia_sections` (`id`) ON UPDATE CASCADE;

--
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
