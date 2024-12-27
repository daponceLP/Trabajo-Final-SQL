-- Creacion de datos mediante scrip

USE supermercado;

-- Insertar datos en la tabla `sucursales`
INSERT INTO sucursales (nombre_sucursal, direccion, telefono, ciudad, provincia, codigo_postal, fecha_apertura)
VALUES 
('Sucursal Central', 'Calle Falsa 123', '123456789', 'Ciudad Central', 'Provincia A', '1234', '2022-01-01'),
('Sucursal Norte', 'Calle Norte 456', '987654321', 'Ciudad Norte', 'Provincia B', '5678', '2021-05-20'),
('Sucursal Sur', 'Calle Sur 789', '112233445', 'Ciudad Sur', 'Provincia C', '91011', '2020-08-15');

-- Insertar datos en la tabla `proveedor`
INSERT INTO proveedor (nombre_proveedor, frecuencia_entrega, metodo_pago)
VALUES 
('Proveedor A', 'Semanal', 'Efectivo'),
('Proveedor B', 'Mensual', '30 dias'),
('Proveedor C', 'Quincenal', '60 dias');

-- Insertar datos en la tabla `categoria_articulo`
INSERT INTO categoria_articulo (nombre_categoria, nombre_subcategoria)
VALUES
('Mercaderia General', 'Lacteos'),
('Alimentos', 'Frutas y Verduras'),
('Frescos', 'Carnicos');

-- Insertar datos en la tabla `articulos`
INSERT INTO articulos (sku, id_proveedor, id_categoria_articulo, ean, nombre_producto, costo, iva)
VALUES
('SKU001', 1, 1, '1234567890123', 'Leche Entera', 15.50, 0.21),
('SKU002', 2, 2, '2345678901234', 'Manzanas', 5.25, 0.18),
('SKU003', 3, 3, '3456789012345', 'Carne de Res', 45.30, 0.22);

-- Insertar datos en la tabla `clientes`
INSERT INTO clientes (nombre_cliente, domicilio, tipo_facturacion)
VALUES 
('Cliente A', 'Direccion A', 'Consumidor Final'),
('Cliente B', 'Direccion B', 'Factura A'),
('Cliente C', 'Direccion C', 'Consumidor Final');

-- Insertar datos en la tabla `categoria_ajustes`
INSERT INTO categoria_ajustes (categoria_ajuste)
VALUES 
('Dañado'),
('Vencido'),
('Error Inventario');

-- Insertar datos en la tabla `ajustes`
INSERT INTO ajustes (id_sucursal, id_categoria_ajustes, fecha, sku, cantidad_ajustada)
VALUES 
(1, 1, '2022-01-15 10:30:00', 'SKU001', -5),
(2, 2, '2022-02-10 12:00:00', 'SKU002', -3),
(3, 3, '2022-03-20 14:15:00', 'SKU003', -2);

-- Insertar datos en la tabla `ventas`
INSERT INTO ventas (id_sucursal, sku, id_clientes, cantidad_sku, fecha)
VALUES
(1, 'SKU001', 1, 10, '2022-01-20 09:00:00'),
(2, 'SKU002', 2, 5, '2022-02-25 11:30:00'),
(3, 'SKU003', 3, 2, '2022-03-18 15:00:00');

-- Insertar datos en la tabla `compras`
INSERT INTO compras (id_sucursal, fecha, sku, proveedor, ctd_pedida, ctd_recibida, vencimiento)
VALUES 
(1, '2022-01-10 08:00:00', 'SKU001', 1, 50, 45, '2022-02-10'),
(2, '2022-02-12 10:00:00', 'SKU002', 2, 30, 30, '2022-03-12'),
(3, '2022-03-05 14:30:00', 'SKU003', 3, 20, 20, '2022-04-05');

-- Insertar datos en la tabla `devoluciones`
INSERT INTO devoluciones (factura, id_sucursal, sku, cantidad, fecha, motivo_devolucion)
VALUES
(1, 1, 'SKU001', 2, '2022-01-25 09:30:00', 'Producto Dañado'),
(2, 2, 'SKU002', 1, '2022-02-28 13:45:00', 'Producto Vencido'),
(3, 3, 'SKU003', 1, '2022-03-22 16:00:00', 'Error en Inventario');

-- Insertar datos en la tabla `ordenes_compra`
INSERT INTO ordenes_compra (id_sucursal, id_proveedor, sku, cantidad_pedida, estado)
VALUES
(1, 1, 'SKU001', 100, 'Pendiente'),
(2, 2, 'SKU002', 50, 'Enviado'),
(3, 3, 'SKU003', 30, 'Recibido');


-- Datos generados desde la pagina claude.ai
USE supermercado;

-- Inserción de sucursales
INSERT INTO sucursales (nombre_sucursal, direccion, telefono, ciudad, provincia, codigo_postal, fecha_apertura) VALUES
('Sucursal Centro', 'Av. Rivadavia 1234', '11-4567-8901', 'Buenos Aires', 'Buenos Aires', '1001', '2020-01-15'),
('Sucursal Norte', 'Av. Libertador 5678', '11-2345-6789', 'San Isidro', 'Buenos Aires', '1642', '2020-03-20'),
('Sucursal Sur', 'Av. Mitre 910', '11-3456-7890', 'Avellaneda', 'Buenos Aires', '1870', '2020-06-10'),
('Sucursal Oeste', 'Av. Rivadavia 15000', '11-7890-1234', 'Morón', 'Buenos Aires', '1708', '2021-02-05'),
('Sucursal Este', 'Calle 7 1234', '221-567-8901', 'La Plata', 'Buenos Aires', '1900', '2021-05-15');

-- Inserción de categoría_ajustes
INSERT INTO categoria_ajustes (categoria_ajuste) VALUES
('Dañado'),
('Vencido'),
('Error Inventario'),
('Conteo Ciclico');

-- Inserción de categoria_articulo
INSERT INTO categoria_articulo (nombre_categoria, nombre_subcategoria) VALUES
('Frescos', 'Lacteos'),
('Frescos', 'Frutas y Verduras'),
('Frescos', 'Carnicos'),
('Mercaderia General', 'Almacen'),
('Mercaderia General', 'Limpieza'),
('Mercaderia General', 'Perfumeria'),
('Alimentos', 'Bebidas Alcoholicas'),
('Alimentos', 'Gaseosas'),
('Alimentos', 'Aguas'),
('Alimentos', 'Aguas Saborizadas'),
('Alimentos', 'Cervezas');

INSERT INTO proveedor (nombre_proveedor, frecuencia_entrega, metodo_pago) VALUES
('Lacteos La Serenísima', 'Semanal', 'Efectivo'),
('Granja El Amanecer', 'Diaria', '30 dias'),
('Carnes Premium', 'Semanal', '60 dias'),
('Limpieza Total', 'Quincenal', '30 dias'),
('Perfumes Paris', 'Mensual', '90 dias'),
('Bebidas del Sur', 'Semanal', '60 dias'),
('Distribuidora Express', 'Diaria', 'Efectivo'),
('Almacén Mayorista', 'Semanal', '30 dias'),
('Importadora Global', 'Mensual', '90 dias'),
('Productos del Campo', 'Semanal', '30 dias');


-- Inserción de artículos
INSERT INTO articulos (sku, id_proveedor, id_categoria_articulo, ean, nombre_producto, costo, iva) VALUES
('SKU001', 1, 1, '7790001000001', 'Leche Entera 1L', 85.50, 0.21),
('SKU002', 1, 1, '7790001000002', 'Yogur Natural 500g', 65.75, 0.21),
('SKU003', 2, 2, '7790002000001', 'Manzanas x Kg', 120.00, 0.21),
('SKU004', 3, 3, '7790003000001', 'Carne Molida x Kg', 950.00, 0.21),
('SKU005', 4, 5, '7790004000001', 'Detergente 1L', 180.25, 0.21),
('SKU006', 5, 6, '7790005000001', 'Shampoo 750ml', 450.80, 0.21),
('SKU007', 6, 7, '7790006000001', 'Vino Tinto 750ml', 850.00, 0.21),
('SKU008', 6, 8, '7790006000002', 'Coca Cola 2.25L', 320.50, 0.21),
('SKU009', 6, 9, '7790006000003', 'Agua Mineral 2L', 150.75, 0.21),
('SKU010', 6, 11, '7790006000004', 'Cerveza Rubia 1L', 280.90, 0.21);


-- Inserción de clientes
INSERT INTO clientes (nombre_cliente, domicilio, tipo_facturacion) VALUES
('Juan Pérez', 'Av. Corrientes 1234', 'Consumidor Final'),
('María González', 'Calle Florida 567', 'Consumidor Final'),
('Comercial SA', 'Lavalle 789', 'Factura A'),
('Carlos López', 'Callao 234', 'Consumidor Final'),
('Distribuidora XYZ', 'Córdoba 567', 'Factura A'),
('Ana Martínez', 'Santa Fe 890', 'Consumidor Final'),
('Pedro Rodríguez', 'Entre Ríos 123', 'Consumidor Final'),
('Mayorista ABC', 'Belgrano 456', 'Factura A'),
('Laura Sánchez', 'Tucumán 789', 'Consumidor Final'),
('Roberto García', 'Maipú 012', 'Consumidor Final');

-- Inserción de ajustes
INSERT INTO ajustes (id_sucursal, id_categoria_ajustes, fecha, sku, cantidad_ajustada) VALUES
(1, 1, '2024-01-15 10:00:00', 'SKU001', -5),
(1, 2, '2024-01-15 11:00:00', 'SKU002', -3),
(2, 3, '2024-01-15 12:00:00', 'SKU003', 10),
(2, 4, '2024-01-15 13:00:00', 'SKU004', -2),
(3, 1, '2024-01-15 14:00:00', 'SKU005', -1),
(3, 2, '2024-01-15 15:00:00', 'SKU006', -4),
(4, 3, '2024-01-15 16:00:00', 'SKU007', 8),
(4, 4, '2024-01-15 17:00:00', 'SKU008', -6),
(5, 1, '2024-01-15 18:00:00', 'SKU009', -3),
(5, 2, '2024-01-15 19:00:00', 'SKU010', -2);

-- Inserción de compras
INSERT INTO compras (id_sucursal, fecha, sku, proveedor, ctd_pedida, ctd_recibida, vencimiento) VALUES
(1, '2024-01-01 08:00:00', 'SKU001', 1, 100, 100, '2024-02-01'),
(1, '2024-01-01 09:00:00', 'SKU002', 1, 50, 48, '2024-02-15'),
(2, '2024-01-02 08:00:00', 'SKU003', 2, 200, 195, '2024-01-10'),
(2, '2024-01-02 09:00:00', 'SKU004', 3, 150, 150, '2024-01-20'),
(3, '2024-01-03 08:00:00', 'SKU005', 4, 80, 80, '2024-12-31'),
(3, '2024-01-03 09:00:00', 'SKU006', 5, 60, 58, '2024-12-31'),
(4, '2024-01-04 08:00:00', 'SKU007', 6, 40, 40, '2025-01-01'),
(4, '2024-01-04 09:00:00', 'SKU008', 6, 120, 120, '2024-06-30'),
(5, '2024-01-05 08:00:00', 'SKU009', 6, 90, 90, '2024-12-31'),
(5, '2024-01-05 09:00:00', 'SKU010', 6, 70, 68, '2024-12-31');

-- Inserción de órdenes de compra
INSERT INTO ordenes_compra (fecha, id_sucursal, id_proveedor, sku, cantidad_pedida, estado) VALUES
('2024-01-01 08:00:00', 1, 1, 'SKU001', 100, 'Recibido'),
('2024-01-01 09:00:00', 1, 1, 'SKU002', 50, 'Recibido'),
('2024-01-02 08:00:00', 2, 2, 'SKU003', 200, 'Recibido'),
('2024-01-02 09:00:00', 2, 3, 'SKU004', 150, 'Recibido'),
('2024-01-03 08:00:00', 3, 4, 'SKU005', 80, 'Recibido'),
('2024-01-03 09:00:00', 3, 5, 'SKU006', 60, 'Recibido'),
('2024-01-04 08:00:00', 4, 6, 'SKU007', 40, 'Recibido'),
('2024-01-04 09:00:00', 4, 6, 'SKU008', 120, 'Enviado'),
('2024-01-05 08:00:00', 5, 6, 'SKU009', 90, 'Pendiente'),
('2024-01-05 09:00:00', 5, 6, 'SKU010', 70, 'Pendiente');

-- Inserción de ventas
INSERT INTO ventas (id_sucursal, sku, id_clientes, cantidad_sku, fecha) VALUES
(1, 'SKU001', 1, 2, '2024-01-15 10:00:00'),
(1, 'SKU002', 2, 1, '2024-01-15 10:30:00'),
(2, 'SKU003', 3, 3, '2024-01-15 11:00:00'),
(2, 'SKU004', 4, 1, '2024-01-15 11:30:00'),
(3, 'SKU005', 5, 2, '2024-01-15 12:00:00'),
(3, 'SKU006', 6, 1, '2024-01-15 12:30:00'),
(4, 'SKU007', 7, 4, '2024-01-15 13:00:00'),
(4, 'SKU008', 8, 2, '2024-01-15 13:30:00'),
(5, 'SKU009', 9, 3, '2024-01-15 14:00:00'),
(5, 'SKU010', 10, 1, '2024-01-15 14:30:00');

-- Inserción de devoluciones
INSERT INTO devoluciones (factura, id_sucursal, sku, cantidad, fecha, motivo_devolucion) VALUES
(1, 1, 'SKU001', 2, '2024-01-16 10:00:00', 'Producto dañado'),
(2, 2, 'SKU003', 1, '2024-01-16 11:00:00', 'Error en pedido'),
(3, 3, 'SKU005', 3, '2024-01-16 12:00:00', 'Calidad no satisfactoria'),
(4, 4, 'SKU007', 1, '2024-01-16 13:00:00', 'Producto vencido'),
(5, 5, 'SKU009', 2, '2024-01-16 14:00:00', 'Error en facturación');