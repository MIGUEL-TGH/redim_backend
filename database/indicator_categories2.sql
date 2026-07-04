-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 23-02-2026 a las 02:53:47
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

--
-- Volcado de datos para la tabla `indicator_categories`
--

INSERT INTO `indicator_categories` (`id`, `indicator_id`, `parent_id`, `name`, `level`, `sort_order`, `status`, `created_at`) VALUES
(1, 1, NULL, 'Aborto', 1, 0, 1, '2026-02-01 00:00:00'),
(2, 2, NULL, 'Abuso de confianza', 0, 0, 1, '2026-02-01 00:00:00'),
(3, 2, NULL, 'Falsedad', 0, 0, 1, '2026-02-01 00:00:00'),
(4, 3, NULL, 'Abuso, acoso y hostigamiento sexual', 0, 0, 1, '2026-02-01 00:00:00'),
(5, 3, 4, 'Abuso sexual', 1, 0, 0, '2026-02-01 00:00:00'),
(6, 3, 4, 'Acoso sexual', 1, 0, 0, '2026-02-01 00:00:00'),
(7, 3, 4, 'Hostigamiento sexual', 1, 0, 0, '2026-02-01 00:00:00'),
(8, 3, NULL, 'IncestoXXXXX', 1, 0, 0, '2026-02-01 00:00:00'),
(9, 3, NULL, 'Otros delitos sexuales N2', 1, 0, 1, '2026-02-01 00:00:00'),
(10, 3, 9, 'Contra la Libertad y el Normal Desarrollo Psicosexual', 1, 0, 1, '2026-02-01 00:00:00'),
(11, 3, 9, 'Delitos Contra la Libertad y el Normal Desarrollo Psicosexual', 1, 0, 0, '2026-02-01 00:00:00'),
(12, 3, 9, 'La libertad y la seguridad sexual', 1, 0, 0, '2026-02-01 00:00:00'),
(13, 3, NULL, 'Otros delitos sexualesXXXXX', 1, 0, 0, '2026-02-20 01:18:17'),
(14, 4, NULL, 'Delitos', 2, 0, 0, '2026-02-20 02:14:25'),
(15, 4, NULL, 'Actos de terrorismo', 1, 0, 1, '2026-02-22 19:16:21'),
(16, 4, 15, 'Terrorismo', 2, 0, 1, '2026-02-22 19:17:05'),
(17, 4, NULL, 'Contrabando de bienes o servicios diversos', 1, 0, 1, '2026-02-22 19:17:39'),
(18, 4, 17, 'Comercialización y tráfico de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 2, 0, 1, '2026-02-22 19:18:55'),
(19, 4, 17, 'Delitos en materia de hidrocarburos y sus derivados', 2, 0, 1, '2026-02-22 19:20:17'),
(20, 4, 18, 'Comercialización de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 3, 0, 1, '2026-02-22 19:22:11'),
(21, 4, 18, 'Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - Comercialización de flora o fauna', 3, 0, 1, '2026-02-22 19:23:18'),
(22, 4, 18, 'Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - Tráfico de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 3, 0, 1, '2026-02-22 19:27:18'),
(23, 4, 18, 'Tráfico de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 3, 0, 1, '2026-02-22 19:28:08'),
(24, 4, 19, 'Aprovechamiento de hidrocarburos y sus derivados', 3, 0, 1, '2026-02-22 19:31:52'),
(25, 4, 19, 'Delitos en materia de hidrocarburos y sus derivados', 3, 0, 1, '2026-02-22 19:32:42'),
(26, 4, 19, 'Delitos en materia de hidrocarburos y sus derivados - Aprovechamiento de hidrocarburos y sus derivados', 3, 0, 1, '2026-02-22 19:33:43'),
(27, 4, 19, 'Delitos en materia de hidrocarburos y sus derivados - No especificado', 3, 0, 1, '2026-02-22 19:36:40'),
(28, 4, 19, 'Delitos en materia de hidrocarburos y sus derivados - No identificado', 3, 0, 1, '2026-02-22 19:40:28');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `indicator_categories`
--
ALTER TABLE `indicator_categories`
  ADD PRIMARY KEY (`id`),
  ADD KEY `parent_id` (`parent_id`),
  ADD KEY `indicator_id` (`indicator_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `indicator_categories`
--
ALTER TABLE `indicator_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `indicator_categories`
--
ALTER TABLE `indicator_categories`
  ADD CONSTRAINT `indicator_categories_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `indicator_categories` (`id`),
  ADD CONSTRAINT `indicator_categories_ibfk_2` FOREIGN KEY (`indicator_id`) REFERENCES `indicators` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
