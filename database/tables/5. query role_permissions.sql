SELECT 
    u.id, 
    u.name, 
    u.email, 
    u.password, -- Necesario para que tu backend verifique el hash bcrypt/argon2
    r.name AS role_name,
    -- Agrupamos todos los permisos del rol en un arreglo JSON
    JSON_ARRAYAGG(
        JSON_OBJECT(
            'module', rp.module, 
            'permission', rp.permission_type
        )
    ) AS permissions
FROM users u
INNER JOIN roles r ON u.role_id = r.id
LEFT JOIN role_permissions rp ON r.id = rp.role_id
WHERE u.email = 'correo_del_usuario@ejemplo.com' -- O u.username, según como hagan login
GROUP BY u.id, r.name;