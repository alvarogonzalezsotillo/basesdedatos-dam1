--------------------------------------------------------
-- Archivo creado  - miércoles-abril-24-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Sequence SECUENCIA_PIEZA_ID
--------------------------------------------------------

   CREATE SEQUENCE  "SECUENCIA_PIEZA_ID"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence SECUENCIA_SERIALNUMBER
--------------------------------------------------------

   CREATE SEQUENCE  "SECUENCIA_SERIALNUMBER"  MINVALUE 1001 MAXVALUE 999999 INCREMENT BY 1 START WITH 1001 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table PIEZA
--------------------------------------------------------

  CREATE TABLE "PIEZA" 
   (	"ID_PIEZA" NUMBER(6,0), 
	"SN" VARCHAR2(20 BYTE), 
	"PN" VARCHAR2(20 BYTE), 
	"NOMBRE" VARCHAR2(20 BYTE), 
	"ID_PADRE" NUMBER(6,0)
   ) PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for View AVIONES_PROFESOR
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "AVIONES_PROFESOR" ("PARTE_ID", "PARTE_PADRE", "NOMBRE", "SN", "PN") AS 
  select id_pieza as PARTE_ID, id_padre as PARTE_PADRE, lpad('   ',3*(level -1)) || nombre as NOMBRE, SN, PN
  from pieza 
  start with id_padre is null
  connect by prior id_pieza = id_padre;
REM INSERTING into PIEZA
SET DEFINE OFF;
--------------------------------------------------------
--  DDL for Index PIEZA_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "PIEZA_PK" ON "PIEZA" ("ID_PIEZA") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  Constraints for Table PIEZA
--------------------------------------------------------

  ALTER TABLE "PIEZA" ADD CONSTRAINT "PIEZA_PK" PRIMARY KEY ("ID_PIEZA")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT)
  TABLESPACE "USERS"  ENABLE;
 
  ALTER TABLE "PIEZA" MODIFY ("ID_PIEZA" NOT NULL ENABLE);
--------------------------------------------------------
--  DDL for Trigger PONER_ID_Y_SN
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "PONER_ID_Y_SN" 
BEFORE INSERT ON PIEZA 
FOR EACH ROW 
BEGIN

  if inserting then    
    if :new."ID_PIEZA" is null then
      select SECUENCIA_PIEZA_ID.nextval into :NEW."ID_PIEZA" from dual;
      
      if :new."PN" is not null then
        select 'SN-' || SECUENCIA_SERIALNUMBER.nextval into :NEW."SN" from dual; 
      end if;
    end if;
  end if;

  exception
    when DUP_VAL_ON_INDEX
      then ROLLBACK;
END;

/


--------------------------------------------------------
--  DDL for Function GET_NUMERO_PIEZAS_SIMPLES
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "GET_NUMERO_PIEZAS_SIMPLES" 
(
  ID_AVION IN NUMBER  
) RETURN NUMBER AS 
numero_de_piezas_simples number;

BEGIN
  select count (SN) into numero_de_piezas_simples from pieza where
    SN in (select SN  from pieza
    start with id_pieza = id_avion       
    connect by prior id_pieza = id_padre); 
  RETURN numero_de_piezas_simples;  
END GET_NUMERO_PIEZAS_SIMPLES;

/


ALTER TRIGGER "PONER_ID_Y_SN" ENABLE;
--------------------------------------------------------
--  DDL for Function COMPRUEBA_AVION
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "COMPRUEBA_AVION" (id_avion number) RETURN number AS 
  numero_de_piezas_simples number;
  mi_id_padre number;
  MAXIMO_DE_PIEZAS_SIMPLES_AVION constant number := 10;
BEGIN
  select id_padre into mi_id_padre
    from pieza where id_pieza = id_avion;
  /* Comprueba que el id que se pasa a la funcion no sea de un avion*/
  if mi_id_padre is not null then
    raise_application_error(-20001, 'El id no es de un avion');
  end if;
  
  if mi_id_padre is null then
    numero_de_piezas_simples := get_numero_piezas_simples(id_avion);
    if numero_de_piezas_simples > MAXIMO_DE_PIEZAS_SIMPLES_AVION then
      raise_application_error(-20002, 'El avion tiene mas de ' ||
        MAXIMO_DE_PIEZAS_SIMPLES_AVION || ' piezas simples');
    end if;
  end if;  
  return numero_de_piezas_simples;
END COMPRUEBA_AVION;

/


--------------------------------------------------------
--  DDL for Function COMPRUEBA_PIEZA
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "COMPRUEBA_PIEZA" 
(
  ID_PIEZA_COMPUESTA IN NUMBER  
) RETURN number AS 
  mi_id_padre number;
  numero_de_piezas_simples number;
  MAXIMO_DE_PIEZAS_SIMPLES constant number := 4;
BEGIN
  select id_padre into mi_id_padre 
    from pieza where id_pieza_compuesta = id_pieza;
  if mi_id_padre is null then
    raise_application_error(-20003, 'El id es de un avion');
  end if;
  
  if mi_id_padre is not null then
    numero_de_piezas_simples := get_numero_piezas_simples(id_pieza_compuesta);
    if numero_de_piezas_simples > MAXIMO_DE_PIEZAS_SIMPLES then
      raise_application_error(-20004, 'La pieza compuesta  tiene mas de '
      || MAXIMO_DE_PIEZAS_SIMPLES || ' piezas simples');
    end if;
  end if;
  return numero_de_piezas_simples;
END COMPRUEBA_PIEZA;

/

--------------------------------------------------------
--  DDL for Procedure BORRAR_AVION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BORRAR_AVION" 
(
  AVION_ID IN NUMBER  
) AS 
parte_avion pieza%rowtype;
BEGIN  
  /* Comprueba que el id que se pasa a la funcion sea de un avion*/
  select * into parte_avion
    from pieza where id_pieza = avion_id;
  if parte_avion.id_padre is not null then
    raise_application_error(-20001, 'El id no es de un avion');
  end if;
    
  if parte_avion.id_padre is null then
    delete from pieza where id_pieza in(
      select id_pieza from pieza
      start with id_pieza = avion_id      
      connect by prior id_pieza = id_padre
    );     
    dbms_output.put_line(parte_avion.nombre || ' con id = ' || avion_id || ' ha sido borrado.');    
  end if;
  
  exception 
  when no_data_found then
    dbms_output.put_line('El id no existe'); 
END BORRAR_AVION;

/
--------------------------------------------------------
--  DDL for Procedure BORRAR_AVIONES
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "BORRAR_AVIONES" AS 
parte_avion pieza%rowtype;
BEGIN  
  /*Recorrer toda la tabla en busca de aviones (id_padre = null)*/
  /*Si se encuentra uno, se recorren todas sus piezas con connect by prior y se borran*/

  for parte_avion in( select * from pieza where id_padre is null)
  loop
    if parte_avion.id_padre is null then
      delete from pieza where parte_avion.id_pieza in(
        select id_pieza from pieza
        start with id_pieza = id_pieza      
        connect by prior id_pieza = id_padre
      );     
    end if;   
  end loop;  
END BORRAR_AVIONES;

/

--------------------------------------------------------
--  DDL for Procedure COPIAR_PIEZAS_HIJAS
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "COPIAR_PIEZAS_HIJAS" 
(
  PIEZA_ID_PADRE IN NUMBER  
, PIEZA_COPIA_ID_PADRE IN NUMBER  
) AS 
pieza_original pieza%rowtype;
id_pieza_copia number;
BEGIN
  -- Se copian los hijos de cada pieza.
  for pieza_original in (select * from pieza where id_padre = PIEZA_ID_PADRE)
  loop
    insert into pieza (nombre, id_padre, pn)
    values (pieza_original.nombre, PIEZA_COPIA_ID_PADRE, pieza_original.pn);
    
    dbms_output.put_line(pieza_original.nombre || ' con id = ' ||
      pieza_original.id_pieza || ' ha sido copiado.');    
    
    -- Como el id no se puede copiar por ser PK, generamos un id nuevo para la
    -- pieza copia:
    select SECUENCIA_PIEZA_ID.currval into id_pieza_copia from dual;
    copiar_piezas_hijas(pieza_original.id_pieza, id_pieza_copia);    
  end loop;
END COPIAR_PIEZAS_HIJAS;

/

--------------------------------------------------------
--  DDL for Procedure COPIAR_AVION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "COPIAR_AVION" 
(
  AVION_ID IN NUMBER  
, COPIA_AVION_ID IN NUMBER  
) AS 
avion_original pieza%rowtype;
BEGIN
  select * into avion_original from pieza where id_pieza = avion_id;
  -- Se crea la copia del avion_original sin piezas:
  insert into pieza (id_pieza, sn, pn, nombre, id_padre)
    values (COPIA_AVION_ID, null, null, avion_original.nombre, null); 
    
  copiar_piezas_hijas(AVION_ID, COPIA_AVION_ID);   
END COPIAR_AVION;

/

--------------------------------------------------------
--  DDL for Procedure CREAR_AVION
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "CREAR_AVION" 
(
  ID_AVION IN NUMBER
) AS 
ID_ASIENTO_PILOTO number(6,0);
ID_CABINA number (6,0);
BEGIN  
  -- simpre que hay PN hay SN
  -- secuencia para poner el id_padre: currval
  insert into pieza(id_pieza, nombre) values(ID_AVION, 'Avion 1');
  insert into pieza(pn, nombre, id_padre) values('PN-001', 'Fuselaje', ID_AVION);
  insert into pieza(nombre, id_padre) values('Cabina', ID_AVION);    
  select SECUENCIA_PIEZA_ID.currval into ID_CABINA from dual;
  insert into pieza(nombre, id_padre) values('Asiento piloto', ID_CABINA);  
  select SECUENCIA_PIEZA_ID.currval into ID_ASIENTO_PILOTO from dual;
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 1', ID_ASIENTO_PILOTO);
  insert into pieza(pn, nombre, id_padre) values('PN-003', 'Controles', ID_ASIENTO_PILOTO);  
  
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 2', ID_CABINA);
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 3', ID_CABINA);  
  
  insert into pieza(pn, nombre, id_padre) values('PN-004', 'Motor 1', ID_AVION);
  insert into pieza(pn, nombre, id_padre) values('PN-004', 'Motor 2', ID_AVION);  
END CREAR_AVION;

/
--------------------------------------------------------
--  DDL for Procedure INTENTA_CREAR_AVION_MASDE10
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "INTENTA_CREAR_AVION_MASDE10" 
(
  AVION_ID IN NUMBER 
) AS 
id_padre number(6,0);
ID_CABINA number (6,0);
BEGIN
  insert into pieza values(AVION_ID, null, null, 'Avion 3', null);
  insert into pieza values(null, null, 'PN-001', 'Fuselaje', AVION_ID);
  insert into pieza values(null, null, null, 'Cabina', AVION_ID);  
  
  select SECUENCIA_PIEZA_ID.currval into id_padre from dual;
  id_cabina := id_padre;
  insert into pieza values(null, null, null, 'Asiento piloto', id_padre);
  
  select SECUENCIA_PIEZA_ID.currval into id_padre from dual;
  insert into pieza values(null, null, 'PN-002', 'Asiento 11', id_padre);
  insert into pieza values(null, null, 'PN-003', 'Controles', id_padre);
    
  insert into pieza values(null, null, null, 'Asiento copiloto', id_cabina);
  select SECUENCIA_PIEZA_ID.currval into id_padre from dual;
  insert into pieza values(null, null, 'PN-002', 'Asiento 12', id_padre);  
  insert into pieza values(null, null, 'PN-003', 'Controles', id_padre);

  insert into pieza values(null, null, 'PN-004', 'Motor 5', AVION_ID);
  insert into pieza values(null, null, 'PN-004', 'Motor 6', AVION_ID);
  insert into pieza values(null, null, 'PN-004', 'Motor 7', AVION_ID);
  insert into pieza values(null, null, 'PN-004', 'Motor 8', AVION_ID);
  
  insert into pieza values(null, null, 'PN-005', 'Caja negra', AVION_ID);
  insert into pieza values(null, null, 'PN-006', 'GPS', AVION_ID);
END INTENTA_CREAR_AVION_MASDE10;

/
--------------------------------------------------------
--  DDL for Procedure INTENTA_CREAR_AVION_MASDE4
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "INTENTA_CREAR_AVION_MASDE4" 
(
  AVION_ID IN NUMBER  
) AS 
id_cabina number;
id_asiento_piloto number;
BEGIN
  insert into pieza(id_pieza, nombre) values(AVION_ID, 'Avion 2');    
  insert into pieza(pn, nombre, id_padre) values('PN-001', 'Fuselaje', AVION_ID);
  insert into pieza(nombre, id_padre) values('Cabina', AVION_ID);
  select SECUENCIA_PIEZA_ID.currval into id_cabina from dual;
  insert into pieza(nombre, id_padre) values('Asiento piloto', id_cabina);
  select SECUENCIA_PIEZA_ID.currval into id_asiento_piloto from dual;
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 4', id_asiento_piloto);
  insert into pieza(pn, nombre, id_padre) values('PN-003', 'Controles', id_asiento_piloto);
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 5', id_cabina);
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 6', id_cabina);
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 7', id_cabina);
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 8', id_cabina);
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 9', id_cabina);
  insert into pieza(pn, nombre, id_padre) values('PN-002', 'Asiento 10', id_cabina);
  insert into pieza(pn, nombre, id_padre) values('PN-004', 'Motor 3', AVION_ID);
  insert into pieza(pn, nombre, id_padre) values('PN-004', 'Motor 4', AVION_ID);    
END INTENTA_CREAR_AVION_MASDE4;

/
