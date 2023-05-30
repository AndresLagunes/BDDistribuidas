-- TRIGGER DE FOLIO_CONTRATO
CREATE TRIGGER generar_folio_contrato
BEFORE INSERT ON contrato_inversion
FOR EACH ROW
SET NEW.folio_contrato = CONCAT(NEW.sucursal, LPAD(NEW.id, 5, '0'), LEFT(NEW.rfc_cliente,6));

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
