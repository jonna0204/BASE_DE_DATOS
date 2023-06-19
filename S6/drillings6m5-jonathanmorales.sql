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
    preciodia NUMERIC(12,2)            
);

CREATE TABLE arriendo(
    folio SERIAL PRIMARY KEY,
    fecha DATE,
    dias SMALLINT,
    valordia NUMERIC(12,2),
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
INSERT INTO herramienta(nombre, preciodia)
VALUES ('Martillo', 1500);
INSERT INTO herramienta(nombre, preciodia)
VALUES ('Desatornillador', 1000);
INSERT INTO herramienta(nombre, preciodia)
VALUES ('Torno', 15000);
INSERT INTO herramienta(nombre, preciodia)
VALUES ('Esmeril', 25000);
INSERT INTO herramienta(nombre, preciodia)
VALUES ('Sincel', 15000);

-- Insertar 3 clientes.
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular)
VALUES ('187657447', 'Arya Stark', 'aryastark@got.com', 'winterfel 123', '12344323');
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular)
VALUES ('185673447', 'Jon Snow', 'jonsnow@got.com', 'winterfel 456', '12383573');
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular)
VALUES ('189868886', 'Ned Stark', 'nedstark@got.com', 'winterfel 1234', '43243424');

--Inserte 2 arriendos para cada cliente.
INSERT INTO arriendo(fecha, dias, valordia, garantia, herramienta_idherramienta, cliente_rut)
VALUES ('2023-06-15', 5, 5000, '2500', 1, '187657447');
INSERT INTO arriendo(fecha, dias, valordia, garantia, herramienta_idherramienta, cliente_rut)
VALUES ('2022-10-01', 15, 20000, '15000', 2, '185673447');


-- Listar todos los arriendos con las siguientes columnas: Folio, Fecha, Días, ValorDia, 
--NombreCliente, RutCliente.

SELECT a.folio AS Folio, a.fecha AS Fecha, a.dias AS Días, a.valordia AS ValorDia,
       c.nombre AS NombreCliente, c.cliente_rut AS RutCliente
FROM arriendo a
JOIN cliente c ON a.cliente_rut = c.cliente_rut;


-- Listar los clientes sin arriendos.
SELECT cliente_rut, nombre
FROM cliente
WHERE cliente_rut NOT IN (SELECT cliente_rut FROM arriendo);


-- Liste RUT y Nombre de las tablas empresa y cliente.
SELECT rut, nombre
FROM empresa
UNION ALL
SELECT cliente_rut, nombre
FROM cliente;

-- Liste la cantidad de arriendos por mes
SELECT EXTRACT(MONTH FROM fecha) AS Mes, COUNT(*) AS CantidadArriendos
FROM arriendo
GROUP BY EXTRACT(MONTH FROM fecha)
ORDER BY EXTRACT(MONTH FROM fecha);



