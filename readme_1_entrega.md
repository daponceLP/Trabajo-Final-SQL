# TRABAJO FINAL SQL

- Alumno: Dario Ponce
- Comision: 59430
- Tutor: Nicolás Maugeri
- Docente: Anderson Torres

## Tematica del Proyecto
La base de datos diseñada aborda las necesidades de gestión y operaciones de cualquier comercio, en especial para este trabajo se utilizo un ejemplo de supermercados.
Las problemáticas que resuelve son las siguientes:

1. Gestión de Sucursales
2. Relación con Proveedores
3. Gestión de Artículos y Categorías
4. Seguimiento de Ventas
5. Control de Compras
6. Manejo de Devoluciones
7. Ajustes de Inventario
8. Administración de Clientes

Los beneficios de esta base de datos son:

 - Centralización de datos: Toda la información relevante está      unificada.
 - Trazabilidad: Cada transacción (compra, venta, devolución, ajuste) está documentada, permitiendo auditar y analizar operaciones.
 - Automatización: Las relaciones entre tablas mediante claves primarias y foráneas simplifican la ejecución de consultas y reportes.
 - Escalabilidad: El modelo soporta la adición de más sucursales, productos, o clientes sin necesidad de rediseñar la estructura.
 
Resumiendo, esta base de datos trata de ser una herramienta integral para optimizar los procesos operativos, logísticos y administrativos de un un comercio.

Esta base de datos esta diseñada para poder utilizarse con alguna herramienta de visualizacion a fin de generar reportes que faciliten la interpretacion de los datos.



## Diseño Orignal de Base de datos DER ONTOLOGICO
![alt text](der.jpeg)

### DER WORKBENCH

![alt text](DER.png)


# Esquema de la Base de Datos

### Tabla sucursales:
Almacena la información de las sucursales del supermercado.

Campos:
- id_sucursal (INT)(PK): Identificador único de la sucursal.
- nombre_sucursal	(VARCHAR): Nombre de la sucursal.
- direccion (VARCHAR): Dirección física de la sucursal.
- telefono (VARCHAR): Número de contacto de la sucursal.
- ciudad (VARCHAR): Ciudad donde se encuentra la sucursal.
- provincia (VARCHAR): Provincia donde se encuentra la sucursal.
- codigo_postal (VARCHAR): Código postal de la sucursal.
- fecha_apertura (DATE): Fecha en que la sucursal comenzó a operar.

Relaciones:
    - Tabla ventas: campo id_sucursal
    - Tabla compras: campo id_sucursal
    - Tabla ajustes: campo id_sucursal
    - Tabla ordenes_compra: campo id_sucursal
    - Tabla devoluciones: campo id_sucursal

### Tabla proveedor:
Registra información sobre los proveedores que suministran productos.

Campos:
- id_proveedor (INT)(PK): Identificador único del proveedor.
- nombre_proveedor (VARCHAR): Nombre del proveedor.
- frecuencia_entrega (VARCHAR): Frecuencia de entrega de productos.
- metodo_pago	(ENUM): Método de pago acordado.

Relaciones:
    - Tabla articulos: campo id_proveedor
    - Tabla compras: campo proveedor
    - Tabla ordenes_compra: campo id_proveedor

### Tabla categoria_articulo:
Define las categorías y subcategorías de los artículos.

Campos:
- id_categoria_articulo (INT)(PK): Identificador único de la categoría.
- nombre_categoria (ENUM): Categoría general.
- nombre_subcategoria	(ENUM):	Subcategoría.

Relaciones:
    - Tabla articulos: campo id_categoria_articulos

### Tabla articulos:
Registra información de los productos disponibles en el supermercado.

Campos:
- sku	(VARCHAR)(PK): Código único del producto, se utiliza como PK ya que el mismo proceso de creacion no permite duplicaciones.
- id_proveedor (INT): Proveedor del artículo.
- id_categoria_articulo (INT): Categoría del artículo.
- ean	(VARCHAR): Código de barras internacional del artículo.
- nombre_producto	(VARCHAR): Nombre descriptivo del producto.
- costo (DECIMAL): Costo unitario del producto.
- iva	(DECIMAL): Porcentaje de IVA aplicado al producto.

Relaciones:
    - Tabla proveedor: campo id_proveedor
    - Tabla categoria_articulo: campo id_categoria_articulo
    - Tabla ventas: campo sku
    - Tabla ajustes: campo sku
    - Tabla compras: campo sku
    - Tabla devoluciones: campo sku
    - Tabla ordenes_compra: campo sku
  
### Tabla clientes:
Contiene información sobre los clientes del comercio

Campos:
- id_clientes	(INT)(PK): Identificador único del cliente.
- nombre_cliente (VARCHAR): Nombre completo del cliente.
- domicilio (VARCHAR): Dirección del cliente.
- tipo_facturacion (ENUM): Tipo de facturación.

Relaciones
    Tabla ventas: campo id_clientes


### Tabla categoria_ajustes:
Define los motivos para realizar ajustes de inventario.

Campos:
- id_categoria_ajustes (INT)(PK): Identificador único del motivo de ajuste.
- categoria_ajuste (ENUM): Motivo del ajuste.

Relaciones:
    Tabla ajustes: campo id_categoria_ajustes

### Tabla ajustes:
Registra los ajustes realizados al inventario.

Campos:
- id_sucursal (INT): Sucursal que realiza el ajuste.
- id_ajustes (INT)(PK): Identificador único del ajuste.
- id_categoria_ajustes (INT): Motivo del ajuste.
- fecha (DATETIME): Fecha y hora del ajuste.
- sku	(VARCHAR): Artículo ajustado.
- cantidad_ajustada (INT): Cantidad ajustada (positiva o negativa).

Relaciones:
    - Tabla sucursales: campo id_sucursal
    - Tabla articulos: campo sku
    - Tabla categoria_ajustes: campo id_categoria_ajuste

### Tabla ventas:
Registra información sobre las ventas realizadas.

Campos:
- factura	(INT)(PK): Número de factura de la venta.
- id_sucursal	(INT): Sucursal donde se realiza la venta.
- sku	(VARCHAR): Producto vendido.
- id_clientes	(INT): Cliente que realizó la compra.
- cantidad_sku (INT): Cantidad del producto vendido.
- fecha (DATETIME): Fecha y hora de la venta.

Relaciones:
    - Tabla sucursales: campo id_sucursal.
    - Tabla articulos: campo sku.
    - Tabla clientes: campo id_clientes.
    - Tabla devoluciones: campo factura.

### Tabla compras:
Registra las compras realizadas a los proveedores.

Campos:
- id_sucursal	(INT): Sucursal que realiza la compra.
- fecha (DATETIME): Fecha en que se realizó la compra.
- sku	(VARCHAR)(PK): Artículo comprado.
- proveedor (INT): Proveedor del producto.
- ctd_pedida (INT): Cantidad pedida en la compra.
- ctd_recibida (INT): Cantidad recibida del pedido.
- vencimiento	(DATE):	Fecha de vencimiento del producto (si aplica).

Relaciones:
    - Tabla sucursales:campo id_sucursal.
    - Tabla articulos: campo sku.
    - Tabla proveedor: campo proveedor.


### Tabla devoluciones:
Registra las devoluciones realizadas.

Campos:
- id_devolucion(INT)(PK):	Identificador único de la devolución.
- factura(INT): Venta asociada a la devolución.
- id_sucursal(INT): Sucursal donde se realizó la devolución.
- sku	(VARCHAR): Producto devuelto.
- cantidad(INT): Cantidad de producto devuelto.
- fecha (DATETIME): Fecha de la devolución.
- motivo_devolucion (VARCHAR): Razón específica de la devolución.

Relaciones:
    - Tabla ventas: campo factura.
    - Tabla sucursales: campo id_sucursal.
    - Tabla articulos: campo sku.

### Tabla ordenes_compra:
Registra las órdenes de compra enviadas a los proveedores.

Campos:
- id_orden (INT)(PK): Identificador único de la orden de compra.
- fecha (DATETIME): Fecha de creación de la orden.
- id_sucursal (INT): Sucursal para la que se genera la orden.
- id_proveedor (INT): Proveedor al que se dirige la orden.
- sku	(VARCHAR):Producto solicitado.
- cantidad_pedida (INT): Cantidad pedida del producto.
- estado (ENUM): Estado de la orden.

Relaciones:
    - Tabla sucursales:campo id_sucursal.
    - Tabla proveedor: campo id_proveedor.
    - Tabla articulos: campo sku.

