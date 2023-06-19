CREATE TABLE marca(
    idmarca SERIAL PRIMARY KEY,
    nombre VARCHAR(120)
);

CREATE TABLE tipovehiculo(
    idtipovehiculo SERIAL PRIMARY KEY,
    nombre VARCHAR(120)
);

CREATE TABLE vehiculo(
    idvehiculo SERIAL PRIMARY KEY,
    patente VARCHAR(10),
    modelo VARCHAR(20),
    color VARCHAR(15),
    precio NUMERIC(12,2),
    frecuencia_mantencion SMALLINT,
    marca_idmarca INTEGER,
    CONSTRAINT fk_marca_idmarca
        FOREIGN KEY (marca_idmarca)
        REFERENCES marca(idmarca),
    tipovehiculo_idtipovehiculo INTEGER,
    CONSTRAINT fk_tipovehiculo_idtipovehiculo
        FOREIGN KEY (tipovehiculo_idtipovehiculo)
        REFERENCES tipovehiculo(idtipovehiculo)
);

CREATE TABLE cliente(
    cliente_rut VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(120),
    correo VARCHAR(80),
    direccion VARCHAR(120),
    celular VARCHAR(15),
    alta BOOLEAN
);

CREATE TABLE venta(
    folio SERIAL PRIMARY KEY,
    fecha DATE,
    monto NUMERIC(12,2),
    cliente_rut VARCHAR(10),
    CONSTRAINT fk_cliente_rut
        FOREIGN KEY(cliente_rut)
        REFERENCES cliente(cliente_rut),
    vehiculo_idvehiculo INTEGER,
    CONSTRAINT fk_vehiculo_idvehiculo
        FOREIGN KEY(vehiculo_idvehiculo)
        REFERENCES vehiculo(idvehiculo)
);

CREATE TABLE empresa(
    rut VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(120),
    direccion VARCHAR(120),
    telefono VARCHAR(15),
    correo VARCHAR(80),
    web VARCHAR(50)
);

***********************************************************************
-- Inserte los datos de una empresa.
INSERT INTO empresa (rut, nombre, direccion, telefono, correo, web)
VALUES ('783454249', 'miniso', 'calle larga 123', '22345433', 'miniso@miniso.cl', 'www.aaaa.cl');

-- Inserte 2 tipos de vehículo.
INSERT INTO tipovehiculo(nombre)
VALUES ('City car');
INSERT INTO tipovehiculo(nombre)
VALUES ('Monster Truck');

-- Inserte 3 clientes.
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular, alta)
VALUES ('187657447', 'Arya Stark', 'aryastark@got.com', 'winterfel 123', '12344323', TRUE);
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular, alta)
VALUES ('185673447', 'Jon Snow', 'jonsnow@got.com', 'winterfel 456', '12383573', TRUE);
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular, alta)
VALUES ('189868886', 'Ned Stark', 'nedstark@got.com', 'winterfel 1234', '43243424', TRUE);

-- Inserte 2 marcas.
INSERT INTO marca(nombre)
VALUES ('Audi');
INSERT INTO marca(nombre)
VALUES ('Bmw');

-- Inserte 5 vehículos.
INSERT INTO vehiculo (patente, modelo, color, precio, frecuencia_mantencion, marca_idmarca, tipovehiculo_idtipovehiculo)
VALUES ('ABCD1', 'a2', 'black', 22000000, 2, 1, 1);
INSERT INTO vehiculo(patente, modelo, color, precio, frecuencia_mantencion, marca_idmarca, tipovehiculo_idtipovehiculo)
VALUES ('ABCD2', 'b6', 'white', 10000000, 1, 1, 2);
INSERT INTO vehiculo(patente, modelo, color, precio, frecuencia_mantencion, marca_idmarca, tipovehiculo_idtipovehiculo)
VALUES ('ABCD3', 'c62', 'black-grey', 5000000, 3, 2, 1);
INSERT INTO vehiculo(patente, modelo, color, precio, frecuencia_mantencion, marca_idmarca, tipovehiculo_idtipovehiculo)
VALUES ('ABCD4', 'f6', 'grey', 2000000, 3, 2, 2);
INSERT INTO vehiculo(patente, modelo, color, precio, frecuencia_mantencion, marca_idmarca, tipovehiculo_idtipovehiculo)
VALUES ('ABCD5', 'kj33', 'black', 2000000, 5, 1, 1);

-- Inserte 1 venta para cada cliente.
INSERT INTO venta (fecha, monto, cliente_rut, vehiculo_idvehiculo)
VALUES ('15-06-2023', 15000, '187657447', 1);
INSERT INTO venta (fecha, monto, cliente_rut, vehiculo_idvehiculo)
VALUES ('20-05-2023', 20000, '185673447', 2);
******************************************************************************

--Listar todos los vehiculos que no han sido vendidos.
SELECT *
FROM vehiculo
WHERE idvehiculo NOT IN (SELECT vehiculo_idvehiculo FROM venta);

-- Listar todas las ventas de enero del 2020 con las columnas: Folio, FechaVenta, 
--MontoVenta, NombreCliente, RutCliente, Patente, NombreMarca, y Modelo.
SELECT v.folio AS Folio, v.fecha AS FechaVenta, v.monto AS MontoVenta,
       c.nombre AS NombreCliente, c.cliente_rut AS RutCliente,
       ve.patente AS Patente, m.nombre AS NombreMarca, ve.modelo AS Modelo
FROM venta v
JOIN cliente c ON v.cliente_rut = c.cliente_rut
JOIN vehiculo ve ON v.vehiculo_idvehiculo = ve.idvehiculo
JOIN marca m ON ve.marca_idmarca = m.idmarca
WHERE EXTRACT(YEAR FROM v.fecha) = 2020 AND EXTRACT(MONTH FROM v.fecha) = 1;

-- Sumar las ventas por mes y marca del año 2020.
SELECT EXTRACT(MONTH FROM v.fecha) AS Mes,
       m.nombre AS Marca,
       SUM(v.monto) AS TotalVentas
FROM venta v
JOIN vehiculo ve ON v.vehiculo_idvehiculo = ve.idvehiculo
JOIN marca m ON ve.marca_idmarca = m.idmarca
WHERE EXTRACT(YEAR FROM v.fecha) = 2020
GROUP BY EXTRACT(MONTH FROM v.fecha), m.nombre;


-- Listar Rut y Nombre de las tablas cliente y empresa.
SELECT cliente_rut AS Rut, nombre
FROM cliente
UNION ALL
SELECT rut, nombre
FROM empresa;



