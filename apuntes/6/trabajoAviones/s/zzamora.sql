--PROBLEMA: Se necesita informatizar la gestión de las piezas de aviones.
--Autores: Zahira Zamora y Carlos Dominguez
-----secuencia para las piezas compuestas
CREATE sequence SECUENCIA_PIEZA_ID
  start with 100
  increment by 1
  maxvalue 999999
  minvalue 100;

-----secuencia para las piezas simples  
CREATE sequence SECUENCIA_SERIALNUMBER
  start with 1001
  increment by 1
  maxvalue 999999
  minvalue 1001;

-----Creacion tabla de relaciones--------------------------------
CREATE TABLE aviones (
  idPieza        number(6,0) not null, 
  descripcion    VARCHAR2(20) not null,
  idPadre        number(6,0),
  serialNumber   VARCHAR2(20),
  partNumber     VARCHAR2(20)
  );

ALTER TABLE aviones
  add constraint aviones_pk
  primary key (idPieza);

ALTER TABLE aviones
  add constraint aviones_fk
  foreign key (idPadre) references aviones(idPieza);

ALTER TABLE aviones
  add constraint aviones_unique
  unique (serialNumber);

-----Creacion vista de relaciones--------------------------------
create view AVIONES_PROFESOR as
select idPieza PARTE_ID, idPadre PARTE_PADRE, descripcion NOMBRE, serialnumber SN, partnumber PN
from aviones;

-----Triggers ID y SN----------------------------
CREATE OR REPLACE TRIGGER PONER_ID_PIEZA 
BEFORE INSERT ON AVIONES 
FOR EACH ROW 
BEGIN
  if :NEW.idPieza is null then
    select secuencia_pieza_id.nextval into :NEW.idPieza from dual;
  end if;
END;
/

CREATE OR REPLACE TRIGGER PONER_SN_PIEZA 
BEFORE INSERT ON AVIONES 
FOR EACH ROW 
BEGIN
  if :NEW.partnumber is not null then
    if :NEW.serialNumber is null then
      select secuencia_serialnumber.nextval into :NEW.serialNumber from dual;
      :NEW.serialNumber := 'SN-' || :NEW.serialNumber;
    end if;
  end if;
END;
/

-----Procedimiento de creacion de aviones-------------------------    /TODO
create or replace 
PROCEDURE CREAR_AVION(avion_id number) AS 
  padre0 number;
  padre1 number;
  padre2 number;
BEGIN
  if avion_id is null then
    insert into aviones (descripcion) values ('Avion 1');
    select secuencia_pieza_id.currval into padre0 from dual;
  else
    insert into aviones (idpieza,descripcion) values (avion_id,'Avion 1');
    padre0 := avion_id;
  end if;
  
  insert into aviones (descripcion,idpadre,partnumber) values('Fuselaje',padre0,'PN-001');
  insert into aviones (descripcion,idpadre) values('Cabina',padre0);
  select secuencia_pieza_id.currval into padre1 from dual;
  insert into aviones (descripcion,idpadre) values('Asiento piloto',padre1);
  select secuencia_pieza_id.currval into padre2 from dual;
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 1',padre2,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Controles',padre2,'PN-003');  
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 2',padre1,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 3',padre1,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Motor 1',padre0,'PN-004');
  insert into aviones (descripcion,idpadre,partnumber) values('Motor 2',padre0,'PN-004');
END CREAR_AVION;
/

-----función COMPRUEBA_AVION(ID), error si el avión tiene más de 10 piezas simples, o si el ID no es el de un avión.
create or replace 
FUNCTION COMPRUEBA_AVION(avion_id number) RETURN varchar2 AS   
  resultado number;
  nAvion number;  
BEGIN
  SELECT count(idPieza) into nAvion from aviones where idPieza = avion_id;
  
  if nAvion=0 then
    raise_application_error(-20004,'Avion no encontrado');
  else  
    SELECT count(serialNumber)
    INTO resultado
    FROM aviones
    START WITH idPieza = avion_id
    CONNECT BY PRIOR idPieza = idPadre; 
    
    if resultado > 10 then
      raise_application_error(-20005,'Avion incorrecto');
    else return 'Avion correcto';
    end if;
  end if;
END;
/

-----función COMPRUEBA_PIEZA(ID), error si la pieza tiene más de 4 piezas simples, o el ID es el de un avión.
create or replace 
FUNCTION COMPRUEBA_PIEZA(pieza_id number) RETURN varchar2 AS   
  resultado number;
  existe number;
  esAvion number;  
BEGIN
  SELECT count(idPieza) into existe from aviones where idPieza = pieza_id;
  
  if existe = 0 then
    raise_application_error(-20001,'No existe esa pieza');
  end if;
  
  SELECT idPadre into esAvion from aviones where idPieza = pieza_id;
  if esAvion is null then
    raise_application_error(-20002,'No es una pieza, es un avion');
  else    
    SELECT count(serialNumber)
    INTO resultado
    FROM aviones
    START WITH idPieza = pieza_id
    CONNECT BY PRIOR idPieza = idPadre; 
    
    if resultado > 4 then
      raise_application_error(-20003,'Pieza incorrecta, tiene mas de 4 piezas simples');
    else return 'Pieza correcta';
    end if;
  end if;
END;
/

-----Procedimiento de borrado de todos los aviones-------------------------
create or replace 
PROCEDURE BORRAR_AVIONES AS 
BEGIN
  DELETE FROM aviones;
END BORRAR_AVIONES;
/

-----Procedimiento de borrado de un solo avion-----------------------------
create or replace 
PROCEDURE BORRAR_AVION(avion_id number) AS 
  CURSOR c_piezas is select idPieza from aviones
                      START WITH idPieza = avion_id
                      CONNECT BY PRIOR idPieza = idPadre
                      order by 1 desc;
BEGIN
  for i in c_piezas loop
    if i.idPieza <> avion_id then
      DELETE FROM aviones where idPieza = i.idPieza;
    end if;
  end loop;
  DELETE FROM aviones where idPieza = avion_id;
END BORRAR_AVION;
/

-----Procedimiento COPIAR_AVION(avion_id number, copia_avion_id number) que cree
----- un avión con el mismo número de piezas y del mismo tipo que el original.-------

--procedimiento auxiliar copiar_hijos
create or replace 
PROCEDURE COPIAR_HIJOS(id_origen number, id_destino number) AS
  id_nuevo number;
  hijo_origen aviones%rowtype;
BEGIN
  for hijo_origen in (select * from aviones where idPadre=id_origen)
  loop
    insert into aviones (descripcion,idPadre,partNumber) 
                 values (hijo_origen.descripcion,id_destino,hijo_origen.partNumber);
    select secuencia_pieza_id.currval into id_nuevo from dual;
    copiar_hijos(hijo_origen.idPieza,id_nuevo);
  end loop;
END COPIAR_HIJOS;
/

--procedimiento principal
create or replace 
PROCEDURE COPIAR_AVION(avion_id number, copia_avion_id number) AS
  existe number;
  descripcion_existente aviones.descripcion%type;
  id_nuevo number;
BEGIN
  SELECT count(idPieza) into existe from aviones where idPieza = avion_id;
  
  if existe = 0 then
    raise_application_error(-20006,'No existe ese avion para copiarlo');
  end if;
  
  select descripcion into descripcion_existente from aviones where idPieza = avion_id;
  insert into aviones (idpieza,descripcion) values (copia_avion_id,descripcion_existente);
  copiar_hijos(avion_id,copia_avion_id);
END COPIAR_AVION;
/

-----INTENTA_CREAR_AVION_MASDE10 ----------------------------------------------------
create or replace 
PROCEDURE INTENTA_CREAR_AVION_MASDE10(avion_id number) AS 
  padre0 number;
  padre1 number;
  padre2 number;
BEGIN
  if avion_id is null then
    insert into aviones (descripcion) values ('Avion 3');
    select secuencia_pieza_id.currval into padre0 from dual;
  else
    insert into aviones (idpieza,descripcion) values (avion_id,'Avion 3');
    padre0 := avion_id;
  end if;
  
  insert into aviones (descripcion,idpadre,partnumber) values('Fuselaje',padre0,'PN-001');
  insert into aviones (descripcion,idpadre) values('Cabina',padre0);
  select secuencia_pieza_id.currval into padre1 from dual;
  insert into aviones (descripcion,idpadre) values('Asiento piloto',padre1);
  select secuencia_pieza_id.currval into padre2 from dual;
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 11',padre2,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Controles',padre2,'PN-003');
  
  insert into aviones (descripcion,idpadre) values('Asiento copiloto',padre1);
  select secuencia_pieza_id.currval into padre2 from dual;
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 12',padre2,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Controles',padre2,'PN-003');    
  
  insert into aviones (descripcion,idpadre,partnumber) values('Motor 5',padre0,'PN-004');
  insert into aviones (descripcion,idpadre,partnumber) values('Motor 6',padre0,'PN-004');
  insert into aviones (descripcion,idpadre,partnumber) values('Motor 7',padre0,'PN-004');
  insert into aviones (descripcion,idpadre,partnumber) values('Motor 8',padre0,'PN-004');
  insert into aviones (descripcion,idpadre,partnumber) values('Caja negra',padre0,'PN-005');
  insert into aviones (descripcion,idpadre,partnumber) values('GPS',padre0,'PN-006');
END INTENTA_CREAR_AVION_MASDE10;
/

-----INTENTA_CREAR_AVION_MASDE4------------------------------------
create or replace 
PROCEDURE INTENTA_CREAR_AVION_MASDE4(avion_id number) AS 
  padre0 number;
  padre1 number;
  padre2 number;
BEGIN
  if avion_id is null then
    insert into aviones (descripcion) values ('Avion 2');
    select secuencia_pieza_id.currval into padre0 from dual;
  else
    insert into aviones (idpieza,descripcion) values (avion_id,'Avion 2');
    padre0 := avion_id;
  end if;
  
  insert into aviones (descripcion,idpadre,partnumber) values('Fuselaje',padre0,'PN-001');
  insert into aviones (descripcion,idpadre) values('Cabina',padre0);
  select secuencia_pieza_id.currval into padre1 from dual;
  insert into aviones (descripcion,idpadre) values('Asiento piloto',padre1);
  select secuencia_pieza_id.currval into padre2 from dual;
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 4',padre2,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Controles',padre2,'PN-003');
  
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 5',padre1,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 6',padre1,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 7',padre1,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 8',padre1,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 9',padre1,'PN-002');
  insert into aviones (descripcion,idpadre,partnumber) values('Asiento 10',padre1,'PN-002');     
  
  insert into aviones (descripcion,idpadre,partnumber) values('Motor 3',padre0,'PN-004');
  insert into aviones (descripcion,idpadre,partnumber) values('Motor 4',padre0,'PN-004');  
END INTENTA_CREAR_AVION_MASDE4;
/
