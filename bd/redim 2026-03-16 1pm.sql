-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 16-03-2026 a las 20:46:40
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
-- Base de datos: `remin`
--

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

--
-- Volcado de datos para la tabla `centers`
--

INSERT INTO `centers` (`id`, `state_id`, `name`, `locate`, `status`) VALUES
(1, 1, 'CENTRO PENITENCIARIO ESTATAL AGUASCALIENTES', '', 1),
(2, 1, 'CENTRO PENITENCIARIO ESTATAL EL LLANO', '', 1),
(3, 1, 'CENTRO PENITENCIARIO ESTATAL DE MUJERES', '', 1),
(4, 1, 'CENTRO ESTATAL PARA EL DESARROLLO DEL ADOLESCENTE', '', 1),
(5, 2, 'CERESO MEXICALI', '', 1),
(6, 2, 'CERESO TIJUANA', '', 1),
(7, 2, 'CERESO ENSENADA', '', 1),
(8, 2, 'CERESO EL HONGO', '', 1),
(9, 2, 'CERESO EL HONGO II', '', 1),
(10, 2, 'CIA MEXICALI', '', 1),
(11, 2, 'CIA TIJUANA', '', 1),
(12, 2, 'CIA ENSENADA', '', 1),
(13, 2, 'CENTRO DE INTERNAMIENTO PARA ADOLESCENTES MEXICALI', '', 1),
(14, 2, 'CENTRO DE INTERNAMIENTO PARA ADOLESCENTES ENSENADA', '', 1),
(15, 2, 'CENTRO DE INTERNAMIENTO PARA ADOLESCENTES TIJUANA', '', 1),
(16, 3, 'CENTRO PENITENCIARIO LA PAZ', '', 1),
(17, 3, 'CENTRO PENITENCIARIO SAN JOSE DEL CABO', '', 1),
(18, 3, 'CENTRO PENITENCIARIO CIUDAD CONSTITUCION', '', 1),
(19, 3, 'CENTRO PENITENCIARIO SANTA ROSALIA', '', 1),
(20, 3, 'CENTRO DE INTERNAMIENTO ESPECIALIZADO PARA ADOLESCENTES', '', 1);

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

--
-- Volcado de datos para la tabla `countries`
--

INSERT INTO `countries` (`id`, `name`, `iso_code`, `demonym`, `status`) VALUES
(1, 'México', 'MEX', 'Mexicanos', 1),
(2, 'Estados Unidos', 'USA', 'Estadounidenses', 1),
(3, 'Canadá', 'CAN', 'Canadienses', 1),
(4, 'Belice', 'BLZ', 'Beliceños', 1),
(5, 'Costa Rica', 'CRI', 'Costarricenses', 1),
(6, 'El Salvador', 'SLV', 'Salvadoreños', 1),
(7, 'Guatemala', 'GTM', 'Guatemaltecos', 1),
(8, 'Honduras', 'HND', 'Hondureños', 1),
(9, 'Nicaragua', 'NIC', 'Nicaragüenses', 1),
(10, 'Panamá', 'PAN', 'Panameños', 1),
(11, 'Antigua y Barbuda', 'ATG', 'Antiguanos', 1),
(12, 'Bahamas', 'BHS', 'Bahameños', 1),
(13, 'Barbados', 'BRB', 'Barbadenses', 1),
(14, 'Cuba', 'CUB', 'Cubanos', 1),
(15, 'Dominica', 'DMA', 'Dominiqueses', 1),
(16, 'República Dominicana', 'DOM', 'Dominicanos', 1),
(17, 'Granada', 'GRD', 'Granadinos', 1),
(18, 'Haití', 'HTI', 'Haitianos', 1),
(19, 'Jamaica', 'JAM', 'Jamaiquinos', 1),
(20, 'San Cristóbal y Nieves', 'KNA', 'Sancristobaleños', 1),
(21, 'San Vicente y las Granadinas', 'VCT', 'Sanvicentinos', 1),
(22, 'Santa Lucía', 'LCA', 'Santalucenses', 1),
(23, 'Trinidad y Tobago', 'TTO', 'Trinitenses', 1),
(24, 'Argentina', 'ARG', 'Argentinos', 1),
(25, 'Bolivia', 'BOL', 'Bolivianos', 1),
(26, 'Brasil', 'BRA', 'Brasileños', 1),
(27, 'Chile', 'CHL', 'Chilenos', 1),
(28, 'Colombia', 'COL', 'Colombianos', 1),
(29, 'Ecuador', 'ECU', 'Ecuatorianos', 1),
(30, 'Guyana', 'GUY', 'Guyaneses', 1),
(31, 'Paraguay', 'PRY', 'Paraguayos', 1),
(32, 'Perú', 'PER', 'Peruanos', 1),
(33, 'Surinam', 'SUR', 'Surinameses', 1),
(34, 'Uruguay', 'URY', 'Uruguayos', 1),
(35, 'Venezuela', 'VEN', 'Venezolanos', 1),
(36, 'Paises bajos', 'PBJ', 'dddddddd', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `genders`
--

CREATE TABLE `genders` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `genders`
--

INSERT INTO `genders` (`id`, `name`, `status`) VALUES
(1, 'Mujer', 1),
(2, 'Hombre', 1),
(3, 'No especificado', 1),
(4, 'No identificado', 1),
(5, 'Otro', 1);

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

--
-- Volcado de datos para la tabla `indicators`
--

INSERT INTO `indicators` (`id`, `name`, `team`, `map`, `status`) VALUES
(1, '1. Aborto', 1, 1, 1),
(2, '2. Abuso de confianza y falsedad', 1, 1, 1),
(3, '3. Otros delitos sexuales (excluyendo lenocinio, prostitución de niñez y adolescencia, pornografía infantil y trata de personas con fines de explotación sexual)', 1, 1, 1),
(4, '4. Delitos de delincuencia organizada y tipificados en Convención de Palermo', 1, 1, 1),
(5, '5. Allanamiento de morada', 1, 1, 1),
(6, '6. Amenazas', 1, 1, 1),
(7, '7. Otros delitos asociados a la delincuencia organizada (excluyendo los contenidos en la Convención de Palermo y de delincuencia organizada)', 1, 1, 1),
(8, '8. Corrupción de niñez, adolescencia y personas con discapacidad', 1, 1, 1),
(9, '9. Delitos bancarios y financieros', 1, 1, 1),
(10, '10. Delitos contra el libre desarrollo de la personalidad y la libertad personal', 1, 1, 1),
(11, '11. Delitos contra el patrimonio y daño a la propiedad', 1, 1, 1),
(12, '12. Delitos contra la administración de justicia', 1, 1, 1),
(13, '13. Delitos contra la autoridad y servidores públicos', 1, 1, 1),
(14, '14. Delitos contra la seguridad de los datos y/o sistemas o equipos informáticos', 1, 1, 1),
(15, '15. Delitos contra la seguridad pública, de la nación o del Estado', 1, 1, 1),
(16, '16. Delitos contra la vida, integridad corporal y seguridad de las personas', 1, 1, 1),
(17, '17. Delitos electorales', 1, 1, 1),
(18, '18. Delitos en materia de vías de comunicación y correspondencia', 1, 1, 1),
(19, '19. Delitos en materia fiscal', 1, 1, 1),
(20, '20. Despojo', 1, 1, 1),
(21, '21. Discriminación', 1, 1, 1),
(22, '22. Evasión de presos', 1, 1, 1),
(23, '23. Incumplimiento de obligaciones familiares', 1, 1, 1),
(24, '24. Otras lesiones (culposas)', 1, 1, 1),
(25, '25. Otros delitos', 1, 1, 1),
(26, '26. Otros delitos cometidos por servidores públicos (excluyendo hechos de corrupción, ejercicio abusivo o indebido y tráfico de influencias)', 1, 1, 1),
(27, '27. Otros delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental (excluyendo comercialización y tráfico de flora o fauna silvestres sujetas de protección)', 1, 1, 1),
(28, '28. Otros delitos contra la salud', 1, 1, 1),
(29, '29. Otros delitos en materia de migración (excluyendo tráfico de personas indocumentadas)', 1, 1, 1),
(30, '30. Otros delitos por hechos de corrupción (excluyendo enriquecimiento ilícito y peculado)', 1, 1, 1),
(31, '31. Otros homicidios (culposos)', 1, 1, 1),
(32, '32. Otros robos (excluyendo robo de vehículo)', 1, 1, 1),
(33, '33. Posesión ilícita de hidrocarburos y sus derivados', 1, 1, 1),
(34, '34. Posesión y posesión simple de narcóticos', 1, 1, 1),
(35, '35. Retención o sustracción de menores e incapaces', 1, 1, 1),
(36, '36. Suplantación y usurpación de identidad', 1, 1, 1),
(37, '37. Total', 1, 1, 1),
(38, '38. Violencia de género', 1, 1, 1),
(39, '39. Violencia familiar', 1, 1, 1);

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
(42, 4, 11, '4.2.2. Delitos en materia de hidrocarburos y sus derivados (excluyendo posesión ilícita de hidrocarburos y sus derivados)', 3, 0, 1, '2026-02-23 18:23:56'),
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
(72, 4, 71, '4.5.1.1. Falsificación', 4, 0, 1, '2026-02-24 10:49:27'),
(73, 4, 71, '4.5.1.2. Falsificación de documentos', 4, 0, 1, '2026-02-24 10:49:58'),
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
(113, 4, 111, '4.10.1.2. Delitos en materia de derechos de autor', 4, 0, 1, '2026-02-24 12:03:33'),
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
(150, 4, 96, '4.15.1. Delitos contra la salud relacionados con narcóticos (excluyendo posesión sin fines de comercio o suministro)', 3, 0, 1, '2026-02-24 12:57:09'),
(151, 4, 96, '4.15.2. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo (excluyendo posesión sin fines de comercio o suministro)', 3, 0, 1, '2026-02-24 12:57:59'),
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
(221, 7, NULL, '7.2. Fraude', 2, 0, 1, '2026-02-24 14:36:35'),
(222, 7, NULL, '7.3. Otros delitos en materia de armas, objetos prohibidos, explosivos y otros materiales destructivos (excluyendo portación, posesión, acopio y tráfico)', 2, 0, 1, '2026-02-24 14:37:47'),
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
(245, 7, 224, '7.5.3. Privación Ilegal de la Libertad y de otras Garantías', 3, 0, 1, '2026-02-24 16:08:28'),
(246, 8, NULL, '8.1. Corrupción de menores', 2, 0, 1, '2026-02-24 16:13:51'),
(247, 8, NULL, '8.2. Corrupción de menores e incapaces', 2, 0, 1, '2026-02-24 16:14:14'),
(248, 8, NULL, '8.3. Corrupción de menores incapaces', 2, 0, 1, '2026-02-24 16:14:28'),
(249, 8, NULL, '8.4. Delitos contra el libre desarrollo de la personalidad - Corrupción de menores e incapaces', 2, 0, 1, '2026-02-24 16:14:56'),
(250, 9, NULL, '9.1. Delitos en materia de instituciones de crédito, inversión, fianzas y seguros', 2, 0, 1, '2026-02-24 16:15:38'),
(251, 9, NULL, '9.2. Delitos en materia de Instituciones de crédito, inversión, fianzas y seguros', 2, 0, 1, '2026-02-24 16:15:49'),
(252, 9, NULL, '9.3. Delitos Previstos en las Leyes en materia de delitos bancarios y financieros', 2, 0, 1, '2026-02-24 16:16:03'),
(253, 9, NULL, '9.4. Legislación de Instituciones de Crédito, Inversión, Fianzas y Seguros', 2, 0, 1, '2026-02-24 16:16:16'),
(254, 11, NULL, '11.1. Contra de las Personas en su Patrimonio', 2, 0, 1, '2026-02-24 16:19:31'),
(255, 11, NULL, '11.2. Daño a la propiedad', 2, 0, 1, '2026-02-24 16:19:42'),
(256, 11, NULL, '11.3. Daño en la propiedad', 2, 0, 1, '2026-02-24 16:19:53'),
(257, 11, NULL, '11.4. Delitos en contra de las personas en su patrimonio', 2, 0, 1, '2026-02-24 16:20:06'),
(258, 11, NULL, '11.5. Delitos en Contra de las Personas en su Patrimonio', 2, 0, 1, '2026-02-24 16:20:17'),
(259, 11, NULL, '11.6. El patrimonio', 2, 0, 1, '2026-02-24 16:20:35'),
(260, 11, NULL, '11.7. Otros delitos contra el patrimonio', 2, 0, 1, '2026-02-24 16:20:48'),
(261, 11, NULL, '11.8. Otros Delitos contra el patrimonio', 2, 0, 1, '2026-02-24 16:21:05'),
(262, 11, NULL, '11.9. Otros delitos que atentan contra el patrimonio', 2, 0, 1, '2026-02-24 16:21:14'),
(263, 11, NULL, '11.10. Otros delitos que atenten contra el patrimonio', 2, 0, 1, '2026-02-24 16:21:28'),
(264, 12, NULL, '12.1. Cometidos contra la Administración de Justicia', 2, 0, 1, '2026-02-24 16:22:51'),
(265, 12, NULL, '12.2. Delitos Cometidos contra la administración de justicia', 2, 0, 1, '2026-02-24 16:23:03'),
(266, 12, NULL, '12.3. Delitos contra la administración de justicia', 2, 0, 1, '2026-02-24 16:23:12'),
(267, 12, NULL, '12.4. Delitos contra la administración de justicia - En materia de amparo', 2, 0, 1, '2026-02-24 16:23:28'),
(268, 12, NULL, '12.5. Delitos contra la administración de justicia - No especificado', 2, 0, 1, '2026-02-24 16:23:53'),
(269, 12, NULL, '12.6. Delitos contra la administración de justicia - No identificado', 2, 0, 1, '2026-02-24 16:24:16'),
(270, 12, NULL, '12.7. Delitos contra la administración de justicia - Otros delitos contra la administración de justicia', 2, 0, 1, '2026-02-24 16:24:39'),
(271, 12, NULL, '12.8. Otros delitos contra la administración de justicia', 2, 0, 1, '2026-02-24 16:25:25'),
(272, 13, NULL, '13.1. Cometidos contra servidores públicos', 2, 0, 1, '2026-02-24 16:26:57'),
(273, 13, NULL, '13.2. Contra el servicio público - No especificado', 2, 0, 1, '2026-02-24 16:30:58'),
(274, 13, NULL, '13.3. Contra la Autoridad', 2, 0, 1, '2026-02-24 16:31:15'),
(275, 13, NULL, '13.4. Delitos contra la autoridad', 2, 0, 1, '2026-02-24 16:31:29'),
(276, 13, NULL, '13.5. Delitos Contra la Autoridad', 2, 0, 1, '2026-02-24 16:31:56'),
(277, 14, NULL, '14.1. Acceso ilícito a sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:34:19'),
(278, 14, NULL, '14.2. Daños a datos informáticos', 2, 0, 1, '2026-02-24 16:34:28'),
(279, 14, NULL, '14.3. Delitos contra la seguridad de los datos y/o sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:35:04'),
(280, 14, NULL, '14.4. Delitos contra la seguridad de los datos y/o sistemas o equipos informáticos - Acceso ilícito a sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:35:31'),
(281, 14, NULL, '14.5. Delitos contra la seguridad de los datos y/o sistemas o equipos informáticos - Daños a datos informáticos', 2, 0, 1, '2026-02-24 16:36:24'),
(282, 14, NULL, '14.6. Delitos contra la seguridad de los datos y/o sistemas o equipos informáticos - Interferir en el buen funcionamiento de sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:36:51'),
(283, 14, NULL, '14.7. Delitos contra la seguridad de los datos y/o sistemas o equipos informáticos - No especificado', 2, 0, 1, '2026-02-24 16:37:13'),
(284, 14, NULL, '14.8. Delitos contra la seguridad de los datos y/o sistemas o equipos informáticos - No identificado', 2, 0, 1, '2026-02-24 16:37:41'),
(285, 14, NULL, '14.9. Delitos contra la seguridad de los datos y/o sistemas o equipos informáticos - Otros delitos contra la seguridad de los datos y/o sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:38:22'),
(286, 14, NULL, '14.10. Delitos contra la seguridad de los sistemas y-o equipos informáticos', 2, 0, 1, '2026-02-24 16:39:02'),
(287, 14, NULL, '14.11. Interferir en el buen funcionamiento de sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:39:15'),
(288, 14, NULL, '14.12. Otros delitos contra la seguridad de los datos y-o sistemas o equipos informáticos', 2, 0, 1, '2026-02-24 16:39:33'),
(289, 14, NULL, '14.13. Revelación de secretos y acceso ilícito a sistemas y equipos de informática', 2, 0, 1, '2026-02-24 16:39:53'),
(290, 15, NULL, '15.1. Contra la Seguridad de la Nación', 2, 0, 1, '2026-02-24 17:12:39'),
(291, 15, NULL, '15.2. Contra la Seguridad Pública', 2, 0, 1, '2026-02-24 17:12:49'),
(292, 15, NULL, '15.3. Delitos contra la seguridad de la nación', 2, 0, 1, '2026-02-24 17:12:59'),
(293, 15, NULL, '15.4. Delitos contra la Seguridad de la Nación', 2, 0, 1, '2026-02-24 17:13:10'),
(294, 15, NULL, '15.5. Delitos Contra la Seguridad Pública', 2, 0, 1, '2026-02-24 17:13:26'),
(295, 15, NULL, '15.6. La seguridad pública y la seguridad del Estado', 2, 0, 1, '2026-02-24 17:13:56'),
(296, 15, NULL, '15.7. Otros delitos contra la seguridad pública', 2, 0, 1, '2026-02-24 17:14:09'),
(297, 15, NULL, '15.8. Otros delitos contra la seguridad pública y la seguridad del Estado', 2, 0, 1, '2026-02-24 17:14:19'),
(298, 15, NULL, '15.9. Otros delitos que atentan contra la seguridad pública', 2, 0, 1, '2026-02-24 17:14:28'),
(299, 15, NULL, '15.10. Otros delitos que atenten contra la Seguridad Pública', 2, 0, 1, '2026-02-24 17:14:39'),
(300, 16, NULL, '16.1. Contra la Paz y Seguridad de las Personas', 2, 0, 1, '2026-02-24 17:23:00'),
(301, 16, NULL, '16.2. Contra la Vida y la Integridad Corporal', 2, 0, 1, '2026-02-24 17:23:08'),
(302, 16, NULL, '16.3. Delitos Contra la Paz y Seguridad de las Personas', 2, 0, 1, '2026-02-24 17:23:17'),
(303, 16, NULL, '16.4. Delitos contra la vida y la integridad corporal', 2, 0, 1, '2026-02-24 17:23:33'),
(304, 16, NULL, '16.5. Delitos Contra la Vida y la Integridad Corporal', 2, 0, 1, '2026-02-24 17:23:48'),
(305, 16, NULL, '16.6. La vida y la integridad corporal', 2, 0, 1, '2026-02-24 17:24:02'),
(306, 16, NULL, '16.7. Otros delitos que atentan contra la integridad corporal', 2, 0, 1, '2026-02-24 17:24:15'),
(307, 16, NULL, '16.8. Otros delitos que atentan contra la vida y la integridad corporal', 2, 0, 1, '2026-02-24 17:24:26'),
(308, 16, NULL, '16.9. Otros Delitos que atentan contra la vida y la integridad corporal', 2, 0, 1, '2026-02-24 17:24:47'),
(309, 17, NULL, '17.1. Delitos electorales', 2, 0, 1, '2026-02-24 17:26:48'),
(310, 17, NULL, '17.2. Delitos electorales (Previstos en el Código Penal Federal y en el Código Federal de Instituciones y Procedimientos Electorales)', 2, 0, 1, '2026-02-24 17:27:10'),
(311, 17, NULL, '17.3. Delitos Electorales y en Materia de Registro Nacional de Ciudadanos', 2, 0, 1, '2026-02-24 17:27:20'),
(312, 17, NULL, '17.4. Electorales', 2, 0, 1, '2026-02-24 17:27:30'),
(313, 17, NULL, '17.5. Electorales y en Materia de Registro Nacional de Ciudadanos', 2, 0, 1, '2026-02-24 17:28:35'),
(314, 18, NULL, '18.1. Ataque a las vías de comunicación', 2, 0, 1, '2026-02-24 18:54:12'),
(315, 18, NULL, '18.2. Ataque a las vías de comunicación', 2, 0, 1, '2026-02-24 18:54:23'),
(316, 18, NULL, '18.3. Delitos en materia de vías de comunicación y correspondencia', 2, 0, 1, '2026-02-24 18:54:34'),
(317, 18, NULL, '18.4. Delitos en Materia de Vías de Comunicación y Correspondencia', 2, 0, 1, '2026-02-24 18:54:54'),
(318, 18, NULL, '18.5. En Materia de Vías de Comunicación y Correspondencia', 2, 0, 1, '2026-02-24 18:55:18'),
(319, 18, NULL, '18.6. Ley de Vías Generales de Comunicación', 2, 0, 1, '2026-02-24 18:55:37'),
(320, 19, NULL, '19.1. Código Fiscal de la Federación', 2, 0, 1, '2026-02-24 18:58:10'),
(321, 19, NULL, '19.2. Delitos en materia fiscal', 2, 0, 1, '2026-02-24 18:58:19'),
(322, 19, NULL, '19.3. Delitos previstos en el Código Fiscal de la Federación', 2, 0, 1, '2026-02-24 18:58:30'),
(323, 19, NULL, '19.4. Delitos Previstos en el Código Fiscal de la Federación', 2, 0, 1, '2026-02-24 18:58:46'),
(324, 20, NULL, '20. Despojo', 1, 0, 1, '2026-02-24 19:00:12'),
(325, 21, NULL, '21.1. Delitos Contra la Dignidad de las Personas (Capítulo Único, Discriminación)', 2, 0, 1, '2026-02-24 19:00:46'),
(326, 21, NULL, '21.2. Discriminación', 2, 0, 1, '2026-02-24 19:01:27'),
(327, 22, NULL, '22. Evasión de presos', 1, 0, 1, '2026-02-24 19:02:52'),
(328, 23, NULL, '23.1. Incumplimiento de obligaciones de asistencia familiar', 2, 0, 1, '2026-02-24 19:06:54'),
(329, 23, NULL, '23.2. Incumplimiento de obligaciones familiares', 2, 0, 1, '2026-02-24 19:07:06'),
(330, 24, NULL, '24. Otras lesiones (culposas)', 1, 0, 1, '2026-02-24 19:08:29'),
(331, 24, 330, '24.1. Lesiones culposas', 2, 0, 1, '2026-02-24 19:08:48'),
(332, 25, NULL, '25.1. Conductas antisociales del fuero federal', 2, 0, 1, '2026-02-24 19:09:56'),
(333, 25, NULL, '25.2. Conductas antisociales del Fuero Federal', 2, 0, 1, '2026-02-24 19:10:11'),
(334, 25, NULL, '25.3. Contra el Derecho Internacional', 2, 0, 1, '2026-02-24 19:10:20'),
(335, 25, NULL, '25.4. Contra la Economía Pública', 2, 0, 1, '2026-02-24 19:10:28'),
(336, 25, NULL, '25.5. Contra la Humanidad', 2, 0, 1, '2026-02-24 19:10:36'),
(337, 25, NULL, '25.6. Delitos Contra el Derecho Internacional', 2, 0, 1, '2026-02-24 19:10:48'),
(338, 25, NULL, '25.7. Delitos Contra el Estado Civil y Bigamia', 2, 0, 1, '2026-02-24 19:11:00'),
(339, 25, NULL, '25.8. Delitos Contra el Honor', 2, 0, 1, '2026-02-24 19:11:12'),
(340, 25, NULL, '25.9. Delitos Contra la Economía Pública', 2, 0, 1, '2026-02-24 19:11:21'),
(341, 25, NULL, '25.10. Delitos Contra la Humanidad', 2, 0, 1, '2026-02-24 19:11:31'),
(342, 25, NULL, '25.11. Delitos en Materia de Inhumaciones y Exhumaciones', 2, 0, 1, '2026-02-24 19:11:43'),
(343, 25, NULL, '25.12. Delitos Previstos en la Ley de Concursos Mercantiles', 2, 0, 1, '2026-02-24 19:12:05'),
(344, 25, NULL, '25.13. Delitos Previstos en la Ley Federal sobre Monumentos y Zonas Arqueológicos, Artísticos e Históricos', 2, 0, 1, '2026-02-24 19:12:21'),
(345, 25, NULL, '25.14. Delitos previstos en la Ley General de Población', 2, 0, 1, '2026-02-24 19:12:35'),
(346, 25, NULL, '25.15. Delitos Previstos en la Ley General de Población', 2, 0, 1, '2026-02-24 19:12:45'),
(347, 25, NULL, '25.16. Delitos Previstos en la Ley sobre Delitos de Imprenta', 2, 0, 1, '2026-02-24 19:13:01'),
(348, 25, NULL, '25.17. En materia de amparo', 2, 0, 1, '2026-02-24 19:13:16'),
(349, 25, NULL, '25.18. En Materia de Inhumaciones y Exhumaciones', 2, 0, 1, '2026-02-24 19:13:27'),
(350, 25, NULL, '25.19. La administración del Estado', 2, 0, 1, '2026-02-24 19:13:38'),
(351, 25, NULL, '25.20. La familia', 2, 0, 1, '2026-02-24 19:13:48'),
(352, 25, NULL, '25.21. La sociedad', 2, 0, 1, '2026-02-24 19:13:57'),
(353, 25, NULL, '25.22. Ley Federal sobre Monumentos y Zonas Arqueológicos, Artísticos e Históricos', 2, 0, 1, '2026-02-24 19:14:07'),
(354, 25, NULL, '25.23. Ley sobre Delitos de Imprenta', 2, 0, 1, '2026-02-24 19:14:28'),
(355, 25, NULL, '25.24. Ninguno', 2, 0, 1, '2026-02-24 19:14:46'),
(356, 25, NULL, '25.25. No especificado', 2, 0, 1, '2026-02-24 19:15:01'),
(357, 25, NULL, '25.26. No especificado delito del fuero común', 2, 0, 1, '2026-02-24 19:15:24'),
(358, 25, NULL, '25.27. No identificado', 2, 0, 1, '2026-02-24 19:15:41'),
(359, 25, NULL, '25.28. Otro', 2, 0, 1, '2026-02-24 19:15:51'),
(360, 25, NULL, '25.29. Otros (bienes jurídicos)', 2, 0, 1, '2026-02-24 19:16:09'),
(361, 25, NULL, '25.30. Otros delitos', 2, 0, 1, '2026-02-24 19:16:19'),
(362, 25, NULL, '25.31. Otros delitos cometidos contra el servicio público', 2, 0, 1, '2026-02-24 19:16:32'),
(363, 25, NULL, '25.32. Otros Delitos contenidos en el Código Penal Federal', 2, 0, 1, '2026-02-24 19:16:44'),
(364, 25, NULL, '25.33. Otros delitos contra la administración del Estado', 2, 0, 1, '2026-02-24 19:16:58'),
(365, 25, NULL, '25.34. Otros delitos contra la familia', 2, 0, 1, '2026-02-24 19:17:06'),
(366, 25, NULL, '25.35. Otros Delitos contra la familia', 2, 0, 1, '2026-02-24 19:17:19'),
(367, 25, NULL, '25.36. Otros delitos contra la libertad personal', 2, 0, 1, '2026-02-24 19:18:29'),
(368, 25, NULL, '25.37. Otros delitos contra la sociedad', 2, 0, 1, '2026-02-24 19:18:38'),
(369, 25, NULL, '25.38. Otros Delitos contra la sociedad', 2, 0, 1, '2026-02-24 19:18:48'),
(370, 25, NULL, '25.39. Otros delitos del fuero común', 2, 0, 1, '2026-02-24 19:18:57'),
(371, 25, NULL, '25.40. Otros delitos del Fuero Común', 2, 0, 1, '2026-02-24 19:19:19'),
(372, 25, NULL, '25.41. Otros Delitos del Fuero Común', 2, 0, 1, '2026-02-24 19:19:37'),
(373, 25, NULL, '25.42. Responsabilidad Profesional', 2, 0, 1, '2026-02-24 19:19:48'),
(374, 26, NULL, '26.1. Código de Justicia Militar', 2, 0, 1, '2026-02-24 19:20:45'),
(375, 26, NULL, '26.2. Cometidos por servidores públicos', 2, 0, 1, '2026-02-24 19:21:01'),
(376, 26, NULL, '26.3. Cometidos por Servidores Públicos', 2, 0, 1, '2026-02-24 19:21:11'),
(377, 26, NULL, '26.4. Delitos cometidos por servidores públicos', 2, 0, 1, '2026-02-24 19:21:20'),
(378, 26, NULL, '26.5. Delitos Cometidos por Servidores Públicos', 2, 0, 1, '2026-02-24 19:21:30'),
(379, 26, NULL, '26.6. Responsabilidad de servidores públicos', 2, 0, 1, '2026-02-24 19:21:42'),
(380, 27, NULL, '27.1. Caza, pesca o tala ilegal de flora o fauna silvestres', 2, 0, 1, '2026-02-24 19:23:27'),
(381, 27, NULL, '27.2. Caza, pesca o tala ilegal de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 2, 0, 1, '2026-02-24 19:23:38'),
(382, 27, NULL, '27.3. Contra el Ambiente y la Gestión Ambiental', 2, 0, 1, '2026-02-24 19:23:47'),
(383, 27, NULL, '27.4. Contra el medio ambiente y equilibrio ecológico', 2, 0, 1, '2026-02-24 19:23:56'),
(384, 27, NULL, '27.5. Daños a los ecosistemas o sus elementos', 2, 0, 1, '2026-02-24 19:24:07'),
(385, 27, NULL, '27.6. Delitos ambientales', 2, 0, 1, '2026-02-24 19:24:21'),
(386, 27, NULL, '27.7. Delitos ambientales (Previstos en el Código Penal Federal y en la Ley General del Equilibrio Ecológico y la Protección al Ambiente)', 2, 0, 1, '2026-02-24 19:25:08'),
(387, 27, NULL, '27.8. Delitos Contra el Ambiente y la Gestión Ambiental', 2, 0, 1, '2026-02-24 19:26:24'),
(388, 27, NULL, '27.9. Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental', 2, 0, 1, '2026-02-24 19:26:37'),
(389, 27, NULL, '27.10. Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - Caza, pesca o tala ilegal de flora o fauna silvestres en peligro de extinción, amenazadas o sujetas a protección', 2, 0, 1, '2026-02-24 19:26:49'),
(390, 27, NULL, '27.11. Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - Daños a los ecosistemas o sus elementos', 2, 0, 1, '2026-02-24 19:27:01'),
(391, 27, NULL, '27.12. Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - No especificado', 2, 0, 1, '2026-02-24 19:27:15'),
(392, 27, NULL, '27.13. Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - No identificado', 2, 0, 1, '2026-02-24 19:28:09'),
(393, 27, NULL, '27.14. Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - Otros delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental', 2, 0, 1, '2026-02-24 19:28:20'),
(394, 27, NULL, '27.15. Delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental - Transporte o manejo de residuos peligrosos', 2, 0, 1, '2026-02-24 19:28:44'),
(395, 27, NULL, '27.16. Otros delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental', 2, 0, 1, '2026-02-24 19:28:57'),
(396, 27, NULL, '27.17. Otros delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental', 2, 0, 1, '2026-02-24 19:29:08'),
(397, 27, NULL, '27.18. Transporte o manejo de residuos peligrosos', 2, 0, 1, '2026-02-24 19:29:19'),
(398, 28, NULL, '28.1. Contra la Salud - No especificado', 2, 0, 1, '2026-02-24 19:30:13'),
(399, 28, NULL, '28.2. Delitos Contra la Salud', 2, 0, 1, '2026-02-24 19:30:25'),
(400, 28, NULL, '28.3. Delitos contra la salud en todas sus modalidades (Previstos en el Código Penal Federal y en la Ley General de Salud)', 2, 0, 1, '2026-02-24 19:30:44'),
(401, 28, NULL, '28.4. Delitos contra la salud no relacionados con narcóticos', 2, 0, 1, '2026-02-24 19:31:24'),
(402, 28, NULL, '28.5. Delitos en contra de la salud en todas sus modalidades', 2, 0, 1, '2026-02-24 19:31:36'),
(403, 28, NULL, '28.6. Otros delitos contra la salud', 2, 0, 1, '2026-02-24 19:31:49'),
(404, 28, NULL, '28.7. Otros delitos previstos en la Ley General de Salud', 2, 0, 1, '2026-02-24 19:32:04'),
(405, 29, NULL, '29.1. Delitos en materia de migración', 2, 0, 1, '2026-02-24 19:33:08'),
(406, 29, NULL, '29.2. Delitos en materia de migración - No especificado', 2, 0, 1, '2026-02-24 19:33:21'),
(407, 29, NULL, '29.3. Delitos en materia de migración - No identificado', 2, 0, 1, '2026-02-24 19:33:30'),
(408, 29, NULL, '29.4. Delitos en materia de migración - Otros delitos en materia de migración', 2, 0, 1, '2026-02-24 19:33:42'),
(409, 29, NULL, '29.5. Delitos Previstos en la Ley de Migración', 2, 0, 1, '2026-02-24 19:33:52'),
(410, 29, NULL, '29.6. Ley de Migración', 2, 0, 1, '2026-02-24 19:34:11'),
(411, 29, NULL, '29.7. Otros delitos en materia de migración', 2, 0, 1, '2026-02-24 19:34:23'),
(412, 30, NULL, '30.1. Abuso de autoridad', 2, 0, 1, '2026-02-24 19:35:40'),
(413, 30, NULL, '30.2. Cohecho', 2, 0, 1, '2026-02-24 19:35:53'),
(414, 30, NULL, '30.3. Delitos por hechos de corrupción', 2, 0, 1, '2026-02-24 19:36:02'),
(415, 30, NULL, '30.4. Delitos por hechos de corrupción - Abuso de autoridad', 2, 0, 1, '2026-02-24 19:36:12'),
(416, 30, NULL, '30.5. Delitos por hechos de corrupción - Cohecho', 2, 0, 1, '2026-02-24 19:36:23'),
(417, 30, NULL, '30.6. Delitos por hechos de corrupción - Ejercicio abusivo de funciones', 2, 0, 1, '2026-02-24 19:36:38'),
(418, 30, NULL, '30.7. Delitos por hechos de corrupción - Ejercicio indebido del servicio público', 2, 0, 1, '2026-02-24 19:36:51'),
(419, 30, NULL, '30.8. Delitos por hechos de corrupción - No especificado', 2, 0, 1, '2026-02-24 19:37:02'),
(420, 30, NULL, '30.9. Delitos por hechos de corrupción - No identificado', 2, 0, 1, '2026-02-24 19:37:13'),
(421, 30, NULL, '30.10. Delitos por hechos de corrupción - Otros delitos por hechos de corrupción', 2, 0, 1, '2026-02-24 19:37:34'),
(422, 30, NULL, '30.11. Delitos por hechos de corrupción - Tráfico de influencias', 2, 0, 1, '2026-02-24 19:37:47'),
(423, 30, NULL, '30.12. Ejercicio abusivo de funciones', 2, 0, 1, '2026-02-24 19:37:57'),
(424, 30, NULL, '30.13. Ejercicio indebido del servicio público', 2, 0, 1, '2026-02-24 19:38:06'),
(425, 30, NULL, '30.14. Otros delitos por hechos de corrupción', 2, 0, 1, '2026-02-24 19:38:17'),
(426, 30, NULL, '30.15. Tráfico de influencia', 2, 0, 1, '2026-02-24 19:38:40'),
(427, 30, NULL, '30.16. Tráfico de influencias', 2, 0, 1, '2026-02-24 19:38:57'),
(428, 31, NULL, '31. Otros homicidios - culposos', 1, 0, 1, '2026-02-24 19:40:39'),
(429, 31, 428, '31.1. Homicidio culposo', 2, 0, 1, '2026-02-24 19:40:53'),
(430, 32, NULL, '32.1. Otros robos', 2, 0, 1, '2026-02-24 19:42:38'),
(431, 32, NULL, '32.2. Robo', 2, 0, 1, '2026-02-24 19:42:53'),
(432, 32, NULL, '32.3. Robo - No especificado', 2, 0, 1, '2026-02-24 19:43:05'),
(433, 32, NULL, '32.4. Robo - No identificado', 2, 0, 1, '2026-02-24 19:43:17'),
(434, 32, NULL, '32.5. Robo - Otros robos', 2, 0, 1, '2026-02-24 19:44:02'),
(435, 32, NULL, '32.6. Robo - Robo a casa habitación', 2, 0, 1, '2026-02-24 19:44:16'),
(436, 32, NULL, '32.7. Robo - Robo a institución bancaria', 2, 0, 1, '2026-02-24 19:44:27'),
(437, 32, NULL, '32.8. Robo - Robo a negocio', 2, 0, 1, '2026-02-24 19:44:37'),
(438, 32, NULL, '32.9. Robo - Robo a persona en un lugar privado', 2, 0, 1, '2026-02-24 19:46:11'),
(439, 32, NULL, '32.10. Robo - Robo a transeúnte en espacio abierto al público', 2, 0, 1, '2026-02-24 19:46:21'),
(440, 32, NULL, '32.11. Robo - Robo a transeúnte en vía pública', 2, 0, 1, '2026-02-24 19:46:42'),
(441, 32, NULL, '32.12. Robo - Robo a transportista', 2, 0, 1, '2026-02-24 19:46:54'),
(442, 32, NULL, '32.13. Robo - Robo de autopartes', 2, 0, 1, '2026-02-24 19:47:03'),
(443, 32, NULL, '32.14. Robo - Robo de energía eléctrica', 2, 0, 1, '2026-02-24 19:47:12'),
(444, 32, NULL, '32.15. Robo - Robo de ganado', 2, 0, 1, '2026-02-24 19:47:22'),
(445, 32, NULL, '32.16. Robo - Robo de maquinaria', 2, 0, 1, '2026-02-24 19:47:32'),
(446, 32, NULL, '32.17. Robo - Robo en transporte individual', 2, 0, 1, '2026-02-24 19:47:47'),
(447, 32, NULL, '32.18. Robo - Robo en transporte público colectivo', 2, 0, 1, '2026-02-24 19:48:18'),
(448, 32, NULL, '32.19. Robo - Robo en transporte público individual', 2, 0, 1, '2026-02-24 19:48:30'),
(449, 32, NULL, '32.20. Robo - Robo simple', 2, 0, 1, '2026-02-24 19:48:41'),
(450, 32, NULL, '32.21. Robo a casa habitación', 2, 0, 1, '2026-02-24 19:49:01'),
(451, 32, NULL, '32.22. Robo a institución bancaria', 2, 0, 1, '2026-02-24 19:49:13'),
(452, 32, NULL, '32.23. Robo a instituciones bancarias', 2, 0, 1, '2026-02-24 19:49:25'),
(453, 32, NULL, '32.24. Robo a negocio', 2, 0, 1, '2026-02-24 19:49:34'),
(454, 32, NULL, '32.25. Robo a persona en un lugar privado', 2, 0, 1, '2026-02-24 19:49:43'),
(455, 32, NULL, '32.26. Robo a transeúnte', 2, 0, 1, '2026-02-24 19:49:53'),
(456, 32, NULL, '32.27. Robo a transeúnte en espacio abierto al público', 2, 0, 1, '2026-02-24 19:50:02'),
(457, 32, NULL, '32.28. Robo a transeúnte en un lugar privado', 2, 0, 1, '2026-02-24 19:50:14'),
(458, 32, NULL, '32.29. Robo a transeúnte en vía pública', 2, 0, 1, '2026-02-24 19:50:24'),
(459, 32, NULL, '32.30. Robo a transportista', 2, 0, 1, '2026-02-24 19:50:38'),
(460, 32, NULL, '32.31. Robo de autopartes', 2, 0, 1, '2026-02-24 19:50:47'),
(461, 32, NULL, '32.32. Robo de energía eléctrica', 2, 0, 1, '2026-02-24 19:50:56'),
(462, 32, NULL, '32.33. Robo de ganado', 2, 0, 1, '2026-02-24 19:51:10'),
(463, 32, NULL, '32.34. Robo de maquinaria', 2, 0, 1, '2026-02-24 19:51:26'),
(464, 32, NULL, '32.35. Robo de menor', 2, 0, 1, '2026-02-24 19:51:36'),
(465, 32, NULL, '32.36. Robo en carretera', 2, 0, 1, '2026-02-24 19:51:59'),
(466, 32, NULL, '32.37. Robo en transporte individual', 2, 0, 1, '2026-02-24 19:52:08'),
(467, 32, NULL, '32.38. Robo en transporte publico colectivo', 2, 0, 1, '2026-02-24 19:52:19'),
(468, 32, NULL, '32.39. Robo en transporte público colectivo', 2, 0, 1, '2026-02-24 19:52:28'),
(469, 32, NULL, '32.40. Robo en transporte publico individual', 2, 0, 1, '2026-02-24 19:52:37'),
(470, 32, NULL, '32.41. Robo en transporte público individual', 2, 0, 1, '2026-02-24 19:52:54'),
(471, 32, NULL, '32.42. Robo simple', 2, 0, 1, '2026-02-24 19:53:13'),
(472, 33, NULL, '33.1. Delitos en materia de hidrocarburos y sus derivados - Posesión ilícita de hidrocarburos y sus derivados', 2, 0, 1, '2026-02-24 19:54:32'),
(473, 33, NULL, '33.2. Posesión ilícita de hidrocarburos y sus derivados', 2, 0, 1, '2026-02-24 19:54:42'),
(474, 34, NULL, '34.1. Delitos contra la salud relacionados con narcóticos en su modalidad de narcomenudeo - Posesión simple de narcóticos', 2, 0, 1, '2026-02-24 19:55:53');
INSERT INTO `indicator_categories` (`id`, `indicator_id`, `parent_id`, `name`, `level`, `sort_order`, `status`, `created_at`) VALUES
(475, 34, NULL, '34.2. Delitos federales contra la salud relacionados con narcóticos - Posesión de narcóticos', 2, 0, 1, '2026-02-24 19:56:09'),
(476, 34, NULL, '34.3. Narcomenudeo en modalidad de posesión simple', 2, 0, 1, '2026-02-24 19:56:21'),
(477, 34, NULL, '34.4. Posesión de narcóticos', 2, 0, 1, '2026-02-24 19:56:33'),
(478, 34, NULL, '34.5. Posesión de Narcóticos', 2, 0, 1, '2026-02-24 19:56:43'),
(479, 34, NULL, '34.6. Posesión simple', 2, 0, 1, '2026-02-24 19:56:57'),
(480, 34, NULL, '34.7. Posesión simple de narcóticos', 2, 0, 1, '2026-02-24 19:57:19'),
(481, 35, NULL, '35. Retención o sustracción de menores e incapaces', 1, 0, 1, '2026-02-24 20:00:35'),
(482, 36, NULL, '36. Suplantación y usurpación de identidad', 1, 0, 1, '2026-02-24 20:00:57'),
(483, 37, NULL, '37. Total', 1, 0, 1, '2026-02-24 20:01:42'),
(484, 38, NULL, '38.1. Violencia de género en todas sus modalidades', 2, 0, 1, '2026-02-24 20:02:25'),
(485, 38, NULL, '38.2. Violencia de género en todas sus modalidades', 2, 0, 1, '2026-02-24 20:02:38'),
(486, 38, NULL, '38.3. Violencia de género en todas sus modalidades distinta a la violencia familiar', 2, 0, 1, '2026-02-24 20:02:58'),
(487, 39, NULL, '39. Violencia familiar', 1, 0, 1, '2026-02-24 20:03:31');

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
-- Estructura de tabla para la tabla `roles`
--

CREATE TABLE `roles` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `roles`
--

INSERT INTO `roles` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1, 'Administrador', 'Control total sobre todos los módulos del sistema', '2026-03-08 21:25:59', '2026-03-08 21:25:59'),
(2, 'Consultor', 'Acceso exclusivo de lectura para análisis y reportes', '2026-03-08 21:25:59', '2026-03-08 21:25:59');

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

--
-- Volcado de datos para la tabla `role_permissions`
--

INSERT INTO `role_permissions` (`id`, `role_id`, `module`, `permission_type`, `created_at`, `updated_at`) VALUES
(1, 1, 'indicators', 'read-write', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(2, 1, 'indicator_categories', 'read-write', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(3, 1, 'centers', 'read-write', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(4, 1, 'states', 'read-write', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(5, 1, 'countries', 'read-write', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(6, 1, 'genders', 'read-write', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(7, 1, 'years', 'read-write', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(8, 2, 'indicators', 'read-only', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(9, 2, 'indicator_categories', 'read-only', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(10, 2, 'centers', 'read-only', '2026-03-08 21:26:38', '2026-03-08 21:26:38'),
(11, 2, 'states', 'read-only', '2026-03-08 21:26:38', '2026-03-08 21:26:38');

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

--
-- Volcado de datos para la tabla `states`
--

INSERT INTO `states` (`id`, `country_id`, `name`, `demonym`, `iso_code`, `status`) VALUES
(1, 1, 'Aguascalientes', 'Aguascalentenses', 'AGU', 0),
(2, 1, 'Baja California', 'Bajacalifornianos', 'BCN', 1),
(3, 1, 'Baja California Sur', 'Bajacalifornianos', 'BCS', 1),
(4, 1, 'Campeche', 'Campechanos', 'CAM', 1),
(5, 1, 'Chiapas', 'Chiapasenses', 'CHP', 1),
(6, 1, 'Chihuahua', 'Chihuahuenses', 'CHH', 1),
(7, 1, 'Ciudad de México', 'Capitalinos', 'CMX', 1),
(8, 1, 'Coahuila de Zaragoza', 'Coahuilenses', 'COA', 1),
(9, 1, 'Colima', 'Colimenses', 'COL', 1),
(10, 1, 'Durango', 'Duranguenses', 'DUR', 1),
(11, 1, 'Guanajuato', 'Guanajuatenses', 'GUA', 1),
(12, 1, 'Guerrero', 'Guerrerenses', 'GRO', 1),
(13, 1, 'Hidalgo', 'Hidalguenses', 'HID', 1),
(14, 1, 'Jalisco', 'Jaliscienses', 'JAL', 1),
(15, 1, 'México', 'Mexiquenses', 'MEX', 1),
(16, 1, 'Michoacán de Ocampo', 'Michoacanos', 'MIC', 1),
(17, 1, 'Morelos', 'Morelenses', 'MOR', 1),
(18, 1, 'Nayarit', 'Nayaritas', 'NAY', 1),
(19, 1, 'Nuevo León', 'Neoleoneses', 'NLE', 1),
(20, 1, 'Oaxaca', 'Oaxaqueños', 'OAX', 1),
(21, 1, 'Puebla', 'Poblanos', 'PUE', 1),
(22, 1, 'Querétaro', 'Queretanos', 'QUE', 1),
(23, 1, 'Quintana Roo', 'Quintanarroenses', 'ROO', 1),
(24, 1, 'San Luis Potosí', 'Potosinos', 'SLP', 1),
(25, 1, 'Sinaloa', 'Sinaloenses', 'SIN', 1),
(26, 1, 'Sonora', 'Sonorenses', 'SON', 1),
(27, 1, 'Tabasco', 'Tabasqueños', 'TAB', 1),
(28, 1, 'Tamaulipas', 'Tamaulipecos', 'TAM', 1),
(29, 1, 'Tlaxcala', 'Tlaxcaltecas', 'TLA', 1),
(30, 1, 'Veracruz de Ignacio de la Llave', 'Veracruzanos', 'VER', 1),
(31, 1, 'Yucatán', 'Yucatecos', 'YUC', 1),
(32, 1, 'Zacatecas', 'Zacatecanos', 'ZAC', 1);

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

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `username`, `password`, `resetpassword`, `status`, `created_at`, `updated_at`) VALUES
(4, 1, 'Super Administrador', 'admin@ninezprimero.org', 'admin', '$2y$10$cd.kxxd1chBmvRhlDyD8MuQlpX.HLnbOs6dXm7wLk6j89t9Ia4hEO', NULL, 1, '2026-03-08 21:43:08', '2026-03-08 21:43:08'),
(5, 2, 'Fernando REDIM', 'fernando@ninezprimero.org', 'fer2026', '$2y$10$vdyje8AviplwRgzfKkxTUeG/QohcwyrQcR5gG.4q1L9tv2SgCktr6', NULL, 1, '2026-03-08 21:45:52', '2026-03-08 21:45:52');

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
-- Volcado de datos para la tabla `years`
--

INSERT INTO `years` (`id`, `name`, `status`) VALUES
(1, '2000', 1),
(2, '2001', 1),
(3, '2002', 1),
(4, '2003', 1),
(5, '2004', 1),
(6, '2005', 1),
(7, '2006', 1),
(8, '2007', 1),
(9, '2008', 1),
(10, '2009', 1),
(11, '2010', 1),
(12, '2011', 1),
(13, '2012', 1),
(14, '2013', 1),
(15, '2014', 1),
(16, '2015', 1),
(17, '2016', 1),
(18, '2017', 1),
(19, '2018', 1),
(20, '2019', 1),
(21, '2020', 1),
(22, '2021', 1),
(23, '2022', 1),
(24, '2023', 1),
(25, '2024', 1),
(26, '2025', 1),
(27, '2026', 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `centers`
--
ALTER TABLE `centers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `state_id` (`state_id`);

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
-- Indices de la tabla `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `fk_users_role` (`role_id`);

--
-- Indices de la tabla `years`
--
ALTER TABLE `years`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `centers`
--
ALTER TABLE `centers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT de la tabla `countries`
--
ALTER TABLE `countries`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT de la tabla `genders`
--
ALTER TABLE `genders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `indicators`
--
ALTER TABLE `indicators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT de la tabla `indicator_categories`
--
ALTER TABLE `indicator_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=488;

--
-- AUTO_INCREMENT de la tabla `indicator_category_details`
--
ALTER TABLE `indicator_category_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `roles`
--
ALTER TABLE `roles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `role_permissions`
--
ALTER TABLE `role_permissions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `years`
--
ALTER TABLE `years`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `centers`
--
ALTER TABLE `centers`
  ADD CONSTRAINT `centers_ibfk_1` FOREIGN KEY (`state_id`) REFERENCES `states` (`id`) ON UPDATE CASCADE;

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
-- Filtros para la tabla `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
