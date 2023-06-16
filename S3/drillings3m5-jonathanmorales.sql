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
    CONSTRAINT fk_herramienta_idherramienta
        FOREIGN KEY (herramienta_idherramienta)
        REFERENCES herramienta(idherramienta),
    cliente_rut VARCHAR(10),
    CONSTRAINT fk_cliente_rut
        FOREIGN KEY (cliente_rut)
        REFERENCES cliente(cliente_rut)
);
