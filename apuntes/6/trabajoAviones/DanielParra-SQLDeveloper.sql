--Trabajo de Daniel Parra Crespo

--Creo la tabla de las piezas
create table piezas(
  serialNumber varchar2(10),
  partNumber varchar2(10),
  nombre Varchar2(20),
  id number(10),
  idPadre number(10));

alter table piezas add constraint piezas_pk primary Key(id);

--creo la SECUENCIA_AVION_ID

CREATE SEQUENCE  "SECUENCIA_AVION_ID"  MINVALUE 1 MAXVALUE 99 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

--creo la SECUENCIA_SERIALNUMBER

CREATE SEQUENCE  "SECUENCIA_SERIALNUMBER"  MINVALUE 1000 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 1000 CACHE 20 NOORDER  NOCYCLE ;

--creo la SECUENCIA_PIEZA_ID

CREATE SEQUENCE  "SECUENCIA_PIEZA_ID"  MINVALUE 100 MAXVALUE 9999999999 INCREMENT BY 1 START WITH 100 CACHE 20 NOORDER  NOCYCLE ;

--creo el trigger para meter SERIAL NUMBERS

CREATE OR REPLACE TRIGGER TRIGGER_SERIAL_NUMBER 
BEFORE INSERT ON PIEZAS 
  FOR EACH ROW
DECLARE
  serialNumber varchar2(3);
BEGIN
  serialNumber := 'SN-';
  IF INSERTING THEN
    IF :NEW."PARTNUMBER" is not null THEN 
      select serialNumber || SECUENCIA_SERIALNUMBER.nextval into :NEW."SERIALNUMBER" from dual;
    end if;
  end if;
END;
/

--creo el trigger para crear el id del avion o de la pieza

create or replace 
trigger TRIGGER_ID 
BEFORE INSERT ON PIEZAS 
FOR EACH ROW
BEGIN
  if inserting then 
    if :NEW."IDPADRE" is null then
      if :NEW."ID" is null then
        select SECUENCIA_AVION_ID.nextval into :NEW."ID" from dual;
      end if;
    else
      select SECUENCIA_PIEZA_ID.nextval into :NEW."ID" from dual;
    end if;
  end if;
END;
/

--creo la funcion de no meter mas de 10 piezas en un avion( COMPRUEBA_AVION)

create or replace 
FUNCTION COMPRUEBA_AVION(idavion number) 
RETURN number AS 
  npiezas number;
  padreid number;
BEGIN
select idpadre into padreid from piezas where id = idavion;
if padreid is null then
  select count(nombre) into npiezas from piezas where serialnumber is not null start with id = idavion connect by prior id = idpadre;
  if npiezas > 10 then 
    raise_application_error(-20010, 'Avion de mas de 10 piezas simples');
  end if;
else
  raise_application_error(-20010, 'Este id no es de un avion');
end if;
END;
/

--creo la funcion de no tener mas de 4 piezas en una pieza compuesta(COMPRUEBA_PIEZA)
  
create or replace 
FUNCTION COMPRUEBA_PIEZA (idpieza number) 
RETURN number AS 
   npiezas number;
   padreid number;
BEGIN
select idpadre into padreid from piezas where id = idpieza;
if padreid is not null then
 select count(nombre) into npiezas from piezas start with id = idpieza connect by prior id = idpadre;
  if npiezas > 4 then 
    raise_application_error(-20010, 'Pieza compuesta de mas de 4 piezas simples');
  end if;
else
   raise_application_error(-20010, 'El id no es de una pieza');
end if;
END;
/
  
--creo el procedimiento CREAR_AVION

create or replace 
PROCEDURE CREAR_AVION(avion_id number) AS 
  cabina_id number;
  piloto_id number;
BEGIN
  insert into piezas (nombre, id) values ('Avion 1',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Fuselaje','PN-001',avion_id);
    insert into piezas (nombre,idpadre) values ('Cabina',avion_id);
    select secuencia_pieza_id.currval into cabina_id from dual;
      insert into piezas (nombre, idpadre) values ('Asiento piloto',cabina_id);
      select secuencia_pieza_id.currval into piloto_id from dual;
        insert into piezas (nombre, partnumber, idpadre) values ('Asiento 1','PN-002',piloto_id);
        insert into piezas (nombre, partnumber, idpadre) values ('Controles','PN-003',piloto_id);
      insert into piezas (nombre, partnumber, idpadre) values ('Asiento 2','PN-002',cabina_id);
      insert into piezas (nombre, partnumber, idpadre) values ('Asiento 3','PN-002',cabina_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Motor 1', 'PN-004',avion_id);
    insert into piezas (nombre, partnumber, idpadre) values ('Motor 2', 'PN-004',avion_id);
END;
/

--creo la vista AVIONES_PROFESOR
  
create view AVIONES_PROFESOR as
  select id as parte_id, nombre, serialNumber as SN, partNumber as PN, idPadre as parte_padre
  from piezas;
  
--creo el procedimiento BORRAR_AVION

create or replace 
PROCEDURE BORRAR_AVION (avion_id number) AS 
BEGIN
  delete from piezas where id IN (select id from piezas start with id = avion_id connect by prior id = idpadre);
END;
/

--creo el procedimiento BORRAR_AVIONES

CREATE OR REPLACE
PROCEDURE BORRAR_AVIONES AS 
BEGIN
  delete from piezas;
END;
/

--creo el copiar_hijos

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

--creo el procedimiento COPIAR_AVION

create or replace 
PROCEDURE COPIAR_AVION (avion_id number, copia_avion_id number) AS 
  avion_creado piezas%ROWTYPE;
BEGIN
  SELECT * INTO avion_creado FROM piezas WHERE id = avion_id;  
  INSERT INTO piezas(id,nombre) VALUES(COPIA_AVION_ID,avion_creado.nombre); 
  copiar_hijos(avion_id, copia_avion_id);
END;
/

--creo el procedimiento INTENTA_CREAR_AVION_MASDE10

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

--creo el procedimiento INTENTA_CREAR_AVION_MASDE4

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






