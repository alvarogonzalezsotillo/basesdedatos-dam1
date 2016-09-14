-- Generado por Oracle SQL Developer Data Modeler 3.1.4.710
--   en:        2013-04-24 01:52:49 CEST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



--CREATE USER PRUEBA 
--    IDENTIFIED BY  
--    ACCOUNT UNLOCK 
--;

CREATE TABLE AVIONES 
    ( 
     IDENTIFICADOR NUMBER (6)  NOT NULL , 
     NOMBRE VARCHAR2 (20 BYTE) 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE USERS 
        LOGGING 
        STORAGE ( 
        INITIAL 65536 
        NEXT 1048576 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
    ) 
;



ALTER TABLE AVIONES 
    ADD CONSTRAINT NOMBREAVION_NOTNULL 
    CHECK ( nombre is not null) 
;

CREATE UNIQUE INDEX AVIONES_PK ON AVIONES 
    ( 
     IDENTIFICADOR ASC 
    ) 
    TABLESPACE USERS 
    PCTFREE 10 
    MAXTRANS 255 
    STORAGE ( 
        INITIAL 65536 
        NEXT 1048576 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT ) 
    LOGGING 
;

ALTER TABLE AVIONES 
    ADD CONSTRAINT AVIONES_PK PRIMARY KEY ( IDENTIFICADOR ) 
    USING INDEX AVIONES_PK ;



CREATE TABLE PART_NUMBER 
    ( 
     PART_NUMBER VARCHAR2 (10 BYTE)  NOT NULL 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE USERS 
        LOGGING 
        STORAGE ( 
        INITIAL 65536 
        NEXT 1048576 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
    ) 
;


CREATE UNIQUE INDEX PART_PK ON PART_NUMBER 
    ( 
     PART_NUMBER ASC 
    ) 
    TABLESPACE USERS 
    PCTFREE 10 
    MAXTRANS 255 
    STORAGE ( 
        INITIAL 65536 
        NEXT 1048576 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT ) 
    LOGGING 
;

ALTER TABLE PART_NUMBER 
    ADD CONSTRAINT PART_PK PRIMARY KEY ( PART_NUMBER ) 
    USING INDEX PART_PK ;

insert into part_number values('PN-001');
insert into part_number values('PN-002');
insert into part_number values('PN-003');
insert into part_number values('PN-004');
insert into part_number values('PN-005');
insert into part_number values('PN-006');

CREATE TABLE PIEZAS_COMPUESTAS 
    ( 
     IDENTIFICADOR NUMBER (6)  NOT NULL , 
     NOMBRE VARCHAR2 (20 BYTE) , 
     ID_AVION NUMBER (6) , 
     ID_PIEZA_CONTENEDORA NUMBER (6) 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE USERS 
        LOGGING 
        STORAGE ( 
        INITIAL 65536 
        NEXT 1048576 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
    ) 
;



ALTER TABLE PIEZAS_COMPUESTAS 
    ADD CONSTRAINT NOMBREPIEZACOMPUESTA 
    CHECK ( nombre is not null) 
;

CREATE UNIQUE INDEX PC_PK ON PIEZAS_COMPUESTAS 
    ( 
     IDENTIFICADOR ASC 
    ) 
    TABLESPACE USERS 
    PCTFREE 10 
    MAXTRANS 255 
    STORAGE ( 
        INITIAL 65536 
        NEXT 1048576 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT ) 
    LOGGING 
;

ALTER TABLE PIEZAS_COMPUESTAS 
    ADD CONSTRAINT PC_PK PRIMARY KEY ( IDENTIFICADOR ) 
    USING INDEX PC_PK ;



CREATE TABLE PIEZAS_SIMPLES 
    ( 
     IDENTIFICADOR NUMBER (6)  NOT NULL , 
     SERIAL_NUMBER VARCHAR2 (10 BYTE) , 
     NOMBRE VARCHAR2 (20 BYTE) , 
     PART_NUMBER VARCHAR2 (10 BYTE) , 
     ID_AVION NUMBER (6) , 
     ID_PIEZA_CONTENEDORA NUMBER (6) 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE USERS 
        LOGGING 
        STORAGE ( 
        INITIAL 65536 
        NEXT 1048576 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT 
    ) 
;



ALTER TABLE PIEZAS_SIMPLES 
    ADD CONSTRAINT SERIALNUMBER_NOTNULL 
    CHECK ( serial_number is not null) 
;


ALTER TABLE PIEZAS_SIMPLES 
    ADD CONSTRAINT NOMBREPIEZA_NOTNULL 
    CHECK ( nombre is not null) 
;


ALTER TABLE PIEZAS_SIMPLES 
    ADD CONSTRAINT PARTNUMBER_NOTNULL 
    CHECK ( part_number is not null) 
;

CREATE UNIQUE INDEX PS_PK ON PIEZAS_SIMPLES 
    ( 
     IDENTIFICADOR ASC 
    ) 
    TABLESPACE USERS 
    PCTFREE 10 
    MAXTRANS 255 
    STORAGE ( 
        INITIAL 65536 
        NEXT 1048576 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT ) 
    LOGGING 
;
CREATE UNIQUE INDEX SERIALNUMBER_UNIQUE ON PIEZAS_SIMPLES 
    ( 
     SERIAL_NUMBER ASC 
    ) 
    TABLESPACE USERS 
    PCTFREE 10 
    MAXTRANS 255 
    STORAGE ( 
        INITIAL 65536 
        NEXT 1048576 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT ) 
    LOGGING 
;

ALTER TABLE PIEZAS_SIMPLES 
    ADD CONSTRAINT PS_PK PRIMARY KEY ( IDENTIFICADOR ) 
    USING INDEX PS_PK ;


ALTER TABLE PIEZAS_SIMPLES 
    ADD CONSTRAINT SERIALNUMBER_UNIQUE UNIQUE ( SERIAL_NUMBER ) 
    USING INDEX SERIALNUMBER_UNIQUE ;




ALTER TABLE PIEZAS_COMPUESTAS 
    ADD CONSTRAINT PC_FK FOREIGN KEY 
    ( 
     ID_AVION
    ) 
    REFERENCES AVIONES 
    ( 
     IDENTIFICADOR
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE PIEZAS_COMPUESTAS 
    ADD CONSTRAINT PC_FK2 FOREIGN KEY 
    ( 
     ID_PIEZA_CONTENEDORA
    ) 
    REFERENCES PIEZAS_COMPUESTAS 
    ( 
     IDENTIFICADOR
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE PIEZAS_SIMPLES 
    ADD CONSTRAINT PS_FK1 FOREIGN KEY 
    ( 
     PART_NUMBER
    ) 
    REFERENCES PART_NUMBER 
    ( 
     PART_NUMBER
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE PIEZAS_SIMPLES 
    ADD CONSTRAINT PS_FK2 FOREIGN KEY 
    ( 
     ID_AVION
    ) 
    REFERENCES AVIONES 
    ( 
     IDENTIFICADOR
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE PIEZAS_SIMPLES 
    ADD CONSTRAINT PS_FK3 FOREIGN KEY 
    ( 
     ID_PIEZA_CONTENEDORA
    ) 
    REFERENCES PIEZAS_COMPUESTAS 
    ( 
     IDENTIFICADOR
    ) 
    NOT DEFERRABLE 
;

CREATE OR REPLACE VIEW AVIONES_PROFESOR AS
select identificador PARTE_ID, null PARTE_PADRE, nombre NOMBRE, null SN, null PN 
from aviones
union
select identificador PARTE_ID, id_pieza_contenedora PARTE_PADRE, nombre NOMBRE, serial_number SN, part_number PN 
from piezas_simples
where id_pieza_contenedora is not null
union
select identificador PARTE_ID, id_avion PARTE_PADRE, nombre NOMBRE, serial_number SN, part_number PN 
from piezas_simples
where id_pieza_contenedora is null
union
select identificador PARTE_ID, id_pieza_contenedora PARTE_PADRE, nombre NOMBRE, null SN, null PN
from piezas_compuestas
where id_pieza_contenedora is not null
union
select identificador PARTE_ID, id_avion PARTE_PADRE, nombre NOMBRE, null SN, null PN
from piezas_compuestas
where id_pieza_contenedora is null ;



CREATE SEQUENCE SECUENCIA_PIEZA_ID 
    INCREMENT BY 1 
    MAXVALUE 999999999999999999999999999 
    MINVALUE 1 
    CACHE 20 
    ORDER 
;

CREATE SEQUENCE SECUENCIA_SERIALNUMBER 
    INCREMENT BY 1 
    MAXVALUE 999999999999999999999999999 
    MINVALUE 1 
    CACHE 20 
    ORDER 
;

CREATE OR REPLACE TRIGGER DISPARADOR_SERIALNUMBER 
    BEFORE INSERT ON PIEZAS_SIMPLES 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."SERIAL_NUMBER" is null then 
         select 'SN-100'||SECUENCIA_SERIALNUMBER.nextval into :NEW."SERIAL_NUMBER" from dual; 
      end if; 
   end if; 
end; 
/


CREATE OR REPLACE TRIGGER IDENTIFICADOR_AVION 
    BEFORE INSERT ON AVIONES 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."IDENTIFICADOR" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."IDENTIFICADOR" from dual; 
      end if; 
   end if; 
end; 
/


CREATE OR REPLACE TRIGGER IDENTIFICADOR_PIEZASCOMPUESTAS 
    BEFORE INSERT ON PIEZAS_COMPUESTAS 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."IDENTIFICADOR" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."IDENTIFICADOR" from dual; 
      end if; 
   end if; 
end; 
/


CREATE OR REPLACE TRIGGER IDENTIFICADOR_PIEZASSIMPLES 
    BEFORE INSERT ON PIEZAS_SIMPLES 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."IDENTIFICADOR" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."IDENTIFICADOR" from dual; 
      end if; 
   end if; 
end; 
/



CREATE OR REPLACE procedure BORRAR_AVION(avion_id number) as
idavion number;
begin
  idavion:=avion_id;
  delete from piezas_simples where id_avion=idavion;
  delete from piezas_compuestas where id_avion=idavion;
  delete from aviones where identificador=idavion;
end;
/

CREATE OR REPLACE procedure BORRAR_AVIONES as
begin
  delete from piezas_simples;
  delete from piezas_compuestas;
  delete from aviones;
end;
/

CREATE OR REPLACE procedure COPIAR_HIJOS(id_origen number, id_destino number) as
cursor c_compuesta is select * from piezas_compuestas where id_avion=id_origen;
cursor c_compuesta2 is select * from piezas_compuestas where id_pieza_contenedora=id_origen;
cursor c_simple is select * from piezas_simples where id_avion=id_origen;
cursor c_simple2 is select * from piezas_simples where id_pieza_contenedora=id_origen;
avion number(10);
nuevo_hijo_id number(10);
ident number(10);
begin
  avion:=91;
  for i in c_compuesta loop
    if i.id_pieza_contenedora is null then
      insert into piezas_compuestas(nombre, id_avion) values(i.nombre, id_destino);
      ident:=i.identificador;
      select secuencia_pieza_id.currval into nuevo_hijo_id from dual;
      copiar_hijos(ident, nuevo_hijo_id);
    end if;
  end loop;
  for j in c_compuesta2 loop
    if j.id_pieza_contenedora is not null then 
      select id_avion into avion from piezas_compuestas where identificador=id_destino;
      insert into piezas_compuestas(nombre, id_pieza_contenedora, id_avion) values(j.nombre, id_destino, avion);
      ident:=j.identificador;
      select secuencia_pieza_id.currval into nuevo_hijo_id from dual;
      copiar_hijos(ident, nuevo_hijo_id);
    end if;
  end loop;
  for k in c_simple loop
    if k.id_pieza_contenedora is null then
      insert into piezas_simples(part_number, nombre, id_avion) values(k.part_number, k.nombre, id_destino);
    end if;
  end loop;
  for m in c_simple2 loop
    if m.id_pieza_contenedora is not null then
      select id_avion into avion from piezas_compuestas where identificador=id_destino;
      insert into piezas_simples(part_number, nombre, id_pieza_contenedora, id_avion) values(m.part_number, m.nombre, id_destino, avion);
    end if;
  end loop;
end;
/

CREATE OR REPLACE procedure COPIAR_AVION(avion_id number, copia_avion_id number) as
avion_existente aviones%rowtype;
begin
  select * into avion_existente 
  from aviones
  where identificador=avion_id;
  insert into aviones values(copia_avion_id, avion_existente.nombre);
  copiar_hijos(avion_id, copia_avion_id);
end;
/


CREATE OR REPLACE procedure CREAR_AVION(avion_id number) as
idavion number;
idcabina number;
idpiloto number;
e number;
begin
    insert into aviones(identificador, nombre) values(avion_id, 'Avion 1');
    idavion:=avion_id;
    insert into piezas_simples(part_number, id_avion, nombre) values('PN-001', idavion, 'Fuselaje');
    insert into piezas_compuestas(id_avion, nombre) values(idavion, 'Cabina');
    select secuencia_pieza_id.currval into idcabina from dual;
    insert into piezas_compuestas(id_avion, nombre, id_pieza_contenedora) values(idavion, 'Asiento piloto', idcabina);
    select secuencia_pieza_id.currval into idpiloto from dual;
    insert into piezas_simples(part_number, id_avion, id_pieza_contenedora, nombre) values('PN-002', idavion, idpiloto, 'Asiento1');
    insert into piezas_simples(part_number, id_avion, id_pieza_contenedora, nombre) values('PN-003', idavion, idpiloto, 'Controles');
    insert into piezas_simples(part_number, id_avion, id_pieza_contenedora, nombre) values('PN-002', idavion, idcabina, 'Asiento 2');
    insert into piezas_simples(part_number, id_avion, id_pieza_contenedora, nombre) values('PN-002', idavion, idcabina, 'Asiento 3');
    insert into piezas_simples(part_number, id_avion, nombre) values('PN-004', idavion, 'Motor 1');
    insert into piezas_simples(part_number, id_avion, nombre) values('PN-004', idavion, 'Motor 2'); 
end;
/

CREATE OR REPLACE procedure INTENTA_CREAR_AVION_MASDE10(avion_id number) as
idcabina number(10);
idpiloto number(10);
idcopiloto number(10);
begin
  insert into aviones(identificador, nombre) values(avion_id, 'Avion 3');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('Fuselaje', avion_id, 'PN-001', 'SN-10019');
  insert into piezas_compuestas(nombre, id_avion) values('Cabina', avion_id);
  select secuencia_pieza_id.currval into idcabina from dual;
  insert into piezas_compuestas(nombre, id_avion, id_pieza_contenedora) values('Asiento piloto', avion_id, idcabina);
  select secuencia_pieza_id.currval into idpiloto from dual;
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Asiento 11', avion_id, idpiloto,'PN-002','SN-10020');
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Controles', avion_id, idpiloto,'PN-003', 'SN-10021');
  insert into piezas_compuestas(nombre, id_avion, id_pieza_contenedora) values('Asiento copiloto', avion_id, idcabina);
  select secuencia_pieza_id.currval into idcopiloto from dual;
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Asiento 12', avion_id, idcopiloto,'PN-002','SN-10022');
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Controles', avion_id, idcopiloto,'PN-003', 'SN-10023');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('Motor 5', avion_id, 'PN-004', 'SN-10024');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('Motor 6', avion_id, 'PN-004', 'SN-10025');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('Motor 7', avion_id, 'PN-004', 'SN-10026');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('Motor 8', avion_id, 'PN-004', 'SN-10027');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('Caja negra', avion_id, 'PN-005', 'SN-10028');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('GPS', avion_id, 'PN-006', 'SN-10029');
end;
/

CREATE OR REPLACE procedure INTENTA_CREAR_AVION_MASDE4(avion_id number) as
idcabina number(10);
idpiloto number(10);
begin
  insert into aviones(identificador, nombre) values(avion_id, 'Avion 2');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('Fuselaje', avion_id, 'PN-001', 'SN-1008');
  insert into piezas_compuestas(nombre, id_avion) values('Cabina', avion_id);
  select secuencia_pieza_id.currval into idcabina from dual;
  insert into piezas_compuestas(nombre, id_avion, id_pieza_contenedora) values('Asiento piloto', avion_id, idcabina);
  select secuencia_pieza_id.currval into idpiloto from dual;
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Asiento 4', avion_id, idpiloto,'PN-002','SN-1009');
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Controles', avion_id, idpiloto,'PN-003', 'SN-10010');
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Asiento 5', avion_id, idcabina,'PN-002', 'SN-10011');
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Asiento 6', avion_id, idcabina,'PN-002', 'SN-10012');
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Asiento 7', avion_id, idcabina,'PN-002', 'SN-10013'); 
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number ,serial_number) values('Asiento 8', avion_id, idcabina,'PN-002', 'SN-10014');
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Asiento 9', avion_id, idcabina,'PN-002', 'SN-10015');
  insert into piezas_simples(nombre, id_avion, id_pieza_contenedora, part_number, serial_number) values('Asiento 10', avion_id, idcabina,'PN-002', 'SN-10016');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('Motor 1', avion_id, 'PN-004', 'SN-10017');
  insert into piezas_simples(nombre, id_avion, part_number, serial_number) values('Motor 2', avion_id, 'PN-004', 'SN-10018');
end;
/

CREATE OR REPLACE function COMPRUEBA_AVION(id number) return number as
es_avion number(10);
cantidad_de_piezas number(10);
no_es_avion exception;
mas_de_diez_piezas exception;
begin
  select count(identificador) into es_avion from aviones where identificador=id;
  if es_avion=0 then
    raise_application_error(-20002,'No es un avion');
  else
   select count(identificador) into cantidad_de_piezas from piezas_simples where id_avion=id;
   if cantidad_de_piezas > 10 then
      raise_application_error(-20001,'El avion tiene mas de diez piezas');
   end if;
  end if;
  return cantidad_de_piezas;
end;
/

CREATE OR REPLACE function COMPRUEBA_PIEZA(id number) return number as
es_avion number(10);
es_compuesta number(10);
cantidad_de_piezas number(10);
begin
  select count(identificador) into es_avion from aviones where identificador=id;
  if es_avion>0 then
    raise_application_error(-20003, 'Es un avion');
  else
    select count(identificador) into es_compuesta from piezas_compuestas where identificador=id;
    if es_compuesta=0 then
      raise_application_error(-20005, 'No es compuesta');
    else  
      select count(identificador) into cantidad_de_piezas from piezas_simples where id_pieza_contenedora=id;
      if cantidad_de_piezas>4 then
        raise_application_error(-20004, 'Hay mas de cuatro piezas');
      end if;
    end if;
  end if;
  return cantidad_de_piezas;
end;
/


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             5
-- ALTER TABLE                             15
-- CREATE VIEW                              1
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         7
-- CREATE FUNCTION                          2
-- CREATE TRIGGER                           4
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
-- CREATE SEQUENCE                          2
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
