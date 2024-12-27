-- Función para calcular días de stock basado en ventas promedio
USE supermercado;
DROP FUNCTION IF EXISTS fn_dias_stock;

DELIMITER //
CREATE FUNCTION fn_dias_stock(
    p_sku VARCHAR(10)
) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE stock_actual INT;
    DECLARE venta_diaria_promedio DECIMAL(10,2);
    DECLARE dias INT;
    
    -- Obtener stock actual
    SET stock_actual = fn_stock_actual(p_sku);
    
    -- Calcular venta diaria promedio de los últimos 30 días
    SELECT IFNULL(AVG(cantidad_sku), 0)
    INTO venta_diaria_promedio
    FROM ventas
    WHERE sku = p_sku
    AND fecha >= DATE_SUB(CURRENT_DATE, INTERVAL 30 DAY);
    
    -- Si no hay ventas, retornar 999 días
    IF venta_diaria_promedio = 0 THEN
        RETURN 999;
    END IF;
    
    SET dias = FLOOR(stock_actual / venta_diaria_promedio);
    
    RETURN dias;
END //
DELIMITER ;

-- FUNCION PARA DETERMINAR 

USE supermercado;
DROP FUNCTION IF EXISTS categoria_mas_ajustes;

DELIMITER //
CREATE FUNCTION categoria_mas_ajustes()
RETURNS VARCHAR(200)
DETERMINISTIC
BEGIN
    DECLARE categoria_nombre VARCHAR(200);
    
    SELECT ca.categoria_ajuste INTO categoria_nombre
    FROM (
        SELECT id_categoria_ajustes, COUNT(*) as total_ajustes
        FROM ajustes
        GROUP BY id_categoria_ajustes
        ORDER BY total_ajustes DESC
        LIMIT 1
    ) max_ajustes
    JOIN categoria_ajustes ca ON max_ajustes.id_categoria_ajustes = ca.id_categoria_ajustes;
    
    RETURN categoria_nombre;
END //

-- Función para calcular el total de ventas de un producto en un período
USE supermercado;
DROP FUNCTION IF EXISTS fn_total_ventas_producto;

DELIMITER //
CREATE FUNCTION fn_total_ventas_producto(
    p_sku VARCHAR(10),
    p_fecha_inicio DATETIME,
    p_fecha_fin DATETIME
) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);
    
    SELECT SUM(v.cantidad_sku * a.costo * (1 + a.iva))
    INTO total
    FROM ventas v
    JOIN articulos a ON v.sku = a.sku
    WHERE v.sku = p_sku
    AND v.fecha BETWEEN p_fecha_inicio AND p_fecha_fin;
    
    RETURN IFNULL(total, 0);
END //
DELIMITER ;
