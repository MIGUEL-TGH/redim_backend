-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-02-2026 a las 01:48:38
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
(5, 'Otro', 1),
(6, 'Otros tipossss', 1);

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
(1, '1.	Aborto', 1, 1, 0),
(2, '2.	Abuso de confianza y falsedad', 1, 1, 0),
(3, '3. Otros delitos sexuales', 1, 1, 0),
(4, '4. Delitos de delincuencia organizada y tipificados en Convención de Palermo', 1, 1, 1),
(5, '5. Allanamiento de morada', 1, 1, 0),
(6, '6. Amenazas', 1, 1, 0),
(7, '7. Otros delitos asociados a la delincuencia organizada', 1, 1, 0),
(8, '8. Corrupción de niñez, adolescencia y personas con discapacidad', 1, 1, 0),
(9, '9. Delitos bancarios y financieros', 1, 1, 0),
(10, '10. Delitos contra el libre desarrollo de la personalidad y la libertad personal', 1, 1, 0),
(11, '11. Delitos contra el patrimonio y daño a la propiedad', 1, 1, 0),
(12, '12. Delitos contra la administración de justicia', 1, 1, 0),
(13, '13. Delitos contra la autoridad y servidores públicos', 1, 1, 0),
(14, '14. Delitos contra la seguridad de los datos y - o sistemas o equipos informáticos', 1, 1, 0),
(15, '15. Delitos contra la seguridad pública, de la nación o del Estado', 1, 1, 0),
(16, '16. Delitos contra la vida, integridad corporal y seguridad de las personas', 1, 1, 0),
(17, '17. Delitos electorales', 1, 1, 0),
(18, '18. Delitos en materia de vías de comunicación y correspondencia', 1, 1, 0),
(19, '19. Delitos en materia fiscal', 1, 1, 0),
(20, '20. Despojo', 1, 1, 0),
(21, '21. Discriminación', 1, 1, 0),
(22, '22. Evasión de presos', 1, 1, 0),
(23, '23. Incumplimiento de obligaciones familiares', 1, 1, 0),
(24, '24. Otras lesiones - culposas', 1, 1, 0),
(25, '25. Otros delitos', 1, 1, 0),
(26, '26. Otros delitos cometidos por servidores públicos', 1, 1, 0),
(27, '27. Otros delitos contra el medio ambiente, el equilibrio ecológico y la gestión ambiental ', 1, 1, 0),
(28, '28. Otros delitos contra la salud', 1, 1, 0),
(29, '29. Otros delitos en materia de migración', 1, 1, 0),
(30, '30. Otros delitos por hechos de corrupción ', 1, 1, 0),
(31, '31. Otros homicidios', 1, 1, 0),
(32, '32. Otros robos', 1, 1, 0),
(33, '33. Posesión ilícita de hidrocarburos y sus derivados', 1, 1, 0),
(34, '34. Posesión y posesión simple de narcóticos', 1, 1, 0),
(35, '35. Retención o sustracción de menores e incapaces', 1, 1, 0),
(36, '36. Suplantación y usurpación de identidad', 1, 1, 0),
(37, '37. Total', 1, 1, 0),
(38, '38. Violencia de género', 1, 1, 0),
(39, '39. Violencia familiar', 1, 1, 0);

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
(5, 3, 4, '3.1.1.	Abuso sexual', 1, 0, 1, '2026-02-01 00:00:00'),
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
(16, 3, 9, '3.3.2.	Delitos Contra la Libertad y el Normal Desarrollo Psicosexual', 1, 0, 1, '2026-02-23 17:05:44'),
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
(43, 4, 42, '4.2.2.1.	Aprovechamiento de hidrocarburos y sus derivados', 4, 0, 1, '2026-02-23 18:25:04'),
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
(61, 4, NULL, '4.4. Extorsión', 2, 0, 1, '2026-02-23 18:41:34');

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

--
-- Volcado de datos para la tabla `indicator_category_details`
--

INSERT INTO `indicator_category_details` (`id`, `category_id`, `year_id`, `gender_id`, `center_id`, `state_id`, `PI`, `PS`, `status`) VALUES
(1, 1, 14, 1, NULL, 1, 0, 0, 1),
(2, 1, 14, 1, NULL, 2, 0, 0, 1),
(3, 1, 14, 1, NULL, 3, 0, 0, 1),
(4, 1, 14, 1, NULL, 4, 0, 0, 1),
(5, 1, 14, 1, NULL, 8, 0, 0, 1),
(6, 1, 14, 1, NULL, 9, 0, 0, 1),
(7, 1, 14, 1, NULL, 5, 0, 0, 1),
(8, 1, 14, 1, NULL, 6, 0, 0, 1),
(9, 1, 14, 1, NULL, 7, 0, 0, 1),
(10, 1, 14, 1, NULL, 10, 0, 0, 1),
(11, 1, 14, 1, NULL, 11, 0, 0, 1),
(12, 1, 14, 1, NULL, 12, 0, 0, 1),
(13, 1, 14, 1, NULL, 13, 0, 0, 1),
(14, 1, 14, 1, NULL, 14, 0, 0, 1),
(15, 1, 14, 1, NULL, 15, 0, 0, 1),
(16, 1, 14, 1, NULL, 16, 0, 0, 1),
(17, 1, 14, 1, NULL, 17, 0, 0, 1),
(18, 1, 14, 1, NULL, 18, 0, 0, 1),
(19, 1, 14, 1, NULL, 19, 0, 0, 1),
(20, 1, 14, 1, NULL, 20, 1, 0, 1),
(21, 1, 14, 1, NULL, 21, 0, 0, 1),
(22, 1, 14, 1, NULL, 22, 0, 0, 1),
(23, 1, 14, 1, NULL, 23, 2, 0, 1),
(24, 1, 14, 1, NULL, 24, 1, 0, 1),
(25, 1, 14, 1, NULL, 25, 0, 0, 1),
(26, 1, 14, 1, NULL, 26, 0, 0, 1),
(27, 1, 14, 1, NULL, 27, 1, 0, 1),
(28, 1, 14, 1, NULL, 28, 0, 0, 1),
(29, 1, 14, 1, NULL, 29, 0, 0, 1),
(30, 1, 14, 1, NULL, 30, 2, 0, 1),
(31, 1, 14, 1, NULL, 31, 0, 0, 1),
(32, 1, 14, 1, NULL, 32, 0, 0, 1),
(33, 1, 14, 2, NULL, 1, 0, 0, 1),
(34, 1, 14, 2, NULL, 2, 1, 0, 1),
(35, 1, 14, 2, NULL, 3, 0, 0, 1),
(36, 1, 14, 2, NULL, 4, 0, 0, 1),
(37, 1, 14, 2, NULL, 8, 0, 0, 1),
(38, 1, 14, 2, NULL, 9, 0, 0, 1),
(39, 1, 14, 2, NULL, 5, 0, 0, 1),
(40, 1, 14, 2, NULL, 6, 0, 0, 1),
(41, 1, 14, 2, NULL, 7, 3, 0, 1),
(42, 1, 14, 2, NULL, 10, 0, 0, 1),
(43, 1, 14, 2, NULL, 11, 0, 0, 1),
(44, 1, 14, 2, NULL, 12, 0, 0, 1),
(45, 1, 14, 2, NULL, 13, 0, 0, 1),
(46, 1, 14, 2, NULL, 14, 0, 0, 1),
(47, 1, 14, 2, NULL, 15, 6, 0, 1),
(48, 1, 14, 2, NULL, 16, 0, 0, 1),
(49, 1, 14, 2, NULL, 17, 0, 0, 1),
(50, 1, 14, 2, NULL, 18, 0, 0, 1),
(51, 1, 14, 2, NULL, 19, 0, 0, 1),
(52, 1, 14, 2, NULL, 20, 0, 0, 1),
(53, 1, 14, 2, NULL, 21, 0, 0, 1),
(54, 1, 14, 2, NULL, 22, 0, 0, 1),
(55, 1, 14, 2, NULL, 23, 0, 0, 1),
(56, 1, 14, 2, NULL, 24, 0, 0, 1),
(57, 1, 14, 2, NULL, 25, 0, 0, 1),
(58, 1, 14, 2, NULL, 26, 1, 0, 1),
(59, 1, 14, 2, NULL, 27, 0, 0, 1),
(60, 1, 14, 2, NULL, 28, 0, 0, 1),
(61, 1, 14, 2, NULL, 29, 0, 0, 1),
(62, 1, 14, 2, NULL, 30, 4, 0, 1),
(63, 1, 14, 2, NULL, 31, 0, 0, 1),
(64, 1, 14, 2, NULL, 32, 2, 0, 1),
(65, 1, 15, 1, NULL, 1, 0, 0, 1),
(66, 1, 15, 1, NULL, 2, 0, 0, 1),
(67, 1, 15, 1, NULL, 3, 0, 0, 1),
(68, 1, 15, 1, NULL, 4, 0, 0, 1),
(69, 1, 15, 1, NULL, 8, 0, 0, 1),
(70, 1, 15, 1, NULL, 9, 0, 0, 1),
(71, 1, 15, 1, NULL, 5, 0, 0, 1),
(72, 1, 15, 1, NULL, 6, 0, 1, 1),
(73, 1, 15, 1, NULL, 7, 3, 0, 1),
(74, 1, 15, 1, NULL, 10, 0, 0, 1),
(75, 1, 15, 1, NULL, 11, 0, 0, 1),
(76, 1, 15, 1, NULL, 12, 0, 0, 1),
(77, 1, 15, 1, NULL, 13, 0, 0, 1),
(78, 1, 15, 1, NULL, 14, 0, 0, 1),
(79, 1, 15, 1, NULL, 15, 0, 0, 1),
(80, 1, 15, 1, NULL, 16, 0, 0, 1),
(81, 1, 15, 1, NULL, 17, 0, 0, 1),
(82, 1, 15, 1, NULL, 18, 1, 0, 1),
(83, 1, 15, 1, NULL, 19, 0, 0, 1),
(84, 1, 15, 1, NULL, 20, 1, 0, 1),
(85, 1, 15, 1, NULL, 21, 0, 0, 1),
(86, 1, 15, 1, NULL, 22, 0, 0, 1),
(87, 1, 15, 1, NULL, 23, 0, 0, 1),
(88, 1, 15, 1, NULL, 24, 1, 0, 1),
(89, 1, 15, 1, NULL, 25, 8, 0, 1),
(90, 1, 15, 1, NULL, 26, 0, 0, 1),
(91, 1, 15, 1, NULL, 27, 0, 0, 1),
(92, 1, 15, 1, NULL, 28, 0, 0, 1),
(93, 1, 15, 1, NULL, 29, 0, 0, 1),
(94, 1, 15, 1, NULL, 30, 1, 0, 1),
(95, 1, 15, 1, NULL, 31, 0, 0, 1),
(96, 1, 15, 1, NULL, 32, 0, 0, 1),
(97, 1, 15, 2, NULL, 1, 0, 0, 1),
(98, 1, 15, 2, NULL, 2, 1, 0, 1),
(99, 1, 15, 2, NULL, 3, 0, 0, 1),
(100, 1, 15, 2, NULL, 4, 0, 0, 1),
(101, 1, 15, 2, NULL, 8, 0, 0, 1),
(102, 1, 15, 2, NULL, 9, 0, 0, 1),
(103, 1, 15, 2, NULL, 5, 5, 0, 1),
(104, 1, 15, 2, NULL, 6, 0, 0, 1),
(105, 1, 15, 2, NULL, 7, 8, 0, 1),
(106, 1, 15, 2, NULL, 10, 0, 0, 1),
(107, 1, 15, 2, NULL, 11, 0, 0, 1),
(108, 1, 15, 2, NULL, 12, 0, 0, 1),
(109, 1, 15, 2, NULL, 13, 4, 0, 1),
(110, 1, 15, 2, NULL, 14, 2, 0, 1),
(111, 1, 15, 2, NULL, 15, 1, 0, 1),
(112, 1, 15, 2, NULL, 16, 0, 0, 1),
(113, 1, 15, 2, NULL, 17, 0, 0, 1),
(114, 1, 15, 2, NULL, 18, 0, 0, 1),
(115, 1, 15, 2, NULL, 19, 0, 0, 1),
(116, 1, 15, 2, NULL, 20, 1, 0, 1),
(117, 1, 15, 2, NULL, 21, 0, 0, 1),
(118, 1, 15, 2, NULL, 22, 1, 0, 1),
(119, 1, 15, 2, NULL, 23, 0, 0, 1),
(120, 1, 15, 2, NULL, 24, 1, 1, 1),
(121, 1, 15, 2, NULL, 25, 0, 0, 1),
(122, 1, 15, 2, NULL, 26, 1, 0, 1),
(123, 1, 15, 2, NULL, 27, 0, 0, 1),
(124, 1, 15, 2, NULL, 28, 4, 0, 1),
(125, 1, 15, 2, NULL, 29, 0, 0, 1),
(126, 1, 15, 2, NULL, 30, 3, 0, 1),
(127, 1, 15, 2, NULL, 31, 0, 0, 1),
(128, 1, 15, 2, NULL, 32, 0, 0, 1),
(129, 1, 16, 1, NULL, 1, 0, 0, 1),
(130, 1, 16, 1, NULL, 2, 0, 0, 1),
(131, 1, 16, 1, NULL, 3, 0, 0, 1),
(132, 1, 16, 1, NULL, 4, 0, 0, 1),
(133, 1, 16, 1, NULL, 5, 0, 0, 1),
(134, 1, 16, 1, NULL, 6, 0, 0, 1),
(135, 1, 16, 1, NULL, 7, 3, 0, 1),
(136, 1, 16, 1, NULL, 8, 0, 0, 1),
(137, 1, 16, 1, NULL, 9, 1, 0, 1),
(138, 1, 16, 1, NULL, 10, 0, 0, 1),
(139, 1, 16, 1, NULL, 11, 0, 0, 1),
(140, 1, 16, 1, NULL, 12, 0, 0, 1),
(141, 1, 16, 1, NULL, 13, 0, 0, 1),
(142, 1, 16, 1, NULL, 14, 0, 0, 1),
(143, 1, 16, 1, NULL, 15, 3, 0, 1),
(144, 1, 16, 1, NULL, 16, 0, 0, 1),
(145, 1, 16, 1, NULL, 17, 0, 0, 1),
(146, 1, 16, 1, NULL, 18, 0, 0, 1),
(147, 1, 16, 1, NULL, 19, 0, 0, 1),
(148, 1, 16, 1, NULL, 20, 0, 0, 1),
(149, 1, 16, 1, NULL, 21, 0, 0, 1),
(150, 1, 16, 1, NULL, 22, 0, 0, 1),
(151, 1, 16, 1, NULL, 23, 0, 0, 1),
(152, 1, 16, 1, NULL, 24, 0, 0, 1),
(153, 1, 16, 1, NULL, 25, 2, 0, 1),
(154, 1, 16, 1, NULL, 26, 0, 0, 1),
(155, 1, 16, 1, NULL, 27, 0, 0, 1),
(156, 1, 16, 1, NULL, 28, 0, 0, 1),
(157, 1, 16, 1, NULL, 29, 0, 0, 1),
(158, 1, 16, 1, NULL, 30, 1, 0, 1),
(159, 1, 16, 1, NULL, 31, 0, 0, 1),
(160, 1, 16, 1, NULL, 32, 0, 0, 1),
(161, 1, 16, 2, NULL, 1, 2, 0, 1),
(162, 1, 16, 2, NULL, 2, 3, 0, 1),
(163, 1, 16, 2, NULL, 3, 0, 0, 1),
(164, 1, 16, 2, NULL, 4, 0, 0, 1),
(165, 1, 16, 2, NULL, 5, 0, 0, 1),
(166, 1, 16, 2, NULL, 6, 1, 0, 1),
(167, 1, 16, 2, NULL, 7, 10, 0, 1),
(168, 1, 16, 2, NULL, 8, 1, 0, 1),
(169, 1, 16, 2, NULL, 9, 0, 0, 1),
(170, 1, 16, 2, NULL, 10, 0, 0, 1),
(171, 1, 16, 2, NULL, 11, 1, 0, 1),
(172, 1, 16, 2, NULL, 12, 0, 0, 1),
(173, 1, 16, 2, NULL, 13, 4, 2, 1),
(174, 1, 16, 2, NULL, 14, 2, 0, 1),
(175, 1, 16, 2, NULL, 15, 4, 0, 1),
(176, 1, 16, 2, NULL, 16, 0, 0, 1),
(177, 1, 16, 2, NULL, 17, 0, 0, 1),
(178, 1, 16, 2, NULL, 18, 0, 0, 1),
(179, 1, 16, 2, NULL, 19, 0, 0, 1),
(180, 1, 16, 2, NULL, 20, 6, 0, 1),
(181, 1, 16, 2, NULL, 21, 1, 0, 1),
(182, 1, 16, 2, NULL, 22, 0, 0, 1),
(183, 1, 16, 2, NULL, 23, 0, 0, 1),
(184, 1, 16, 2, NULL, 24, 1, 0, 1),
(185, 1, 16, 2, NULL, 25, 0, 0, 1),
(186, 1, 16, 2, NULL, 26, 4, 0, 1),
(187, 1, 16, 2, NULL, 27, 0, 0, 1),
(188, 1, 16, 2, NULL, 28, 4, 0, 1),
(189, 1, 16, 2, NULL, 29, 0, 0, 1),
(190, 1, 16, 2, NULL, 30, 1, 0, 1),
(191, 1, 16, 2, NULL, 31, 0, 0, 1),
(192, 1, 16, 2, NULL, 32, 0, 0, 1),
(193, 1, 17, 1, NULL, 1, 0, 0, 1),
(194, 1, 17, 1, NULL, 2, 0, 0, 1),
(195, 1, 17, 1, NULL, 3, 0, 0, 1),
(196, 1, 17, 1, NULL, 4, 0, 0, 1),
(197, 1, 17, 1, NULL, 5, 0, 0, 1),
(198, 1, 17, 1, NULL, 6, 0, 0, 1),
(199, 1, 17, 1, NULL, 7, 2, 0, 1),
(200, 1, 17, 1, NULL, 8, 0, 0, 1),
(201, 1, 17, 1, NULL, 9, 0, 0, 1),
(202, 1, 17, 1, NULL, 10, 2, 0, 1),
(203, 1, 17, 1, NULL, 11, 0, 0, 1),
(204, 1, 17, 1, NULL, 12, 0, 0, 1),
(205, 1, 17, 1, NULL, 13, 0, 0, 1),
(206, 1, 17, 1, NULL, 14, 0, 0, 1),
(207, 1, 17, 1, NULL, 15, 11, 0, 1),
(208, 1, 17, 1, NULL, 16, 0, 0, 1),
(209, 1, 17, 1, NULL, 17, 0, 0, 1),
(210, 1, 17, 1, NULL, 18, 0, 0, 1),
(211, 1, 17, 1, NULL, 19, 0, 0, 1),
(212, 1, 17, 1, NULL, 20, 0, 0, 1),
(213, 1, 17, 1, NULL, 21, 0, 0, 1),
(214, 1, 17, 1, NULL, 22, 0, 0, 1),
(215, 1, 17, 1, NULL, 23, 0, 0, 1),
(216, 1, 17, 1, NULL, 24, 0, 0, 1),
(217, 1, 17, 1, NULL, 25, 1, 0, 1),
(218, 1, 17, 1, NULL, 26, 0, 0, 1),
(219, 1, 17, 1, NULL, 27, 0, 0, 1),
(220, 1, 17, 1, NULL, 28, 0, 0, 1),
(221, 1, 17, 1, NULL, 29, 0, 0, 1),
(222, 1, 17, 1, NULL, 30, 1, 0, 1),
(223, 1, 17, 1, NULL, 31, 0, 0, 1),
(224, 1, 17, 1, NULL, 32, 0, 0, 1),
(225, 1, 17, 2, NULL, 1, 1, 0, 1),
(226, 1, 17, 2, NULL, 2, 0, 0, 1),
(227, 1, 17, 2, NULL, 3, 0, 0, 1),
(228, 1, 17, 2, NULL, 4, 0, 0, 1),
(229, 1, 17, 2, NULL, 5, 0, 0, 1),
(230, 1, 17, 2, NULL, 6, 0, 0, 1),
(231, 1, 17, 2, NULL, 7, 10, 0, 1),
(232, 1, 17, 2, NULL, 8, 0, 0, 1),
(233, 1, 17, 2, NULL, 9, 0, 0, 1),
(234, 1, 17, 2, NULL, 10, 0, 0, 1),
(235, 1, 17, 2, NULL, 11, 1, 0, 1),
(236, 1, 17, 2, NULL, 12, 0, 0, 1),
(237, 1, 17, 2, NULL, 13, 2, 0, 1),
(238, 1, 17, 2, NULL, 14, 3, 0, 1),
(239, 1, 17, 2, NULL, 15, 88, 0, 1),
(240, 1, 17, 2, NULL, 16, 0, 0, 1),
(241, 1, 17, 2, NULL, 17, 0, 0, 1),
(242, 1, 17, 2, NULL, 18, 0, 0, 1),
(243, 1, 17, 2, NULL, 19, 0, 0, 1),
(244, 1, 17, 2, NULL, 20, 0, 0, 1),
(245, 1, 17, 2, NULL, 21, 2, 0, 1),
(246, 1, 17, 2, NULL, 22, 1, 0, 1),
(247, 1, 17, 2, NULL, 23, 1, 0, 1),
(248, 1, 17, 2, NULL, 24, 1, 0, 1),
(249, 1, 17, 2, NULL, 25, 0, 0, 1),
(250, 1, 17, 2, NULL, 26, 0, 0, 1),
(251, 1, 17, 2, NULL, 27, 0, 0, 1),
(252, 1, 17, 2, NULL, 28, 5, 0, 1),
(253, 1, 17, 2, NULL, 29, 0, 0, 1),
(254, 1, 17, 2, NULL, 30, 8, 0, 1),
(255, 1, 17, 2, NULL, 31, 1, 0, 1),
(256, 1, 17, 2, NULL, 32, 0, 0, 1);

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
(32, 1, 'Zacatecas', 'Zacatecanos', 'ZAC', 1),
(33, 3, 'ASDF', 'FHYDFGDFG', 'EFG', 1);

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
-- Indices de la tabla `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`id`),
  ADD KEY `country_id` (`country_id`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT de la tabla `indicator_category_details`
--
ALTER TABLE `indicator_category_details`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1026;

--
-- AUTO_INCREMENT de la tabla `states`
--
ALTER TABLE `states`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

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
-- Filtros para la tabla `states`
--
ALTER TABLE `states`
  ADD CONSTRAINT `states_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `countries` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
