CREATE DATABASE IF NOT EXISTS Inversiones_B;
USE Inversiones_B;

CREATE TABLE tasa (
clave_tasa CHAR(5) PRIMARY KEY NOT NULL,
tasa_interes DECIMAL(4,2)
);

-- CREATE TABLE clientes (
-- RFC CHAR(13) PRIMARY KEY NOT NULL,
-- nombre CHAR(30),
-- apellido_paterno CHAR(15),
-- apellido_materno CHAR(15),
-- direccion CHAR(200),
-- telefono CHAR(13),
-- email CHAR(50),
-- sucursal CHAR(1)
-- );

CREATE TABLE contrato_inversion (
folio_contrato CHAR(8) PRIMARY KEY NOT NULL,
sucursal INT(1),
rfc_cliente CHAR(13),
fecha_inicio DATETIME,
fecha_vencimiento DATE
);

CREATE TABLE inversiones (
folio_inversion CHAR(5) PRIMARY KEY NOT NULL,
folio_contrato CHAR(8),
clave_tasa CHAR(5),
tipo_inversion VARCHAR(20),
monto_invertido DECIMAL(12,2),
monto_ganado DECIMAL(14,4),
CONSTRAINT fk_folio_contrato FOREIGN KEY (folio_contrato) REFERENCES contrato_inversion(folio_contrato),
CONSTRAINT fk_clave_tasa FOREIGN KEY (clave_tasa) REFERENCES tasa(clave_tasa)
);


-- --------------------------------------------------------------------------------------------------------------------------------------



-- Tasa
INSERT INTO tasa (clave_tasa, tasa_interes) VALUES
('TasaA', 10.00),
('TasaB', 15.00),
('TasaC', 20.00),
('TasaD', 25.00),
('TasaE', 30.00);



-- Contrato Inversion
INSERT INTO contrato_inversion (folio_contrato, sucursal, rfc_cliente, fecha_inicio, fecha_vencimiento) VALUES
('2CBBBB01', 2,'BBBB010112BBB', '2022-01-01-12:30:45', '2023-01-01'),
('2CBBBB02', 2,'BBBB010113BBB', '2022-02-28-08:15:00', '2023-05-23'),
('2CBBBB03', 2,'BBBB010114BBB', '2022-03-15-16:45:30', '2023-01-01'),
('2CBBBB04', 2,'BBBB010115BBB', '2022-04-22-21:00:15', '2023-05-23'),
('2CBBBB05', 2,'BBBB010116BBB', '2022-05-12-10:30:00', '2023-01-01'),
('2CBBBB06', 2,'BBBB010117BBB', '2022-06-19-14:20:10', '2023-05-23'),
('2CBBBB07', 2,'BBBB010118BBB', '2022-07-03-18:00:20', '2024-01-01'),
('2CBBBB08', 2,'BBBB010119BBB', '2022-08-08-09:10:05', '2024-05-23'),
('2CBBBB09', 2,'BBBB010120BBB', '2022-09-25-23:59:59', '2024-01-01'),
('2CBBBB10', 2,'BBBB010121BBB', '2022-12-31-23:59:59', '2024-05-23');


-- Inversion
INSERT INTO inversiones (folio_inversion, folio_contrato, clave_tasa, monto_invertido, monto_ganado) VALUES
('2I001', '2CBBBB01', 'TasaB', 100000.00, 55.3375),
('2I002', '2CBBBB02', 'TasaE', 200000.00, 65465.41),
('2I003', '2CBBBB03', 'TasaA', 50000.00, 1234.5695),
('2I004', '2CBBBB04', 'TasaB', 70000.00, 2345.6778),
('2I005', '2CBBBB05', 'TasaC', 80000.00, 3456.7846),
('2I006', '2CBBBB06', 'TasaD', 90000.00, 4567.8946),
('2I007', '2CBBBB07', 'TasaE', 100000.00, 5678.9046),
('2I008', '2CBBBB08', 'TasaA', 110000.00, 6789.0145),
('2I009', '2CBBBB09', 'TasaA', 120000.00, 7890.1287),
('2I010', '2CBBBB10', 'TasaB', 130000.00, 8901.2356),
('2I011', '2CBBBB10', 'TasaB', 1000.00, 74.2356),
('2I012', '2CBBBB10', 'TasaB', 1314.00, 89.2356);

