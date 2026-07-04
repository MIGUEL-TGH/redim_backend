-- Eliminamos la tabla si ya existe para evitar conflictos
DROP TABLE IF EXISTS role_permissions;

CREATE TABLE role_permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    module VARCHAR(50) NOT NULL, -- Cambiado a VARCHAR para mayor flexibilidad futura
    permission_type ENUM('read-only', 'read-write') NOT NULL, -- Mantenemos ENUM aquí porque son fijos
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Definición de la llave foránea
    CONSTRAINT fk_role_permissions_role 
        FOREIGN KEY (role_id) 
        REFERENCES roles(id) 
        ON DELETE CASCADE
);