CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  direccion VARCHAR(100),
  telefono VARCHAR(20),
  email VARCHAR(50)
);

CREATE TABLE cuentas (
  id_cuenta INT PRIMARY KEY AUTO_INCREMENT,
  id_cliente INT,
  tipo_cuenta VARCHAR(20),
  saldo DECIMAL(10, 2),
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE transacciones (
  id_transaccion INT PRIMARY KEY AUTO_INCREMENT,
  id_cuenta INT,
  tipo_transaccion VARCHAR(20),
  monto DECIMAL(10, 2),
  fecha DATE,
  FOREIGN KEY (id_cuenta) REFERENCES cuentas(id_cuenta)
);

CREATE TABLE empleados (
  id_empleado INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  cargo VARCHAR(50),
  salario DECIMAL(10, 2)
);

CREATE TABLE sucursales (
  id_sucursal INT PRIMARY KEY AUTO_INCREMENT,
  direccion VARCHAR(100),
  telefono VARCHAR(20)
);

/*insercion de datos*/

INSERT INTO clientes (nombre, apellido, direccion, telefono, email) VALUES
  ('Juan', 'Pérez', 'Calle 123', '1234567890', 'juan.perez@example.com'),
  ('María', 'Rodríguez', 'Calle 456', '9876543210', 'maria.rodriguez@example.com');

INSERT INTO cuentas (id_cliente, tipo_cuenta, saldo) VALUES
  (1, 'Corriente', 1000.00),
  (2, 'Ahorro', 500.00);

INSERT INTO transacciones (id_cuenta, tipo_transaccion, monto, fecha) VALUES
  (1, 'Depósito', 500.00, '2022-01-01'),
  (2, 'Retiro', 200.00, '2022-01-15');

INSERT INTO empleados (nombre, apellido, cargo, salario) VALUES
  ('Carlos', 'García', 'Gerente', 50000.00),
  ('Ana', 'Martínez', 'Cajera', 20000.00);

INSERT INTO sucursales (direccion, telefono) VALUES
  ('Calle 789', '5551234567'),
  ('Calle 901', '5559876543');

Consultas

-- Obtener el saldo de una cuenta específica
SELECT saldo FROM cuentas WHERE id_cuenta = 1;

-- Obtener la lista de transacciones de una cuenta específica
SELECT * FROM transacciones WHERE id_cuenta = 1;

-- Obtener la información de un cliente específico
SELECT * FROM clientes WHERE id_cliente = 1;

-- Obtener la lista de empleados
SELECT * FROM empleados;