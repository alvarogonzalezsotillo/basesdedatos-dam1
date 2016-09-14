--Creamos la tabla que necesitamos
create table piezas(
  serialnumber VARCHAR2(10),
  partnumber VARCHAR2(10),
  nombre VARCHAR2(20),
  id NUMBER(10),
  idpadre NUMBER(10));

alter table piezas
  add constraint piezas_pk
  primary key (id);

--Creamos la vista AVIONES_PROFESOR
create view AVIONES_PROFESOR as
select id PARTE_ID, nombre, idpadre PARTE_PADRE, serialnumber SN, partnumber PN
from piezas;

--Creamos la secuencia SECUENCIA_AVION_ID (Empezará apartir del 1)--
CREATE SEQUENCE  "SECUENCIA_AVION_ID"  MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

--Creamos la secuencia SECUENCIA_PIEZA_ID (Empezará apartir del 100)--
CREATE SEQUENCE  "SECUENCIA_PIEZA_ID"  MINVALUE 100 MAXVALUE 999 INCREMENT BY 1 START WITH 100 CACHE 20 NOORDER  NOCYCLE ;

--Creamos la secuencia SECUENCIA_SERIALNUMBER (Empezará apartir del 1000)--
CREATE SEQUENCE  "SECUENCIA_SERIALNUMBER"  MINVALUE 1000 MAXVALUE 9999 INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER  NOCYCLE ;

--Creamos el trigger TRIGGER_ID
create or replace 
trigger TRIGGER_ID
BEFORE INSERT ON PIEZAS
FOR EACH ROW
BEGIN
  IF inserting THEN
    IF :NEW."IDPADRE" IS NULL THEN
      IF :NEW."ID" IS NULL THEN
        select SECUENCIA_AVION_ID.nextval into :NEW."ID" from dual;
      END IF;
    ELSE
      select SECUENCIA_PIEZA_ID.nextval into :NEW."ID" from dual;
    END IF;
  END IF;
END;
/

--Creamos el trigger TRIGGER_SN
CREATE OR REPLACE TRIGGER TRIGGER_SN 
BEFORE INSERT ON PIEZAS
FOR EACH ROW
DECLARE
  prefijo varchar2(3):= 'SN-';
BEGIN
  IF inserting THEN
    IF :NEW."PARTNUMBER" is not null THEN
      select prefijo || SECUENCIA_SERIALNUMBER.nextval into :NEW."SERIALNUMBER" from dual;
    END IF;
  END IF;
END;
/

--Creamos la función de un avion no tener más de 10 piezas simples
create or replace 
FUNCTION COMPRUEBA_AVION(idavion number) RETURN NUMBER AS
  numpiezas number;
  padreid number;
BEGIN
select idpadre into padreid from piezas where id = idavion;
if padreid is null then
  select count(nombre) into numpiezas from piezas where serialnumber is not null start with id=idavion connect by prior id=idpadre;
  if numpiezas > 10 then 
    raise_application_error(-20001, 'Mas de 10 piezas simples.');
  end if;
else
  raise_application_error(-20002, 'No es un avión.');
end if;
END;
/

--Creamos la funcion de un avion no tener mas de 4 piezas en una pieza compuesta
create or replace 
FUNCTION COMPRUEBA_PIEZA (idpieza number) RETURN number AS 
   numpiezas number;
   padreid number;
BEGIN
select idpadre into padreid from piezas where id = idpieza;
if padreid is not null then
 select count(nombre) into numpiezas from piezas start with id=idpieza connect by prior id=idpadre;
  if numpiezas > 4 then 
    raise_application_error(-20001, 'Mas de 4 piezas simples');
  end if;
else
   raise_application_error(-20002, 'No es una pieza');
end if;
END;
/

--Creamos el procedimiento CREAR_AVION
create or replace 
PROCEDURE CREAR_AVION(avion_id number) AS
  cabina_id number;
  piloto_id number;
BEGIN
  insert into piezas(nombre,id) values ('Avion 1',avion_id);
    insert into piezas(nombre,partnumber,idpadre) values ('Fuselaje','PN-001',avion_id);
    insert into piezas(nombre,idpadre) values ('Cabina',avion_id);
    select SECUENCIA_PIEZA_ID.currval into cabina_id from dual;
      insert into piezas(nombre,partnumber,idpadre) values ('Asiento 2','PN-002',cabina_id);
      insert into piezas(nombre,partnumber,idpadre) values ('Asiento 3','PN-002',cabina_id);
      insert into piezas(nombre,idpadre) values ('Asiento Piloto',cabina_id);
        select SECUENCIA_PIEZA_ID.currval into piloto_id from dual;
        insert into piezas(nombre,partnumber,idpadre) values ('Asiento 1','PN-002',piloto_id);
        insert into piezas(nombre,partnumber,idpadre) values ('Controles','PN-003',piloto_id);
    insert into piezas(nombre,partnumber,idpadre) values ('Motor 1','PN-004',avion_id);
    insert into piezas(nombre,partnumber,idpadre) values ('Motor 2','PN-004',avion_id);
END CREAR_AVION;
/

--Creamos el procedimiento BORRAR_AVION
create or replace 
PROCEDURE BORRAR_AVION (avion_id number) AS 
BEGIN
  delete from piezas where id IN (select id from piezas start with id = avion_id connect by prior id = idpadre);
END;
/

--Creamos el procedimiento BORRAR_AVIONES
create or replace
procedure BORRAR_AVIONES as
BEGIN
  delete from piezas;
 END;
/

--Creamos el procedimiento INTENTA_CREAR_AVION_MASDE4
CREATE OR REPLACE
PROCEDURE INTENTA_CREAR_AVION_MASDE4 (avion_id number) AS 
  cabina_id number;
  piloto_id number;
  copiloto_id number;
BEGIN
  insert into piezas (nombre, id) values ('Avion 3',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Fuselaje','PN-001',avion_id);
    insert into piezas (nombre,idpadre) values ('Cabina',avion_id);
    select secuencia_pieza_id.currval into cabina_id from dual;
      insert into piezas (nombre, idpadre) values ('Asiento piloto',cabina_id);
      select secuencia_pieza_id.currval into piloto_id from dual;
        insert into piezas (nombre, partnumber, idpadre) values ('Asiento 4','PN-002',piloto_id);
        insert into piezas (nombre, partnumber, idpadre) values ('Controles','PN-003',piloto_id);
      insert into piezas (nombre, idpadre) values ('Asiento 5',cabina_id);
      insert into piezas (nombre, idpadre) values ('Asiento 6',cabina_id);
      insert into piezas (nombre, idpadre) values ('Asiento 7',cabina_id);
      insert into piezas (nombre, idpadre) values ('Asiento 8',cabina_id);
      insert into piezas (nombre, idpadre) values ('Asiento 9',cabina_id);
      insert into piezas (nombre, idpadre) values ('Asiento 10',cabina_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Motor 5', 'PN-004',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Motor 6', 'PN-004',avion_id);
END;
/

--Creamos el procedimiento INTENTA_CREAR_AVION_MASDE10
CREATE OR REPLACE
PROCEDURE INTENTA_CREAR_AVION_MASDE10 (avion_id number) AS 
  cabina_id number;
  piloto_id number;
  copiloto_id number;
BEGIN
  insert into piezas (nombre, id) values ('Avion 3',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Fuselaje','PN-001',avion_id);
    insert into piezas (nombre,idpadre) values ('Cabina',avion_id);
    select secuencia_pieza_id.currval into cabina_id from dual;
      insert into piezas (nombre, idpadre) values ('Asiento piloto',cabina_id);
      select secuencia_pieza_id.currval into piloto_id from dual;
        insert into piezas (nombre, partnumber, idpadre) values ('Asiento 11','PN-002',piloto_id);
        insert into piezas (nombre, partnumber, idpadre) values ('Controles','PN-003',piloto_id);
       insert into piezas (nombre, idpadre) values ('Asiento copiloto',cabina_id);
       select secuencia_pieza_id.currval into copiloto_id from dual;
        insert into piezas (nombre, partnumber, idpadre) values ('Asiento 12','PN-002',copiloto_id);
        insert into piezas (nombre, partnumber, idpadre) values ('Controles','PN-003',copiloto_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Motor 5', 'PN-004',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Motor 6', 'PN-004',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Motor 7', 'PN-004',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Motor 8', 'PN-004',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Caja negra', 'PN-005',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('GPS', 'PN-006',avion_id);
END;
/

--Creamos el procedimiento COPIAR_HIJOS
create or replace 
PROCEDURE COPIAR_HIJOS (pieza_id number, pieza_copia_id number) AS  
  avion_creado piezas%ROWTYPE;
  pieza_recien_creada number;
BEGIN
  for piezas in (select * from piezas where idpadre=pieza_id)
  loop
    INSERT INTO piezas(nombre,idpadre,partnumber) VALUES(piezas.nombre, pieza_copia_id, avion_creado.partnumber );
    select SECUENCIA_PIEZA_ID.currval into pieza_recien_creada from dual;
    copiar_hijos(piezas.id,pieza_recien_creada);
  end loop;                 
END;
/

--Creamos el procedimiento COPIAR_AVION
create or replace 
PROCEDURE COPIAR_AVION (avion_id number, copia_avion_id number) AS 
  avion_creado piezas%ROWTYPE;
BEGIN
  SELECT * INTO avion_creado FROM piezas WHERE id = avion_id;  
  INSERT INTO piezas(id,nombre,idpadre,partnumber) VALUES(COPIA_AVION_ID,avion_creado.nombre, null,  null ); 
  copiar_hijos(avion_id, copia_avion_id);
END;
/