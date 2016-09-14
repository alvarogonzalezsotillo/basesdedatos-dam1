-- Generado por Oracle SQL Developer Data Modeler 3.1.0.699
--   en:        2013-04-24 19:29:59 CEST
--   sitio:      Oracle Database 10g
--   tipo:      Oracle Database 10g



CREATE USER ALUMNO 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE TABLE ALUMNO.AVIONES 
    ( 
     NAVION NUMBER (10)  NOT NULL , 
     NOMBRE VARCHAR2 (10 BYTE) 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE USERS 
        LOGGING 
        STORAGE ( 
        INITIAL 65536 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
    ) 
;



ALTER TABLE ALUMNO.AVIONES 
    ADD CONSTRAINT PK_AVIONES PRIMARY KEY ( NAVION ) ;



CREATE TABLE ALUMNO.PIEZASCOMPUESTAS 
    ( 
     IDCOMPUESTO NUMBER (10) , 
     NAVION NUMBER (10) , 
     NOMBRE VARCHAR2 (30 BYTE) , 
     IDENTIFICADOR NUMBER (10)  NOT NULL 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE USERS 
        LOGGING 
        STORAGE ( 
        INITIAL 65536 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
    ) 
;



ALTER TABLE ALUMNO.PIEZASCOMPUESTAS 
    ADD CONSTRAINT PK_PC PRIMARY KEY ( IDENTIFICADOR ) ;



CREATE TABLE ALUMNO.PIEZASSIMPLES 
    ( 
     IDENTIFICADOR NUMBER (10)  NOT NULL , 
     SERIALNUMBER VARCHAR2 (10 BYTE) , 
     NAVION NUMBER (10)  NOT NULL , 
     IDPARTNUMBER VARCHAR2 (10 BYTE) , 
     IDCOMPUESTO NUMBER (10) , 
     NOMBRE VARCHAR2 (10 BYTE) 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE USERS 
        LOGGING 
        STORAGE ( 
        INITIAL 65536 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
    ) 
;



ALTER TABLE ALUMNO.PIEZASSIMPLES 
    ADD CONSTRAINT PK_PS PRIMARY KEY ( IDENTIFICADOR ) ;



CREATE TABLE ALUMNO.TIPOPIEZA 
    ( 
     ID_PART_NUMBER NUMBER (10)  NOT NULL , 
     TIPO_PIEZA VARCHAR2 (10 BYTE)  NOT NULL 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE USERS 
        LOGGING 
        STORAGE ( 
        INITIAL 65536 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
    ) 
;



ALTER TABLE ALUMNO.TIPOPIEZA 
    ADD CONSTRAINT PK_ID_PART_NUMBER PRIMARY KEY ( ID_PART_NUMBER ) ;




ALTER TABLE ALUMNO.PIEZASSIMPLES 
    ADD CONSTRAINT FK2_PS FOREIGN KEY 
    ( 
     IDCOMPUESTO
    ) 
    REFERENCES ALUMNO.PIEZASCOMPUESTAS 
    ( 
     IDENTIFICADOR
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE ALUMNO.PIEZASCOMPUESTAS 
    ADD CONSTRAINT FK_PC FOREIGN KEY 
    ( 
     NAVION
    ) 
    REFERENCES ALUMNO.AVIONES 
    ( 
     NAVION
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE ALUMNO.PIEZASSIMPLES 
    ADD CONSTRAINT FK_PS FOREIGN KEY 
    ( 
     NAVION
    ) 
    REFERENCES ALUMNO.AVIONES 
    ( 
     NAVION
    ) 
    NOT DEFERRABLE 
;

CREATE OR REPLACE VIEW ALUMNO.AVIONES_PROFESOR AS
SELECT  NAVION PARTE_ID,NULL PARTE_PADRE,NOMBRE NOMBRE, NULL SN,NULL PN FROM AVIONES
UNION
SELECT IDENTIFICADOR PARTE_ID, IDCOMPUESTO PARTE_PADRE,NOMBRE NOMBRE,SERIALNUMBER SN,IDPARTNUMBER PN FROM PIEZASSIMPLES
WHERE IDCOMPUESTO IS NOT NULL
UNION
SELECT IDENTIFICADOR PARTE_ID, NAVION PARTE_PADRE,NOMBRE NOMBRE, SERIALNUMBER SN,IDPARTNUMBER PN FROM PIEZASSIMPLES
WHERE IDCOMPUESTO IS NULL
UNION
SELECT IDENTIFICADOR PARTE_ID,IDCOMPUESTO  PARTE_PADRE, NOMBRE NOMBRE,NULL SN, NULL PN FROM PIEZASCOMPUESTAS
WHERE IDCOMPUESTO IS NOT NULL
UNION
SELECT IDENTIFICADOR PARTE_ID,NAVION  PARTE_PADRE, NOMBRE NOMBRE,NULL SN, NULL PN FROM PIEZASCOMPUESTAS
WHERE IDCOMPUESTO IS NULL ;



CREATE SEQUENCE ALUMNO.INSTRUCTOR_ID_SEQ 
    INCREMENT BY 1 
    MAXVALUE 999999999999999999999999999 
    MINVALUE 1 
    NOCACHE 
;

CREATE SEQUENCE ALUMNO.SECTION_ID_SEQ 
    INCREMENT BY 1 
    MAXVALUE 999999999999999999999999999 
    MINVALUE 1 
    NOCACHE 
;

CREATE SEQUENCE ALUMNO.SECUENCIA_PIEZA_ID 
    INCREMENT BY 1 
    MAXVALUE 999999999999999999999999999 
    MINVALUE 1 
    CACHE 20 
    ORDER 
;

CREATE SEQUENCE ALUMNO.SECUENCIA_SERIALNUMBER 
    INCREMENT BY 1 
    MAXVALUE 999 
    MINVALUE 1 
    CACHE 20 
    ORDER 
;

CREATE OR REPLACE TRIGGER ALUMNO.CREACION_ID_PIEZA 
    BEFORE INSERT ON ALUMNO.AVIONES 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."NAVION" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."NAVION" from dual; 
      end if; 
   end if; 
end; 
/


CREATE OR REPLACE TRIGGER ALUMNO.DISPARADOR_DE_PIEZAS_SIMPLES 
    BEFORE INSERT ON ALUMNO.PIEZASSIMPLES 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."IDENTIFICADOR" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."IDENTIFICADOR" from dual; 
      end if; 
   end if; 
end;



create or replace
trigger DISPARADOR_DE_PIEZAS_COMPUESTAS
   before insert on PIEZASCOMPUESTAS
   for each row 

begin  
   if inserting then 
      if :NEW."IDENTIFICADOR" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."IDENTIFICADOR" from dual; 
      end if; 
   end if; 
end; 
/


CREATE OR REPLACE TRIGGER ALUMNO.DISPARADOR_PIEZAS_COMPUESTAS 
    BEFORE INSERT ON ALUMNO.PIEZASCOMPUESTAS 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."IDENTIFICADOR" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."IDENTIFICADOR" from dual; 
      end if; 
   end if; 
end;
 
/


CREATE OR REPLACE TRIGGER ALUMNO.DISPARADOR_SERIALNUMBER 
    BEFORE INSERT ON ALUMNO.PIEZASSIMPLES 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."SERIALNUMBER" is null then 
         select 'SN-'||SECUENCIA_SERIALNUMBER.nextval into :NEW."SERIALNUMBER" from dual; 
      end if; 
   end if; 
end; 
/


CREATE OR REPLACE TRIGGER ALUMNO.TRIGGER1 
    BEFORE INSERT ON ALUMNO.PIEZASCOMPUESTAS 
    FOR EACH ROW 
BEGIN
  NULL;
END; 
/



CREATE OR REPLACE PROCEDURE ALUMNO.BORRAR_AVION (AVION_ID IN NUMBER) AS 
ID_AVION NUMBER;
BEGIN
ID_AVION:=AVION_ID;
DELETE FROM PIEZASSIMPLES WHERE NAVION=ID_AVION;
DELETE FROM PIEZASCOMPUESTAS WHERE NAVION=ID_AVION;
DELETE FROM AVIONES WHERE NAVION=ID_AVION;
END BORRAR_AVION;
/

CREATE OR REPLACE PROCEDURE ALUMNO.BORRAR_AVIONES  AS 
BEGIN
DELETE FROM PIEZASSIMPLES;
DELETE FROM PIEZASCOMPUESTAS;
DELETE FROM AVIONES;
END BORRAR_AVIONES;
/

CREATE OR REPLACE PROCEDURE ALUMNO.COPIAR_AVION (AVION_ID IN NUMBER  , COPIA_AVION_ID IN NUMBER) AS 
ID_AVION AVIONES%ROWTYPE;
BEGIN
SELECT * INTO ID_AVION FROM AVIONES WHERE NAVION=AVION_ID;
INSERT INTO AVIONES(NOMBRE,NAVION) VALUES(ID_AVION.NOMBRE,COPIA_AVION_ID);
END COPIAR_AVION;
/

CREATE OR REPLACE procedure ALUMNO.COPIAR_HIJOS(id_origen number, id_destino number) as
cursor c_compuesta is select * from piezascompuestas where navion=id_origen;
cursor c_compuesta2 is select * from piezascompuestas where idpartnumber=id_origen;
cursor c_simple is select * from piezassimples where navion=id_origen;
cursor c_simple2 is select * from piezassimples where idcompuesto=id_origen;
avion number(3);
nuevo_hijo_id number(3);
ident number(3);
begin
  avion:=91;
  for i in c_compuesta loop
    if i.id_pieza_contenedora is null then
      insert into piezascompuestas(nombre, id_avion) values(i.nombre, id_destino);
      ident:=i.identificador;
      select secuencia_pieza_id.currval into nuevo_hijo_id from dual;
      copiar_hijos(ident, nuevo_hijo_id);
    end if;
  end loop;
  for j in c_compuesta2 loop
    if j.id_pieza_contenedora is not null then 
      select id_avion into avion from piezascompuestas where identificador=id_destino;
      insert into piezascompuestas(nombre, id_pieza_contenedora, id_avion) values(j.nombre, id_destino, avion);
      ident:=j.identificador;
      select secuencia_pieza_id.currval into nuevo_hijo_id from dual;
      copiar_hijos(ident, nuevo_hijo_id);
    end if;
  end loop;
  for k in c_simple loop
    if k.id_pieza_contenedora is null then
      insert into piezassimples(part_number, nombre, navion) values(k.part_number, k.nombre, id_destino);
    end if;
  end loop;
  for m in c_simple2 loop
    if m.id_pieza_contenedora is not null then
      select navion into avion from piezas_compuestas where identificador=id_destino;
      insert into piezas_simples(part_number, nombre, id_pieza_contenedora, navion) values(m.part_number, m.nombre, id_destino, avion);
    end if;
  end loop;
end;
/

CREATE OR REPLACE PROCEDURE ALUMNO.CREARAVION(ID NUMBER) AS 
DECLARE
BUSCA_ID NUMBER(10);
BEGIN
SELECT NUMERO_CONSECUTIVO INTO BUSCA_ID FROM AVION
WHERE NUMERO_CONSECUTIVO=ID;

IF BUSCA_ID IS NULL THEN
INSERT INTO AVION VALUES(ID);
 NULL;
END CREARAVION;
/

CREATE OR REPLACE PROCEDURE ALUMNO.CREAR_AVION (AVION_ID IN NUMBER) AS 
I NUMBER:=avion_id;
IDCABINA NUMBER(10);
IDPILOTO NUMBER(10);
BEGIN
INSERT INTO AVIONES(NAVION,NOMBRE) VALUES(I,'AVION1');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10001',I,'PN-001','FUSELAJE');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10002',I,'PN-002','Asiento 1');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10003',I,'PN-003','Controles');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10004',I,'PN-002','Asiento 2');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10005',I,'PN-002','Asiento 3');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10006',I,'PN-004','Motor 1');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10007',I,'PN-004','Motor 2');
INSERT INTO piezascompuestas(idcompuesto,navion,nombre) VALUES(1,I,'Cabina');
INSERT INTO piezascompuestas(idcompuesto,navion,nombre) VALUES(10,I,'Asiento piloto');
END CREAR_AVION;
/

CREATE OR REPLACE PROCEDURE ALUMNO.CREAR_AVION1(ID NUMBER) AS
BUSCA_ID NUMBER(10);
BEGIN
SELECT NUMERO_CONSECUTIVO INTO BUSCA_ID FROM AVION
WHERE NUMERO_CONSECUTIVO=ID;
IF BUSCA_ID!=ID THEN
DBMS_OUTPUT.PUT_LINE('ID NO ENCONTRADO');
END IF;
INSERT INTO AVION VALUES(ID,'NOMBRE');
commit;
END CREAR_AVION1;
/

CREATE OR REPLACE PROCEDURE ALUMNO.CREAR_AVION11(ID NUMBER) AS 
BUSCA_ID NUMBER(10);
BEGIN
SELECT NUMERO_CONSECUTIVO INTO BUSCA_ID FROM AVION
WHERE NUMERO_CONSECUTIVO=ID;
IF BUSCA_ID=ID THEN
DBMS_OUTPUT.PUT_LINE('ID ENCONTRADO');
END IF;
INSERT INTO AVION(NUMERO_CONSECUTIVO,NOMBRE) VALUES(ID,'NOMBRE');
commit;
END CREAR_AVION11;
/

CREATE OR REPLACE PROCEDURE ALUMNO.INTENTA_CREAR_AVION_MASDE10 (AVION_ID IN NUMBER) AS 
I NUMBER:=avion_id;
BEGIN
INSERT INTO AVIONES(NAVION,NOMBRE) VALUES(I,'AVION3');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10019',I,'PN-001','FUSELAJE');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10020',I,'PN-002','Asiento 11');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10021',I,'PN-003','Controles');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10022',I,'PN-002','Asiento 12');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10023',I,'PN-003','Controles');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10024',I,'PN-004','Motor 5');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10025',I,'PN-004','Motor 6');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10026',I,'PN-004','Motor 7');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10027',I,'PN-004','Motor 8');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10028',I,'PN-005','Caja negra');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10029',I,'PN-006','Gps');
INSERT INTO piezascompuestas(idcompuesto,navion,nombre) VALUES(1,I,'Cabina');
INSERT INTO piezascompuestas(idcompuesto,navion,nombre) VALUES(10,I,'Asiento piloto');
INSERT INTO piezascompuestas(idcompuesto,navion,nombre) VALUES(11,I,'Asiento piloto');
END INTENTA_CREAR_AVION_MASDE10;
/

CREATE OR REPLACE PROCEDURE ALUMNO.INTENTA_CREAR_AVION_MASDE4 (AVION_ID IN NUMBER) AS 
I NUMBER:=avion_id;
BEGIN
INSERT INTO AVIONES(NAVION,NOMBRE) VALUES(I,'AVION2');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10008',I,'PN-001','FUSELAJE');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10009',I,'PN-002','Asiento 4');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10010',I,'PN-003','Controles');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10011',I,'PN-002','Asiento 5');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10012',I,'PN-002','Asiento 6');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10013',I,'PN-002','Asiento 7');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10014',I,'PN-002','Asiento 8');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10015',I,'PN-002','Asiento 9');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10016',I,'PN-002','Asiento 10');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10017',I,'PN-004','Motor 3');
INSERT INTO piezassimples(SERIALNUMBER,NAVION,IDPARTNUMBER,NOMBRE) VALUES('SN-10018',I,'PN-004','Motor 4');
INSERT INTO piezascompuestas(idcompuesto,navion,nombre) VALUES(1,I,'Cabina');
INSERT INTO piezascompuestas(idcompuesto,navion,nombre) VALUES(10,I,'Asiento piloto');
END INTENTA_CREAR_AVION_MASDE4;
/

CREATE OR REPLACE FUNCTION ALUMNO.COMPRUEBA_AVION(ID number) RETURN varchar2 AS 
NUMEROPIEZAS NUMBER(10);
ID_NO NUMBER(10):=ID;
EX EXCEPTION;
EX2 EXCEPTION;
  BEGIN
    SELECT COUNT(identificador) INTO NUMEROPIEZAS FROM piezassimples; 
    IF NUMEROPIEZAS>10 THEN
      RAISE EX;
    END IF;
    SELECT NAVION INTO ID_NO FROM aviones WHERE navion=ID;
    IF ID_NO<>ID THEN
      RAISE EX2;
    END IF ;
    EXCEPTION 
      WHEN EX2 THEN
         DBMS_OUTPUT.PUT_LINE('DEMASIADAS PIEZAS');
    RETURN numeropiezas;
  END;
/

CREATE OR REPLACE FUNCTION ALUMNO.COMPRUEBA_PIEZA(ID number) RETURN VARCHAR2 AS 
NUMEROPIEZAS NUMBER(10);
IDAVION NUMBER(10);
EX exception;
BEGIN
select count(identificador) INTO NUMEROPIEZAS from piezascompuestas WHERE numeropiezas=ID;
  IF NUMEROPIEZAS>4 THEN
  RAISE EX;
  END IF;
  IF IDAVION <> id THEN
    RAISE EX;
  END IF;
  RETURN NUMEROPIEZAS;
  EXCEPTION WHEN EX THEN
  DBMS_OUTPUT.PUT_LINE('ERROR');
END;
/

CREATE OR REPLACE FUNCTION ALUMNO.MEDIA RETURN number AS 
Cursor notas is select numeric_grade from grade;
contador number;
resultado number;
media number;
BEGIN
contador:=0;
resultado:=0;
media:=0;
for i in notas loop
if i.numeric_grade>80 then
resultado:=resultado+i.numeric_grade;
contador:=contador+1;
end if;
end loop;
media:=resultado/contador;
return media;
 END;
/

CREATE OR REPLACE FUNCTION ALUMNO.MIFUNCIONMIA RETURN VARCHAR2 AS 
BEGIN
  RETURN NULL;
END MIFUNCIONMIA;
/


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             0
-- ALTER TABLE                              7
-- CREATE VIEW                              1
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                        10
-- CREATE FUNCTION                          4
-- CREATE TRIGGER                           5
-- ALTER TRIGGER                            0
-- CREATE STRUCTURED TYPE                   0
-- CREATE COLLECTION TYPE                   0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          4
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              1
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
