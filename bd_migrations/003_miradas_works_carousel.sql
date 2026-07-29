-- ============================================================
-- miradas_works: retira el contenido 'carousel' (reemplazado por
-- 'personajes' en el rediseño local) y siembra las 6 filas nuevas.
-- Las filas 'gallery' (ids 4-7) de producción NO se tocan: sus
-- imágenes son reales, mientras que en local esas mismas filas
-- fueron pisadas con URLs de prueba (picsum.photos) y no deben
-- copiarse a producción.
--
-- Ejecutar DESPUÉS de 001_migracion_esquema.sql y 002_datos_nuevas_tablas.sql.
-- ============================================================

START TRANSACTION;

-- Decisión confirmada: se eliminan definitivamente las 3 filas viejas de carousel
-- (ids 1,2,3: "Niñez Libre", "Libres de violencia", "Derechos humanos").
DELETE FROM `miradas_works` WHERE `id` IN (1, 2, 3);

-- Ya no quedan filas con section='carousel': se retira el valor del enum.
ALTER TABLE `miradas_works`
  MODIFY COLUMN `section` enum('personajes','gallery') NOT NULL DEFAULT 'gallery';

-- Se insertan las 6 filas nuevas de 'personajes' (rutas de imagen
-- normalizadas a forward-slash; sin id explícito para no chocar con
-- los ids existentes 4-7 de 'gallery').
INSERT INTO `miradas_works`
  (`section`, `title`, `author_name`, `age`, `image_url`, `sort_order`, `status`, `created_at`, `updated_at`) VALUES
('personajes', 'IDENTIDAD', 'La oportunidad de recuperar la identidad como persona.', 0, 'miradas/works/1826c2c068772b12933d4039bd1fb213.png', 1, 1, '2026-07-23 05:42:47', '2026-07-26 13:00:32'),
('personajes', 'ESPERANZA', 'La certeza de que una nueva oportunidad es posible, de que existe un camino hacia la libertad.', 0, 'miradas/works/172f56470cab6bf933b367ba537b319b.png', 2, 1, '2026-07-23 05:42:47', '2026-07-26 13:03:00'),
('personajes', 'AUTOESTIMA', 'El reconocimiento del propio valor y la confianza.', 0, 'miradas/works/2d6295d17ee396babbb2b8ab293cf811.png', 3, 1, '2026-07-23 05:42:47', '2026-07-26 13:02:40'),
('personajes', 'DIGNIDAD', 'Recuperar la autonomía y el ejercicio pleno de derechos.', 0, 'miradas/works/dab72c029c575187bb3b4b55d5376e79.png', 4, 1, '2026-07-26 13:03:50', '2026-07-26 13:03:50'),
('personajes', 'AMOR', 'La reconstrucción del bienestar a través del cuidado, la confianza y el acompañamiento de una red de apoyo que brinda seguridad y esperanza.', 0, 'miradas/works/42e9cd6b7dbe88b6fa21bd96892b9665.png', 5, 1, '2026-07-26 13:05:42', '2026-07-26 13:05:42'),
('personajes', 'CUIDADO', 'Protección y acompañamiento, a través de acciones concretas de atención, prevención y apoyo, garantizando entornos seguros y el respeto a los derechos', 0, 'miradas/works/8d98e70ef595698fe34aae95c2f5cc01.png', 6, 1, '2026-07-26 13:07:42', '2026-07-26 13:07:42');

COMMIT;
