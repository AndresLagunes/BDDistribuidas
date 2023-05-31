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

CREATE TABLE `contrato_inversion` (
  `folio_contrato` int NOT NULL AUTO_INCREMENT,
  `sucursal` int DEFAULT '2',
  `rfc_cliente` char(13) DEFAULT NULL,
  `fecha_inicio` datetime DEFAULT NULL,
  `fecha_vencimiento` date DEFAULT NULL,
  PRIMARY KEY (`folio_contrato`, `sucursal`),
  KEY `idx_folio_contrato` (`folio_contrato`),
) ENGINE=InnoDB AUTO_INCREMENT=0 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



CREATE TABLE `inversiones` (
  `folio_inversion` int NOT NULL AUTO_INCREMENT,
  `sucursal` int DEFAULT '2',
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



-- Tasa
INSERT INTO tasa (clave_tasa, tasa_interes) VALUES
('TasaA', 10.00),
('TasaB', 15.00),
('TasaC', 20.00),
('TasaD', 25.00),
('TasaE', 30.00);



-- Contrato Inversion
INSERT INTO contrato_inversion (rfc_cliente, fecha_inicio, fecha_vencimiento) VALUES
('BBBB010112BBB', '2022-01-01-12:30:45', '2023-01-01'),
('BBBB010113BBB', '2022-02-28-08:15:00', '2023-05-23'),
('BBBB010114BBB', '2022-03-15-16:45:30', '2023-01-01'),
('BBBB010115BBB', '2022-04-22-21:00:15', '2023-05-23'),
('BBBB010116BBB', '2022-05-12-10:30:00', '2023-01-01'),
('BBBB010117BBB', '2022-06-19-14:20:10', '2023-05-23'),
('BBBB010118BBB', '2022-07-03-18:00:20', '2024-01-01'),
('BBBB010119BBB', '2022-08-08-09:10:05', '2024-05-23'),
('BBBB010120BBB', '2022-09-25-23:59:59', '2024-01-01'),
('BBBB010121BBB', '2022-12-31-23:59:59', '2024-05-23');


-- Inversion
INSERT INTO inversiones (folio_inversion, folio_contrato, clave_tasa,tipo_inversion, monto_invertido, monto_ganado) VALUES
('2I001', '2CBBBB01', 'TasaB', "Coca-Cola	", 100000.00, 55.3375),
('2I002', '2CBBBB02', 'TasaE', "Coca-Cola	", 200000.00, 65465.41),
('2I003', '2CBBBB03', 'TasaA', "Coca-Cola	", 50000.00, 1234.5695),
('2I004', '2CBBBB04', 'TasaB', "Coca-Cola	", 70000.00, 2345.6778),
('2I005', '2CBBBB05', 'TasaC', "Coca-Cola	", 80000.00, 3456.7846),
('2I006', '2CBBBB06', 'TasaD', "Coca-Cola	", 90000.00, 4567.8946),
('2I007', '2CBBBB07', 'TasaE', "Coca-Cola	", 100000.00, 5678.9046),
('2I008', '2CBBBB08', 'TasaA', "Coca-Cola	", 110000.00, 6789.0145),
('2I009', '2CBBBB09', 'TasaA', "Coca-Cola	", 120000.00, 7890.1287),
('2I010', '2CBBBB10', 'TasaB', "Coca-Cola	", 130000.00, 8901.2356),
('2I011', '2CBBBB10', 'TasaB', "Coca-Cola	", 1000.00, 74.2356),
('2I012', '2CBBBB10', 'TasaB', "Coca-Cola	", 1314.00, 89.2356);

-- TRIGGER DE FOLIO_CONTRATO
DELIMITER //
CREATE TRIGGER validar_insercion_contratos
BEFORE INSERT ON contrato_inversion
FOR EACH ROW
BEGIN
  DECLARE max_id INT;
  SELECT MAX(folio_contrato) INTO max_id FROM contrato_inversion;
  IF (NEW.sucursal IS NOT NULL AND NEW.sucursal <> 2) OR NEW.folio_contrato > max_id THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No puedes insertar un valor manualmente en folio_contrato y el valor de sucursal debe ser 2 o NULL.';
  END IF;
END;
//
DELIMITER ;


-- TRIGGER DE INVERSIÓN PARA IMPEDIR QUE SE META UNA SUCURSAL DIFERENTA LA 2 Y SE INGRESE ALGÚN ID
DELIMITER //
CREATE TRIGGER validar_insercion_inversiones
BEFORE INSERT ON inversiones
FOR EACH ROW
BEGIN
DECLARE max_id INT;
  SELECT MAX(folio_inversion) INTO max_id FROM inversiones;
  IF (NEW.sucursal IS NOT NULL AND NEW.sucursal <> 2) OR NEW.folio_inversion > max_id THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No puedes insertar un valor manualmente en folio_inversion y el valor de sucursal debe ser 2 o NULL.';
  END IF;
END;
//
DELIMITER ;
INSERT INTO contrato_inversion (rfc_cliente, fecha_inicio, fecha_vencimiento) VALUES ('CCCC010130CCC', '2023-05-16', '2023-06-09')