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
VALUES ('15-06-2023', 5, 5000, '2500', 1, '187657447');
INSERT INTO arriendo(fecha, dias, valordia, garantia, herramienta_idherramienta, cliente_rut)
VALUES ('15-06-2023', 15, 20000, '15000', 2, '185673447');

-- Listar los clientes sin arriendos por medio de una subconsulta.
SELECT cliente_rut, nombre, correo, direccion, celular
FROM cliente
WHERE cliente_rut NOT IN (SELECT DISTINCT cliente_rut FROM arriendo);


-- Listar todos los arriendos con las siguientes columnas: Folio, Fecha, Dias, ValorDia, 
--NombreCliente, RutCliente
SELECT a.folio, a.fecha, a.dias, a.valordia, c.nombre AS nombre_cliente, c.cliente_rut AS rut_cliente
FROM arriendo a
JOIN cliente c ON a.cliente_rut = c.cliente_rut;


-- Por medio de una subconsulta, listar los clientes con el nombre de la herramienta más 
--arrendada
SELECT c.nombre AS nombre_cliente, t.nombre AS nombre_herramienta
FROM cliente c
JOIN arriendo a ON a.cliente_rut = c.cliente_rut
JOIN herramienta t ON a.herramienta_idherramienta = t.idherramienta
WHERE t.nombre = (
    SELECT nombre
    FROM herramienta
    WHERE idherramienta = (
        SELECT herramienta_idherramienta
        FROM arriendo
        GROUP BY herramienta_idherramienta
        ORDER BY COUNT(*) DESC
        LIMIT 1
    )
);

