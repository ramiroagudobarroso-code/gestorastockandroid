-- Esquema Gestora Stock para importar en la base seleccionada en Railway.
-- No crea ni elimina bases. No borra ni duplica registros existentes.
-- Los nombres de tabla coinciden exactamente con las consultas PHP.

CREATE TABLE IF NOT EXISTS Proveedor (
    id_proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Clientes (
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(150) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    telefono VARCHAR(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Producto (
    id_producto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150) NOT NULL,
    precio_compra DECIMAL(10,2) NOT NULL,
    precio_venta DECIMAL(10,2) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    id_proveedor INT NULL,
    CONSTRAINT fk_producto_proveedor
        FOREIGN KEY (id_proveedor)
        REFERENCES Proveedor (id_proveedor)
        ON DELETE SET NULL
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Pedido (
    id_pedido INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_cliente INT NOT NULL,
    total_pedido DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Clientes (id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS Producto_pedido (
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_producto),
    CONSTRAINT fk_pp_pedido
        FOREIGN KEY (id_pedido)
        REFERENCES Pedido (id_pedido)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_pp_producto
        FOREIGN KEY (id_producto)
        REFERENCES Producto (id_producto)
        ON DELETE RESTRICT
        ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_usuario VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    creado_en TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;