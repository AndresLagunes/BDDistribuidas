CREATE DATABASE IF NOT EXISTS Inversiones_C;
USE Inversiones_C;

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

-- llenado de datos

-- Tasa
INSERT INTO tasa (clave_tasa, tasa_interes) VALUES
('TasaA', 10.00),
('TasaB', 15.00),
('TasaC', 20.00),
('TasaD', 25.00),
('TasaE', 30.00);


-- Contrato Inversion
INSERT INTO contrato_inversion (folio_contrato, sucursal, rfc_cliente, fecha_inicio, fecha_vencimiento) VALUES
('3CCCC01', 3, 'CCCC010121CCC', '2022-01-01-12:30:45', '2023-01-01'),
('3CCCC02', 3, 'CCCC010122CCC', '2022-02-28-08:15:00', '2023-05-23'),
('3CCCC03', 3, 'CCCC010123CCC', '2022-03-15-16:45:30', '2023-01-01'),
('3CCCC04', 3, 'CCCC010124CCC', '2022-04-22-21:00:15', '2023-05-23'),
('3CCCC05', 3, 'CCCC010125CCC', '2022-05-12-10:30:00', '2023-01-01'),
('3CCCC06', 3, 'CCCC010126CCC', '2022-06-19-14:20:10', '2023-05-23'),
('3CCCC07', 3, 'CCCC010127CCC', '2022-07-03-18:00:20', '2024-01-01'),
('3CCCC08', 3, 'CCCC010128CCC', '2022-08-08-09:10:05', '2024-05-23'),
('3CCCC09', 3, 'CCCC010129CCC', '2022-09-25-23:59:59', '2024-01-01'),
('3CCCC10', 3, 'CCCC010130CCC', '2022-12-31-23:59:59', '2024-05-23');



-- Inversion
INSERT INTO inversiones (folio_inversion, folio_contrato, clave_tasa, monto_invertido, monto_ganado) VALUES
('3I001', '3CCCC01', 'TasaB', 100000.00, 55.3375),
('3I002', '3CCCC02', 'TasaE', 200000.00, 65465.41),
('3I003', '3CCCC03', 'TasaA', 50000.00, 1234.5695),
('3I004', '3CCCC04', 'TasaB', 70000.00, 2345.6778),
('3I005', '3CCCC04', 'TasaC', 80000.00, 3456.7846),
('3I006', '3CCCC04', 'TasaD', 90000.00, 4567.8946),
('3I007', '3CCCC05', 'TasaE', 100000.00, 5678.9046),
('3I008', '3CCCC06', 'TasaA', 110000.00, 6789.0145),
('3I009', '3CCCC07', 'TasaA', 120000.00, 7890.1287),
('3I010', '3CCCC08', 'TasaB', 130000.00, 8901.2356),
('3I011', '3CCCC09', 'TasaB', 1300.00, 890.2356),
('3I012', '3CCCC10', 'TasaB', 1300.00, 890.2356);