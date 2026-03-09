-- Orden de insercion de datos
-- 1. roles
INSERT INTO roles (name, description) VALUES 
('Administrador', 'Control total sobre todos los módulos del sistema'),
('Consultor', 'Acceso exclusivo de lectura para análisis y reportes');

-- 2. role_permissions
-- Asignar permisos al Administrador (role_id = 1) - Acceso read-write
INSERT INTO role_permissions (role_id, module, permission_type) VALUES 
(1, 'indicators', 'read-write'),
(1, 'indicator_categories', 'read-write'),
(1, 'centers', 'read-write'),
(1, 'states', 'read-write'),
(1, 'countries', 'read-write'),
(1, 'genders', 'read-write'),
(1, 'years', 'read-write');

-- Asignar permisos al Consultor (role_id = 2) - Acceso read-only
INSERT INTO role_permissions (role_id, module, permission_type) VALUES 
(2, 'indicators', 'read-only'),
(2, 'indicator_categories', 'read-only'),
(2, 'centers', 'read-only'),
(2, 'states', 'read-only');
-- Nota: Al consultor no le dimos acceso a countries, genders ni years. 
-- El dashboard debería ocultar estos módulos completamente para este rol.




-- --------------------------------------------------------------------------------------------------------------

-- user:admin   password: MiPasswordSeguro123
-- user:fer2026   password: MiSeguro123

-- Asignar permisos de usuarios
-- Convertir al usuario con ID 1 en Administrador
UPDATE users 
SET role_id = 1 
WHERE id = 1;

-- Convertir al usuario con ID 2 en Consultor
UPDATE users 
SET role_id = 2 
WHERE id = 2;