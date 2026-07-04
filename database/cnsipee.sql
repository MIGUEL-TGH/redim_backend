-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 04-07-2026 a las 02:16:39
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
-- Estructura de tabla para la tabla `cnsipee`
--

CREATE TABLE `cnsipee` (
  `id` int(11) NOT NULL,
  `state_id` int(11) NOT NULL,
  `woman` int(5) NOT NULL,
  `man` int(5) NOT NULL,
  `status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Reclutamiento de adolescentes en México';

--
-- Volcado de datos para la tabla `cnsipee`
--

INSERT INTO `cnsipee` (`id`, `state_id`, `woman`, `man`, `status`) VALUES
(1, 1, 0, 19, 1),
(2, 2, 3, 47, 1),
(3, 3, 0, 1, 1),
(4, 4, 0, 3, 1),
(5, 5, 3, 29, 1),
(6, 6, 11, 84, 1),
(7, 7, 12, 53, 1),
(8, 8, 6, 30, 1),
(9, 9, 0, 6, 1),
(10, 10, 0, 7, 1),
(11, 11, 7, 21, 1),
(12, 12, 2, 17, 1),
(13, 13, 1, 10, 1),
(14, 14, 2, 16, 1),
(15, 15, 24, 177, 1),
(16, 16, 0, 0, 1),
(17, 17, 9, 81, 1),
(18, 18, 0, 3, 1),
(19, 19, 1, 16, 1),
(20, 20, 2, 10, 1),
(21, 21, 0, 26, 1),
(22, 22, 0, 15, 1),
(23, 23, 1, 14, 1),
(24, 24, 2, 4, 1),
(25, 25, 0, 3, 1),
(26, 26, 6, 145, 1),
(27, 27, 4, 12, 1),
(28, 28, 2, 7, 1),
(29, 29, 0, 0, 1),
(30, 30, 8, 38, 1),
(31, 31, 1, 27, 1),
(32, 32, 9, 47, 1);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cnsipee`
--
ALTER TABLE `cnsipee`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cnsipee`
--
ALTER TABLE `cnsipee`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
