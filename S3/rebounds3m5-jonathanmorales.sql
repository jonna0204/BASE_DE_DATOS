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

CREATE TABLE vehiculo(
    idvehiculo SERIAL PRIMARY KEY,
    patente VARCHAR(10),
    marca VARCHAR(20),
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

CREATE TABLE tipovehiculo(
    idtipovehiculo SERIAL PRIMARY KEY,
    nombre VARCHAR(120)
);

CREATE TABLE marca(
    idmarca SERIAL PRIMARY KEY,
    nombre VARCHAR(120)
);
