
--creacion de tablas
create table Pieza_Simple
	(id number(6,0),serial_number varchar(25),part_Number varchar(25),id_piezaCompuesta number(6,0), nombre varchar(25));
create table Pieza_Compuesta
	(id number(6,0), id_piezaCompuesta number(6,0), nombre varchar(25));
--creacion de las pk	
alter table Pieza_Simple
add CONSTRAINTS PK_Pieza_Simple
Primary Key (id);

alter table Pieza_Compuesta
add CONSTRAINTS PK_Pieza_Compuesta
Primary Key (id);
--creacion de las fk
alter table Pieza_Simple
add CONSTRAINTS FK_Simple_Compuesta
FOREIGN key (id_piezaCompuesta) references Pieza_Compuesta(id);

alter table Pieza_Compuesta
add CONSTRAINTS FK_Compuesta_Compuesta
FOREIGN key (id_piezaCompuesta) references Pieza_Compuesta(id);

--valores que no pueden se null. No va a ser null nada, sólo el id_piezacompuesta 
--en el caso de la tabla pieza compuesta.
alter table Pieza_Simple
add CONSTRAINTS serialNumberNotNull
check (serial_number is not null);

alter table Pieza_Simple
add CONSTRAINTS partNumberNotNull
check (part_number is not null);

alter table Pieza_Simple
add CONSTRAINTS idCompuestaNotNull
check (id_piezaCompuesta is not null);

alter table Pieza_Simple
add CONSTRAINTS nombrePSNotNull
check (nombre is not null);

alter table Pieza_Compuesta
add CONSTRAINTS nombrePCNotNull
check (nombre is not null);


--Creacion de las secuencias

--Secuencia para obtener el ID, es tanto el id de la tabla piezas compuestas, 
--como para la tabla pieza_simple
create sequence SECUENCIA_PIEZA_ID
increment by 1
start WITH 1
MAXVALUE 999999
MINVALUE 1;

--Secuencia para obtener el serial number
create sequence SECUENCIA_SERIALNUMBER
increment by 1
start WITH 1
MAXVALUE 999999
MINVALUE 1;

--Trigger para conseguir que si no ponemos los id de las piezas al introducir los datos,
--los ponga automáticamente desde la secuencia_pieza_id ya creada
create or replace 
trigger SECUENCIA_PIEZA  
   before insert on "PIEZA_COMPUESTA" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end SECUENCIA_PIEZA;
/

create or replace 
trigger SECUENCIAPIEZAID  
   before insert on "PIEZA_SIMPLE" 
   for each row 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end SECUENCIAPIEZAID;
/

--Creación de un trigger para que si no introducimos el SN de una pieza lo ponga de forma automática desde
--la secuencia creada SECUENCIA_SERIALNUMBER
create or replace 
trigger SERIAL_NUMBER  
   before insert on "PIEZA_SIMPLE" 
   for each row 
declare
  snletras varchar(25);
  snnum varchar(25);
begin  
   if inserting then 
      if :NEW."SERIAL_NUMBER" is null then
         select 'SN-'||SECUENCIA_SERIALNUMBER.nextval into :NEW."SERIAL_NUMBER" from dual; 
      end if; 
   end if; 
end;
/

--Funcion que comprueba si una pieza compuesta es un avion
create or replace 
FUNCTION ES_AVION(id_avion numeric) RETURN numeric AS 
is_avion numeric;
BEGIN
  select id_piezacompuesta into is_avion from pieza_compuesta where id=id_avion;

  if (is_avion is not null) then
    RETURN 0;
  else
    return 1;
  end if;
END ES_AVION;
/

--Funcion que cuenta el numero de piezas simples en una pieza compuesta
create or replace 
FUNCTION CONTADOR_PIEZAS(id_pieza_compuesta numeric) RETURN numeric AS 
total numeric;
BEGIN
  select count (s.id) into total
  from pieza_simple s
  where s.id_piezacompuesta in (
            select c.id 
            from pieza_compuesta c
            start with c.id=id_pieza_compuesta
            connect by prior c.id=c.id_piezacompuesta);
              
  return total;
END CONTADOR_PIEZAS;
/

--Funcion que provoca un error si un avion tiene mas de 10 piezas simples, si no introducimos
--el id de un avion tambien da error
create or replace 
FUNCTION COMPRUEBA_AVION (id_avion numeric) RETURN VARCHAR2 AS 
comprobacion numeric;
piezas_simples numeric;
BEGIN

    select es_avion(id_avion) into comprobacion from dual;

    if comprobacion = 1 then
      select contador_piezas(id_avion) into piezas_simples from dual;
      if (piezas_simples < 10) then
        return 'Es una avion valida.';
      else
        raise_application_error(-20000,'El avion tiene demasiadas piezas');
      end if;
    else
      raise_application_error (-20001, 'El id no es de una avion');
    end if;
    
END COMPRUEBA_AVION;
/

--Funcion que comprueba que una pieza compuesta no tenga mas de 4 piezas simples,
--sino dara un error. Tambien da error si el id es el de un avion.
create or replace 
FUNCTION COMPRUEBA_PIEZA(id_pieza number) RETURN VARCHAR2 AS 
avion exception;
numeropiezasexcedido exception;
aviontrue number;
numeroPiezasSimples number;
BEGIN
 select es_avion (id_pieza) into aviontrue from dual;
 if aviontrue=1 then
   raise avion;
 
 else
  select contador_piezas (id_pieza) into numeropiezasSimples from dual;
    if numeropiezassimples<=4 then
      return 'El numero de piezas simples que la componen es correcto.';
    else
      raise numeropiezasexcedido;
    end if;  
   end if; 
END COMPRUEBA_PIEZA;
/

--Procedimiento para crear piezas simples, lo necesitaremos en todos los procedimientos de cerar aviones.
create or replace 
PROCEDURE CREAR_PIEZA_SIMPLE (id_padre numeric, pn varchar2, sn varchar2, nbr varchar2) AS 
BEGIN
  insert into pieza_simple (id_piezacompuesta,part_number,serial_number,nombre) 
  values (id_padre, pn, sn, nbr);
END CREAR_PIEZA_SIMPLE;
/

--Procedimiento para crear piezas compuestas, lo necesitaremos en todos los procedimientos de crear aviones.
create or replace 
PROCEDURE CREAR_PIEZA_COMPUESTA (id_padre numeric, nbr varchar2) AS 
BEGIN
  insert into pieza_compuesta (id_piezacompuesta, nombre)
  values (id_padre, nbr);
END CREAR_PIEZA_COMPUESTA;
/

--Procedimiento que crea un avion concreto al pasarle el id de dicho avion.
create or replace PROCEDURE CREAR_AVION(id_avion numeric) AS 
id_intermedio numeric;
id_intermedio2 numeric;
BEGIN
  insert into pieza_compuesta (id, nombre) values (id_avion, 'Avion 1');
 
  crear_pieza_compuesta(id_avion,'Cabina');
  select id into id_intermedio 
	from pieza_compuesta 
	where nombre like 'Cabina' and id_piezacompuesta=id_avion;
  crear_pieza_simple(id_intermedio,'PN-002','SN-1004','Asiento 2');
  crear_pieza_simple(id_intermedio,'PN-002','SN-1005','Asiento 3');
  
  crear_pieza_compuesta(id_intermedio,'Asiento Piloto');
  select id into id_intermedio2 
	from pieza_compuesta 
	where nombre like 'Asiento Piloto' and id_piezacompuesta=id_intermedio;
  crear_pieza_simple(id_intermedio,'PN-002','SN-1002','Asiento 1');
  crear_pieza_simple(id_intermedio,'PN-003','SN-1003','Controles');
  
  crear_pieza_simple(id_avion,'PN-004','SN-1006','Motor1');
  crear_pieza_simple(id_avion,'PN-004','SN-1007','Motor2');
  crear_pieza_simple(id_avion,'PN-001','SN-1001','Fuselaje');
END CREAR_AVION;
/

--Realizacion de la vista pedida, cuyo nombre es AVIONES_PROFESOR y lista todo.
Create view AVIONES_PROFESOR AS
	(SELECT ID AS PARTE_ID, ID_PIEZACOMPUESTA AS PARTE_PADRE, NOMBRE, NULL AS SN, NULL AS PN
		FROM PIEZA_COMPUESTA)
		UNION
(SELECT ID AS PARTE_ID, ID_PIEZACOMPUESTA AS PARTE_PADRE, NOMBRE, SERIAL_NUMBER AS SN, PART_NUMBER AS PN
	FROM PIEZA_SIMPLE);

--Procedimiento que borra piezas simples, será de utilidad para los procedimientos
--de borrado de aviones.
CREATE OR REPLACE PROCEDURE BORRAR_PIEZA_SIMPLE (ID_PIEZA_PADRE number) AS 
BEGIN

  DELETE FROM pieza_simple 
  WHERE id_piezacompuesta=id_pieza_padre;
  
END BORRAR_PIEZA_SIMPLE;
/	

--Procedimiento que borra piezas compuestas, será de utilidad para los procedimientos
--de borrado de aviones.
CREATE OR REPLACE PROCEDURE BORRAR_PIEZA_COMPUESTA (ID_PIEZA_PADRE number) AS 
PIEZAS_CONTENIDAS PIEZA_COMPUESTA%ROWTYPE;

BEGIN

FOR PIEZAS_CONTENIDAS IN (select c.id 
            from pieza_compuesta c
            start with c.id=ID_PIEZA_PADRE
            connect by prior c.id=c.id_piezacompuesta 
            ORDER BY 1 DESC)
LOOP
         BORRAR_PIEZA_SIMPLE(PIEZAS_CONTENIDAS.ID);
         DELETE FROM pieza_compuesta
         WHERE ID=PIEZAS_CONTENIDAS.ID;
END LOOP;
END BORRAR_PIEZA_COMPUESTA;
/

--Procedimiento que borra un avion incluidas todas sus piezas al pasarle un id de un avion
create or replace 
PROCEDURE BORRAR_AVION (ID_PIEZA_PADRE number) AS
PIEZAS_CONTENIDAS PIEZA_COMPUESTA%ROWTYPE;

BEGIN

FOR PIEZAS_CONTENIDAS IN (select c.id
            from pieza_compuesta c
            start with c.id=ID_PIEZA_PADRE
            connect by prior c.id=c.id_piezacompuesta
            ORDER BY 1 DESC)
LOOP
         BORRAR_PIEZA_SIMPLE(PIEZAS_CONTENIDAS.ID);
         if(piezas_contenidas.id!=id_pieza_padre)then
			 DELETE FROM pieza_compuesta
			 WHERE ID=PIEZAS_CONTENIDAS.ID;
         end if;
END LOOP;
  delete from pieza_compuesta
  where id=id_pieza_padre;
END BORRAR_AVION;
/

--Procedimiento encargado de borrar todas las aviones con sus piezas.
CREATE OR REPLACE PROCEDURE BORRAR_AVIONES AS 
AVIONES PIEZA_COMPUESTA%ROWTYPE;
BEGIN
 FOR AVIONES IN (SELECT ID
                 FROM pieza_compuesta
                 WHERE id_piezacompuesta IS NULL)
 LOOP
  BORRAR_AVION(AVIONES.ID);
 END LOOP;
END BORRAR_AVIONES;
/

--Procedimiento encargado de copiar piezas simples, se utilizará en el procedimiento copiar_piezaCompuesta
--que nos sera necesario para copiar un avion
CREATE OR REPLACE PROCEDURE COPIAR_PIEZA_SIMPLE (ID_PADRE_ORIGINAL NUMERIC, ID_PADRE_NUEVO NUMERIC) AS 
PIEZAS PIEZA_SIMPLE%ROWTYPE;
BEGIN
  FOR PIEZAS IN (SELECT * FROM PIEZA_SIMPLE WHERE ID_PIEZACOMPUESTA=ID_PADRE_ORIGINAL)
  LOOP
    INSERT INTO PIEZA_SIMPLE (ID_PIEZACOMPUESTA, PART_NUMBER, NOMBRE)
    VALUES (ID_PADRE_NUEVO, PIEZAS.PART_NUMBER, PIEZAS.NOMBRE);
  END LOOP;
END COPIAR_PIEZA_SIMPLE;
/

--Procedimiento que copia piezas compuestas.
CREATE OR REPLACE PROCEDURE COPIAR_PIEZA_COMPUESTA (ID_PADRE_ORIGINAL NUMERIC, ID_PADRE_NUEVO NUMERIC) AS 
PIEZAS PIEZA_SIMPLE%ROWTYPE;
PIEZA_NUEVA NUMERIC;
BEGIN
  FOR PIEZAS IN (SELECT * FROM PIEZA_COMPUESTA WHERE ID_PIEZACOMPUESTA=ID_PADRE_ORIGINAL)
  LOOP
  
  INSERT INTO pieza_compuesta (ID_PIEZACOMPUESTA, NOMBRE)
  VALUES (ID_PADRE_NUEVO, PIEZAS.NOMBRE);
  
  SELECT SECUENCIA_PIEZA_ID.CURRVAL INTO PIEZA_NUEVA FROM DUAL;
  
  copiar_pieza_simple(PIEZAS.ID,PIEZA_NUEVA);
  copiar_pieza_COMPUESTA(PIEZAS.ID,PIEZA_NUEVA);
  
  END LOOP;
END COPIAR_PIEZA_COMPUESTA;
/

--Procedimiento que copia un avion entero.
CREATE OR REPLACE PROCEDURE COPIAR_AVION (AVION_ID NUMBER, COPIA_AVION_ID NUMBER) AS 
AVION PIEZA_COMPUESTA%ROWTYPE;
BEGIN

  SELECT * INTO AVION FROM pieza_compuesta WHERE id=AVION_ID;

  INSERT INTO pieza_compuesta (ID, NOMBRE)
  VALUES (COPIA_AVION_ID,AVION.NOMBRE);
  
  copiar_pieza_simple(AVION_ID,COPIA_AVION_ID);
  copiar_pieza_COMPUESTA(AVION_ID,COPIA_AVION_ID);
  
END COPIAR_AVION;
/

--Creacion de un avion en el que una de sus piezas compuestas tiene más de 4 piezas simples.
CREATE OR REPLACE PROCEDURE INTENTA_CREAR_AVION_MASDE4(id_avion number) AS 
id_intermedio number;
id_intermedio2 number;
BEGIN
 
  insert into pieza_compuesta (id, nombre) values (id_avion, 'Avion 2');
  crear_pieza_compuesta(id_avion,'Cabina');
  select id into id_intermedio from pieza_compuesta where id_piezacompuesta=id_avion and nombre like '%Cabina%';
  crear_pieza_simple(id_intermedio,'PN-002','SN-10011','Asiento 5');
  crear_pieza_simple(id_intermedio,'PN-002','SN-10012','Asiento 6');
  crear_pieza_simple(id_intermedio,'PN-002','SN-10013','Asiento 7');
  crear_pieza_simple(id_intermedio,'PN-002','SN-10014','Asiento 8');
  crear_pieza_simple(id_intermedio,'PN-002','SN-10015','Asiento 9');
  crear_pieza_simple(id_intermedio,'PN-002','SN-10016','Asiento 10');
  
  crear_pieza_compuesta(id_intermedio,'Asiento Piloto');
  select id into id_intermedio2 from pieza_compuesta where nombre like 'Asiento Piloto' and id_piezacompuesta=id_intermedio;
  crear_pieza_simple(id_intermedio2,'PN-002','SN-1009','Asiento 4');
  crear_pieza_simple(id_intermedio2,'PN-003','SN-10010','Controles');
  crear_pieza_simple(id_avion,'PN-004','SN-10017','Motor3');
  crear_pieza_simple(id_avion,'PN-004','SN-10018','Motor4');
  crear_pieza_simple(id_avion,'PN-001','SN-1008','Fuselaje');

 
END INTENTA_CREAR_AVION_MASDE4;
/

--Creacion de un avion en el que tiene mas de 10 piezas simples.
CREATE OR REPLACE PROCEDURE INTENTA_CREAR_AVION_MASDE10(id_avion number) AS 
id_intermedio number;
id_intermedio2 number;
BEGIN
 
  insert into pieza_compuesta (id, nombre) values (id_avion, 'Avion 3');
  crear_pieza_compuesta(id_avion,'Cabina');
  select id into id_intermedio from pieza_compuesta where id_piezacompuesta=id_avion and nombre like '%Cabina%';
  crear_pieza_compuesta(id_intermedio,'Asiento Piloto');
  select id into id_intermedio2 from pieza_compuesta where nombre like '%Asiento Piloto%' and id_piezacompuesta=id_intermedio;
  crear_pieza_simple(id_intermedio2,'PN-002','SN-10020','Asiento 11');
  crear_pieza_simple(id_intermedio2,'PN-003','SN-10021','Controles');
  crear_pieza_compuesta (id_intermedio,'Asiento Copiloto');
  select id into id_intermedio2 from pieza_compuesta where nombre like '%Asiento Copiloto%' and id_piezacompuesta=id_intermedio;
  crear_pieza_simple(id_intermedio2,'PN-002','SN-10022','Asiento 12');
  crear_pieza_simple(id_intermedio2,'PN-003','SN-10023','Controles');
  crear_pieza_simple (id_avion,'PN-004','SN-10024', 'Motor 5');
  crear_pieza_simple (id_avion,'PN-004','SN-10025', 'Motor 6');
  crear_pieza_simple (id_avion,'PN-004','SN-10026', 'Motor 7');
  crear_pieza_simple (id_avion,'PN-004','SN-10027', 'Motor 8');
  crear_pieza_simple (id_avion,'PN-005','SN-10028', 'Caja negra');
  crear_pieza_simple (id_avion,'PN-007','SN-10027', 'GPS');
  crear_pieza_simple(id_avion,'PN-001','SN-10019','Fuselaje');

  
 
END INTENTA_CREAR_AVION_MASDE10 ;
/


