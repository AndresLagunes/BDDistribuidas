-- PROCEDIMIENTO DE INSERCIÓN DE INVERSIÓN PARA QUE SE AUTO GENERE EL FOLIO
DELIMITER //
CREATE PROCEDURE InsertarInversion(
    IN folio_contrato_param CHAR(14),
    IN clave_tasa_param CHAR(5),
    IN tipo_inversion_param VARCHAR(30),
    IN monto_invertido_param DECIMAL(12,2),
    IN monto_ganado_param DECIMAL(14,4)
)
BEGIN
    DECLARE next_id INT;
    DECLARE folio_inversion_param CHAR(8);

    -- Obtiene el próximo valor del AUTO_INCREMENT
    SELECT AUTO_INCREMENT INTO next_id
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'inversiones';

    -- Genera el folio_inversion
    SET folio_inversion_param = CONCAT('1I', LPAD(next_id, 5, '0'));

    -- Realiza la inserción
    INSERT INTO inversiones (
        folio_inversion, 
        folio_contrato, 
        clave_tasa, 
        tipo_inversion, 
        monto_invertido, 
        monto_ganado
    ) 
    VALUES (
        folio_inversion_param,
        folio_contrato_param, 
        clave_tasa_param, 
        tipo_inversion_param, 
        monto_invertido_param, 
        monto_ganado_param
    );
END//
DELIMITER ;