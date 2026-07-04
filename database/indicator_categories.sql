-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-02-2026 a las 23:58:56
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
(1, 1, NULL, '1. Aborto', 1, 0, 1, '2026-02-01 00:00:00'),
(2, 2, NULL, '2.1. Abuso de confianza', 1, 0, 1, '2026-02-01 00:00:00'),
(3, 2, NULL, '2.2. Falsedad', 1, 0, 1, '2026-02-01 00:00:00'),
(4, 3, NULL, '3.1. Abuso, acoso y hostigamiento sexual', 1, 0, 1, '2026-02-01 00:00:00'),
(5, 3, 4, '3.1.1. Abuso sexual', 1, 0, 1, '2026-02-01 00:00:00'),
(6, 3, 4, '3.1.2. Acoso sexual', 1, 0, 1, '2026-02-01 00:00:00'),
(7, 3, 4, '3.1.3. Hostigamiento sexual', 1, 0, 1, '2026-02-01 00:00:00'),
(8, 3, NULL, '3.2. Incesto', 1, 0, 1, '2026-02-01 00:00:00'),
(9, 3, NULL, '3.3. Otros delitos sexuales', 1, 0, 1, '2026-02-01 00:00:00'),
(10, 4, 25, '4.1.1. Terrorismo', 3, 0, 1, '2026-02-01 00:00:00'),
(11, 4, NULL, '4.2. Contrabando de bienes o servicios diversos', 2, 0, 1, '2026-02-01 00:00:00'),
(12, 10, NULL, '10.3. Delitos contra el libre desarrollo de la personalidad', 2, 0, 1, '2026-02-01 00:00:00'),
(13, 10, NULL, '10.1. Contra el Libre Desarrollo de la Personalidad', 2, 0, 1, '2026-02-20 12:27:41'),
(14, 10, NULL, '10.2. Contra el libre desarrollo de la personalidad - No especificado', 2, 0, 1, '2026-02-20 12:28:23'),
(15, 3, 9, '3.3.1. Contra la Libertad y el Normal Desarrollo Psicosexual', 1, 0, 1, '2026-02-23 17:05:17'),
(16, 3, 9, '3.3.2. Delitos Contra la Libertad y el Normal Desarrollo Psicosexual', 1, 0, 1, '2026-02-23 17:05:44'),
(17, 3, 9, '3.3.3. La libertad y la seguridad sexual', 1, 0, 1, '2026-02-23 17:06:52'),
(18, 3, NULL, '3.4. Turismo sexual', 1, 0, 1, '2026-02-23 17:08:02'),
(19, 3, 18, '3.4.1. Delitos contra el libre desarrollo de la personalidad - Turismo sexual', 1, 0, 1, '2026-02-23 17:08:37'),
(20, 3, 18, '3.4.2. Turismo sexual', 1, 0, 1, '2026-02-23 17:09:08'),
(21, 3, NULL, '3.5. Violación, estupro, pederastia y rapto', 1, 0, 1, '2026-02-23 17:11:33'),
(22, 3, 21, '3.5.1. Delitos contra el libre desarrollo de la personalidad - Pederastia', 1, 0, 1, '2026-02-23 17:12:07'),
(23, 3, 21, '3.5.2. Estupro', 1, 0, 1, '2026-02-23 17:12:27'),
(24, 3, 21, '3.5.3. Otro tipo de violación', 1, 0, 1, '2026-02-23 17:13:20'),
(25, 4, NULL, '4.1. Actos de terrorismo', 2, 0, 1, '2026-02-23 17:24:26'),
(26, 4, 11, '4.2.1. Comercialización y tráfico de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 3, 0, 1, '2026-02-23 17:30:11'),
(27, 4, 26, '4.2.1.1. Comercialización de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 4, 0, 1, '2026-02-23 17:34:14'),
(28, 4, 26, '4.2.1.2. Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - Comercialización de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 4, 0, 1, '2026-02-23 17:35:22'),
(29, 4, 26, '4.2.1.3. Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - Tráfico de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 4, 0, 1, '2026-02-23 17:36:09'),
(30, 4, 26, '4.2.1.4. Tráfico de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 4, 0, 1, '2026-02-23 17:38:41'),
(31, 10, NULL, '10.4. Delitos Contra el libre desarrollo de la personalidad', 2, 0, 1, '2026-02-23 17:49:49'),
(32, 10, NULL, '10.5. Delitos contra el libre desarrollo de la personalidad - No especificado', 2, 0, 1, '2026-02-23 17:50:30'),
(33, 10, NULL, '10.6. Delitos contra el libre desarrollo de la personalidad - No identificado', 2, 0, 1, '2026-02-23 17:50:55'),
(34, 10, NULL, '10.7. Delitos contra el libre desarrollo de la personalidad - Otros delitos contra el libre desarrollo de la personalidad', 2, 0, 1, '2026-02-23 17:51:43'),
(35, 10, NULL, '10.8. La libertad personal', 2, 0, 1, '2026-02-23 17:52:05'),
(36, 10, NULL, '10.9. Otros delitos contra el libre desarrollo de la personalidad', 2, 0, 1, '2026-02-23 17:52:33'),
(37, 10, NULL, '10.10. Otros delitos contra la libertad personal', 2, 0, 1, '2026-02-23 17:53:48'),
(38, 10, NULL, '10.11. Otros delitos que atentan contra la libertad personal', 2, 0, 1, '2026-02-23 17:54:09'),
(39, 10, NULL, '10.12. Otros Delitos que atentan contra la libertad personal', 2, 0, 1, '2026-02-23 17:55:07'),
(40, 10, NULL, '10.13. Otros delitos que atentan contra la libertad personal con fines de lucro', 2, 0, 1, '2026-02-23 17:55:42'),
(41, 10, NULL, '10.14. Otros delitos que atentan contra la libertad personal sin fines de lucro', 2, 0, 1, '2026-02-23 17:56:10'),
(42, 4, 11, '4.2.2. Delitos en materia de hidrocarburos y sus derivados', 3, 0, 1, '2026-02-23 18:23:56'),
(43, 4, 42, '4.2.2.1. Aprovechamiento de hidrocarburos y sus derivados', 4, 0, 1, '2026-02-23 18:25:04'),
(44, 4, 42, '4.2.2.2. Delitos en materia de hidrocarburos y sus derivados', 4, 0, 1, '2026-02-23 18:25:42'),
(45, 4, 42, '4.2.2.2. Delitos en materia de hidrocarburos y sus derivados', 4, 0, 1, '2026-02-23 18:26:24'),
(46, 4, 42, '4.2.2.3. Delitos en materia de hidrocarburos y sus derivados - Aprovechamiento de hidrocarburos y sus derivados', 4, 0, 1, '2026-02-23 18:27:28'),
(47, 4, 42, '4.2.2.4. Delitos en materia de hidrocarburos y sus derivados - No especificado', 4, 0, 1, '2026-02-23 18:28:01'),
(48, 4, 42, '4.2.2.5. Delitos en materia de hidrocarburos y sus derivados - No identificado', 4, 0, 1, '2026-02-23 18:28:27'),
(49, 4, 42, '4.2.2.6. Deli la personalidad y la libertad personal tos en materia de hidrocarburos y sus derivados - Otros delitos en materia de hidrocarburos y sus derivados', 4, 0, 1, '2026-02-23 18:29:14'),
(50, 4, 42, '4.2.2.7. Delitos en materia de hidrocarburos y sus derivados - Sustracción de hidrocarburos y sus derivados', 4, 0, 1, '2026-02-23 18:29:46'),
(51, 4, 42, '4.2.2.8. Otros delitos en materia de hidrocarburos y sus derivados', 4, 0, 1, '2026-02-23 18:30:13'),
(52, 4, 42, '4.2.2.9. Sustracción de hidrocarburos', 4, 0, 1, '2026-02-23 18:30:36'),
(53, 4, 42, '4.2.2.10. Sustracción de hidrocarburos y sus derivados', 4, 0, 1, '2026-02-23 18:31:46'),
(54, 4, NULL, '4.3. Delitos de delincuencia organizada', 2, 0, 1, '2026-02-23 18:36:01'),
(55, 4, 54, '4.3.1. Delitos de delincuencia organizada', 3, 0, 1, '2026-02-23 18:36:35'),
(56, 4, 55, '4.3.1.1. Delitos cometidos por miembros de la delincuencia organizada', 4, 0, 1, '2026-02-23 18:37:39'),
(57, 4, 55, '4.3.1.2. Delitos de delincuencia organizada', 4, 0, 1, '2026-02-23 18:38:42'),
(58, 4, 55, '4.3.1.3. Delitos previstos en la Ley Federal contra la Delincuencia Organizada', 4, 0, 1, '2026-02-23 18:39:21'),
(59, 4, 55, '4.3.1.4. Delitos Previstos en la Ley Federal Contra la Delincuencia Organizada', 4, 0, 1, '2026-02-23 18:39:55'),
(60, 4, 55, '4.3.1.5. Ley Federal contra la Delincuencia Organizada', 4, 0, 1, '2026-02-23 18:40:30'),
(61, 4, NULL, '4.4. Extorsión', 2, 0, 1, '2026-02-23 18:41:34'),
(62, 4, 61, '4.4.1. Extorsión', 3, 0, 1, '2026-02-24 10:38:23'),
(63, 4, 62, '4.4.1.1. Extorsión', 4, 0, 1, '2026-02-24 10:39:24'),
(64, 4, 62, '4.4.1.2. Extorsión - Extorsión cometida por vía telefónica o cualquier otro medio electrónico o de comunicación', 4, 0, 1, '2026-02-24 10:40:08'),
(65, 4, 62, '4.4.1.3. Extorsión - No especificado', 4, 0, 1, '2026-02-24 10:42:25'),
(66, 4, 62, '4.4.1.4. Extorsión - No identificado', 4, 0, 1, '2026-02-24 10:42:56'),
(67, 4, 62, '4.4.1.5. Extorsión - Otro tipo de extorsión', 4, 0, 1, '2026-02-24 10:43:24'),
(68, 4, 62, '4.4.1.6. Extorsión cometida por vía telefónica o cualquier otro medio electrónico o de comunicación', 4, 0, 1, '2026-02-24 10:44:09'),
(69, 4, 62, '4.4.1.7. Otro tipo de extorsión', 4, 0, 1, '2026-02-24 10:45:59'),
(70, 4, NULL, '4.5. Falsificación de documentos', 2, 0, 1, '2026-02-24 10:48:07'),
(71, 4, 70, '4.5.1. Falsificación y falsificación de documentos', 3, 0, 1, '2026-02-24 10:48:48'),
(72, 4, 71, '4.5.1.1.	Falsificación', 4, 0, 1, '2026-02-24 10:49:27'),
(73, 4, 71, '4.5.1.2.	Falsificación de documentos', 4, 0, 1, '2026-02-24 10:49:58'),
(74, 4, NULL, '4.6. Feminicidio y homicidio', 2, 0, 1, '2026-02-24 11:25:40'),
(75, 4, 74, '4.6.1. Feminicidio', 3, 0, 1, '2026-02-24 11:26:38'),
(76, 4, 74, '4.6.2. Homicidio y homicidio doloso', 3, 0, 1, '2026-02-24 11:27:46'),
(77, 4, 76, '4.6.2.1. Homicidio', 4, 0, 1, '2026-02-24 11:28:26'),
(78, 4, 76, '4.6.2.2. Homicidio doloso', 4, 0, 1, '2026-02-24 11:29:21'),
(79, 4, NULL, '4.7. Lavado patrimonial', 2, 0, 1, '2026-02-24 11:30:56'),
(80, 4, 79, '4.7.1. Enriquecimiento ilícito y peculado', 3, 0, 1, '2026-02-24 11:32:54'),
(81, 4, 79, '4.7.2. Operaciones con recursos de procedencia ilícita y encubrimiento', 3, 0, 1, '2026-02-24 11:33:54'),
(82, 4, 80, '4.7.1.1. Delitos por hechos de corrupción - Enriquecimiento ilícito', 4, 0, 1, '2026-02-24 11:34:47'),
(83, 4, 80, '4.7.1.2. Delitos por hechos de corrupción - Peculado', 4, 0, 1, '2026-02-24 11:35:07'),
(84, 4, 80, '4.7.1.3. Enriquecimiento ilícito', 4, 0, 1, '2026-02-24 11:35:24'),
(85, 4, 80, '4.7.1.4. Peculado', 4, 0, 1, '2026-02-24 11:35:48'),
(86, 4, 81, '4.7.2.1. Encubrimiento', 4, 0, 1, '2026-02-24 11:37:35'),
(87, 4, 81, '4.7.2.2. Encubrimiento y Operaciones con Recursos de Procedencia Ilícita', 4, 0, 1, '2026-02-24 11:38:32'),
(88, 4, 81, '4.7.2.3. Operaciones con recursos de procedencia ilícita', 4, 0, 1, '2026-02-24 11:38:51'),
(89, 4, NULL, '4.8. Lenocinio y prostitución de niñez, adolescencia y personas con discapacidad', 2, 0, 1, '2026-02-24 11:41:49'),
(90, 4, NULL, '4.9. Lesiones, tortura y tratos o penas crueles inhumanos o degradantes', 2, 0, 1, '2026-02-24 11:42:21'),
(91, 4, NULL, '4.10. Piratería de productos diversos', 2, 0, 1, '2026-02-24 11:42:43'),
(92, 4, NULL, '4.11. Pornografía infantil', 2, 0, 1, '2026-02-24 11:42:59'),
(93, 4, NULL, '4.12. Robo de vehículo', 2, 0, 1, '2026-02-24 11:43:17'),
(94, 4, NULL, '4.13. Secuestro y desaparición forzada', 2, 0, 1, '2026-02-24 11:43:36'),
(95, 4, NULL, '4.14. Tráfico de armas', 2, 0, 1, '2026-02-24 11:44:07'),
(96, 4, NULL, '4.15. Tráfico de estupefacientes', 2, 0, 1, '2026-02-24 11:45:20'),
(97, 4, NULL, '4.16. Tráfico de niñez y adolescencia', 2, 0, 1, '2026-02-24 11:46:40'),
(98, 4, NULL, '4.17. Tráfico de personas indocumentadas', 2, 0, 1, '2026-02-24 11:46:59'),
(99, 4, NULL, '4.18. Trata de personas', 2, 0, 1, '2026-02-24 11:47:19'),
(100, 4, 89, '4.8.1. Lenocinio', 3, 0, 1, '2026-02-24 11:52:36'),
(101, 4, 89, '4.8.2. Prostitución de niñez, adolescencia y personas con discapacidad', 3, 0, 1, '2026-02-24 11:53:17'),
(102, 4, 101, '4.8.2.1. Delitos contra el libre desarrollo de la personalidad - Prostitución de menores e incapaces', 4, 0, 1, '2026-02-24 11:54:05'),
(103, 4, 101, '4.8.2.2. Prostitución de menores e incapaces', 4, 0, 1, '2026-02-24 11:54:36'),
(104, 4, 90, '4.9.1. Lesiones y lesiones dolosas', 3, 0, 1, '2026-02-24 11:55:51'),
(105, 4, 90, '4.9.2. Tortura y tratos o penas crueles inhumanos o degradantes', 3, 0, 1, '2026-02-24 11:56:45'),
(106, 4, 104, '4.9.1.1. Lesiones', 4, 0, 1, '2026-02-24 11:57:56'),
(107, 4, 104, '4.9.1.2. Lesiones dolosas', 4, 0, 1, '2026-02-24 11:58:15'),
(108, 4, 105, '4.9.2.1. Tortura', 4, 0, 1, '2026-02-24 11:59:30'),
(109, 4, 105, '4.9.2.2. Tortura y otros tratos o penas crueles inhumanos o degradantes', 4, 0, 1, '2026-02-24 11:59:55'),
(110, 4, 105, '4.9.2.3. Tratos o penas crueles, inhumanos o degradantes', 4, 0, 1, '2026-02-24 12:00:20'),
(111, 4, 91, '4.10.1. Delitos en materia de derechos de autor, propiedad intelectual e industrial, invenciones y marcas', 3, 0, 1, '2026-02-24 12:02:12'),
(112, 4, 111, '4.10.1.1. De los Delitos en Materia de Derechos de Autor', 4, 0, 1, '2026-02-24 12:03:01'),
(113, 4, 111, '4.10.1.2.	Delitos en materia de derechos de autor', 4, 0, 1, '2026-02-24 12:03:33'),
(114, 4, 111, '4.10.1.3. Delitos en materia de propiedad industrial', 4, 0, 1, '2026-02-24 12:03:55'),
(115, 4, 111, '4.10.1.4. Delitos previstos en la Ley Federal del Derecho de Autor', 4, 0, 1, '2026-02-24 12:04:21'),
(116, 4, 111, '4.10.1.5. Delitos Previstos en las Leyes en materia de invenciones y marcas', 4, 0, 1, '2026-02-24 12:05:12'),
(117, 4, 111, '4.10.1.6. Delitos Previstos en las Leyes en materia de propiedad intelectual', 4, 0, 1, '2026-02-24 12:05:35'),
(118, 4, 111, '4.10.1.7. En Materia de Derechos de Autor', 4, 0, 1, '2026-02-24 12:06:03'),
(119, 4, 111, '4.10.1.8. Ley Federal del Derecho de Autor', 4, 0, 1, '2026-02-24 12:07:00'),
(120, 4, 92, '4.11.1. Pornografía infantil', 3, 0, 1, '2026-02-24 12:12:54'),
(121, 4, 120, '4.11.1.1. Delitos contra el libre desarrollo de la personalidad - Pornografía infantil', 4, 0, 1, '2026-02-24 12:13:32'),
(122, 4, 120, '4.11.1.2. Pornografía infantil', 4, 0, 1, '2026-02-24 12:13:51'),
(123, 4, 93, '4.12.1. Robo de vehículo', 3, 0, 1, '2026-02-24 12:15:07'),
(124, 4, 123, '4.12.1.1. Robo - Robo de vehículo', 4, 0, 1, '2026-02-24 12:15:37'),
(125, 4, 123, '4.12.1.2. Robo de vehículo', 4, 0, 1, '2026-02-24 12:15:59'),
(126, 4, 94, '4.13.1. Desaparición forzada', 3, 0, 1, '2026-02-24 12:21:41'),
(127, 4, 94, '4.13.2. Secuestro', 3, 0, 1, '2026-02-24 12:21:59'),
(128, 4, 126, '4.13.1.1. Desaparición forzada', 4, 0, 1, '2026-02-24 12:23:43'),
(129, 4, 126, '4.13.1.2. Desaparición forzada de personas', 4, 0, 1, '2026-02-24 12:24:22'),
(130, 4, 127, '4.13.2.1. Otro tipo de secuestro', 4, 0, 1, '2026-02-24 12:25:32'),
(131, 4, 127, '4.13.2.2. Otro tipo de secuestros', 4, 0, 1, '2026-02-24 12:25:52'),
(132, 4, 127, '4.13.2.3. Secuestro', 4, 0, 1, '2026-02-24 12:26:12'),
(133, 4, 127, '4.13.2.4. Secuestro - No especificado', 4, 0, 1, '2026-02-24 12:26:51'),
(134, 4, 127, '4.13.2.5. Secuestro - No identificado', 4, 0, 1, '2026-02-24 12:27:49'),
(135, 4, 127, '4.13.2.6. Secuestro - Otro tipo de secuestro', 4, 0, 1, '2026-02-24 12:28:09'),
(136, 4, 127, '4.13.2.7. Secuestro - Secuestro en calidad de rehén', 4, 0, 1, '2026-02-24 12:28:34'),
(137, 4, 127, '4.13.2.8. Secuestro - Secuestro exprés', 4, 0, 1, '2026-02-24 12:28:54'),
(138, 4, 127, '4.13.2.9. Secuestro - Secuestro extorsivo', 4, 0, 1, '2026-02-24 12:29:15'),
(139, 4, 127, '4.13.2.10. Secuestro - Secuestro para causar daño', 4, 0, 1, '2026-02-24 12:29:35'),
(140, 4, 127, '4.13.2.11. Secuestro con calidad de rehén', 4, 0, 1, '2026-02-24 12:31:10'),
(141, 4, 127, '4.13.2.12. Secuestro en calidad de rehén', 4, 0, 1, '2026-02-24 12:31:36'),
(142, 4, 127, '4.13.2.13. Secuestro exprés', 4, 0, 1, '2026-02-24 12:31:55'),
(143, 4, 127, '4.13.2.14. Secuestro express', 4, 0, 1, '2026-02-24 12:32:16'),
(144, 4, 127, '4.13.2.15. Secuestro extorsivo', 4, 0, 1, '2026-02-24 12:32:38'),
(145, 4, 127, '4.13.2.16. Secuestro para causar daño', 4, 0, 1, '2026-02-24 12:33:17'),
(146, 4, 127, '4.13.2.17. Secuestro para causar daños', 4, 0, 1, '2026-02-24 12:33:45'),
(147, 4, 95, '4.14.1. Tráfico ilícito de armas, explosivos y otros materiales destructivos', 3, 0, 1, '2026-02-24 12:53:53'),
(148, 4, 147, '4.14.1.1. Delitos en materia de armas, explosivos y otros materiales destructivos - Tráfico ilícito de armas, explosivos y otros materiales destructivos', 4, 0, 1, '2026-02-24 12:54:31'),
(149, 4, 147, '4.14.1.2. Tráfico ilícito de armas, explosivos y otros materiales destructivos', 4, 0, 1, '2026-02-24 12:54:58'),
(150, 4, 96, '4.15.1. Delitos contra la salud relacionados con narcóticos - excluyendo posesión sin fines de comercio o suministro', 4, 0, 1, '2026-02-24 12:57:09'),
(151, 4, 96, '4.15.2. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - excluyendo posesión sin fines de comercio o suministro', 3, 0, 1, '2026-02-24 12:57:59'),
(152, 4, 150, '4.15.1.1. Comercio de narcóticos', 4, 0, 1, '2026-02-24 13:00:14'),
(153, 4, 150, '4.15.1.2. Comercio de Narcóticos', 4, 0, 1, '2026-02-24 13:00:44'),
(154, 4, 150, '4.15.1.3. Comercio de narcóticos 1', 4, 0, 1, '2026-02-24 13:01:05'),
(155, 4, 150, '4.15.1.4. Delitos federales contra la salud relacionados con narcóticos', 4, 0, 1, '2026-02-24 13:02:44'),
(156, 4, 150, '4.15.1.5. Delitos federales contra la salud relacionados con narcóticos - Comercio de narcóticos', 4, 0, 1, '2026-02-24 13:15:12'),
(157, 4, 150, '4.15.1.6. Delitos federales contra la salud relacionados con narcóticos - No especificado', 4, 0, 1, '2026-02-24 13:16:08'),
(158, 4, 150, '4.15.1.7. Delitos federales contra la salud relacionados con narcóticos - No identificado', 4, 0, 1, '2026-02-24 13:16:37'),
(159, 4, 150, '4.15.1.8. Delitos federales contra la salud relacionados con narcóticos - Otros', 4, 0, 1, '2026-02-24 13:18:04'),
(160, 4, 150, '4.15.1.9. Delitos federales contra la salud relacionados con narcóticos - Otros delitos federales contra la salud relacionados con narcóticos', 4, 0, 1, '2026-02-24 13:19:03'),
(161, 4, 150, '4.15.1.10. Delitos federales contra la salud relacionados con narcóticos - Producción de narcóticos', 4, 0, 1, '2026-02-24 13:19:46'),
(162, 4, 150, '4.15.1.11. Delitos federales contra la salud relacionados con narcóticos - Suministro de narcóticos', 4, 0, 1, '2026-02-24 13:20:20'),
(163, 4, 150, '4.15.1.12. Delitos federales contra la salud relacionados con narcóticos - Tráfico de narcóticos', 4, 0, 1, '2026-02-24 13:20:44'),
(164, 4, 150, '4.15.1.13. Delitos federales contra la salud relacionados con narcóticos - Transporte de narcóticos', 4, 0, 1, '2026-02-24 13:21:18'),
(165, 4, 150, '4.15.1.14. Otras Modalidades distintas a las anteriores relacionadas con Narcóticos', 4, 0, 1, '2026-02-24 13:21:40'),
(166, 4, 150, '4.15.1.15. Otros delitos federales contra la salud relacionados con narcóticos', 4, 0, 1, '2026-02-24 13:23:27'),
(167, 4, 150, '4.15.1.16. Posesión con fines de comercio o suministro', 4, 0, 1, '2026-02-24 13:23:54'),
(168, 4, 150, '4.15.1.17. Posesión con fines de comercio o suministro de narcóticos', 4, 0, 1, '2026-02-24 13:25:16'),
(169, 4, 150, '4.15.1.18. Producción de narcóticos', 4, 0, 1, '2026-02-24 13:25:38'),
(170, 4, 150, '4.15.1.19. Producción de Narcóticos', 4, 0, 1, '2026-02-24 13:27:10'),
(171, 4, 150, '4.15.1.20. Suministro de narcóticos', 4, 0, 1, '2026-02-24 13:27:36'),
(172, 4, 150, '4.15.1.21. Suministro de Narcóticos', 4, 0, 1, '2026-02-24 13:27:58'),
(173, 4, 150, '4.15.1.22. Suministro de narcóticos 1', 4, 0, 1, '2026-02-24 13:28:24'),
(174, 4, 150, '4.15.1.23. Tráfico de narcóticos', 4, 0, 1, '2026-02-24 13:30:07'),
(175, 4, 150, '4.15.1.24. Tráfico de Narcóticos', 4, 0, 1, '2026-02-24 13:30:30'),
(176, 4, 150, '4.15.1.25. Transporte de narcóticos', 4, 0, 1, '2026-02-24 13:31:01'),
(177, 4, 150, '4.15.1.26. Transporte de Narcóticos', 4, 0, 1, '2026-02-24 13:31:33'),
(178, 4, 151, '4.15.2.1. Contra la Salud en su modalidad de Narcomenudeo', 4, 0, 1, '2026-02-24 13:50:54'),
(179, 4, 151, '4.15.2.2. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo', 4, 0, 1, '2026-02-24 13:51:26'),
(180, 4, 151, '4.15.2.3. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - Comercio de narcóticos', 4, 0, 1, '2026-02-24 13:51:52'),
(181, 4, 151, '4.15.2.4. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - No especificado', 4, 0, 1, '2026-02-24 13:52:54'),
(182, 4, 151, '4.15.2.5. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - No identificado', 4, 0, 1, '2026-02-24 13:53:22'),
(183, 4, 151, '4.15.2.6. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - Otros', 4, 0, 1, '2026-02-24 13:54:06'),
(184, 4, 151, '4.15.2.7. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - Otros delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo', 4, 0, 1, '2026-02-24 13:54:45'),
(185, 4, 151, '4.15.2.8. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - Posesión con fines de comercio o suminist', 4, 0, 1, '2026-02-24 13:55:20'),
(186, 4, 151, '4.15.2.9. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - Posesión con fines de comercio o suministro de narcóticos', 4, 0, 1, '2026-02-24 13:55:51'),
(187, 4, 151, '4.15.2.10. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - Suministro de narcóticos', 4, 0, 1, '2026-02-24 13:56:25'),
(188, 4, 151, '4.15.2.11. Narcomenudeo', 4, 0, 1, '2026-02-24 13:56:51'),
(189, 4, 151, '4.15.2.12. Narcomenudeo - No especificado', 4, 0, 1, '2026-02-24 13:57:33'),
(190, 4, 151, '4.15.2.13. Narcomenudeo en modalidad de posesión con fines de venta y suministro', 4, 0, 1, '2026-02-24 13:58:07'),
(191, 4, 151, '4.15.2.14. Narcomenudeo en modalidad de venta o suministro', 4, 0, 1, '2026-02-24 13:58:35'),
(192, 4, 151, '4.15.2.15. Narcomenudeo en modalidad distinta a las anteriores', 4, 0, 1, '2026-02-24 13:59:35'),
(193, 4, 151, '4.15.2.16. Otros delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo', 4, 0, 1, '2026-02-24 14:00:06'),
(194, 4, 97, '4.16.1. Tráfico de niñez y adolescencia', 3, 0, 1, '2026-02-24 14:01:39'),
(195, 4, 194, '4.16.1.1. Tráfico de menores', 4, 0, 1, '2026-02-24 14:02:04'),
(196, 4, 194, '4.16.1.2. Tráfico de menores', 4, 0, 1, '2026-02-24 14:02:36'),
(197, 4, 194, '4.16.1.3. Tráfico de Menores', 4, 0, 1, '2026-02-24 14:02:56'),
(198, 4, 98, '4.17.1. Tráfico de personas indocumentadas', 3, 0, 1, '2026-02-24 14:05:57'),
(199, 4, 198, '4.17.1.1. Delitos en materia de migración - Tráfico de indocumentados', 4, 0, 1, '2026-02-24 14:06:16'),
(200, 4, 198, '4.17.1.2. Tráfico de indocumentados', 4, 0, 1, '2026-02-24 14:06:51'),
(201, 4, 99, '4.18.1. Otra trata de personas', 3, 0, 1, '2026-02-24 14:08:41'),
(202, 4, 99, '4.18.2. Trata de personas con fines de explotación sexual', 3, 0, 1, '2026-02-24 14:09:50'),
(203, 4, 99, '4.18.3. Trata de personas con fines de trabajo o servicios forzados', 3, 0, 1, '2026-02-24 14:10:24'),
(204, 4, 99, '4.18.4. Trata de personas con fines de tráfico de órganos', 3, 0, 1, '2026-02-24 14:11:20'),
(205, 4, 201, '4.18.1.1. Trata de personas', 4, 0, 1, '2026-02-24 14:13:02'),
(206, 4, 201, '4.18.1.2. Trata de personas - No especificado', 4, 0, 1, '2026-02-24 14:15:22'),
(207, 4, 201, '4.18.1.3. Trata de personas - No identificado', 4, 0, 1, '2026-02-24 14:15:41'),
(208, 4, 201, '4.18.1.4. Trata de personas - Trata de personas con otros fines', 4, 0, 1, '2026-02-24 14:16:05'),
(209, 4, 201, '4.18.1.5. Trata de personas con otros fines', 4, 0, 1, '2026-02-24 14:16:37'),
(210, 4, 201, '4.18.1.6. Trata de personas con otros fines de explotación', 4, 0, 1, '2026-02-24 14:16:59'),
(211, 4, 202, '4.18.2.1. Trata de personas - Trata de personas con fines de explotación sexual', 4, 0, 1, '2026-02-24 14:19:26'),
(212, 4, 202, '4.18.2.2. Trata de personas con fines de explotación sexual', 4, 0, 1, '2026-02-24 14:20:17'),
(213, 4, 203, '4.18.3.1. Trata de personas - Trata de personas con fines de trabajo o servicios forzados', 4, 0, 1, '2026-02-24 14:21:14'),
(214, 4, 203, '4.18.3.2. Trata de personas con fines de trabajo o servicios forzados', 4, 0, 1, '2026-02-24 14:21:45'),
(215, 4, 203, '4.18.3.3. Trata de personas con fines de trabajo o servicios forzados', 4, 0, 1, '2026-02-24 14:22:17'),
(216, 4, 204, '4.18.4.1. Trata de personas - Trata de personas con fines de tráfico de órganos', 4, 0, 1, '2026-02-24 14:23:43'),
(217, 4, 204, '4.18.4.2. Trata de personas con fines de tráfico de órganos', 4, 0, 1, '2026-02-24 14:24:16'),
(218, 5, NULL, '5. Allanamiento de morada', 1, 0, 1, '2026-02-24 14:27:58'),
(219, 6, NULL, '6. Amenazas', 1, 0, 1, '2026-02-24 14:29:11'),
(220, 7, NULL, '7.1. Asociación delictuosa', 1, 0, 1, '2026-02-24 14:29:32'),
(221, 7, NULL, '7.2.	Fraude', 2, 0, 1, '2026-02-24 14:36:35'),
(222, 7, NULL, '7.3. Otros delitos en materia de armas, objetos prohibidos, explosivos y otros materiales destructivos - excluyendo portación, posesión, acopio y tráfico', 2, 0, 1, '2026-02-24 14:37:47'),
(223, 7, NULL, '7.4. Portación, posesión y acopio ilícitos de armas, cartuchos y cargadores', 2, 0, 1, '2026-02-24 14:39:05'),
(224, 7, NULL, '7.5. Privación de la libertad', 2, 0, 1, '2026-02-24 14:39:46'),
(225, 7, 222, '7.3.1. Armas y objetos prohibidos', 3, 0, 1, '2026-02-24 14:42:04'),
(226, 7, 222, '7.3.2. Delitos en materia de armas de fuego, explosivos y otros materiales destructivos', 3, 0, 1, '2026-02-24 14:43:42'),
(227, 7, 222, '7.3.3. Delitos en materia de armas y objetos prohibidos', 3, 0, 1, '2026-02-24 14:44:12'),
(228, 7, 222, '7.3.4. Delitos en materia de armas, explosivos y otros materiales destructivos', 3, 0, 1, '2026-02-24 14:45:04'),
(229, 7, 222, '7.3.5. Delitos en materia de armas, explosivos y otros materiales destructivos - No especificado', 3, 0, 1, '2026-02-24 14:45:33'),
(230, 7, 222, '7.3.6. Delitos en materia de armas, explosivos y otros materiales destructivos - No identificado', 3, 0, 1, '2026-02-24 14:46:12'),
(231, 7, 222, '7.3.7. Delitos en materia de armas, explosivos y otros materiales destructivos - Otros delitos en materia de armas, explosivos y otros materiales destructivos', 3, 0, 1, '2026-02-24 14:46:59'),
(232, 7, 222, '7.3.8. Delitos previstos en la Ley Federal de Armas de Fuego y Explosivos', 3, 0, 1, '2026-02-24 14:47:39'),
(233, 7, 222, '7.3.9. Delitos previstos en la Ley Federal de Armas de Fuego y Explosivos', 3, 0, 1, '2026-02-24 14:48:08'),
(234, 7, 222, '7.3.10. Delitos Previstos en la Ley Federal de Armas de Fuego y Explosivos', 3, 0, 1, '2026-02-24 14:48:37'),
(235, 7, 222, '7.3.11. Ley Federal de Armas de Fuego y Explosivos', 3, 0, 1, '2026-02-24 14:49:00'),
(236, 7, 222, '7.3.12. Otros delitos en materia de armas, explosivos y otros materiales destructivos', 3, 0, 1, '2026-02-24 14:49:36'),
(237, 7, 223, '7.4.1. Acopio ilícito de armas', 3, 0, 1, '2026-02-24 14:51:44'),
(238, 7, 223, '7.4.2. Delitos en materia de armas, explosivos y otros materiales destructivos - Acopio ilícito de armas', 3, 0, 1, '2026-02-24 14:56:47'),
(239, 7, 223, '7.4.3. Delitos en materia de armas, explosivos y otros materiales destructivos - Portación ilícita de armas', 3, 0, 1, '2026-02-24 14:57:12'),
(240, 7, 223, '7.4.4. Delitos en materia de armas, explosivos y otros materiales destructivos - Posesión ilícita de armas, cartuchos y cargadores', 3, 0, 1, '2026-02-24 14:58:20'),
(241, 7, 223, '7.4.5. Portación ilícita de armas', 3, 0, 1, '2026-02-24 14:58:40'),
(242, 7, 223, '7.4.6. Posesión ilícita de armas, cartuchos y cargadores', 3, 0, 1, '2026-02-24 14:59:05'),
(243, 7, 224, '7.5.1. Otros delitos que privan de la vida', 3, 0, 1, '2026-02-24 16:07:04'),
(244, 7, 224, '7.5.2. Privación de la libertad', 3, 0, 1, '2026-02-24 16:07:27'),
(245, 7, 224, '7.5.3.	Privación Ilegal de la Libertad y de otras Garantías', 3, 0, 1, '2026-02-24 16:08:28'),
(246, 8, NULL, '8.1.	Corrupción de menores', 2, 0, 1, '2026-02-24 16:13:51'),
(247, 8, NULL, '8.2.	Corrupción de menores e incapaces', 2, 0, 1, '2026-02-24 16:14:14'),
(248, 8, NULL, '8.3.	Corrupción de menores incapaces', 2, 0, 1, '2026-02-24 16:14:28'),
(249, 8, NULL, '8.4. Delitos contra el libre desarrollo de la personalidad - Corrupción de menores e incapaces', 2, 0, 1, '2026-02-24 16:14:56'),
(250, 9, NULL, '9.1.	Delitos en materia de instituciones de crédito, inversión, fianzas y seguros', 2, 0, 1, '2026-02-24 16:15:38'),
(251, 9, NULL, '9.2.	Delitos en materia de Instituciones de crédito, inversión, fianzas y seguros', 2, 0, 1, '2026-02-24 16:15:49'),
(252, 9, NULL, '9.3.	Delitos Previstos en las Leyes en materia de delitos bancarios y financieros', 2, 0, 1, '2026-02-24 16:16:03'),
(253, 9, NULL, '9.4.	Legislación de Instituciones de Crédito, Inversión, Fianzas y Seguros', 2, 0, 1, '2026-02-24 16:16:16'),
(254, 11, NULL, '11.1. Contra de las Personas en su Patrimonio', 2, 0, 1, '2026-02-24 16:19:31'),
(255, 11, NULL, '11.2.	Daño a la propiedad', 2, 0, 1, '2026-02-24 16:19:42'),
(256, 11, NULL, '11.3.	Daño en la propiedad', 2, 0, 1, '2026-02-24 16:19:53'),
(257, 11, NULL, '11.4.	Delitos en contra de las personas en su patrimonio', 2, 0, 1, '2026-02-24 16:20:06'),
(258, 11, NULL, '11.5.	Delitos en Contra de las Personas en su Patrimonio', 2, 0, 1, '2026-02-24 16:20:17'),
(259, 11, NULL, '11.6.	El patrimonio', 2, 0, 1, '2026-02-24 16:20:35'),
(260, 11, NULL, '11.7.	Otros delitos contra el patrimonio', 2, 0, 1, '2026-02-24 16:20:48'),
(261, 11, NULL, '11.8.	Otros Delitos contra el patrimonio', 2, 0, 1, '2026-02-24 16:21:05'),
(262, 11, NULL, '11.9.	Otros delitos que atentan contra el patrimonio', 2, 0, 1, '2026-02-24 16:21:14'),
(263, 11, NULL, '11.10.	Otros delitos que atenten contra el patrimonio', 2, 0, 1, '2026-02-24 16:21:28'),
(264, 12, NULL, '12.1. Cometidos contra la Administración de Justicia', 2, 0, 1, '2026-02-24 16:22:51'),
(265, 12, NULL, '12.2.	Delitos Cometidos contra la administración de justicia', 2, 0, 1, '2026-02-24 16:23:03'),
(266, 12, NULL, '12.3.	Delitos contra la administración de justicia', 2, 0, 1, '2026-02-24 16:23:12'),
(267, 12, NULL, '12.4.	Delitos contra la administración de justicia - En materia de amparo', 2, 0, 1, '2026-02-24 16:23:28'),
(268, 12, NULL, '12.5.	Delitos contra la administración de justicia - No especificado', 2, 0, 1, '2026-02-24 16:23:53'),
(269, 12, NULL, '12.6.	Delitos contra la administración de justicia - No identificado', 2, 0, 1, '2026-02-24 16:24:16'),
(270, 12, NULL, '12.7.	Delitos contra la administración de justicia - Otros delitos contra la administración de justicia', 2, 0, 1, '2026-02-24 16:24:39'),
(271, 12, NULL, '12.8.	Otros delitos contra la administración de justicia', 2, 0, 1, '2026-02-24 16:25:25'),
(272, 13, NULL, '13.1.	Cometidos contra servidores públicos', 2, 0, 1, '2026-02-24 16:26:57'),
(273, 13, NULL, '13.2.	Contra el servicio público - No especificado', 2, 0, 1, '2026-02-24 16:30:58'),
(274, 13, NULL, '13.3.	Contra la Autoridad', 2, 0, 1, '2026-02-24 16:31:15'),
(275, 13, NULL, '13.4.	Delitos contra la autoridad', 2, 0, 1, '2026-02-24 16:31:29'),
(276, 13, NULL, '13.5.	Delitos Contra la Autoridad', 2, 0, 1, '2026-02-24 16:31:56'),
(277, 14, NULL, '14.1.	Acceso ilícito a sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:34:19'),
(278, 14, NULL, '14.2.	Daños a datos informáticos', 2, 0, 1, '2026-02-24 16:34:28'),
(279, 14, NULL, '14.3.	Delitos contra la seguridad de los datos y - o sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:35:04'),
(280, 14, NULL, '14.4.	Delitos contra la seguridad de los datos y - o sistemas o equipos informáticos - Acceso ilícito a sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:35:31'),
(281, 14, NULL, '14.5.	Delitos contra la seguridad de los datos y - o sistemas o equipos informáticos - Daños a datos informáticos', 2, 0, 1, '2026-02-24 16:36:24'),
(282, 14, NULL, '14.6.	Delitos contra la seguridad de los datos y - o sistemas o equipos informáticos - Interferir en el buen funcionamiento de sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:36:51'),
(283, 14, NULL, '14.7.	Delitos contra la seguridad de los datos y - o sistemas o equipos informáticos - No especificado', 2, 0, 1, '2026-02-24 16:37:13'),
(284, 14, NULL, '14.8.	Delitos contra la seguridad de los datos y - o sistemas o equipos informáticos - No identificado', 2, 0, 1, '2026-02-24 16:37:41'),
(285, 14, NULL, '14.9.	Delitos contra la seguridad de los datos y - o sistemas o equipos informáticos - Otros delitos contra la seguridad de los datos y - o sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:38:22'),
(286, 14, NULL, '14.10.	Delitos contra la seguridad de los sistemas y-o equipos informáticos', 2, 0, 1, '2026-02-24 16:39:02'),
(287, 14, NULL, '14.11.	Interferir en el buen funcionamiento de sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:39:15'),
(288, 14, NULL, '14.12.	Otros delitos contra la seguridad de los datos y-o sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:39:33'),
(289, 14, NULL, '14.13.	Revelación de secretos y acceso ilícito a sistemas y equipos de informática', 2, 0, 1, '2026-02-24 16:39:53');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=290;

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
