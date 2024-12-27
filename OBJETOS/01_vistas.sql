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
WITH compras_totales AS (
    SELECT 
        sku,
        SUM(ctd_recibida) as total_comprado
    FROM compras
    GROUP BY sku
),
ventas_totales AS (
    SELECT 
        sku,
        SUM(cantidad_sku) as total_vendido
    FROM ventas
    GROUP BY sku
),
ajustes_totales AS (
    SELECT 
        sku,
        SUM(cantidad_ajustada) as total_ajustado
    FROM ajustes
    GROUP BY sku
)
SELECT 
    a.sku,
    a.nombre_producto,
    a.costo,
    p.nombre_proveedor,
    p.frecuencia_entrega,
    p.metodo_pago,
    ca.nombre_categoria,
    ca.nombre_subcategoria,
    (IFNULL(c.total_comprado, 0) - 
     IFNULL(v.total_vendido, 0) + 
     IFNULL(aj.total_ajustado, 0)) as stock
FROM articulos AS a
JOIN proveedor AS p ON a.id_proveedor = p.id_proveedor
JOIN categoria_articulo AS ca ON a.id_categoria_articulo = ca.id_categoria_articulo
LEFT JOIN compras_totales c ON a.sku = c.sku
LEFT JOIN ventas_totales v ON a.sku = v.sku
LEFT JOIN ajustes_totales aj ON a.sku = aj.sku;

-- VISTA vw_vencimientos
-- Vista que se genera para poder detectar productos proximos a vencer

USE supermercado;
DROP VIEW IF EXISTS vw_vencimientos;

CREATE VIEW vw_vencimientos AS
SELECT 
    a.sku,
    a.nombre_producto AS descripcion,
    c.vencimiento AS fecha_vencimiento,
    DATEDIFF(c.vencimiento, CURDATE()) AS dias_para_vencer
FROM articulos a
INNER JOIN compras c ON a.sku = c.sku
WHERE DATEDIFF(c.vencimiento, CURDATE()) <= 5
    AND DATEDIFF(c.vencimiento, CURDATE()) >= 0
ORDER BY c.vencimiento ASC;


-- VISTA vw_sin_movimiento
-- Vista que se genera ára poder detectar productos que no tienen ventas

USE supermercado;
DROP VIEW IF EXISTS vw_sin_movimiento;

CREATE VIEW vw_sin_movimiento AS
SELECT 
    a.sku,
    a.nombre_producto,
    p.nombre_proveedor,
    MAX(v.fecha) as ultima_venta
FROM articulos a
LEFT JOIN ventas v ON a.sku = v.sku
JOIN proveedor p ON a.id_proveedor = p.id_proveedor
GROUP BY a.sku, a.nombre_producto, p.nombre_proveedor
HAVING ultima_venta IS NULL OR ultima_venta < DATE_SUB(CURDATE(), INTERVAL 30 DAY);


-- VISTA vw_ventas_por_sucursal
-- Vista que desglosa el detalle de venta por sucursal

USE supermercado;
DROP VIEW IF EXISTS vw_ventas_por_sucursal;

CREATE VIEW vw_ventas_por_sucursal AS
SELECT 
    s.nombre_sucursal,
    s.ciudad,
    s.provincia,
    DATE_FORMAT(v.fecha, '%Y-%m') as mes_venta,
    COUNT(DISTINCT v.factura) as cantidad_ventas,
    SUM(v.cantidad_sku) as unidades_vendidas,
    SUM(v.cantidad_sku * a.costo) as costo_total,
    SUM(v.cantidad_sku * a.costo * (1 + a.iva)) as venta_total_con_iva,
    ca.nombre_categoria,
    ca.nombre_subcategoria,
    COUNT(DISTINCT v.id_clientes) as cantidad_clientes_unicos
FROM ventas v
JOIN sucursales s ON v.id_sucursal = s.id_sucursal
JOIN articulos a ON v.sku = a.sku
JOIN categoria_articulo ca ON a.id_categoria_articulo = ca.id_categoria_articulo
GROUP BY 
    s.nombre_sucursal,
    s.ciudad,
    s.provincia,
    DATE_FORMAT(v.fecha, '%Y-%m'),
    ca.nombre_categoria,
    ca.nombre_subcategoria
ORDER BY 
    s.nombre_sucursal,
    mes_venta DESC;