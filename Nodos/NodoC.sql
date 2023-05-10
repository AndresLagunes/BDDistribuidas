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
folio_contrato CHAR(26) PRIMARY KEY NOT NULL,
rfc_cliente CHAR(13),
fecha_inicio DATETIME,
fecha_vencimiento DATE
);

CREATE TABLE inversiones (
folio_inversion CHAR(31) PRIMARY KEY NOT NULL,
folio_contrato CHAR(26),
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
INSERT INTO contrato_inversion (folio_contrato, rfc_cliente, fecha_inicio, fecha_vencimiento) VALUES
('C220101123045CCC010121CCC', 'CCC010121CCC', '2022-01-01-12:30:45', '2023-01-01'),
('C220228081500CCC010122CCC', 'CCC010122CCC', '2022-02-28-08:15:00', '2023-05-23'),
('C220315164530CCC010123CCC', 'CCC010123CCC', '2022-03-15-16:45:30', '2023-01-01'),
('C220422210015CCC010124CCC', 'CCC010124CCC', '2022-04-22-21:00:15', '2023-05-23'),
('C220512103000CCC010125CCC', 'CCC010125CCC', '2022-05-12-10:30:00', '2023-01-01'),
('C220619142010CCC010126CCC', 'CCC010126CCC', '2022-06-19-14:20:10', '2023-05-23'),
('C220703180020CCC010127CCC', 'CCC010127CCC', '2022-07-03-18:00:20', '2024-01-01'),
('C220808091005CCC010128CCC', 'CCC010128CCC', '2022-08-08-09:10:05', '2024-05-23'),
('C220925235959CCC010129CCC', 'CCC010129CCC', '2022-09-25-23:59:59', '2024-01-01'),
('C221231235959CCC010130CCC', 'CCC010130CCC', '2022-12-31-23:59:59', '2024-05-23');



-- Inversion
INSERT INTO inversiones (folio_inversion, folio_contrato, clave_tasa, monto_invertido, monto_ganado) VALUES
('C220101123045CCC010121CCCI0001', 'C220101123045CCC010121CCC', 'TasaB', 100000.00, 55.3375),
('C220228081500CCC010122CCCI0001', 'C220228081500CCC010122CCC', 'TasaE', 200000.00, 65465.41),
('C220315164530CCC010123CCCI0001', 'C220315164530CCC010123CCC', 'TasaA', 50000.00, 1234.5695),
('C220422210015CCC010124CCCI0001', 'C220422210015CCC010124CCC', 'TasaB', 70000.00, 2345.6778),
('C220512103000CCC010125CCCI0001', 'C220512103000CCC010125CCC', 'TasaC', 80000.00, 3456.7846),
('C220619142010CCC010126CCCI0001', 'C220619142010CCC010126CCC', 'TasaD', 90000.00, 4567.8946),
('C220703180020CCC010127CCCI0001', 'C220703180020CCC010127CCC', 'TasaE', 100000.00, 5678.9046),
('C220808091005CCC010128CCCI0001', 'C220808091005CCC010128CCC', 'TasaA', 110000.00, 6789.0145),
('C220925235959CCC010129CCCI0001', 'C220925235959CCC010129CCC', 'TasaA', 120000.00, 7890.1287),
('C221231235959CCC010130CCCI0001', 'C221231235959CCC010130CCC', 'TasaB', 130000.00, 8901.2356),
('C221231235959CCC010130CCCI0002', 'C221231235959CCC010130CCC', 'TasaB', 1300.00, 890.2356),
('C221231235959CCC010130CCCI0003', 'C221231235959CCC010130CCC', 'TasaB', 1300.00, 890.2356);