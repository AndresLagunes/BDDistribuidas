-- TRIGGER DE FOLIO_CONTRATO
DELIMITER //
CREATE TRIGGER validar_insercion_contratos
BEFORE INSERT ON contrato_inversion
FOR EACH ROW
BEGIN
  IF NEW.sucursal <> 1 OR NEW.folio_contrato IS NOT NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se puede insertar un valor en folio_inversion y el valor de sucursal debe ser 1.';
  END IF;
END;
//
DELIMITER ;


--TRIGGER DE INVERSIÓN PARA IMPEDIR QUE SE META UNA SUCURSAL DIFERENTA LA 1 Y SE INGRESE ALGÚN ID
DELIMITER //
CREATE TRIGGER validar_insercion_inversiones
BEFORE INSERT ON inversiones
FOR EACH ROW
BEGIN
  IF NEW.sucursal <> 1 OR NEW.folio_inversion IS NOT NULL THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'No se puede insertar un valor en folio_inversion y el valor de sucursal debe ser 1.';
  END IF;
END;
//
DELIMITER ;


-- ¡¡¡¡¡¡¡¡¡¡¡¡¡NO SE OCUPA!!!!!!!!!!!!!!
-- TRIGGER DE FOLIO_INVERSION
DELIMITER //
CREATE TRIGGER set_folio_inversion
AFTER INSERT ON inversiones
FOR EACH ROW
BEGIN
    SET @id := LPAD(NEW.id, 4, '0');  -- Pads the id with leading zeros
    SET @folio := CONCAT('1I', @id);  -- Concatenates '1000I' with the padded id
    UPDATE inversiones
    SET folio_inversion = @folio
    WHERE id = NEW.id;
END //
DELIMITER ;
