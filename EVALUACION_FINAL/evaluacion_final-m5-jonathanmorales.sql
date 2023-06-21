--insertar, modificar y eliminar un Customer.
INSERT INTO customer(store_id, first_name, last_name, email,address_id, activebool, create_date, last_update,active)
VALUES(1,'Arya','Stark','aryastark@sakilacustomer.org',1,'true','2006-02-14','2013-05-26',1);

UPDATE customer SET email = 'sansa.stark@sakilacustomer.org'
WHERE customer_id = 9;

DELETE FROM customer WHERE first_name = 'Arya';

SELECT * FROM customer;


--insertar, modificar y eliminar un Staff.
INSERT INTO staff(first_name, last_name, address_id, email, store_id, active, username, password)
VALUES('Jon','Snow','5','jon.snow@sakilastaff.com','3','true','jon','abcde4');

UPDATE staff SET last_name = 'Stark'
WHERE staff_id = 3;

DELETE FROM staff WHERE last_name = 'Stark';

SELECT * FROM staff;


--insertar, modificar y eliminar un Actor.
INSERT INTO actor(first_name, last_name, last_update)
VALUES('Daenerys','Targaryen','06-06-2023');

UPDATE actor SET last_update = '20-05-2022'
WHERE first_name = 'Daenerys';

DELETE FROM actor WHERE last_name = 'Targaryen';

SELECT * FROM actor;

--Listar todas las “rental” con los datos del “customer” dado un año y mes.
SELECT rental.*, customer.* FROM rental
JOIN customer
  ON rental.customer_id = customer.customer_id
WHERE rental.rental_date >= '2005-05-01' AND rental.rental_date < '2008-06-01';


--Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
SELECT payment_id, payment_date AS fecha, amount FROM payment
ORDER BY payment_date ASC;

--Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.
SELECT * FROM film WHERE release_year = 2006 AND rental_rate > 4;

--Diccionario de datos, ver la constitucion de la base de datos y documentación
SELECT 
    t1.table_name AS tabla_nombre,
    t1.column_name AS columna_nombre,
    t1.column_default AS columna_defecto,
    t1.is_nullable AS columna_nulo,
    t1.data_type AS columna_tipo_dato,
    CASE
        WHEN t1.numeric_precision IS NOT NULL THEN t1.numeric_precision
        ELSE t1.character_maximum_length
    END AS columna_longitud,
    pg_catalog.col_description(t2.oid, t1.ordinal_position::int) AS columna_descripcion,
    t1.domain_name AS columna_dominio
FROM information_schema.columns t1 INNER JOIN pg_class t2 ON t2.relname = t1.table_name
WHERE t1.table_schema = 'public'
ORDER BY t1.table_name;


					