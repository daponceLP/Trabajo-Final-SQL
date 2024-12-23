-- Creacion de datos mediante scrip

USE supermercado;
DROP PROCEDURE IF EXISTS generar_datos;

SET SQL_SAFE_UPDATES = 0;
DELIMITER //

CREATE PROCEDURE generar_datos()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE random_sku VARCHAR(10);
    
    -- Limpiar tablas existentes de manera segura
    DELETE FROM compras WHERE sku IS NOT NULL;
    DELETE FROM ventas WHERE factura > 0;
    DELETE FROM ajustes WHERE id_ajustes > 0;
    DELETE FROM articulos WHERE sku IS NOT NULL;
    DELETE FROM categoria_ajustes WHERE id_categoria_ajustes > 0;
    DELETE FROM clientes WHERE id_clientes > 0;
    DELETE FROM categoria_articulo WHERE id_categoria_articulo > 0;
    DELETE FROM proveedor WHERE id_proveedor > 0;
    
    -- Generar proveedores
    WHILE i <= 50 DO
        INSERT INTO proveedor (nombre_proveedor, frecuencia_entrega, metodo_pago)
        VALUES (
            CONCAT('Proveedor ', i),
            ELT(1 + FLOOR(RAND() * 4), 'Diaria', 'Semanal', 'Quincenal', 'Mensual'),
            ELT(1 + FLOOR(RAND() * 4), 'Efectivo', '30 dias', '60 dias', '90 dias')
        );
        SET i = i + 1;
    END WHILE;
    
    -- Generar categorías
    SET i = 1;
    WHILE i <= 50 DO
        INSERT INTO categoria_articulo (nombre_categoria, nombre_subcategoria)
        VALUES (
            ELT(1 + FLOOR(RAND() * 3), 'Mercaderia General', 'Alimentos', 'Frescos'),
            ELT(1 + FLOOR(RAND() * 11), 'Lacteos', 'Frutas y Verduras', 'Carnicos', 
                'Almacen', 'Limpieza', 'Perfumeria', 'Bebidas Alcoholicas', 
                'Gaseosas', 'Aguas', 'Aguas Saborizadas', 'Cervezas')
        );
        SET i = i + 1;
    END WHILE;

    -- Generar artículos
    SET i = 1;
    WHILE i <= 50 DO
        SET random_sku = CONCAT(
            SUBSTRING('ABCDEFGHIJKLMNOPQRSTUVWXYZ', FLOOR(1 + RAND() * 26), 1),
            LPAD(i, 4, '0')
        );
        
        INSERT INTO articulos (
            sku, 
            id_proveedor, 
            id_categoria_articulo, 
            ean, 
            nombre_producto, 
            costo, 
            iva, 
            stock
        )
        VALUES (
            random_sku,
            FLOOR(1 + RAND() * 50), -- ID proveedor aleatorio
            FLOOR(1 + RAND() * 50), -- ID categoría aleatorio
            CONCAT('779000', LPAD(i, 6, '0')),
            CONCAT('Producto ', i),
            ROUND(50 + RAND() * 950, 2), -- Costo entre 50 y 1000
            0.21,
            ROUND(10 + RAND() * 990, 2) -- Stock entre 10 y 1000
        );
        SET i = i + 1;
    END WHILE;

    -- Generar clientes
    SET i = 1;
    WHILE i <= 50 DO
        INSERT INTO clientes (nombre_cliente, domicilio, tipo_facturacion)
        VALUES (
            CONCAT('Cliente ', i),
            CONCAT('Calle ', i, ' ', FLOOR(RAND() * 5000)),
            ELT(1 + FLOOR(RAND() * 2), 'Consumidor Final', 'Factura A')
        );
        SET i = i + 1;
    END WHILE;

    -- Generar categorías de ajustes
    SET i = 1;
    WHILE i <= 50 DO
        INSERT INTO categoria_ajustes (categoria_ajuste)
        VALUES (
            ELT(1 + FLOOR(RAND() * 4), 'Dañado', 'Vencido', 'Error Inventario', 'Conteo Ciclico')
        );
        SET i = i + 1;
    END WHILE;

    -- Generar ajustes
    SET i = 1;
    WHILE i <= 50 DO
        INSERT INTO ajustes (
            id_categoria_ajustes, 
            fecha, 
            sku, 
            cantidad_ajustada
        )
        SELECT 
            FLOOR(1 + RAND() * 50),
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY),
            sku,
            FLOOR(-10 + RAND() * 21)
        FROM articulos
        ORDER BY RAND()
        LIMIT 1;
        SET i = i + 1;
    END WHILE;

    -- Generar ventas
    SET i = 1;
    WHILE i <= 50 DO
        INSERT INTO ventas (
            sku, 
            id_clientes, 
            cantidad_sku, 
            fecha
        )
        SELECT 
            sku,
            FLOOR(1 + RAND() * 50),
            FLOOR(1 + RAND() * 10),
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY)
        FROM articulos
        ORDER BY RAND()
        LIMIT 1;
        SET i = i + 1;
    END WHILE;

    -- Generar compras
    SET i = 1;
    WHILE i <= 50 DO
        INSERT INTO compras (
            fecha,
            sku,
            proveedor,
            ctd_pedida,
            ctd_recibida,
            vencimiento
        )
        SELECT 
            DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY),
            a.sku,
            a.id_proveedor,
            FLOOR(50 + RAND() * 151),
            FLOOR(50 + RAND() * 151),
            DATE_ADD(NOW(), INTERVAL FLOOR(RAND() * 365) DAY)
        FROM articulos a
        WHERE NOT EXISTS (
            SELECT 1 FROM compras c WHERE c.sku = a.sku
        )
        ORDER BY RAND()
        LIMIT 1;
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;

CALL generar_datos();
SET SQL_SAFE_UPDATES = 1;