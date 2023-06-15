CREATE TABLE empresa(
    rut VARCHAR2(10) PRIMARY KEY,
    nombre VARCHAR2(120),
    direccion VARCHAR2(120),
    telefono VARCHAR2(15),
    correo VARCHAR2(80),
    web VARCHAR2(50)
);

CREATE TABLE cliente(     
    cliente_rut VARCHAR2(10) PRIMARY KEY,
    nombre VARCHAR2(120),
    correo VARCHAR2(80),
    direccion VARCHAR2(120),
    celular VARCHAR2(15),
    alta CHAR(1)
);

CREATE TABLE venta(    
    folio NUMBER(12) PRIMARY KEY,    
    fecha DATE,    
    monto NUMBER(12),         
    cliente_rut VARCHAR2(10),    
    CONSTRAINT fk_cliente_rut        
        FOREIGN KEY(cliente_rut)            
        REFERENCES cliente(cliente_rut),
    vehiculo_idvehiculo NUMBER(12),    
    CONSTRAINT vehiculo_idvehiculo        
        FOREIGN KEY(vehiculo_idvehiculo)            
        REFERENCES vehiculo(idvehiculo)
);

CREATE TABLE vehiculo(
    idvehiculo NUMBER(12) PRIMARY KEY,
    patente VARCHAR2(10),
    marca VARCHAR2(20),
    modelo VARCHAR2(20),
    color VARCHAR2(15),
    precio NUMBER(12),
    frecuencia_mantencion NUMBER(5),
    marca_idmarca NUMBER(12),
    CONSTRAINT marca_idmarca
        FOREIGN KEY (marca_idmarca)
        REFERENCES marca(idmarca),
    tipovehiculo_IDtipovehiculo NUMBER(12),
    CONSTRAINT tipovehiculo_IDtipovehiculo
        FOREIGN KEY (tipovehiculo_IDtipovehiculo)
        REFERENCES tipovehiculo(idtipovehiculo)
);

CREATE TABLE tipovehiculo(
    idtipovehiculo NUMBER(12) PRIMARY KEY,
    nombre VARCHAR2(120)
);

CREATE TABLE marca(
    idmarca NUMBER(12) PRIMARY KEY,
    nombre VARCHAR2(120)
);


INSERT INTO empresa (rut, nombre, direccion, telefono, correo, web)
VALUES("783454249","miniso","calle larga 123",22345433,"miniso@miniso.cl","www.aaaa.cl");

INSERT INTO tipovehiculo(idtipovehiculo, nombre)
VALUES(0001,"City car")
VALUES(0002,"Monster Truck");

INSERT INTO cliente(cliente_rut,nombre,correo,direccion,celular,alta)
VALUES("187657447","Arya Stark","aryastark@got.com","winterfel 123",12344323,1)
VALUES("185673447","Jon Snow","jonsnow@got.com","winterfel 456",12383573,1)
VALUES("189868886","Ned Stark","nedstark@got.com","winterfel 1234",43243424,1)