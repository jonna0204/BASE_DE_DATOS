CREATE TABLE peliculas (
  id INT PRIMARY KEY,
  pelicula VARCHAR(255),
  estreno INT,
  directo VARCHAR(200)
);

CREATE TABLE reparto (
  id_pelicula INT,
  actor VARCHAR(200),
  FOREIGN KEY (id_pelicula) REFERENCES peliculas(id)
);


--Cargar ambos archivos a su tabla correspondiente.
-- COMANDOS INGRESADOS EN CMD PSQL
--postgres=# \c peliculas
--Ahora está conectado a la base de datos «peliculas» con el usuario «postgres».
--peliculas=# \COPY "peliculas" FROM 'C:\Users\PC\Desktop\DATABASE\S5\ApoyoCSV\peliculas.csv' WITH CSV;
--COPY 100
--peliculas=# \COPY "reparto" FROM 'C:\Users\PC\Desktop\DATABASE\S5\ApoyoCSV\reparto.csv' WITH CSV;
--COPY 1049
--peliculas=#

--Listar todos los actores que aparecen en la película "Titanic", indicando el título de la película,
--año de estreno, director y todo el reparto.
SELECT p.pelicula, p.estreno, p.directo, r.actor
FROM peliculas p
JOIN reparto r ON p.id = r.id_pelicula
WHERE p.pelicula = 'Titanic';

--Listar los 10 directores más populares, indicando su nombre y cuántas películas aparecen
--en el top 100
SELECT p.directo AS director, COUNT(*) AS num_peliculas
FROM peliculas p
WHERE p.id IN (
  SELECT id
  FROM peliculas
  ORDER BY estreno DESC
  LIMIT 100
)
GROUP BY p.directo
ORDER BY num_peliculas DESC;

--Indicar cuantos actores hay.
SELECT COUNT (DISTINCT actor) FROM reparto;

--Indicar las películas estrenadas entre los años 1990 y 1999 (ambos incluidos), ordenadas
--por título de manera ascendente.
SELECT pelicula,estreno FROM peliculas WHERE estreno BETWEEN 1990 AND 1999
ORDER BY estreno ASC;

--Listar los actores de la pelicula más nueva.
SELECT r.actor FROM peliculas p
JOIN reparto r 
ON p.id = r.id_pelicula
WHERE p.estreno = (SELECT MAX(estreno) FROM peliculas);

--Inserte los datos de una nueva película solo en memoria,
--y otra película en el disco duro.


--Actualice 5 directores utilizando ROLLBACK
BEGIN TRANSACTION;
UPDATE peliculas SET directo = 'Martin Scorsese' WHERE id = 1;
UPDATE peliculas SET directo = 'Christopher Nolan' WHERE id = 2;
UPDATE peliculas SET directo = 'Quentin Tarantino' WHERE id = 3;
UPDATE peliculas SET directo = 'Steven Spielberg' WHERE id = 4;
UPDATE peliculas SET directo = 'Guillermo del Toro' WHERE id = 5;
ROLLBACK;

--Inserte 3 actores de la pelicula 'Rambo' utilizando SAVEPOINT
BEGIN TRANSACTION;
SAVEPOINT savepoint_insert;
INSERT INTO reparto (id_pelicula, actor)
SELECT id, 'Sylvester Stallone' FROM peliculas WHERE pelicula = 'Rambo';

INSERT INTO reparto (id_pelicula, actor)
SELECT id, 'Richard Crenna' FROM peliculas WHERE pelicula = 'Rambo';

INSERT INTO reparto (id_pelicula, actor)
SELECT id, 'Brian Dennehy' FROM peliculas WHERE pelicula = 'Rambo';
ROLLBACK TO SAVEPOINT savepoint_insert;

SELECT r.actor FROM reparto r
JOIN peliculas p ON r.id_pelicula = p.id
WHERE p.pelicula = 'Rambo';



--Elimina las películas estrenadas el año 2008 solo en memoria.
BEGIN TRANSACTION;
DELETE FROM peliculas WHERE estreno = 2008;
ROLLBACK;

--Inserte 2 actores para cada película estrenada el 2001.
BEGIN TRANSACTION;
INSERT INTO reparto (id_pelicula, actor)
SELECT id, 'XXXXXXX' FROM peliculas WHERE estreno = 2001;
INSERT INTO reparto (id_pelicula, actor)
SELECT id, 'YYYYYYY' FROM peliculas WHERE estreno = 2001;
ROLLBACK;

--Actualice la película “King Kong” por el nombre de “Donkey Kong”, sin efectuar cambios en
--disco duro.

BEGIN TRANSACTION;
UPDATE peliculas SET pelicula = 'Donkey Kong' WHERE pelicula = 'King Kong';
ROLLBACK;
