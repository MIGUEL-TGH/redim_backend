-- Migración del contenido hoy hardcodeado en ActuamosView.vue hacia las 3 tablas
-- independientes de actuamos (ver content_modules.sql). Re-ejecutable: limpia
-- estas 3 tablas antes de volver a sembrar. NO afecta otras tablas.
--
-- Las imágenes referenciadas deben copiarse antes a:
--   redim_backend/multimedia/actuamos/acciones/
--   redim_backend/multimedia/actuamos/states/
--   redim_backend/multimedia/actuamos/internacional/
-- (mismos nombres de archivo que hoy existen en el frontend, en
-- vue2/src/assets/actuamos/), para que image_url resuelva correctamente.

TRUNCATE TABLE actuamos_acciones;
TRUNCATE TABLE actuamos_state_posts;
TRUNCATE TABLE actuamos_internacional;

-- ===================================  ACCIONES  ====================================================

INSERT INTO actuamos_acciones (platform, image_url, title, date_label, url, sort_order) VALUES
('instagram', 'actuamos/acciones/ig-C8OFuiTupDr.png', 'Invitación a la presentación del proyecto “Niñez Primero”', '14 de junio de 2024', 'https://www.instagram.com/p/C8OFuiTupDr/', 1),
('youtube',   'actuamos/acciones/yt-IaDpcTjEiz0.jpg', 'Presentación del proyecto de incidencia y atención de la trata y reclutamiento', '11 de abril de 2025', 'https://www.youtube.com/watch?v=IaDpcTjEiz0', 2),
('youtube',   'actuamos/acciones/yt-NtevbAO69lU.jpg', 'Presentan proyecto para impulsar la erradicación de la trata y el reclutamiento de infancias', '27 de junio de 2024', 'https://www.youtube.com/watch?v=NtevbAO69lU', 3),
('instagram', 'actuamos/acciones/ig-DHo4bpJSxE6.png', 'Invitación a la presentación de la Agenda de Trabajo del proyecto', '25 de marzo de 2025', 'https://www.instagram.com/p/DHo4bpJSxE6/', 4),
('instagram', 'actuamos/acciones/ig-DHdyNRgsqf4.png', 'Presentación de la Agenda de Trabajo del proyecto', '21 de marzo de 2025', 'https://www.instagram.com/p/DHdyNRgsqf4/', 5),
('instagram', 'actuamos/acciones/ig-DHtMeg6ujpM.png', 'Recordatorio: presentación de la Agenda de Trabajo del proyecto', '27 de marzo de 2025', 'https://www.instagram.com/p/DHtMeg6ujpM/', 6),
('facebook',  NULL, 'Publicación de REDIM en Facebook', '2 de abril de 2026', 'https://www.facebook.com/derechosinfancia.org.mx/posts/pfbid0gPVQAkBNsP9oresMcruCy3NLAD6AFKmZVNokV1K7RQBCgtZcKRMLQ3zhZ5EAAqWCl?rdid=YiZn2pUnHFPcbw2f', 7),
('instagram', 'actuamos/acciones/ig-DQxnMODDMi8.png', '¿Sabías que…? Trata y reclutamiento en la CDMX y su zona metropolitana', '7 de noviembre de 2025', 'https://www.instagram.com/p/DQxnMODDMi8/?img_index=1', 8);

-- ===================================  MAPA: VERACRUZ  ==============================================

INSERT INTO actuamos_state_posts (state, platform, image_url, title, url, sort_order) VALUES
('veracruz', 'instagram', 'actuamos/states/ig-DPDD-A4DKuR.png', '5 claves para entender la trata y el reclutamiento en Veracruz', 'https://www.instagram.com/p/DPDD-A4DKuR/?img_index=1', 1),
('veracruz', 'instagram', 'actuamos/states/ig-DO9VgCTEpsT.png', 'Invitación al Ciclo de Actividades – Proyecto Niñez Primero', 'https://www.instagram.com/p/DO9VgCTEpsT/', 2),
('veracruz', 'instagram', 'actuamos/states/ig-DMyPBjZuMIq.png', 'El reclutamiento de niñas, niños y adolescentes por grupos delictivos', 'https://www.instagram.com/p/DMyPBjZuMIq/?img_index=1', 3),
('veracruz', 'youtube',   'actuamos/states/yt-T3SSffDq1W8.jpg', 'Presentación de la #InfanciaCuenta Veracruz', 'https://www.youtube.com/watch?v=T3SSffDq1W8', 4);

-- ===================================  MAPA: CIUDAD DE MÉXICO  =======================================

INSERT INTO actuamos_state_posts (state, platform, image_url, title, url, sort_order) VALUES
('cdmx', 'instagram', 'actuamos/states/ig-DQ5VGH3jN13.png', 'REDIM y CAM, con apoyo de la UE, presentaron el proyecto en la CDMX', 'https://www.instagram.com/p/DQ5VGH3jN13/?img_index=1', 1),
('cdmx', 'instagram', 'actuamos/states/ig-DQxnMODDMi8.png', '¿Sabías que…? Trata y reclutamiento en la CDMX y su zona metropolitana', 'https://www.instagram.com/p/DQxnMODDMi8/?img_index=1', 2),
('cdmx', 'instagram', 'actuamos/states/ig-DQpNy2fESOZ.png', 'Te invitamos al foro sobre trata y reclutamiento', 'https://www.instagram.com/p/DQpNy2fESOZ/', 3);

-- ===================================  MAPA: MICHOACÁN  ==============================================

INSERT INTO actuamos_state_posts (state, platform, image_url, title, url, sort_order) VALUES
('michoacan', 'instagram', 'actuamos/states/ig-DU1MNs4kq8b.png', '¡Aparta la fecha! Ciclo de actividades del proyecto', 'https://www.instagram.com/p/DU1MNs4kq8b/', 1),
('michoacan', 'instagram', 'actuamos/states/ig-DVHTP6WkqQ2.png', 'Aviso importante derivado del contexto actual de violencia', 'https://www.instagram.com/p/DVHTP6WkqQ2/', 2),
('michoacan', 'instagram', 'actuamos/states/ig-DVwNXvZEemr.png', 'En el marco del proyecto “Niñez Primero: Incidencia”', 'https://www.instagram.com/p/DVwNXvZEemr/', 3),
('michoacan', 'instagram', 'actuamos/states/ig-DWC-wfqDNdp.png', 'Te invitamos al foro “Niñez Primero: trata y reclutamiento”', 'https://www.instagram.com/p/DWC-wfqDNdp/', 4),
('michoacan', 'facebook',  NULL, 'Video de REDIM en Facebook', 'https://www.facebook.com/share/v/1BWvu42Ytj/', 5),
('michoacan', 'instagram', 'actuamos/states/ig-DWnPXnaDAB8.jpg', '#AsíSeVivió (II parte): detrás de cada espacio de diálogo', 'https://www.instagram.com/p/DWnPXnaDAB8/?img_index=7', 6),
('michoacan', 'tiktok',    'actuamos/states/tk-7624031342040321298.jpg', 'Reflexiones y análisis de organizaciones de la sociedad civil', 'https://www.tiktok.com/@derechoinfancia_redim/video/7624031342040321298', 7),
('michoacan', 'instagram', 'actuamos/states/ig-DWnEzWdDHCD.jpg', '#Entérate: REDIM, junto a CAM y con apoyo de la UE', 'https://www.instagram.com/p/DWnEzWdDHCD/?img_index=1', 8),
('michoacan', 'instagram', 'actuamos/states/ig-DWnoQaXDW1Y.png', 'El reclutamiento y la trata de niñas, niños y adolescentes', 'https://www.instagram.com/p/DWnoQaXDW1Y/?img_index=1', 9),
('michoacan', 'linkedin',  'actuamos/states/li-8776187904.jpg', '#NiñezPrimero #DerechosDeLaInfancia — publicación de REDIM', 'https://www.linkedin.com/posts/red-por-los-derechos-de-la-infancia-en-m%C3%A9xico-redim-_niaehezprimero-derechosdelainfancia-veracruz-share-7376355008776187904-XyZu/?utm_source=share&utm_medium=member_desktop&rcm=ACoAADdSyBQBSASRjhFrAkDD-FgByPeJ1ydWRYQ', 10);

-- ===================================  INCIDENCIA INTERNACIONAL  ====================================

INSERT INTO actuamos_internacional (platform, image_url, title, url, sort_order) VALUES
('youtube', 'actuamos/internacional/yt-9vpMKbnY0tQ.jpg', 'REDIM en audiencia sobre reclutamiento ante la CIDH | 194º Periodo de Sesiones', 'https://www.youtube.com/watch?v=9vpMKbnY0tQ', 1),
('youtube', 'actuamos/internacional/yt-ivVikr3nqTM.jpg', 'Grupo de Participación REDIM cuenta su experiencia en el Comité de los Derechos del Niño', 'https://www.youtube.com/watch?v=ivVikr3nqTM', 2),
('youtube', 'actuamos/internacional/yt-ZIUMhw7P6f4.jpg', 'REDIM ante el Foro Político de Alto Nivel para el Desarrollo Sostenible 2024', 'https://www.youtube.com/watch?v=ZIUMhw7P6f4', 3);
