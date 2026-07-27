-- Corrige la vista "Historias": renombra path, label y view_key de 'historia' a 'historias'.
-- El view_key se migra en las 3 tablas a la vez para no perder el histórico del contador de visitas
-- (view_visit_daily y view_visit_log referencian view_key, no path).
-- Requiere que el frontend también actualice router/index.js -> meta.viewKey: 'historias'.

UPDATE `view_pages`
SET `view_key` = 'historias',
    `path` = '/historias',
    `label` = 'Historias'
WHERE `view_key` = 'historia';

UPDATE `view_visit_daily`
SET `view_key` = 'historias'
WHERE `view_key` = 'historia';

UPDATE `view_visit_log`
SET `view_key` = 'historias'
WHERE `view_key` = 'historia';
