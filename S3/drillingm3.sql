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
    celular VARCHAR2(15)
);

CREATE TABLE herramienta(    
    idherramienta NUMBER(12) PRIMARY KEY,    
    nombre VARCHAR2(120),    
    preciodia NUMBER(12)            
);

CREATE TABLE arriendo(
    folio NUMBER(12) PRIMARY KEY,
    fecha DATE,
    dias NUMBER(5),
    valordia NUMBER(12),
    garantia VARCHAR2(30),
    herramienta_idherramienta NUMBER(12),
    CONSTRAINT fk_herramienta_idherramienta
        FOREIGN KEY (herramienta_idherramienta)
        REFERENCES herramienta(idherramienta),
    cliente_rut VARCHAR2(10),
    CONSTRAINT fk_cliente_rut
        FOREIGN KEY (cliente_rut)
        REFERENCES cliente(cliente_rut)
);
