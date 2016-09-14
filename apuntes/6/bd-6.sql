-- Generado por Oracle SQL Developer Data Modeler 3.1.4.710
--   en:        2013-04-04 00:09:44 CEST
--   sitio:      Oracle Database 10g
--   tipo:      Oracle Database 10g



CREATE USER AVIONES 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE TABLE AVIONES.PARTES_AVION 
    ( 
     PARTE_ID NUMBER  NOT NULL , 
     NOMBRE VARCHAR2 (20 BYTE)  NOT NULL , 
     PARTE_PADRE NUMBER , 
     SN VARCHAR2 (20 BYTE) , 
     PN VARCHAR2 (20 BYTE) 
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


CREATE UNIQUE INDEX AVIONES.PARTES_AVION_PK ON AVIONES.PARTES_AVION 
    ( 
     PARTE_ID ASC 
    ) 
    TABLESPACE USERS 
    PCTFREE 10 
    MAXTRANS 255 
    STORAGE ( 
        INITIAL 65536 
        PCTINCREASE 0 
        MINEXTENTS 1 
        MAXEXTENTS 2147483645 
        FREELISTS 1 
        FREELIST GROUPS 1 
        BUFFER_POOL DEFAULT ) 
    LOGGING 
;

ALTER TABLE AVIONES.PARTES_AVION 
    ADD CONSTRAINT PARTES_AVION_PK PRIMARY KEY ( PARTE_ID ) 
    USING INDEX AVIONES.PARTES_AVION_PK ;



CREATE OR REPLACE VIEW AVIONES.AVIONES_PROFESOR AS
select "PARTE_ID","NOMBRE","PARTE_PADRE","SN","PN" from partes_avion ;



CREATE SEQUENCE AVIONES.SECUENCIA_PIEZA_ID 
    INCREMENT BY 1 
    MAXVALUE 999999999999999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE SEQUENCE AVIONES.SECUENCIA_SERIALNUMBER 
    INCREMENT BY 1 
    MAXVALUE 999999999999999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE OR REPLACE TRIGGER AVIONES.PARTES_AVION_SEQ_ID 
    BEFORE INSERT ON AVIONES.PARTES_AVION 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."PARTE_ID" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."PARTE_ID" from dual; 
      end if; 
   end if; 
end;
 
/


CREATE OR REPLACE TRIGGER AVIONES.PARTES_AVION_SEQ_SN 
    BEFORE INSERT ON AVIONES.PARTES_AVION 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW.sn is null and :new.pn is not null then 
         select 'SN-'||SECUENCIA_SERIALNUMBER.nextval into :NEW.sn from dual; 
      end if; 
   end if; 
end; 
/



CREATE OR REPLACE PROCEDURE AVIONES.BORRAR_AVION 
(
  AVION_ID IN NUMBER  
) AS 
BEGIN
  DELETE FROM PARTES_AVION
  WHERE PARTE_ID IN(
    SELECT PARTE_ID FROM PARTES_AVION
    START WITH PARTE_ID = AVION_ID
    CONNECT BY PRIOR parte_id = parte_padre
  );
END BORRAR_AVION;
/

CREATE OR REPLACE PROCEDURE AVIONES.BORRAR_AVIONES AS 
BEGIN
  delete from partes_avion;
END;
/

CREATE OR REPLACE procedure AVIONES.COMPRUEBA_AVION(avion_id number)AS 
  partes_simples number;
BEGIN
  
  if parte_es_avion(avion_id)=0 then
    raise_application_error( -20999, 'No es un avion:' || avion_id );
  end if;
  
  partes_simples := calcula_partes_simples_hijas(avion_id);
  if partes_simples>10 then
    raise_application_error( -20998, 'Muchas partes hijas:' || partes_simples );
  end if;
  
END;
/

CREATE OR REPLACE procedure AVIONES.COMPRUEBA_PIEZA(pieza_id number)AS 
  partes_simples number;
BEGIN
  
  if parte_es_avion(pieza_id)=1 then
    raise_application_error( -20997, 'Es un avion:' || pieza_id );
  end if;
  
  partes_simples := calcula_partes_simples_hijas(pieza_id);
  if partes_simples>4 then
    raise_application_error( -20996, 'Muchas partes hijas:' || partes_simples );
  end if;
  
END;
/

CREATE OR REPLACE PROCEDURE AVIONES.COPIAR_AVION 
(
  AVION_ID IN NUMBER  
, COPIA_AVION_ID IN NUMBER  
) AS 
  AVION_EXISTENTE PARTES_AVION%ROWTYPE;
BEGIN
  -- AVION QUE YA EXISTE
  SELECT * INTO avion_EXISTENTE
  FROM PARTES_AVION
  WHERE PARTE_ID = AVION_ID;
  
  -- AVION A CREAR
  INSERT INTO PARTES_AVION(PARTE_ID,NOMBRE,PARTE_PADRE,PN)
  VALUES(COPIA_AVION_ID,AVION_existente.nombre, null,  null );
  
  COPIAR_HIJOS_DE_PIEZA(AVION_ID, COPIA_AVION_ID);
  
  
END COPIAR_AVION;
/

CREATE OR REPLACE PROCEDURE AVIONES.COPIAR_HIJOS_DE_PIEZA 
(
  PIEZA_ID IN NUMBER  
, PIEZA_COPIA_ID IN NUMBER  
) AS 
  PARTE_EXISTENTE PARTES_AVION%ROWTYPE;
  parte_recien_creada number;
BEGIN
  for PARTE_EXISTENTE in (select * from partes_avion where parte_padre=pieza_id)
  loop
    -- PARTE A CREAR COMO HIJA DE PIEZA_COPIA_ID
    INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
    VALUES(PARTE_EXISTENTE.nombre, PIEZA_COPIA_ID, PARTE_EXISTENTE.PN );
    
    select SECUENCIA_PIEZA_ID.currval into parte_recien_creada from dual;
    copiar_hijos_de_pieza(PARTE_EXISTENTE.PARTE_ID,parte_recien_creada);
  end loop;
                        
END COPIAR_HIJOS_DE_PIEZA;
/

CREATE OR REPLACE PROCEDURE AVIONES.CREAR_AVION 
(
  AVION_ID IN NUMBER  
) AS 
  cabina_id number;
  asientopiloto_id number;
BEGIN
  INSERT INTO PARTES_AVION(PARTE_ID,NOMBRE,PARTE_PADRE,PN)
  VALUES(avion_id,'Avion 1', null,  null );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Fuselaje', avion_id, 'PN-001' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Cabina', avion_id, null );
  select SECUENCIA_PIEZA_ID.currval into cabina_id from dual;
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento piloto', cabina_id, null );
  select SECUENCIA_PIEZA_ID.currval into asientopiloto_id from dual;
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 1', asientopiloto_id, 'PN-002' );

  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Controles', asientopiloto_id, 'PN-003' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 2', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 3', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Motor 1', avion_id, 'PN-004' );
    
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Motor 2', avion_id, 'PN-004' );
  
END CREAR_AVION;
/

CREATE OR REPLACE PROCEDURE AVIONES.INTENTA_CREAR_AVION_MASDE4 
(
  AVION_ID IN NUMBER  
) AS 
  cabina_id number;
  asientopiloto_id number;
BEGIN
  INSERT INTO PARTES_AVION(PARTE_ID,NOMBRE,PARTE_PADRE,PN)
  VALUES(avion_id,'Avion 2', null,  null );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Fuselaje', avion_id, 'PN-001' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Cabina', avion_id, null );
  select SECUENCIA_PIEZA_ID.currval into cabina_id from dual;
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento piloto', cabina_id, null );
  select SECUENCIA_PIEZA_ID.currval into asientopiloto_id from dual;
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 4', asientopiloto_id, 'PN-002' );

  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Controles', asientopiloto_id, 'PN-003' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 5', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 6', cabina_id, 'PN-002' );

  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 7', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 8', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 9', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 10', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Motor 1', avion_id, 'PN-004' );
    
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Motor 2', avion_id, 'PN-004' );
  
END INTENTA_CREAR_AVION_MASDE4;
/

CREATE OR REPLACE PROCEDURE AVIONES."INTENTA_CREAR_AVION_MASDE4 " 
(
  AVION_ID IN NUMBER  
) AS 
  cabina_id number;
  asientopiloto_id number;
BEGIN
  INSERT INTO PARTES_AVION(PARTE_ID,NOMBRE,PARTE_PADRE,PN)
  VALUES(avion_id,'Avion 1', null,  null );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Fuselaje', avion_id, 'PN-001' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Cabina', avion_id, null );
  select SECUENCIA_PIEZA_ID.currval into cabina_id from dual;
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento piloto', cabina_id, null );
  select SECUENCIA_PIEZA_ID.currval into asientopiloto_id from dual;
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 4', asientopiloto_id, 'PN-002' );

  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Controles', asientopiloto_id, 'PN-003' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 5', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 6', cabina_id, 'PN-002' );

  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 7', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 8', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 9', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Asiento 10', cabina_id, 'PN-002' );
  
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Motor 1', avion_id, 'PN-004' );
    
  INSERT INTO PARTES_AVION(NOMBRE,PARTE_PADRE,PN)
  VALUES('Motor 2', avion_id, 'PN-004' );
  
END "INTENTA_CREAR_AVION_MASDE4 ";
/

CREATE OR REPLACE FUNCTION AVIONES.CALCULA_PARTES_SIMPLES_HIJAS 
(
  P_ID IN NUMBER  
) RETURN NUMBER AS 
  partessimples number;
BEGIN
  select count(sn) into partessimples
  from partes_avion
  start with parte_id = p_id
  connect by prior parte_id = parte_padre;
  
  return partessimples;
END CALCULA_PARTES_SIMPLES_HIJAS;
/

CREATE OR REPLACE FUNCTION AVIONES.PARTE_ES_AVION 
(
  P_ID IN NUMBER  
) RETURN number AS 
  padre number;
BEGIN
  select parte_padre into padre
  from partes_avion
  where parte_id = p_id;
  
  if padre is null then
    return 1;
  else
    return 0;
  end if;
  
END PARTE_ES_AVION;
/

CREATE OR REPLACE FUNCTION AVIONES.PARTE_ES_SIMPLE 
(
  P_ID IN NUMBER  
) RETURN VARCHAR2 AS 
  SERIAL varchar2(20);
BEGIN
  select sn into serial
  from partes_avion
  where parte_id = p_id;
  
  if serial is null then
    return 0;
  else
    return 1;
  end if;
END PARTE_ES_SIMPLE;
/


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             1
-- CREATE INDEX                             1
-- ALTER TABLE                              1
-- CREATE VIEW                              1
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         9
-- CREATE FUNCTION                          3
-- CREATE TRIGGER                           2
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
