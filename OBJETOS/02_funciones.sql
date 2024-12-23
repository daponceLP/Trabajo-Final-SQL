-- FUNCION PARA DETERMINAR CUANTOS ARTICULOS TENGO CON STOCK POR CATEGORIA

USE supermercado;
DROP FUNCTION IF EXISTS contar_articulos_con_stock_por_subcategoria;

DELIMITER //
CREATE FUNCTION contar_articulos_con_stock_por_subcategoria(
    p_nombre_subcategoria VARCHAR(200)
) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_articulos_con_stock INT;
    
    SELECT COUNT(*) INTO total_articulos_con_stock
    FROM articulos a
    JOIN categoria_articulo ca ON a.id_categoria_articulo = ca.id_categoria_articulo
    WHERE ca.nombre_subcategoria = p_nombre_subcategoria
      AND a.stock > 0;
    
    RETURN total_articulos_con_stock;
END //

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
