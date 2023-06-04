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
sucursal INT(1)
);

CREATE TABLE `contrato_inversion` (
  `folio_contrato` int NOT NULL AUTO_INCREMENT,
  `sucursal` int,
  `rfc_cliente` char(13) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  PRIMARY KEY (`folio_contrato`, `sucursal`),
  KEY `fk_rfc_cliente` (`rfc_cliente`),
  KEY `idx_folio_contrato` (`folio_contrato`),
  CONSTRAINT `fk_rfc_cliente` FOREIGN KEY (`rfc_cliente`) REFERENCES `clientes` (`rfc`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `inversiones` (
  `folio_inversion` int NOT NULL AUTO_INCREMENT,
  `sucursal` int,
  `folio_contrato` int DEFAULT NULL,
  `clave_tasa` char(5) DEFAULT NULL,
  `tipo_inversion` varchar(30) DEFAULT NULL,
  `monto_invertido` decimal(12,2) DEFAULT NULL,
  `monto_ganado` decimal(14,4) DEFAULT NULL,
  PRIMARY KEY (`folio_inversion`, `sucursal`),
  KEY `fk_clave_tasa` (`clave_tasa`),
  KEY `fk_folio_contrato_sucursal` (`folio_contrato`,`sucursal`),
  CONSTRAINT `fk_clave_tasa` FOREIGN KEY (`clave_tasa`) REFERENCES `tasa` (`clave_tasa`),
  CONSTRAINT `fk_folio_contrato_sucursal` FOREIGN KEY (`folio_contrato`,`sucursal`) REFERENCES `contrato_inversion` (`folio_contrato`,`sucursal`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;







-- --------------------------------------------------------------------------------------------------------------------------------------

-- llenado de datos
-- Clientes
INSERT INTO clientes (RFC, nombre, apellido_paterno, apellido_materno, direccion, telefono, email, sucursal) VALUES
('AAAA010101AAA', 'Juan', 'Pérez', 'García', 'Calle 1, Colonia Centro, Ciudad de México', '5555555555', 'juan.perez@example.com', 1 ),
('AAAA010102AAA', 'María', 'González', 'López', 'Avenida 2, Colonia Del Valle, Ciudad de México', '5555555556', 'maria.gonzalez@example.com', 1 ),
('AAAA010103AAA', 'Pedro', 'Martínez', 'Gómez', 'Calle 3, Colonia Roma, Ciudad de México', '5555555557', 'pedro.martinez@example.com', 1 ),
('AAAA010104AAA', 'Ana', 'Hernández', 'Pérez', 'Calle 4, Colonia Condesa, Ciudad de México', '5555555558', 'ana.hernandez@example.com', 1 ),
('AAAA010105AAA', 'Luis', 'Sánchez', 'Ramírez', 'Calle 5, Colonia Narvarte, Ciudad de México', '5555555559', 'luis.sanchez@example.com', 1 ),
('AAAA010106AAA', 'Carla', 'Jiménez', 'Torres', 'Calle 6, Colonia Coyoacán, Ciudad de México', '5555555560', 'carla.jimenez@example.com', 1 ),
('AAAA010107AAA', 'Jorge', 'Castillo', 'Ruiz', 'Calle 7, Colonia Polanco, Ciudad de México', '5555555561', 'jorge.castillo@example.com', 1 ),
('AAAA010108AAA', 'Mónica', 'Guzmán', 'Santos', 'Calle 8, Colonia Santa Fe, Ciudad de México', '5555555562', 'monica.guzman@example.com', 1 ),
('AAAA010109AAA', 'Felipe', 'López', 'Fernández', 'Calle 9, Colonia Reforma, Ciudad de México', '5555555563', 'felipe.lopez@example.com', 1 ),
('AAAA010110AAA', 'Sofía', 'Ramírez', 'Vargas', 'Calle 10, Colonia Vallejo, Ciudad de México', '5555555564', 'sofia.ramirez@example.com', 1),
('BBBB010112BBB', 'Ricardo', 'Martínez', 'García', 'Calle 11, Colonia Centro, Guadalajara, Jalisco', '5555555565', 'ricardo.martinez@example.com', 2 ),
('BBBB010113BBB', 'Carmen', 'Hernández', 'López', 'Avenida 12, Colonia Providencia, Guadalajara, Jalisco', '5555555566', 'carmen.hernandez@example.com', 2 ),
('BBBB010114BBB', 'José', 'González', 'Ramírez', 'Calle 13, Colonia Chapalita, Guadalajara, Jalisco', '5555555567', 'jose.gonzalez@example.com', 2 ),
('BBBB010115BBB', 'Verónica', 'Pérez', 'Vargas', 'Calle 14, Colonia Tlaquepaque, Guadalajara, Jalisco', '5555555568', 'veronica.perez@example.com', 2 ),
('BBBB010116BBB', 'Roberto', 'Sánchez', 'Gómez', 'Calle 15, Colonia El Rosario, Guadalajara, Jalisco', '5555555569', 'roberto.sanchez@example.com', 2 ),
('BBBB010117BBB', 'Fernanda', 'López', 'Torres', 'Calle 16, Colonia La Estancia, Guadalajara, Jalisco', '5555555570', 'fernanda.lopez@example.com', 2 ),
('BBBB010118BBB', 'Juan', 'Castillo', 'Santos', 'Calle 17, Colonia Las Fuentes, Guadalajara, Jalisco', '5555555571', 'juan.castillo@example.com', 2 ),
('BBBB010119BBB', 'María', 'Guzmán', 'Fernández', 'Calle 18, Colonia Arcos Vallarta, Guadalajara, Jalisco', '5555555572', 'maria.guzman@example.com', 2 ),
('BBBB010120BBB', 'Pedro', 'Ramírez', 'Ruiz', 'Calle 19, Colonia San Isidro, Guadalajara, Jalisco', '5555555573', 'pedro.ramirez@example.com', 2),
('BBBB010121BBB', 'Lucía', 'Hernández', 'Pérez', 'Calle 20, Colonia La Calma, Guadalajara, Jalisco', '5555555574', 'lucia.hernandez@example.com', 2),
('CCCC010121CCC', 'Fabiola', 'González', 'Torres', 'Calle 21, Colonia Centro, Monterrey, Nuevo León', '5555555575', 'fabiola.gonzalez@example.com', 3 ),
('CCCC010122CCC', 'Andrés', 'Pérez', 'García', 'Avenida 22, Colonia San Jerónimo, Monterrey, Nuevo León', '5555555576', 'andres.perez@example.com', 3  ),
('CCCC010123CCC', 'Ana', 'Hernández', 'López', 'Calle 23, Colonia Del Valle, Monterrey, Nuevo León', '5555555577', 'ana.hernandez2@example.com', 3  ),
('CCCC010124CCC', 'Luis', 'Ramírez', 'Gómez', 'Calle 24, Colonia Cumbres, Monterrey, Nuevo León', '5555555578', 'luis.ramirez@example.com', 3  ),
('CCCC010125CCC', 'María', 'García', 'Ramírez', 'Calle 25, Colonia Obispado, Monterrey, Nuevo León', '5555555579', 'maria.garcia@example.com', 3  ),
('CCCC010126CCC', 'José', 'Martínez', 'Sánchez', 'Calle 26, Colonia Mitras Centro, Monterrey, Nuevo León', '5555555580', 'jose.martinez@example.com', 3  ),
('CCCC010127CCC', 'Fernando', 'Castillo', 'Fernández', 'Calle 27, Colonia Altavista, Monterrey, Nuevo León', '5555555581', 'fernando.castillo@example.com', 3  ),
('CCCC010128CCC', 'Sofía', 'Gómez', 'Santos', 'Calle 28, Colonia Loma Larga, Monterrey, Nuevo León', '5555555582', 'sofia.gomez@example.com', 3  ),
('CCCC010129CCC', 'Alejandro', 'Sánchez', 'López', 'Calle 29, Colonia Anáhuac, Monterrey, Nuevo León', '5555555583', 'alejandro.sanchez@example.com', 3  ),
('CCCC010130CCC', 'Diana', 'Ramírez', 'Torres', 'Calle 30, Colonia San Pedro, Monterrey, Nuevo León', '5555555584', 'diana.ramirez@example.com', 3  );

-- Tasa
INSERT INTO tasa (clave_tasa, tasa_interes) VALUES
('TasaA', 10.00),
('TasaB', 15.00),
('TasaC', 20.00),
('TasaD', 25.00),
('TasaE', 30.00);



-- Contrato Inversion
INSERT INTO contrato_inversion ( rfc_cliente, fecha_inicio, fecha_vencimiento) VALUES
( 'AAAA010101AAA', '2019-01-01-15:15:15', '2020-01-01'),
( 'AAAA010102AAA', '2019-05-23-16:16:16', '2020-05-23'),
( 'AAAA010103AAA', '2020-01-01-17:17-17', '2021-01-01'),
( 'AAAA010104AAA', '2020-05-23-15:16:17', '2021-05-23'),
( 'AAAA010105AAA', '2021-01-01-17:16:15', '2022-01-01'),
( 'AAAA010106AAA', '2021-05-23-11:11:11', '2022-05-23'),
( 'AAAA010107AAA', '2022-01-01-11:11:13', '2023-01-01'),
( 'AAAA010108AAA', '2022-05-23-12:12:13', '2023-05-23'),
( 'AAAA010109AAA', '2023-01-01-20:20:20', '2024-01-01'),
( 'AAAA010110AAA', '2023-05-23-21:21:21', '2024-05-23');


-- Inversion
-- INSERT INTO inversiones (folio_contrato, clave_tasa, monto_invertido, monto_ganado) VALUES
-- ('AAAA010101AAA', 'TasaB', 100000.00, 55.3375),
-- ('AAAA010102AAA', 'TasaE', 200000.00, 65465.41),
-- ('AAAA010103AAA', 'TasaA', 50000.00, 1234.5695),
-- ('AAAA010103AAA', 'TasaB', 70000.00, 2345.6778),
-- ('AAAA010104AAA', 'TasaC', 80000.00, 3456.7846),
-- ('AAAA010104AAA', 'TasaD', 90000.00, 4567.8946),
-- ('AAAA010105AAA', 'TasaE', 100000.00, 5678.9046),
-- ('AAAA010106AAA', 'TasaA', 110000.00, 6789.0145),
-- ('AAAA010108AAA', 'TasaA', 120000.00, 7890.1287),
-- ('AAAA010108AAA', 'TasaB', 130000.00, 8901.2356),
-- ('AAAA010109AAA', 'TasaC', 140000.00, 9012.3445),
-- ('AAAA010110AAA', 'TasaE', 150000.00, 12345.6714);


-- TRIGGER DE FOLIO_CONTRATO
DELIMITER //
CREATE TRIGGER validar_insercion_contratos
BEFORE INSERT ON contrato_inversion
FOR EACH ROW
BEGIN
  DECLARE max_id INT;
  SELECT MAX(folio_contrato) INTO max_id FROM contrato_inversion;
  IF (NEW.sucursal IS NOT NULL AND NEW.sucursal <> 1) OR NEW.folio_contrato > max_id THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No puedes insertar un valor manualmente en folio_contrato y el valor de sucursal debe ser 1 o NULL.';
  END IF;
END;
//
DELIMITER ;


-- TRIGGER DE INVERSIÓN PARA IMPEDIR QUE SE META UNA SUCURSAL DIFERENTA LA 1 Y SE INGRESE ALGÚN ID
DELIMITER //
CREATE TRIGGER validar_insercion_inversiones
BEFORE INSERT ON inversiones
FOR EACH ROW
BEGIN
DECLARE max_id INT;
  SELECT MAX(folio_inversion) INTO max_id FROM inversiones;
  IF (NEW.sucursal IS NOT NULL AND NEW.sucursal <> 1) OR NEW.folio_inversion > max_id THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No puedes insertar un valor manualmente en folio_inversion y el valor de sucursal debe ser 1 o NULL.';
  END IF;
END;
//
DELIMITER ;
