CREATE DATABASE IF NOT EXISTS Inversiones_A;
USE Inversiones_A;

CREATE TABLE tasa (
clave_tasa CHAR(5) PRIMARY KEY NOT NULL,
tasa_interes DECIMAL(4,2)
);

CREATE TABLE clientes (
rfc CHAR(13) PRIMARY KEY NOT NULL,
nombre VARCHAR(30),
apellido_paterno VARCHAR(15),
apellido_materno VARCHAR(15),
direccion VARCHAR(150),
telefono CHAR(13) UNIQUE,
email VARCHAR(50) UNIQUE,
sucursal CHAR(1)
);

CREATE TABLE contrato_inversion (
folio_contrato CHAR(26) PRIMARY KEY NOT NULL,
rfc_cliente CHAR(13),
fecha_inicio DATETIME,
fecha_vencimiento DATE,
CONSTRAINT fk_rfc_cliente FOREIGN KEY (rfc_cliente) REFERENCES clientes(rfc)
);

CREATE TABLE inversiones (
folio_inversion CHAR(31) PRIMARY KEY NOT NULL,
folio_contrato CHAR(26),
clave_tasa CHAR(5),
tipo_inversion VARCHAR(30),
monto_invertido DECIMAL(12,2),
monto_ganado DECIMAL(14,4),
CONSTRAINT fk_folio_contrato FOREIGN KEY (folio_contrato) REFERENCES contrato_inversion(folio_contrato),
CONSTRAINT fk_clave_tasa FOREIGN KEY (clave_tasa) REFERENCES tasa(clave_tasa)
);


-- --------------------------------------------------------------------------------------------------------------------------------------

-- llenado de datos
-- Clientes
INSERT INTO clientes (RFC, nombre, apellido_paterno, apellido_materno, direccion, telefono, email, sucursal) VALUES
('AAA010101AAA', 'Juan', 'Pérez', 'García', 'Calle 1, Colonia Centro, Ciudad de México', '5555555555', 'juan.perez@example.com', 'A'),
('AAA010102AAA', 'María', 'González', 'López', 'Avenida 2, Colonia Del Valle, Ciudad de México', '5555555556', 'maria.gonzalez@example.com', 'A'),
('AAA010103AAA', 'Pedro', 'Martínez', 'Gómez', 'Calle 3, Colonia Roma, Ciudad de México', '5555555557', 'pedro.martinez@example.com', 'A'),
('AAA010104AAA', 'Ana', 'Hernández', 'Pérez', 'Calle 4, Colonia Condesa, Ciudad de México', '5555555558', 'ana.hernandez@example.com', 'A'),
('AAA010105AAA', 'Luis', 'Sánchez', 'Ramírez', 'Calle 5, Colonia Narvarte, Ciudad de México', '5555555559', 'luis.sanchez@example.com', 'A'),
('AAA010106AAA', 'Carla', 'Jiménez', 'Torres', 'Calle 6, Colonia Coyoacán, Ciudad de México', '5555555560', 'carla.jimenez@example.com', 'A'),
('AAA010107AAA', 'Jorge', 'Castillo', 'Ruiz', 'Calle 7, Colonia Polanco, Ciudad de México', '5555555561', 'jorge.castillo@example.com', 'A'),
('AAA010108AAA', 'Mónica', 'Guzmán', 'Santos', 'Calle 8, Colonia Santa Fe, Ciudad de México', '5555555562', 'monica.guzman@example.com', 'A'),
('AAA010109AAA', 'Felipe', 'López', 'Fernández', 'Calle 9, Colonia Reforma, Ciudad de México', '5555555563', 'felipe.lopez@example.com', 'A'),
('AAA010110AAA', 'Sofía', 'Ramírez', 'Vargas', 'Calle 10, Colonia Vallejo, Ciudad de México', '5555555564', 'sofia.ramirez@example.com', 'A'),
('BBB010112BBB', 'Ricardo', 'Martínez', 'García', 'Calle 11, Colonia Centro, Guadalajara, Jalisco', '5555555565', 'ricardo.martinez@example.com', 'B'),
('BBB010113BBB', 'Carmen', 'Hernández', 'López', 'Avenida 12, Colonia Providencia, Guadalajara, Jalisco', '5555555566', 'carmen.hernandez@example.com', 'B'),
('BBB010114BBB', 'José', 'González', 'Ramírez', 'Calle 13, Colonia Chapalita, Guadalajara, Jalisco', '5555555567', 'jose.gonzalez@example.com', 'B'),
('BBB010115BBB', 'Verónica', 'Pérez', 'Vargas', 'Calle 14, Colonia Tlaquepaque, Guadalajara, Jalisco', '5555555568', 'veronica.perez@example.com', 'B'),
('BBB010116BBB', 'Roberto', 'Sánchez', 'Gómez', 'Calle 15, Colonia El Rosario, Guadalajara, Jalisco', '5555555569', 'roberto.sanchez@example.com', 'B'),
('BBB010117BBB', 'Fernanda', 'López', 'Torres', 'Calle 16, Colonia La Estancia, Guadalajara, Jalisco', '5555555570', 'fernanda.lopez@example.com', 'B'),
('BBB010118BBB', 'Juan', 'Castillo', 'Santos', 'Calle 17, Colonia Las Fuentes, Guadalajara, Jalisco', '5555555571', 'juan.castillo@example.com', 'B'),
('BBB010119BBB', 'María', 'Guzmán', 'Fernández', 'Calle 18, Colonia Arcos Vallarta, Guadalajara, Jalisco', '5555555572', 'maria.guzman@example.com', 'B'),
('BBB010120BBB', 'Pedro', 'Ramírez', 'Ruiz', 'Calle 19, Colonia San Isidro, Guadalajara, Jalisco', '5555555573', 'pedro.ramirez@example.com', 'B'),
('BBB010121BBB', 'Lucía', 'Hernández', 'Pérez', 'Calle 20, Colonia La Calma, Guadalajara, Jalisco', '5555555574', 'lucia.hernandez@example.com', 'B'),
('CCC010121CCC', 'Fabiola', 'González', 'Torres', 'Calle 21, Colonia Centro, Monterrey, Nuevo León', '5555555575', 'fabiola.gonzalez@example.com', 'C'),
('CCC010122CCC', 'Andrés', 'Pérez', 'García', 'Avenida 22, Colonia San Jerónimo, Monterrey, Nuevo León', '5555555576', 'andres.perez@example.com', 'C'),
('CCC010123CCC', 'Ana', 'Hernández', 'López', 'Calle 23, Colonia Del Valle, Monterrey, Nuevo León', '5555555577', 'ana.hernandez2@example.com', 'C'),
('CCC010124CCC', 'Luis', 'Ramírez', 'Gómez', 'Calle 24, Colonia Cumbres, Monterrey, Nuevo León', '5555555578', 'luis.ramirez@example.com', 'C'),
('CCC010125CCC', 'María', 'García', 'Ramírez', 'Calle 25, Colonia Obispado, Monterrey, Nuevo León', '5555555579', 'maria.garcia@example.com', 'C'),
('CCC010126CCC', 'José', 'Martínez', 'Sánchez', 'Calle 26, Colonia Mitras Centro, Monterrey, Nuevo León', '5555555580', 'jose.martinez@example.com', 'C'),
('CCC010127CCC', 'Fernando', 'Castillo', 'Fernández', 'Calle 27, Colonia Altavista, Monterrey, Nuevo León', '5555555581', 'fernando.castillo@example.com', 'C'),
('CCC010128CCC', 'Sofía', 'Gómez', 'Santos', 'Calle 28, Colonia Loma Larga, Monterrey, Nuevo León', '5555555582', 'sofia.gomez@example.com', 'C'),
('CCC010129CCC', 'Alejandro', 'Sánchez', 'López', 'Calle 29, Colonia Anáhuac, Monterrey, Nuevo León', '5555555583', 'alejandro.sanchez@example.com', 'C'),
('CCC010130CCC', 'Diana', 'Ramírez', 'Torres', 'Calle 30, Colonia San Pedro, Monterrey, Nuevo León', '5555555584', 'diana.ramirez@example.com', 'C');

-- Tasa
INSERT INTO tasa (clave_tasa, tasa_interes) VALUES
('TasaA', 10.00),
('TasaB', 15.00),
('TasaC', 20.00),
('TasaD', 25.00),
('TasaE', 30.00);



-- Contrato Inversion
INSERT INTO contrato_inversion (folio_contrato, rfc_cliente, fecha_inicio, fecha_vencimiento) VALUES
('C201901151515AAA010101AAA', 'AAA010101AAA', '2019-01-01-15:15:15', '2020-01-01'),
('C190523161616AAA010102AAA', 'AAA010102AAA', '2019-05-23-16:16:16', '2020-05-23'),
('C200101171717AAA010103AAA', 'AAA010103AAA', '2020-01-01-17:17-17', '2021-01-01'),
('C200523151617AAA010104AAA', 'AAA010104AAA', '2020-05-23-15:16:17', '2021-05-23'),
('C210101171615AAA010105AAA', 'AAA010105AAA', '2021-01-01-17:16:15', '2022-01-01'),
('C210523111111AAA010106AAA', 'AAA010106AAA', '2021-05-23-11:11:11', '2022-05-23'),
('C220101111113AAA010107AAA', 'AAA010107AAA', '2022-01-01-11:11:13', '2023-01-01'),
('C220523121213AAA010108AAA', 'AAA010108AAA', '2022-05-23-12:12:13', '2023-05-23'),
('C230101202020AAA010109AAA', 'AAA010109AAA', '2023-01-01-20:20:20', '2024-01-01'),
('C230523212121AAA010110AAA', 'AAA010110AAA', '2023-05-23-21:21:21', '2024-05-23');


-- Inversion
INSERT INTO inversiones (folio_inversion, folio_contrato, clave_tasa, monto_invertido, monto_ganado) VALUES
('C201901151515AAA010101AAAI0001', 'C201901151515AAA010101AAA', 'TasaB', 100000.00, 55.3375),
('C190523161616AAA010102AAAI0001', 'C190523161616AAA010102AAA', 'TasaE', 200000.00, 65465.41),
('C200101171717AAA010103AAAI0001', 'C200101171717AAA010103AAA', 'TasaA', 50000.00, 1234.5695),
('C200101171717AAA010103AAAI0002', 'C200101171717AAA010103AAA', 'TasaB', 70000.00, 2345.6778),
('C200523151617AAA010104AAAI0001', 'C200523151617AAA010104AAA', 'TasaC', 80000.00, 3456.7846),
('C200523151617AAA010104AAAI0002', 'C200523151617AAA010104AAA', 'TasaD', 90000.00, 4567.8946),
('C210101171615AAA010105AAAI0001', 'C210101171615AAA010105AAA', 'TasaE', 100000.00, 5678.9046),
('C210523111111AAA010106AAAI0001', 'C210523111111AAA010106AAA', 'TasaA', 110000.00, 6789.0145),
('C220101111113AAA010107AAAI0001', 'C220101111113AAA010107AAA', 'TasaA', 120000.00, 7890.1287),
('C220523121213AAA010108AAAI0001', 'C220523121213AAA010108AAA', 'TasaB', 130000.00, 8901.2356),
('C230101202020AAA010109AAAI0001', 'C230101202020AAA010109AAA', 'TasaC', 140000.00, 9012.3445),
('C230523212121AAA010110AAAI0001', 'C230523212121AAA010110AAA', 'TasaE', 150000.00, 12345.6714);




-- --------------------------------------------------------------------------------------------------------------------------------------