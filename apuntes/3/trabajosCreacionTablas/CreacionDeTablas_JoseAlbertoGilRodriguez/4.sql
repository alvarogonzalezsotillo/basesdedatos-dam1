----- 4.sql


--  4. Nuevos datos a insertar
--  - El coche con matr�cula 1234ABC se compr� rojo el 1-1-11. 
--    Se repint� a verde el 1-6-11.
--  - Los Renault deben realizar un mantenimiento cada 15000 km. 
--    1111ABC realiz� su primera revisi�n el 1-3-12. 
--    4321ABC se compr� el 1-2-12, y lleva dos revisiones, 
--    el 1-4-12 y el 1-10-12.
--  - Los mercedes realizan un mantenimiento cada 20000 km. 
--    1234ABC se compr� el 1-1-11, y se revis� por primera vez el 1-4-12.
--  - Todos los coches se revisan a los 4 a�os en la ITV.
--  - El coche con matr�cula 1111abc tiene asientos calefactados.


-- MODIFICAR LA TABLA COCHE CON LA INCORPORACI�N DE LA COLUMNA FECHA_COMPRA

ALTER TABLE COCHE ADD FECHA_COMPRA DATE;


-- INSERTAR FECHAS DE COMPRAS DE LOS COCHES

UPDATE COCHE 
SET FECHA_COMPRA = TO_DATE('01/01/2011','DD/MM/YYYY')
WHERE BASTIDOR = 'ABCDEFGH100000001';

UPDATE COCHE 
SET FECHA_COMPRA = TO_DATE('01/02/2010','DD/MM/YYYY')
WHERE BASTIDOR = 'ABCDEFGH100000002';

UPDATE COCHE 
SET FECHA_COMPRA = TO_DATE('01/02/2012','DD/MM/YYYY')
WHERE BASTIDOR = 'ABCDEFGH100000003';

UPDATE COCHE 
SET FECHA_COMPRA = TO_DATE('01/04/2012','DD/MM/YYYY')
WHERE BASTIDOR = 'ABCDEFGH100000004';


-- MODIFICAR RESTRICCI�N NOT NULL DE FECHA_COMPRA EN LA TABLA COCHE

ALTER TABLE COCHE MODIFY FECHA_COMPRA DATE NOT NULL;

   
-- REPINTADO DEL COCHE MATRICULA 1234ABC EL 1-6-11 A COLOR VERDE
INSERT INTO  REPINTADO (ID_REPINTADO, N_BASTIDOR,
REPINTADO, FECHA_REPINTADO)
VALUES (501, 'ABCDEFGH100000001', 
'VERDE', TO_DATE('01/06/2011','DD/MM/YYYY'));

-- REVISION DE MANTENIMIENTO EN LOS RENAULT CADA 15.000 KM
INSERT INTO REVISION_MANTENIMIENTO (ID_REVI_MAN, NU_BASTIDOR,
FECHA_REV_MAN, KMS_REV_MAN)
VALUES (5001, 'ABCDEFGH100000002', 
TO_DATE('01/03/2012','DD/MM/YYYY'), 15000);

INSERT INTO REVISION_MANTENIMIENTO
VALUES (5002, 'ABCDEFGH100000003', 
TO_DATE('01/04/2012','DD/MM/YYYY'), 15000);

INSERT INTO REVISION_MANTENIMIENTO
VALUES (5003, 'ABCDEFGH100000003', 
TO_DATE('01/10/2012','DD/MM/YYYY'), 30000);

INSERT INTO REVISION_MANTENIMIENTO
VALUES (5004, 'ABCDEFGH100000001', 
TO_DATE('01/04/2012','DD/MM/YYYY'), 20000);

-- REVISION CADA 4 A�OS EN ITV
INSERT INTO REVISION_ITV
VALUES (10001, 'ABCDEFGH100000001', 
TO_DATE('01/01/2015','DD/MM/YYYY'));

INSERT INTO REVISION_ITV
VALUES (10002, 'ABCDEFGH100000002', 
TO_DATE('01/02/2014','DD/MM/YYYY'));

INSERT INTO REVISION_ITV
VALUES (10003, 'ABCDEFGH100000003', 
TO_DATE('01/02/2016','DD/MM/YYYY'));

INSERT INTO REVISION_ITV
VALUES (10004, 'ABCDEFGH100000004', 
TO_DATE('01/04/2016','DD/MM/YYYY'));

-- MODIFICO EL ACABADO DEL COCHE CON MAR�CULA 1111ABC
UPDATE ACABADO
SET ASIENTOS_CALEFACTADOS = 'SI'
WHERE ID_ACABADO = 1002;
