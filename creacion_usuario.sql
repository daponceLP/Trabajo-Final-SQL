-- Creacion de 2 usuarios, uno para operacion y otro para comercial

CREATE USER 'comercial'@'localhost' IDENTIFIED BY 'Com3rc1al2024*';
CREATE USER 'operaciones'@'localhost' IDENTIFIED BY 'Op3r4c1ones2024*';

-- Asignacion de Permisos para el Area Comercial

GRANT SELECT, INSERT, UPDATE ON supermercado.ventas TO 'comercial_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON supermercado.clientes TO 'comercial_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON supermercado.devoluciones TO 'comercial_user'@'localhost';
GRANT SELECT ON supermercado.articulos TO 'comercial_user'@'localhost';
GRANT SELECT ON supermercado.categoria_articulo TO 'comercial_user'@'localhost';
GRANT SELECT ON supermercado.sucursales TO 'comercial_user'@'localhost';

-- Asignacion de Permisos para el Area Opertaciones

GRANT SELECT, INSERT, UPDATE ON supermercado.articulos TO 'operations_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON supermercado.proveedor TO 'operations_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON supermercado.compras TO 'operations_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON supermercado.ordenes_compra TO 'operations_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON supermercado.ajustes TO 'operations_user'@'localhost';
GRANT SELECT, INSERT, UPDATE ON supermercado.categoria_ajustes TO 'operations_user'@'localhost';
GRANT SELECT ON supermercado.sucursales TO 'operations_user'@'localhost';

-- Grant EXECUTE permission on stored procedures (if any exist)
GRANT EXECUTE ON supermercado.* TO 'comercial_user'@'localhost';
GRANT EXECUTE ON supermercado.* TO 'operations_user'@'localhost';

-- Apply the privileges
FLUSH PRIVILEGES;