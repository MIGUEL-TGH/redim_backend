-- Nueva tabla para la sección "Carrusel gallery" (la primera de ActuamosView.vue),
-- migrando el array hardcodeado `galleryItems` — mismo patrón que
-- actuamos_acciones / actuamos_state_posts / actuamos_internacional
-- (ver database/tables/content_modules.sql y database/tables/actuamos_seed.sql).
--
-- Las imágenes deben copiarse antes a:
--   redim_backend/multimedia/actuamos/gallery/
-- (mismos nombres de archivo que hoy existen en el frontend, en
-- vue2/src/assets/actuamos/), para que image_url resuelva correctamente.

CREATE TABLE IF NOT EXISTS actuamos_gallery (
  id          INT AUTO_INCREMENT PRIMARY KEY,
  platform    ENUM('instagram','youtube','facebook','tiktok','linkedin') NOT NULL,
  image_url   VARCHAR(255) DEFAULT NULL,
  title       VARCHAR(300) NOT NULL,
  date_label  VARCHAR(100) DEFAULT NULL,
  url         VARCHAR(500) NOT NULL,
  sort_order  INT NOT NULL DEFAULT 0,
  status      TINYINT(1) NOT NULL DEFAULT 1,
  created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

TRUNCATE TABLE actuamos_gallery;

INSERT INTO actuamos_gallery (platform, image_url, title, date_label, url, sort_order) VALUES
('instagram', 'actuamos/gallery/ig-DPDD-A4DKuR.png', '5 claves para entender la trata y el reclutamiento en Veracruz', '15 de marzo de 2023', 'https://www.instagram.com/p/DPDD-A4DKuR/?img_index=1', 1),
('instagram', 'actuamos/gallery/ig-DO9VgCTEpsT.png', 'Invitación al Ciclo de Actividades – Proyecto Niñez Primero', '15 de marzo de 2023', 'https://www.instagram.com/p/DO9VgCTEpsT/', 2),
('instagram', 'actuamos/gallery/ig-DMyPBjZuMIq.png', 'El reclutamiento de niñas, niños y adolescentes por grupos delictivos', '15 de marzo de 2023', 'https://www.instagram.com/p/DMyPBjZuMIq/?img_index=1', 3),
('youtube',   'actuamos/gallery/yt-T3SSffDq1W8.jpg', 'Presentación de la #InfanciaCuenta Veracruz', '15 de marzo de 2023', 'https://www.youtube.com/watch?v=T3SSffDq1W8', 4),
('instagram', 'actuamos/gallery/ig-DQ5VGH3jN13.png', 'REDIM y CAM, con apoyo de la UE, presentaron el proyecto en la CDMX', '15 de marzo de 2023', 'https://www.instagram.com/p/DQ5VGH3jN13/?img_index=1', 5),
('instagram', 'actuamos/gallery/ig-DQxnMODDMi8.png', '¿Sabías que…? Trata y reclutamiento en la CDMX y su zona metropolitana', '15 de marzo de 2023', 'https://www.instagram.com/p/DQxnMODDMi8/?img_index=1', 6),
('instagram', 'actuamos/gallery/ig-DQpNy2fESOZ.png', 'Te invitamos al foro sobre trata y reclutamiento', '15 de marzo de 2023', 'https://www.instagram.com/p/DQpNy2fESOZ/', 7),
('instagram', 'actuamos/gallery/ig-DU1MNs4kq8b.png', '¡Aparta la fecha! Ciclo de actividades del proyecto', '15 de marzo de 2023', 'https://www.instagram.com/p/DU1MNs4kq8b/', 8),
('instagram', 'actuamos/gallery/ig-DVHTP6WkqQ2.png', 'Aviso importante derivado del contexto actual de violencia', '15 de marzo de 2023', 'https://www.instagram.com/p/DVHTP6WkqQ2/', 9),
('instagram', 'actuamos/gallery/ig-DVwNXvZEemr.png', 'En el marco del proyecto "Niñez Primero: Incidencia"', '15 de marzo de 2023', 'https://www.instagram.com/p/DVwNXvZEemr/', 10),
('instagram', 'actuamos/gallery/ig-DWC-wfqDNdp.png', 'Te invitamos al foro "Niñez Primero: trata y reclutamiento"', '15 de marzo de 2023', 'https://www.instagram.com/p/DWC-wfqDNdp/', 11),
('facebook',  NULL, 'Video de REDIM en Facebook', '15 de marzo de 2023', 'https://www.facebook.com/share/v/1BWvu42Ytj/', 12),
('instagram', 'actuamos/gallery/ig-DWnPXnaDAB8.jpg', '#AsíSeVivió (II parte): detrás de cada espacio de diálogo', '15 de marzo de 2023', 'https://www.instagram.com/p/DWnPXnaDAB8/?img_index=7', 13),
('tiktok',    'actuamos/gallery/tk-7624031342040321298.jpg', 'Reflexiones y análisis de organizaciones de la sociedad civil', '15 de marzo de 2023', 'https://www.tiktok.com/@derechoinfancia_redim/video/7624031342040321298', 14),
('instagram', 'actuamos/gallery/ig-DWnEzWdDHCD.jpg', '#Entérate: REDIM, junto a CAM y con apoyo de la UE', '15 de marzo de 2023', 'https://www.instagram.com/p/DWnEzWdDHCD/?img_index=1', 15),
('instagram', 'actuamos/gallery/ig-DWnoQaXDW1Y.png', 'El reclutamiento y la trata de niñas, niños y adolescentes', '15 de marzo de 2023', 'https://www.instagram.com/p/DWnoQaXDW1Y/?img_index=1', 16),
('linkedin',  'actuamos/gallery/li-8776187904.jpg', '#NiñezPrimero #DerechosDeLaInfancia — publicación de REDIM', '15 de marzo de 2023', 'https://www.linkedin.com/posts/red-por-los-derechos-de-la-infancia-en-m%C3%A9xico-redim-_niaehezprimero-derechosdelainfancia-veracruz-share-7376355008776187904-XyZu/?utm_source=share&utm_medium=member_desktop&rcm=ACoAADdSyBQBSASRjhFrAkDD-FgByPeJ1ydWRYQ', 17);
