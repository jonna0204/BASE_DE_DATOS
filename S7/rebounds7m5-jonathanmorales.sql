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

-- Listar los clientes sin ventas por medio de una subconsulta.
SELECT cliente_rut, nombre
FROM cliente
WHERE cliente_rut NOT IN (SELECT DISTINCT cliente_rut FROM venta);


-- Listar todas ventas con las siguientes columnas: Folio, Fecha, Monto, NombreCliente, 
--RutCliente.
SELECT venta.folio, venta.fecha, venta.monto, cliente.nombre AS NombreCliente, cliente.cliente_rut AS RutCliente
FROM venta
JOIN cliente ON venta.cliente_rut = cliente.cliente_rut;


-- Clasificar los clientes según la siguiente tabla:
SELECT cliente_rut, nombre, correo, direccion, celular,
    CASE
        WHEN total_ventas <= 1000000 THEN 'Standard'
        WHEN total_ventas <= 3000000 THEN 'Gold'
        ELSE 'Premium'
    END AS Clasificacion
FROM (
    SELECT c.cliente_rut, c.nombre, c.correo, c.direccion, c.celular, COALESCE(SUM(v.monto), 0) AS total_ventas
    FROM cliente c
    LEFT JOIN venta v ON c.cliente_rut = v.cliente_rut
    WHERE v.fecha >= DATE_TRUNC('year', CURRENT_DATE) -- Filtrar ventas del año actual
    GROUP BY c.cliente_rut
) AS subconsulta;



-- Por medio de una subconsulta, listar las ventas con la marca del vehículo más vendido.
SELECT venta.folio, venta.fecha, venta.monto, cliente.nombre AS NombreCliente, cliente.cliente_rut AS RutCliente, m.nombre AS MarcaMasVendida
FROM venta
JOIN cliente ON venta.cliente_rut = cliente.cliente_rut
JOIN vehiculo v ON venta.vehiculo_idvehiculo = v.idvehiculo
JOIN marca m ON v.marca_idmarca = m.idmarca
WHERE v.marca_idmarca = (
    SELECT marca_idmarca
    FROM (
        SELECT marca_idmarca, COUNT(*) AS total_ventas
        FROM venta
        GROUP BY marca_idmarca
        ORDER BY total_ventas DESC
        LIMIT 1
    ) AS subconsulta
);
