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
    CONSTRAINT marca_idmarca
        FOREIGN KEY (marca_idmarca)
        REFERENCES marca(idmarca),
    tipovehiculo_IDtipovehiculo INTEGER,
    CONSTRAINT tipovehiculo_IDtipovehiculo
        FOREIGN KEY (tipovehiculo_IDtipovehiculo)
        REFERENCES tipovehiculo(idtipovehiculo)
);

CREATE TABLE cliente(     
    cliente_rut VARCHAR(10) PRIMARY KEY,
    nombre VARCHAR(120),
    correo VARCHAR(80),
    direccion VARCHAR(120),
    celular VARCHAR(15),
    alta CHAR(1)
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
    CONSTRAINT vehiculo_idvehiculo        
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

--Inserte los datos de una empresa.
INSERT INTO empresa (rut, nombre, direccion, telefono, correo, web)
VALUES ('783454249', 'miniso', 'calle larga 123', '22345433', 'miniso@miniso.cl', 'www.aaaa.cl');

--Inserte 2 tipos de vehículo.
INSERT INTO tipovehiculo(idtipovehiculo, nombre)
VALUES (0001, 'City car');
INSERT INTO tipovehiculo(idtipovehiculo, nombre)
VALUES (0002, 'Monster Truck');

--Inserte 3 clientes.
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular, alta)
VALUES ('187657447', 'Arya Stark', 'aryastark@got.com', 'winterfel 123', '12344323', '1');
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular, alta)
VALUES ('185673447', 'Jon Snow', 'jonsnow@got.com', 'winterfel 456', '12383573', '1');
INSERT INTO cliente(cliente_rut, nombre, correo, direccion, celular, alta)
VALUES ('189868886', 'Ned Stark', 'nedstark@got.com', 'winterfel 1234', '43243424', '1');

--Inserte 2 marcas.
INSERT INTO marca(nombre)
VALUES ('Audi');
INSERT INTO marca(nombre)
VALUES ('Bmw')

--Inserte 5 vehículos.
INSERT INTO vehiculo(patente,modelo,color,precio,frecuencia_mantencion)
VALUES ('ABCD1','a2','black','22000000',2);
INSERT INTO vehiculo(patente,modelo,color,precio,frecuencia_mantencion)
VALUES ('ABCD2','b6','white','10000000',1);
INSERT INTO vehiculo(patente,modelo,color,precio,frecuencia_mantencion)
VALUES ('ABCD3','c62','black-grey','5000000',3);
INSERT INTO vehiculo(patente,modelo,color,precio,frecuencia_mantencion)
VALUES ('ABCD4','f6','grey','2000000',3);
INSERT INTO vehiculo(patente,modelo,color,precio,frecuencia_mantencion)
VALUES ('ABCD5','kj33','black','2000000',5);

--Elimina el último cliente.
DELETE FROM cliente WHERE cliente_rut = '189868886';

--Inserte 1 venta para cada cliente.
INSERT INTO venta (fecha, monto, cliente_rut, vehiculo_idvehiculo)
VALUES ('15-06-2023', 15000, '187657447', 1);
INSERT INTO venta (fecha, monto, cliente_rut, vehiculo_idvehiculo)
VALUES ('20-05-2023', 20000, '185673447', 2);

--Modifique el nombre del segundo cliente
UPDATE cliente SET nombre = 'Sansa Stark' WHERE cliente_rut = '187657447';

--Liste todas las ventas.
SELECT * FROM venta;

--Liste las ventas del primer cliente.
SELECT * FROM venta WHERE cliente_rut = '187657447';

--Obtenga las patentes de todos los vehiculos.
SELECT patente FROM vehiculo;