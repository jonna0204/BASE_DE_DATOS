CREATE TABLE empresa(
    rut VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(120),
    direccion VARCHAR(120),
    telefono VARCHAR(15),
    correo VARCHAR(80),
    web VARCHAR(50)
);

CREATE TABLE cliente(     
    cliente_rut VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(120),
    correo VARCHAR(80),
    direccion VARCHAR(120),
    celular VARCHAR(15)
);

CREATE TABLE herramienta(    
    idherramienta SERIAL PRIMARY KEY,    
    nombre VARCHAR(120),    
    precio_dia NUMERIC(12,2)            
);

CREATE TABLE arriendo(
    folio SERIAL PRIMARY KEY,
    fecha DATE,
    dias SMALLINT,
    valor_dia NUMERIC(12,2),
    garantia VARCHAR(30),
    herramienta_idherramienta INTEGER,
    cliente_rut VARCHAR(10),
    CONSTRAINT fk_herramienta_idherramienta
        FOREIGN KEY (herramienta_idherramienta)
        REFERENCES herramienta(idherramienta),
    CONSTRAINT fk_cliente_rut
        FOREIGN KEY (cliente_rut)
        REFERENCES cliente(cliente_rut)
);

-- Insertar los datos de una empresa.
INSERT INTO empresa (rut, nombre, direccion, telefono, correo, web)
VALUES ('783454249', 'miniso', 'calle larga 123', '22345433', 'miniso@miniso.cl', 'www.aaaa.cl');

-- Inserte 5 herramientas.
INSERT INTO herramienta(nombre, precio_dia)
VALUES ('Martillo', 1500);
INSERT INTO herramienta(nombre, precio_dia)
VALUES ('Desatornillador', 1000);
INSERT INTO herramienta(nombre, precio_dia)
VALUES ('Torno', 15000);
INSERT INTO herramienta(nombre, precio_dia)
VALUES ('Esmeril', 25000);
INSERT INTO herramienta(nombre, precio_dia)
VALUES ('Sincel', 15000);

-- Insertar 3 clientes.
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular)
VALUES ('187657447', 'Arya Stark', 'aryastark@got.com', 'winterfel 123', '12344323');
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular)
VALUES ('185673447', 'Jon Snow', 'jonsnow@got.com', 'winterfel 456', '12383573');
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular)
VALUES ('189868886', 'Ned Stark', 'nedstark@got.com', 'winterfel 1234', '43243424');

--  Elimina el último cliente.
DELETE FROM cliente WHERE cliente_rut = '189868886';

-- Elimina la primera herramienta.
DELETE FROM herramienta WHERE idherramienta = 1;

-- Inserte 2 arriendos para cada cliente.
INSERT INTO arriendo(fecha, dias, valor_dia, garantia, herramienta_idherramienta, cliente_rut)
VALUES ('15-06-2023', 5, 5000, '2500', 2, '187657447');
INSERT INTO arriendo(fecha, dias, valor_dia, garantia, herramienta_idherramienta, cliente_rut)
VALUES ('20-04-2023', 15, 20000, '15000', 3, '185673447');

-- Modificar el correo del primer cliente
UPDATE cliente SET correo = 'arya@got.cl' WHERE cliente_rut = '187657447';

-- Liste todas las herramientas.
SELECT * FROM herramienta;

-- Liste los arriendos del segundo cliente.
SELECT * FROM arriendo WHERE cliente_rut = '185673447';

-- Liste los clientes cuyo nombre contenga una a.
SELECT * FROM cliente WHERE nombre LIKE '%a%';

-- Obtenga el nombre de la segunda herramienta insertada.
SELECT nombre FROM herramienta ORDER BY idherramienta LIMIT 1 OFFSET 1;

-- Modifique los primeros 2 arriendos insertados con fecha 15/01/2020.
UPDATE arriendo SET fecha = '15-01-2020' WHERE folio IN (SELECT folio FROM arriendo WHERE fecha = '15-06-2023' LIMIT 2);

-- Liste Folio, Fecha y ValorDia de los arriendos de enero del 2020.
SELECT folio, fecha, valor_dia FROM arriendo WHERE EXTRACT(MONTH FROM fecha) = 1 AND EXTRACT(YEAR FROM fecha) = 2020;