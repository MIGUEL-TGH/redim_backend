-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3307
-- Tiempo de generación: 23-07-2026 a las 22:29:48
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
-- Estructura de tabla para la tabla `miradas_contest_links`
--

CREATE TABLE `miradas_contest_links` (
  `id` int(11) NOT NULL,
  `label` varchar(150) NOT NULL,
  `action` varchar(150) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `miradas_contest_links`
--

INSERT INTO `miradas_contest_links` (`id`, `label`, `action`, `parent_id`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Convocatoria', 'convocatoria', NULL, 1, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(2, 'Bases', 'bases', NULL, 2, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(3, 'Calendario', 'calendario', NULL, 3, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(4, 'Registro', 'registro', NULL, 4, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(5, 'Resultados', 'resultados', NULL, 5, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(6, 'Jurado', 'jurado', 5, 1, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(7, 'Ganadores', 'ganadores', 5, 2, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(8, 'Menciones honoríficas', 'menciones', 5, 3, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `miradas_works`
--

CREATE TABLE `miradas_works` (
  `id` int(11) NOT NULL,
  `section` enum('carousel','gallery') NOT NULL DEFAULT 'gallery',
  `title` varchar(250) DEFAULT NULL,
  `author_name` varchar(150) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `miradas_works`
--

INSERT INTO `miradas_works` (`id`, `section`, `title`, `author_name`, `age`, `image_url`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'carousel', '\"Niñez Libre\"', 'María Laura', 8, 'https://picsum.photos/seed/miradas-c0/400/560', 1, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(2, 'carousel', '\"Libres de violencia\"', 'José Emilio', 14, 'https://picsum.photos/seed/miradas-c1/400/560', 2, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(3, 'carousel', '\"Derechos humanos\"', 'Karla Ximena', 11, 'https://picsum.photos/seed/miradas-c2/400/560', 3, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(4, 'gallery', '\"Una niña en este mundo\"', 'Mario Torres', 11, 'https://picsum.photos/seed/miradas-g0/400/400', 1, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(5, 'gallery', '\"Una niña en este mundo\"', 'Mario Torres', 11, 'https://picsum.photos/seed/miradas-g1/400/400', 2, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(6, 'gallery', '\"Una niña en este mundo\"', 'Mario Torres', 11, 'https://picsum.photos/seed/miradas-g2/400/400', 3, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(7, 'gallery', '\"Una niña en este mundo\"', 'Mario Torres', 11, 'https://picsum.photos/seed/miradas-g3/400/400', 4, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47');

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

--
-- Volcado de datos para la tabla `recursos_downloads`
--

INSERT INTO `recursos_downloads` (`id`, `title`, `subtitle`, `file_url`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Infografías digitales', 'Tipo carrusel', 'https://drive.google.com/file/d/1OgwZD0oPW0dpsAQn2tb66g4u4WpCeMmB/view?usp=drive_link', 1, 1, '2026-07-23 05:42:47', '2026-07-23 06:20:10'),
(2, 'Presentaciones digitales', 'Tipo slides', NULL, 2, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(3, 'Carteles de impresión', 'Tamaño 60x90cm', NULL, 3, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(4, 'Material didáctico', 'Tamaño carta', NULL, 4, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(5, 'Personajes', 'Imagen PNG', NULL, 5, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos_studies`
--

CREATE TABLE `recursos_studies` (
  `id` int(11) NOT NULL,
  `title` varchar(300) NOT NULL,
  `url` varchar(500) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recursos_studies`
--

INSERT INTO `recursos_studies` (`id`, `title`, `url`, `category_id`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Informe sobre Trata y Desaparición NNA en Contextos de Movilidad', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2Fc51ce08e7e%2FInforme_sobre_Trata_y_Desaparicio__n_NNA_en_Contextos_de_Movilidad.pdf', NULL, 1, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(2, 'La infancia: objetivo de grupos delincuenciales', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2Fda3e939cfb%2FReportaje_reclutamiento_ilicito-otra_fuente_compressed__1_.pdf', NULL, 2, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(3, 'Reclutamiento y utilización de niñas, niños y adolescentes por grupos delictivos en México', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2Fa05c233b26%2Freclutamiento_crimen.rev_DVS_AA.pdf', NULL, 3, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(4, '2da parte estudio “Reclutamiento y Utilización de niñas, niños y adolescentes por grupos delictivos”', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2Ffbc3715083%2FRECLUTAMIENTO_V2_FNAL_compressed__1_.pdf', NULL, 4, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(5, 'La Infancia Cuenta en México 2022: Niñez y Desapariciones', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2F3e3061c940%2FINFANCIA_CUENTA_2022_-_NIN__EZ_Y_DESAPARICIONES-optimizado.pdf', NULL, 5, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(6, 'Desaparición de mujeres adolescentes, niñas y niños en el Estado de México', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2Fbf1ca78701%2FINFORME_EDOMEX_VERSIO__N_PU__BLICA.pdf', NULL, 6, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(7, 'Personas, circunstancias y otros datos relevantes para entender la desaparición. Estado de México', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2F6212398a4c%2FESTADI__STICOS_EDO_MEX.pdf', NULL, 7, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(8, 'Categorías analíticas para el análisis de la desaparición en el Estado de México', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2Ff0f24a15b6%2FINVESTIGACIO__N._INFORME_EDO.MEX.pdf', NULL, 8, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(9, 'Guía didáctica para el abordaje de los NNAPES dentro de espacios educativos', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2F01fc8aa6ec%2FGui__a_dida__ctica_NNAPES_FINAL_06_Nov_Vinculado.pdf', NULL, 9, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(10, 'Desaparición forzada en México', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2F9fb5b26bf5%2Fdesaparicion_forzada_mexico.pdf', NULL, 10, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(11, 'Ni menores, ni pequeñas, ni pequeños. Recomendaciones para el uso adecuado y tratamiento de la imagen narrativa de niñas, niños y adolescentes', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2Fbb8bdd6ade%2FREDIM-CCD_Manual_121125.pdf', NULL, 11, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(12, 'Guía para el uso ético y respetuoso de la imagen de niñas, niños y adolescentes', 'https://biblioteca.aularedim.net/leer.php?pdf=pdfs%2Feea49627e8%2F1._GUIA_USO_ETICO_.pdf', NULL, 12, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `recursos_study_categories`
--

CREATE TABLE `recursos_study_categories` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL,
  `sort_order` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `recursos_study_categories`
--

INSERT INTO `recursos_study_categories` (`id`, `name`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Contexto Veracruz', 1, 1, '2026-07-23 05:42:47', '2026-07-23 06:39:59'),
(2, 'Contexto Michoacán', 2, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(3, 'Contexto Ciudad de México', 3, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47');

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

--
-- Volcado de datos para la tabla `tv_social_buttons`
--

INSERT INTO `tv_social_buttons` (`id`, `label`, `url`, `icon`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'YOUTUBE', 'https://www.youtube.com/@DerechosInfanciaREDIM', 'mdi-youtube', 1, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(2, 'FACEBOOK', 'https://www.facebook.com/derechosinfancia.org.mx', 'mdi-facebook', 2, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(3, 'INSTAGRAM', 'https://www.instagram.com/redim_mx/', 'mdi-instagram', 3, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(4, 'X', 'https://x.com/derechoinfancia', 'mdi-alpha-x', 4, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(5, 'THREADS', 'https://www.threads.com/@redim_mx', 'mdi-at', 5, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(6, 'TIKTOK', 'https://www.tiktok.com/@derechoinfancia_redim', 'mdi-music-note', 6, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(7, 'TELEGRAM', 'https://t.me/redim_derechos_infancia', 'mdi-send', 7, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47');

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

--
-- Volcado de datos para la tabla `tv_videos`
--

INSERT INTO `tv_videos` (`id`, `youtube_id`, `playlist_id`, `thumb_id`, `title`, `channel`, `date_label`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'ipaF-0j6ZlY', NULL, NULL, 'REDIM: Migrar es un derecho', 'REDIM', '26 DE ENERO 2021', 1, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(2, 'ccnA9oNsi7w', NULL, NULL, 'REDIM: ¿Quiénes buscan a niñas, niños y adolescentes desaparecidos?', 'REDIM', '26 DE ENERO 2021', 2, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(3, 'fw9AAIEbVaw', NULL, NULL, 'REDIM: En Ciudad Juárez, candidat@s también firmaron el ¡Compromiso con la Niñez. SuFuturoEsHOY!', 'REDIM', '26 DE ENERO 2021', 3, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(4, 'W6upFglzI_s', NULL, NULL, 'REDIM: #NiñezIndígena habla sobre su derecho a la participación', 'REDIM', '26 DE ENERO 2021', 4, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(5, 'NnfB5NOWl-w', NULL, NULL, 'REDIM: Derecho a la identidad desde la mirada de la #NiñezIndígena | Comunidad de Chabeclumil, Chiapas', 'REDIM', '26 DE ENERO 2021', 5, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(6, '4LSr9erYiGE', NULL, NULL, 'REDIM: Niñez y adolescencia indígena de Pajajté, en Chiapas, hablan sobre su derecho a la paz', 'REDIM', '26 DE ENERO 2021', 6, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(7, 'DLpPL2NwIHU', NULL, NULL, 'REDIM: ABRAZOS - Historias de niñas y niños con familiares privados de libertad / Cap. 4 - Visitas', 'REDIM', '26 DE ENERO 2021', 7, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(8, 'AajGrcOiWj8', NULL, NULL, '⭕️ #AquíEstoy #DíaMundialContraLaTrata', 'REDIM', NULL, 8, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(9, 'KtGpAekTYUY', NULL, NULL, '⭕️ ¿Cuales son las características del reclutamiento de niñas, niños y adolescente en México?', 'REDIM', NULL, 9, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(10, '8X3xzC3EnAE', NULL, NULL, '⭕️ Tres patrones que se pueden identificar en el reclutamiento de la niñez en México.', 'REDIM', NULL, 10, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(11, 'Y0KsKjFfw88', NULL, NULL, '⭕️ #NiñezBuscadora', 'REDIM', NULL, 11, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(12, 'fInUEFzbHY4', NULL, NULL, '⭕️ “Voces de infancias y adolescencias buscadoras”, una campaña de @Fernandodelucio_activista', 'REDIM', NULL, 12, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(13, 'sZX28-79Y2I', NULL, NULL, '⭕️ “Voces de infancias y adolescencias buscadoras” | CAP. 2', 'REDIM', NULL, 13, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(14, 'fNJd9E3WKfI', NULL, NULL, '⭕️ 118,498 niñas, niños y adolescentes han sido reportados como desaparecidos en México', 'REDIM', NULL, 14, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(15, 'E-VBDMRMgWE', NULL, NULL, '⭕️ Este Día de las Madres, muchas no celebran. Marchan, buscan y luchan', 'REDIM', NULL, 15, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(16, NULL, 'PLc12g26yz6EcdFeDMxiPCR8XZ05XoZHVg', 'VnWuObjG9jg', '#NiñezDesaparecida', 'REDIM · Lista de reproducción', NULL, 16, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(17, 'RlHl6FHTNE4', NULL, NULL, '⭕️ 3 datos preocupantes sobre la trata de niñas, niños y adolescentes en México', 'REDIM', NULL, 17, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(18, 'B0oGgr_46KQ', NULL, NULL, '⭕️ 4 datos sobre el reclutamiento y la utilización de niñas, niños y adolescentes en México', 'REDIM', NULL, 18, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(19, 'thBVPJn4las', NULL, NULL, '⭕️ La violencia en el hogar, un impulsor de la #NiñezReclutada', 'REDIM', NULL, 19, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(20, 'HsDx7GUwuTc', NULL, NULL, '⭕️ REPORTAJE: Al menos 95 mil personas han sido desaparecidas en México, según cifras oficiales.', 'REDIM', NULL, 20, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(21, 'SG5apmCGi8M', NULL, NULL, '⭕️ Cuento infantil: La familia que aparece', 'REDIM', NULL, 21, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(22, 'HTE-xl5giwE', NULL, NULL, '⭕️ Desaparición de la niñez en el Estado de México y su vínculo con la explotación sexual', 'REDIM', NULL, 22, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(23, 'iBy6cVy2jJw', NULL, NULL, '⭕️ Campaña prevención de la #NiñezReclutada en México.', 'REDIM', NULL, 23, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(24, '4EJ1uNjuO_Q', NULL, NULL, '⭕️ Presentación 2da parte Estudio Reclutamiento y Utilización de las infancias por grupos delictivos', 'REDIM', NULL, 24, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47'),
(25, 'yWbT0dfafn0', NULL, NULL, '⭕️ Lanzamiento del Podcast: “1,2,3 por mí y por ti”.', 'REDIM', NULL, 25, 1, '2026-07-23 05:42:47', '2026-07-23 05:42:47');

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

--
-- Volcado de datos para la tabla `voces_podcasts`
--

INSERT INTO `voces_podcasts` (`id`, `title`, `author`, `duration`, `url`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Podcast \"1,2,3 por mí y por ti\", sobre desaparición infantil.', 'de Fer contra la desaparición y por los derechos humanos', '27:59', 'https://music.youtube.com/watch?v=GJWfGOtYKkk&list=PLEO9IC-WjzH3826WgCfGk5maqckrg2Cju', 1, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(2, 'Podcast \"1,2,3 por mí y por ti\", sobre desaparición infantil.', 'de Fer contra la desaparición y por los derechos humanos', '27:59', 'https://music.youtube.com/watch?v=A95P0NgOh5A&list=PLEO9IC-WjzH3826WgCfGk5maqckrg2Cju', 2, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(3, 'Podcast \"1,2,3 por mí y por ti\", sobre desaparición infantil.', 'de Fer contra la desaparición y por los derechos humanos', '27:59', 'https://music.youtube.com/watch?v=1anjO9OX9Z0&list=PLEO9IC-WjzH3826WgCfGk5maqckrg2Cju', 3, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(4, 'Podcast \"1,2,3 por mí y por ti\", sobre desaparición infantil.', 'de Fer contra la desaparición y por los derechos humanos', '27:59', 'https://music.youtube.com/watch?v=C3aDJnKjgew&list=PLEO9IC-WjzH3826WgCfGk5maqckrg2Cju', 4, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(5, 'Podcast \"1,2,3 por mí y por ti\", sobre desaparición infantil.', 'de Fer contra la desaparición y por los derechos humanos', '27:59', 'https://music.youtube.com/watch?v=SFt4Y2zEqqI&list=PLEO9IC-WjzH3826WgCfGk5maqckrg2Cju', 5, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(6, 'Podcast \"1,2,3 por mí y por ti\", sobre desaparición infantil.', 'de Fer contra la desaparición y por los derechos humanos', '27:59', 'https://music.youtube.com/watch?v=gklGoaz-y-M&list=PLEO9IC-WjzH3826WgCfGk5maqckrg2Cju', 6, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(7, 'Podcast \"1,2,3 por mí y por ti\", sobre desaparición infantil.', 'de Fer contra la desaparición y por los derechos humanos', '27:59', 'https://music.youtube.com/watch?v=r-kcMAL3GOM&list=PLEO9IC-WjzH3826WgCfGk5maqckrg2Cju', 7, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(8, 'Podcast \"1,2,3 por mí y por ti\", sobre desaparición infantil.', 'de Fer contra la desaparición y por los derechos humanos', '27:59', 'https://music.youtube.com/watch?v=Ll-W9i78eD0&list=PLEO9IC-WjzH3826WgCfGk5maqckrg2Cju', 8, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00');

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

--
-- Volcado de datos para la tabla `voces_testimonials`
--

INSERT INTO `voces_testimonials` (`id`, `name`, `country`, `tagline`, `image_url`, `description`, `is_main`, `badges`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'FLOR MOLINA', 'MÉXICO', 'Un ejemplo de esperanza:', 'voces/testimonials/flor-molina.png', 'Flor fue víctima de trata laboral en Estados Unidos después de ser engañada con una oferta de trabajo desde México. Gracias al apoyo de la <strong>Organización Internacional para las Migraciones (OIM)</strong> y la <strong>Coalición para Abolir la Esclavitud y la Trata (CAST)</strong>, logró escapar y reunirse con sus hijos tras ocho años de separación. Hoy en día, Flor es una defensora de los derechos de las víctimas de trata y trabaja para crear conciencia sobre este delito, demostrando que la reunificación familiar y la recuperación son posibles; reafirmando que siempre hay una salida y que la esperanza puede transformar vidas.', 1, '[{\"label\":\"ORGANIZACIÓN INTERNACIONAL PARA LAS MIGRACIONES (OIM)\",\"url\":\"https:\\/\\/mismomundomismosderechos.com\\/\"},{\"label\":\"COALICIÓN PARA ABOLIR LA ESCLAVITUD Y TRATA (CAST)\",\"url\":\"https:\\/\\/derechosinfancia.org.mx\\/v1\\/campana-ninezprimero-llega-a-michoacan-redim-y-cam-presentan-diagnostico-sobre-trata-y-reclutamiento-de-ninas-ninos-y-adolescentes-en-la-entidad\\/\"}]', 1, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(2, 'EILEEN DONG', 'ESTADOS UNIDOS', 'Un ejemplo de esperanza:', 'voces/testimonials/eileen-dong.jpg', 'Hola. Para las niñas y los niños de México: soy Eileen Dong, Embajadora Global de Buena Voluntad para el ODS 16 en <strong>UNA-USA</strong> y líder sobreviviente. Fundé <strong>Hope Phoenix Global</strong>, una organización sin fines de lucro con sede en Estados Unidos que apoya a sobrevivientes de trata de personas y violencia de género. Soy una sobreviviente, pero soy más que una sobreviviente. Cuando estaba siendo víctima de trata, no sabía qué era la trata, porque en mi cultura me enseñaron a ser obediente; no sabía qué era el consentimiento. Pensé que el tratante era mi pareja, sin saber que solo era un \"Romeo\" que engaña para explotar. Hoy quiero que sepas que debes estar atenta a las señales de alerta: cualquiera puede ser víctima y cualquiera puede ser tratante. Muchas personas pasan mucho tiempo en redes sociales sin saber que la persona del otro lado de la pantalla puede no ser quien dice ser: puede fingir que te ama, puede ser cualquiera, pero te aseguro que no te ama. Te vigilan para descubrir tus carencias y, a partir de ahí, te explotan y te manipulan hacia la trata. Recuerda: <strong>los tratantes explotan a las personas por dinero. Nunca caigas en su trampa.</strong>', 0, '[{\"label\":\"VER TESTIMONIO EN VIDEO\",\"url\":\"https:\\/\\/www.youtube.com\\/watch?v=9tvWAA9ciB0\"}]', 2, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(3, 'MAURICIO', 'MÉXICO', 'Un ejemplo de esperanza:', 'https://picsum.photos/seed/voces-mauricio/300/300', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 0, '[{\"label\":\"ORGANIZACIÓN INTERNACIONAL PARA LAS MIGRACIONES (OIM)\",\"url\":\"https:\\/\\/derechosinfancia.org.mx\\/v1\\/redim-presenta-ante-la-presidencia-de-la-republica-el-balance-anual-2025-sobre-la-situacion-de-la-ninez-y-adolescencia-en-mexico\\/\"},{\"label\":\"CONOCE MÁS\",\"url\":\"https:\\/\\/derechosinfancia.org.mx\\/v1\\/conoce-mas-2\\/\"}]', 3, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(4, 'MELISA', 'GUATEMALA', 'Un ejemplo de esperanza:', 'https://picsum.photos/seed/voces-melisa/300/300', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 0, '[{\"label\":\"COALICIÓN PARA ABOLIR LA ESCLAVITUD Y TRATA (CAST)\",\"url\":\"https:\\/\\/derechosinfancia.org.mx\\/v1\\/en-audiencia-ante-la-cidh-redim-llama-a-proteger-a-ninas-ninos-y-adolescentes-del-reclutamiento-y-utilizacion-asi-como-a-quienes-estan-en-contexto-de-movilidad-humana\\/\"}]', 4, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00'),
(5, 'ANTONIO', 'MÉXICO', 'Un ejemplo de esperanza:', 'https://picsum.photos/seed/voces-antonio/300/300', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.', 0, '[{\"label\":\"INFANCIA CUENTA (ISSUU)\",\"url\":\"https:\\/\\/issuu.com\\/infanciacuenta\"},{\"label\":\"VACANTES\",\"url\":\"https:\\/\\/derechosinfancia.org.mx\\/v1\\/vacantes\\/\"}]', 5, 1, '2026-07-23 05:25:00', '2026-07-23 05:25:00');

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

--
-- Volcado de datos para la tabla `voces_videos`
--

INSERT INTO `voces_videos` (`id`, `youtube_id`, `title`, `date_label`, `channel`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
(1, 'ipaF-0j6ZlY', 'REDIM: Migrar es un derecho', '26 DE ENERO 2021', 'REDIM', 1, 1, '2026-07-23 05:24:59', '2026-07-23 05:24:59'),
(2, 'ccnA9oNsi7w', 'REDIM: ¿Quiénes buscan a niñas, niños y adolescentes desaparecidos?', '26 DE ENERO 2021', 'REDIM', 2, 1, '2026-07-23 05:24:59', '2026-07-23 05:24:59'),
(3, 'fw9AAIEbVaw', 'REDIM: En Ciudad Juárez, candidat@s también firmaron el ¡Compromiso con la Niñez. SuFuturoEsHOY!', '26 DE ENERO 2021', 'REDIM', 3, 1, '2026-07-23 05:25:00', '2026-07-23 07:09:55'),
(4, 'W6upFglzI_s', 'REDIM: #NiñezIndígena habla sobre su derecho a la participación', '26 DE ENERO 2021', 'REDIM', 4, 1, '2026-07-23 05:25:00', '2026-07-23 07:09:55'),
(5, 'NnfB5NOWl-w', 'REDIM: Derecho a la identidad desde la mirada de la #NiñezIndígena | Comunidad de Chabeclumil, Chiapas', '26 DE ENERO 2021', 'REDIM', 5, 1, '2026-07-23 05:25:00', '2026-07-23 19:43:40'),
(6, '4LSr9erYiGE', 'REDIM: Niñez y adolescencia indígena de Pajajté, en Chiapas, hablan sobre su derecho a la paz', '26 DE ENERO 2021', 'REDIM', 6, 1, '2026-07-23 05:25:00', '2026-07-23 19:43:41'),
(7, 'DLpPL2NwIHU', 'REDIM: ABRAZOS - Historias de niñas y niños con familiares privados de libertad / Cap. 4 - Visitas', '26 DE ENERO 2021', 'REDIM', 7, 1, '2026-07-23 05:25:00', '2026-07-23 19:43:55');

--
-- Índices para tablas volcadas
--

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
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `recursos_study_categories`
--
ALTER TABLE `recursos_study_categories`
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
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `miradas_contest_links`
--
ALTER TABLE `miradas_contest_links`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `miradas_works`
--
ALTER TABLE `miradas_works`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `recursos_downloads`
--
ALTER TABLE `recursos_downloads`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `recursos_studies`
--
ALTER TABLE `recursos_studies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `recursos_study_categories`
--
ALTER TABLE `recursos_study_categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tv_social_buttons`
--
ALTER TABLE `tv_social_buttons`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `tv_videos`
--
ALTER TABLE `tv_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT de la tabla `voces_podcasts`
--
ALTER TABLE `voces_podcasts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `voces_testimonials`
--
ALTER TABLE `voces_testimonials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `voces_videos`
--
ALTER TABLE `voces_videos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
