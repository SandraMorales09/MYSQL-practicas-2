USE tienda;
CREATE TABLE productos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  precio DECIMAL(10, 2)
);

INSERT INTO productos (nombre, precio) VALUES
  ('Producto 1', 10.99),
  ('Producto 2', 5.99),
  ('Producto 3', 7.99),
  ('Producto 4', 12.99),
  ('Producto 5', 8.99);

  SELECT * FROM productos;

UPDATE productos SET precio = 11.99 WHERE id = 1;

DELETE FROM productos WHERE id = 2;


CREATE TABLE pedidos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_producto INT,
  cantidad INT,
  FOREIGN KEY (id_producto) REFERENCES productos(id)
);

INSERT INTO pedidos (id_producto, cantidad) VALUES
  (1, 2),
  (3, 1),
  (4, 3),
  (5, 2),
  (1, 1);


SELECT p.id, pr.nombre, p.cantidad
FROM pedidos p
JOIN productos pr ON p.id_producto = pr.id;


SELECT pr.nombre, SUM(p.cantidad) AS cantidad_total
FROM pedidos p
JOIN productos pr ON p.id_producto = pr.id
GROUP BY pr.nombre;

CREATE VIEW vista_pedidos AS
SELECT p.id, pr.nombre, p.cantidad
FROM pedidos p
JOIN productos pr ON p.id_producto = pr.id;

SELECT * FROM vista_pedidos;

CREATE INDEX idx_nombre ON productos (nombre);

DELIMITER //
CREATE PROCEDURE sp_insertar_producto(
  IN p_nombre VARCHAR(50),
  IN p_precio DECIMAL(10, 2)
)
BEGIN
  INSERT INTO productos (nombre, precio) VALUES (p_nombre, p_precio);
END//
DELIMITER ;


CALL sp_insertar_producto('Producto 6', 9.99);

DELIMITER //
CREATE FUNCTION fn_calcular_total(
  p_id_pedido INT
)
RETURNS DECIMAL(10, 2)
BEGIN
  DECLARE total DECIMAL(10, 2);
  SELECT SUM(pr.precio * p.cantidad) INTO total
  FROM pedidos p
  JOIN productos pr ON p.id_producto = pr.id
  WHERE p.id = p_id_pedido;
  RETURN total;
END//
DELIMITER ;


SELECT fn_calcular_total(1) AS total;

DELIMITER //
CREATE TRIGGER tr_actualizar_precio
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
  UPDATE pedidos SET cantidad = cantidad * (NEW.precio / OLD.precio) WHERE id_producto = NEW.id;
END//
DELIMITER ;

CREATE USER 'usuario1'@'%' IDENTIFIED BY 'password1';

GRANT SELECT, INSERT, UPDATE ON tienda.* TO 'usuario1'@'%';

REVOKE INSERT, UPDATE ON tienda.* FROM 'usuario1'@'%';

CREATE ROLE 'rol_admin';
GRANT SELECT, INSERT, UPDATE, DELETE ON tienda.* TO 'rol_admin';


# Ejercicio 23: Asignar un rol a un usuario
Asigna el rol "rol_admin" al usuario "usuario1".


GRANT 'rol_admin' TO 'usuario1'@'%';

CREATE TABLE ventas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  fecha DATE,
  monto DECIMAL(10, 2)
) PARTITION BY RANGE (YEAR(fecha)) (
  PARTITION p_2020 VALUES LESS THAN (2021),
  PARTITION p_2021 VALUES LESS THAN (2022),
  PARTITION p_2022 VALUES LESS THAN MAXVALUE
);

INSERT INTO ventas (fecha, monto) VALUES
  ('2020-01-01', 100.00),
  ('2021-01-01', 200.00),
  ('2022-01-01', 300.00);

SELECT * FROM ventas PARTITION (p_2021);

CREATE FULLTEXT INDEX idx_nombre ON productos (nombre);

SELECT * FROM productos WHERE MATCH (nombre) AGAINST ('producto');


CREATE TABLE pedidos_json (
  id INT PRIMARY KEY AUTO_INCREMENT,
  datos JSON
);

INSERT INTO pedidos_json (datos) VALUES ('{"cliente": "Juan", "monto": 100.00}');
SELECT * FROM pedidos_json WHERE JSON_EXTRACT(datos, '$.cliente') = 'Juan';

