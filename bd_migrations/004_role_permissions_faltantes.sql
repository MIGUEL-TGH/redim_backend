-- ============================================================
-- role_permissions: filas faltantes en producción.
--
-- Comparación hecha por (role_id, module), no por id: las secuencias
-- de autoincremento divergieron entre local y producción, así que
-- módulos como voces/miradas/tv/recursos/cnsipee YA existen en
-- producción bajo otro id — no se reinsertan.
--
-- Faltan los permisos de los módulos agregados después: actuamos,
-- historias, ayuda, transparencia, state_descriptions e
-- indicator_category_details (rol 1 = read-write, rol 2 = read-only).
--
-- Se omite la columna `id` a propósito para que el AUTO_INCREMENT de
-- producción asigne el siguiente id disponible y no choque con ids
-- ya usados ahí.
-- ============================================================

START TRANSACTION;

INSERT INTO `role_permissions` (`role_id`, `module`, `permission_type`, `created_at`, `updated_at`) VALUES
(1, 'actuamos', 'read-write', '2026-07-24 07:10:42', '2026-07-24 07:10:42'),
(2, 'actuamos', 'read-only', '2026-07-24 07:10:42', '2026-07-24 07:10:42'),
(1, 'historias', 'read-write', '2026-07-29 04:50:38', '2026-07-29 04:50:38'),
(2, 'historias', 'read-only', '2026-07-29 04:50:38', '2026-07-29 04:50:38'),
(1, 'ayuda', 'read-write', '2026-07-29 05:16:30', '2026-07-29 05:16:30'),
(2, 'ayuda', 'read-only', '2026-07-29 05:16:30', '2026-07-29 05:16:30'),
(1, 'transparencia', 'read-write', '2026-07-29 06:07:29', '2026-07-29 06:07:29'),
(2, 'transparencia', 'read-only', '2026-07-29 06:07:29', '2026-07-29 06:07:29'),
(1, 'state_descriptions', 'read-write', '2026-07-29 07:13:25', '2026-07-29 07:13:25'),
(2, 'state_descriptions', 'read-only', '2026-07-29 07:13:25', '2026-07-29 07:13:25'),
(1, 'indicator_category_details', 'read-write', '2026-07-29 08:54:11', '2026-07-29 08:54:11'),
(2, 'indicator_category_details', 'read-only', '2026-07-29 08:54:11', '2026-07-29 08:54:11');

COMMIT;
