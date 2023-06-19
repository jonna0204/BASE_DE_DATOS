-- Crear tabla "editoriales"
CREATE TABLE editoriales (
    codigo INT PRIMARY KEY,
    nombre VARCHAR(255)
);

-- Crear tabla "libros"
CREATE TABLE libros (
    codigo INT PRIMARY KEY,
    titulo VARCHAR(255),
    codigoeditorial INT,
    FOREIGN KEY (codigoeditorial) REFERENCES editoriales(codigo)
);

-- Insertar editoriales
INSERT INTO editoriales (codigo, nombre) 
VALUES(1, 'Anaya'),(2, 'Andina'),(3, 'S.M.');

-- Insertar libros
INSERT INTO libros (codigo, titulo, codigoeditorial) 
VALUES(1, 'Don Quijote de La Mancha I', 1),(2, 'El principito', 2),
(3, 'El príncipe', 3),(4, 'Diplomacia', 3),
(5, 'Don Quijote de La Mancha II', 1);

-- Modificar tabla "libros"
ALTER TABLE libros
ADD COLUMN autor VARCHAR(255),
ADD COLUMN precio INT;

-- Agregar autor y precio a los libros ya ingresados
UPDATE libros
SET autor = CASE codigo
    WHEN 1 THEN 'Miguel de Cervantes'
    WHEN 2 THEN 'Antoine Saint-Exupery'
    WHEN 3 THEN 'Maquiavelo'
    WHEN 4 THEN 'Henry Kissinger'
    WHEN 5 THEN 'Miguel de Cervantes'
    END,
    precio = CASE codigo
    WHEN 1 THEN 150
    WHEN 2 THEN 120
    WHEN 3 THEN 180
    WHEN 4 THEN 170
    WHEN 5 THEN 140
    END;

-- Insertar 2 libros nuevos
INSERT INTO libros(codigo, titulo, codigoeditorial,autor,precio)
VALUES (6,'1984',4,'George Orwell',200)
VALUES (7,'Tormenta de espadas',4,'George R. R. Martin',300)