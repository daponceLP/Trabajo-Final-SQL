-- VISTA TOP 5 PRODUCTOS MAS VENDIDOS
-- Nos permite determinar cuales son los productos que mas se venden

USE supermercado;
DROP VIEW IF EXISTS vw_top_5_articulos_mas_vendidos;

CREATE VIEW vw_top_5_articulos_mas_vendidos AS
SELECT 
    a.sku,
    a.nombre_producto,
    SUM(v.cantidad_sku) AS cantidad_total_vendida
FROM 
    articulos AS a
JOIN 
    ventas AS v ON a.sku = v.sku
GROUP BY 
    a.sku, 
    a.nombre_producto
ORDER BY 
    cantidad_total_vendida DESC
LIMIT 5;


-- VISTA DE ARTICULOS
-- Nos permite ver la informacion mas relevante de los articulos que comercia el negocio.

USE supermercado;
DROP VIEW IF EXISTS vw_articulos;

CREATE VIEW vw_articulos AS
SELECT 
    a.sku,
    a.nombre_producto,
    a.costo,
    a.stock,
    p.nombre_proveedor,
    p.frecuencia_entrega,
    p.metodo_pago,
    ca.nombre_categoria,
    ca.nombre_subcategoria
FROM articulos AS a
JOIN proveedor AS p ON a.id_proveedor = p.id_proveedor
JOIN categoria_articulo AS ca ON a.id_categoria_articulo = ca.id_categoria_articulo
;

-- VISTA vw_vencimientos
-- Vista que se genera para poder detectar productos proximos a vencer

USE supermercado;
DROP VIEW IF EXISTS vw_vencimientos;

CREATE VIEW vw_vencimientos AS
SELECT 
    a.sku,
    a.nombre_producto AS descripcion,
    a.stock,
    c.vencimiento AS fecha_vencimiento,
    DATEDIFF(c.vencimiento, CURDATE()) AS dias_para_vencer
FROM articulos a
INNER JOIN compras c ON a.sku = c.sku
WHERE DATEDIFF(c.vencimiento, CURDATE()) <= 5
    AND DATEDIFF(c.vencimiento, CURDATE()) >= 0
ORDER BY c.vencimiento ASC;

SELECT * FROM vw_vencimientos;


--VISTA vw_sin_movimiento
-- Vista que se genera ára poder detectar productos que no tienen ventas

USE supermercado;
DROP VIEW IF EXISTS vw_sin_movimiento;

CREATE VIEW vw_sin_movimiento AS
SELECT 
    a.sku,
    a.nombre_producto,
    a.stock,
    p.nombre_proveedor,
    MAX(v.fecha) as ultima_venta
FROM articulos a
LEFT JOIN ventas v ON a.sku = v.sku
JOIN proveedor p ON a.id_proveedor = p.id_proveedor
GROUP BY a.sku, a.nombre_producto, a.stock, p.nombre_proveedor
HAVING ultima_venta IS NULL OR ultima_venta < DATE_SUB(CURDATE(), INTERVAL 30 DAY);