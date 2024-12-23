--Procedimiento para agregar nuevos proveedores al sistema.

USE supermercado;
DROP STORED PROCEDURE IF EXISTS agregar_proveedor

DELIMITER //
CREATE PROCEDURE agregar_proveedor(
    IN p_nombre_proveedor VARCHAR(200),
    IN p_frecuencia_entrega VARCHAR(200),
    IN p_metodo_pago ENUM('Efectivo', '30 dias', '60 dias', '90 dias')
)
BEGIN
    INSERT INTO proveedor (nombre_proveedor, frecuencia_entrega, metodo_pago)
    VALUES (p_nombre_proveedor, p_frecuencia_entrega, p_metodo_pago);
    
    SELECT LAST_INSERT_ID() AS new_proveedor_id;
END //
DELIMITER ;

--Procedimiento para generar reporte de ventas en una fecha determinada

USE supermercado;
DROP STORED PROCEDURE IF EXISTS agregar_proveedor

DELIMITER //
CREATE PROCEDURE ventas_por_fecha(
    IN p_fecha_inicio DATETIME,
    IN p_fecha_fin DATETIME
)
BEGIN
    SELECT 
        v.fecha, 
        a.nombre_producto, 
        v.cantidad_sku, 
        a.costo * v.cantidad_sku AS costo_total,
        c.nombre_cliente,
        c.tipo_facturacion
    FROM ventas AS v
    JOIN articulos AS a ON v.sku = a.sku
    JOIN clientes AS c ON v.id_clientes = c.id_clientes
    WHERE v.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
    ORDER BY v.fecha;
END //
