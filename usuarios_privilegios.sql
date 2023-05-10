-- Creación de Usuarios con todos los privilegios en todas las bases de datos de manera remota (rodrigo, juanjo, andres, angel)

-- 1. Crear el usuario con contraseña
CREATE USER rodrigo@'%' IDENTIFIED BY 'rodrigo';
CREATE USER juanjo@'%' IDENTIFIED BY 'juanjo';
CREATE USER andres@'%' IDENTIFIED BY 'andres';
CREATE USER angel@'%' IDENTIFIED BY 'angel';
CREATE USER master@'%' IDENTIFIED BY 'master';

-- 2. Darle privilegios
GRANT ALL PRIVILEGES ON *.* TO rodrigo@'%';
GRANT ALL PRIVILEGES ON *.* TO juanjo@'%';
GRANT ALL PRIVILEGES ON *.* TO andres@'%';
GRANT ALL PRIVILEGES ON *.* TO angel@'%';
GRANT ALL PRIVILEGES ON *.* TO master@'%';

-- 3. Refrescar los privilegios
FLUSH PRIVILEGES;
