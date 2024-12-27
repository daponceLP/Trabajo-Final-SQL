DROP DATABASE IF EXISTS supermercado; -- se borra tabla si existe para evitar conflictos
CREATE DATABASE supermercado; -- creacion de la base de datos
USE supermercado; -- seleccion de la base de datos a utilizar

-- creacion de tablas y designacion de PK y FK
CREATE TABLE sucursales (
    id_sucursal INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_sucursal VARCHAR(200),
    direccion VARCHAR(255),
    telefono VARCHAR(15),
    ciudad VARCHAR(100),
    provincia VARCHAR(100),
    codigo_postal VARCHAR(10),
    fecha_apertura DATE  -- Fecha de apertura de la sucursal
);

CREATE TABLE proveedor(
   id_proveedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
   nombre_proveedor VARCHAR(200),
   frecuencia_entrega VARCHAR(200),
   metodo_pago ENUM('Efectivo', '30 dias', '60 dias', '90 dias')
);
CREATE TABLE categoria_articulo(
    id_categoria_articulo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_categoria ENUM('Mercaderia General', 'Alimentos', 'Frescos'),
    nombre_subcategoria ENUM('Lacteos', 'Frutas y Verduras', 'Carnicos', 'Almacen', 'Limpieza', 'Perfumeria', 'Bebidas Alcoholicas', 'Gaseosas', 'Aguas', 'Aguas Saborizadas', 'Cervezas')
);

CREATE TABLE articulos(
     sku VARCHAR(10) NOT NULL PRIMARY KEY,
     id_proveedor INT,
     id_categoria_articulo INT,
     ean VARCHAR(13),
     nombre_producto VARCHAR(200),
     costo DECIMAL (5,2),
     iva DECIMAL (2,2)
     
 );
 ALTER TABLE articulos
     ADD CONSTRAINT fk_constraint_id_proveedor
     FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor)
     ;
 ALTER TABLE articulos
     ADD CONSTRAINT fk_constraint_id_categoria_articulo 
     FOREIGN KEY (id_categoria_articulo) REFERENCES categoria_articulo(id_categoria_articulo);
     
CREATE TABLE clientes(
    id_clientes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nombre_cliente VARCHAR(200),
    domicilio VARCHAR(200),
    tipo_facturacion ENUM('Consumidor Final', 'Factura A')
);

CREATE TABLE categoria_ajustes(
    id_categoria_ajustes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    categoria_ajuste ENUM ( 'Dañado','Vencido','Error Inventario','Conteo Ciclico')
);

CREATE TABLE ajustes(
    id_sucursal INT,
    id_ajustes INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_categoria_ajustes INT,
    fecha DATETIME,
    sku VARCHAR(10),
    cantidad_ajustada INT    
);
 ALTER TABLE ajustes
    ADD CONSTRAINT fk_ajuste_sucursal 
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal);
 
 ALTER TABLE ajustes
     ADD CONSTRAINT fk_constraint_sku 
     FOREIGN KEY (sku) REFERENCES articulos(sku);
 ALTER TABLE ajustes
     ADD CONSTRAINT fk_constraint_id_categoria_ajustes
     FOREIGN KEY (id_categoria_ajustes) REFERENCES categoria_ajustes(id_categoria_ajustes);

CREATE TABLE ventas(
    factura INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_sucursal INT,
    sku VARCHAR(10),
    id_clientes INT,
    cantidad_sku INT,
    fecha DATETIME
); 
  ALTER TABLE ventas
     ADD CONSTRAINT fk_venta_sucursal 
     FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal);
  ALTER TABLE ventas
     ADD CONSTRAINT fk_constraint2_sku 
     FOREIGN KEY (sku) REFERENCES articulos(sku);
  ALTER TABLE ventas
     ADD CONSTRAINT fk_constraint_id_clientes 
     FOREIGN KEY (id_clientes) REFERENCES clientes(id_clientes);
     
     CREATE TABLE compras(
    id_sucursal INT,
    fecha DATETIME,
    sku VARCHAR(10) NOT NULL PRIMARY KEY,
    proveedor INT,
    ctd_pedida INT,
    ctd_recibida INT,
    vencimiento DATE
    
); 
  ALTER TABLE compras
     ADD CONSTRAINT fk_compra_sucursal
     FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal);
  ALTER TABLE compras
     ADD CONSTRAINT fk_constraint3_sku 
     FOREIGN KEY (sku) REFERENCES articulos(sku);
  ALTER TABLE compras
     ADD CONSTRAINT fk_constraint4_proveedor 
     FOREIGN KEY (proveedor) REFERENCES proveedor(id_proveedor);

CREATE TABLE devoluciones (
    id_devolucion INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    factura INT,
    id_sucursal INT,
    sku VARCHAR(10),
    cantidad INT,
    fecha DATETIME,
    motivo_devolucion VARCHAR(255)

);
ALTER TABLE devoluciones
    ADD CONSTRAINT fk_devolucion_sucursal
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal);    
ALTER TABLE devoluciones
    ADD CONSTRAINT fk_constraint5_factura
    FOREIGN KEY (factura) REFERENCES ventas(factura);

ALTER TABLE devoluciones
    ADD CONSTRAINT fk_constraint6_sku
    FOREIGN KEY (sku) REFERENCES articulos(sku);
    
CREATE TABLE ordenes_compra (
    id_orden INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    id_sucursal INT,
    id_proveedor INT,
    sku VARCHAR(10),
    cantidad_pedida INT,
    estado ENUM('Pendiente', 'Enviado', 'Recibido') DEFAULT 'Pendiente'
    
    );
ALTER TABLE ordenes_compra
    ADD CONSTRAINT fk_orden_sucursal
    FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal);
ALTER TABLE ordenes_compra
    ADD CONSTRAINT fk_constraint7_id_proveedor
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id_proveedor);
ALTER TABLE ordenes_compra
    ADD CONSTRAINT fk_constraint8_sku
    FOREIGN KEY (sku) REFERENCES articulos(sku);