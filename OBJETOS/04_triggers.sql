-- Descontar articulos vendidos

USE supermercado
DROP TRIGGER IF EXISTS agregar_compras

DELIMITER //

CREATE TRIGGER agregar_compras
AFTER INSERT ON compras
FOR EACH ROW
BEGIN
    -- Si el artículo ya existe en la sucursal, actualizamos el stock
    IF EXISTS (SELECT 1 FROM stock_sucursal WHERE id_sucursal = NEW.id_sucursal AND sku = NEW.sku) THEN
        UPDATE stock_sucursal
        SET stock = stock + NEW.ctd_recibida
        WHERE id_sucursal = NEW.id_sucursal AND sku = NEW.sku;
    ELSE
        -- Si el artículo no existe, insertamos un nuevo registro
        INSERT INTO stock_sucursal (id_sucursal, sku, stock)
        VALUES (NEW.id_sucursal, NEW.sku, NEW.ctd_recibida);
    END IF;
END //

DELIMITER ;

DELIMITER //

CREATE TRIGGER descontar_ventas
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
    -- Verifica si hay suficiente stock antes de proceder
    DECLARE current_stock INT;

    -- Obtenemos el stock actual
    SELECT stock INTO current_stock
    FROM stock_sucursal
    WHERE id_sucursal = NEW.id_sucursal AND sku = NEW.sku;

    -- Si hay suficiente stock, lo actualizamos
    IF current_stock >= NEW.cantidad_sku THEN
        UPDATE stock_sucursal
        SET stock = stock - NEW.cantidad_sku
        WHERE id_sucursal = NEW.id_sucursal AND sku = NEW.sku;
    ELSE
        -- Si no hay suficiente stock, podemos lanzar un error o realizar una acción de manejo de inventario
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No hay suficiente stock para realizar la venta.';
    END IF;
END //

DELIMITER ;


-- Evitar que se borren productos con historial de ventas

USE supermercado
DROP TRIGGER IF EXISTS no_borrar

DELIMITER //

CREATE TRIGGER no_borrar
BEFORE DELETE ON articulos
FOR EACH ROW
BEGIN
    -- Verificamos si el artículo tiene ventas asociadas
    DECLARE ventas_existentes INT;

    -- Contamos las ventas asociadas al artículo
    SELECT COUNT(*) INTO ventas_existentes
    FROM ventas
    WHERE sku = OLD.sku;

    -- Si el artículo tiene historial de ventas lanzamos un error
    IF ventas_existentes > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'No se puede eliminar el artículo porque tuvo ventas';
    END IF;
END //

DELIMITER ;