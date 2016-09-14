-- Generado por Oracle SQL Developer Data Modeler 3.1.4.710
--   en:        2013-04-23 13:32:51 CEST
--   sitio:      Oracle Database 10g
--   tipo:      Oracle Database 10g



CREATE TABLE PIEZA (ID_PIEZA NUMBER (6)  NOT NULL ,ID_PIEZA_CONTENEDORA NUMBER (6) ,NOMBRE VARCHAR2 (20 BYTE)  NOT NULL ,SN VARCHAR2 (40 BYTE) ,PN VARCHAR2 (40 BYTE))TABLESPACE USERS LOGGING;

CREATE UNIQUE INDEX PIEZA_PK ON PIEZA (ID_PIEZA ASC)TABLESPACE USERS LOGGING;

ALTER TABLE PIEZA ADD CONSTRAINT PIEZA_PK PRIMARY KEY ( ID_PIEZA ) USING INDEX PIEZA_PK;


ALTER TABLE PIEZA ADD CONSTRAINT PIEZA_PIEZA_FK1 FOREIGN KEY(ID_PIEZA)REFERENCES PIEZA(ID_PIEZA)ON DELETE CASCADE NOT DEFERRABLE;

CREATE OR REPLACE VIEW AVIONES_PROFESOR AS SELECT ID_PIEZA as PARTE_ID, ID_PIEZA_CONTENEDORA as PARTE_PADRE, NOMBRE as NOMBRE, SN as SN, PN as PN FROM pieza ;


CREATE SEQUENCE SECUENCIA_PIEZA_ID INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20 ORDER;

CREATE SEQUENCE SECUENCIA_SERIALNUMBER INCREMENT BY 1 MAXVALUE 999999999999999999999999999 MINVALUE 1 CACHE 20 ORDER ;

CREATE OR REPLACE TRIGGER DISPARADOR_ID 
    BEFORE INSERT ON PIEZA 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."ID_PIEZA" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."ID_PIEZA" from dual; 
      end if; 
   end if; 
end;
 
/
CREATE OR REPLACE TRIGGER DISPARADOR_SN 
    BEFORE INSERT ON PIEZA 
    FOR EACH ROW 
begin  
   if inserting then     
      if :NEW."SN" is null and :NEW."PN" is not null then  
      select 'SN-'||SECUENCIA_SERIALNUMBER.nextval into :NEW."SN" from dual; 
      end if; 
   end if; 
end; 
/
CREATE OR REPLACE PROCEDURE BORRAR_AVION
(PADRE_ID_PIEZA  PIEZA.ID_PIEZA%TYPE) 
IS
BEGIN
 for j in (select ID_PIEZA
            FROM pieza
            START WITH id_pieza=PADRE_ID_PIEZA
            CONNECT BY PRIOR ID_PIEZA=id_pieza_contenedora)
LOOP
            
    DELETE From pieza
    WHERE id_pieza= j.id_pieza;
    
    end loop;
END BORRAR_AVION;
/

CREATE OR REPLACE PROCEDURE COPIAR_HIJOS_DE_PIEZA 
(PIEZA_ID IN NUMBER, 
  PIEZA_COPIA_ID IN NUMBER) AS 
  PIEZA_EXISTENTE PIEZA%ROWTYPE;
  
  parte_recien_creada number;

BEGIN
  for PIEZA_EXISTENTE in (select * from PIEZA where id_pieza_contenedora=pieza_id)
  loop

    INSERT INTO PIEZA(ID_PIEZA, NOMBRE, id_pieza_contenedora, sn, PN)
    VALUES(NULL, PIEZA_EXISTENTE.nombre, PIEZA_COPIA_ID, NULL, PIEZA_EXISTENTE.PN );
    
    select SECUENCIA_PIEZA_ID.currval into parte_recien_creada from dual;
    COPIAR_HIJOS_DE_PIEZA(PIEZA_EXISTENTE.ID_PIEZA, parte_recien_creada);
  end loop;
                        
END COPIAR_HIJOS_DE_PIEZA;
/
CREATE OR REPLACE PROCEDURE COPIAR_AVION 
  (AVION_ID IN NUMBER, 
   COPIA_AVION_ID IN NUMBER) AS 
  AVION_EXISTENTE PIEZA%ROWTYPE;
  
BEGIN

  SELECT * INTO AVION_EXISTENTE
  FROM PIEZA
  WHERE ID_PIEZA = AVION_ID;
  
  INSERT INTO PIEZA(id_pieza, NOMBRE, id_pieza_contenedora, sn, PN)
  VALUES(COPIA_AVION_ID,AVION_existente.nombre, null,  null, NULL );
  
  COPIAR_HIJOS_DE_PIEZA(AVION_ID, COPIA_AVION_ID);
  
END COPIAR_AVION;
/

CREATE OR REPLACE PROCEDURE CREAR_AVION
(NUEVO_ID_PIEZA  PIEZA.ID_PIEZA%TYPE) IS 
BEGIN 
insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
VALUES (nuevo_id_pieza, null, 'Avion 1', null, null);
  
  insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
  VALUES (nuevo_id_pieza+1, nuevo_id_pieza, 'Fuselaje', null, 'PN-001'); 
  insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
  VALUES (nuevo_id_pieza+2, nuevo_id_pieza, 'Cabina', null, null);
  
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+3, nuevo_id_pieza+2, 'Asiento Piloto', null, null);
      
          insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
          VALUES (nuevo_id_pieza+4, nuevo_id_pieza+3, 'Asiento1', null, 'PN-002');
          insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
          VALUES (nuevo_id_pieza+5, nuevo_id_pieza+3, 'controles', null, 'PN-003');
          
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+6, nuevo_id_pieza+2, 'Asiento2', null, 'PN-002');
      
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+7, nuevo_id_pieza+2, 'Asiento3', null, 'PN-002');
      
  insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
  VALUES (nuevo_id_pieza+8, nuevo_id_pieza, 'Motor1', null, 'PN-004');   
  insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
  VALUES (nuevo_id_pieza+9, nuevo_id_pieza, 'Motor2', null, 'PN-004'); 
  
END CREAR_AVION;
/
CREATE OR REPLACE PROCEDURE INTENTA_CREAR_AVION_MASDE10 
(NUEVO_ID_PIEZA  PIEZA.ID_PIEZA%TYPE) IS
BEGIN
    insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
    VALUES (nuevo_id_pieza, null, 'Avion  3', null, null);
    
        insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
        VALUES (nuevo_id_pieza+1, nuevo_id_pieza, 'Fuselaje', null, 'PN-001'); 
        insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
        VALUES (nuevo_id_pieza+2, nuevo_id_pieza, 'Cabina', null, null);

          insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
          VALUES (nuevo_id_pieza+3, nuevo_id_pieza+2, 'Asiento Piloto', null, null);
          
              insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
              VALUES (nuevo_id_pieza+4, nuevo_id_pieza+3, 'Asiento11', null, 'PN-002');
              insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
              VALUES (nuevo_id_pieza+5, nuevo_id_pieza+3, 'controles', null, 'PN-003');
              
          insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
          VALUES (nuevo_id_pieza+6, nuevo_id_pieza+2, 'Asiento Copiloto', null, null);
          
              insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
              VALUES (nuevo_id_pieza+7, nuevo_id_pieza+3, 'Asiento12', null, 'PN-002');
              insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
              VALUES (nuevo_id_pieza+8, nuevo_id_pieza+3, 'controles', null, 'PN-003');
              
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
    VALUES (nuevo_id_pieza+9, nuevo_id_pieza, 'Motor5', null, 'PN-004');   
    insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
    VALUES (nuevo_id_pieza+10, nuevo_id_pieza, 'Motor6', null, 'PN-004'); 
    
     insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
    VALUES (nuevo_id_pieza+11, nuevo_id_pieza, 'Motor7', null, 'PN-004');   
    insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
    VALUES (nuevo_id_pieza+12, nuevo_id_pieza, 'Motor8', null, 'PN-004');
    
    insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
    VALUES (nuevo_id_pieza+13, nuevo_id_pieza, 'Caja Negra', null, 'PN-004');
    insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
    VALUES (nuevo_id_pieza+14, nuevo_id_pieza, 'GPS', null, 'PN-004');
  NULL;
  
END INTENTA_CREAR_AVION_MASDE10;
/
CREATE OR REPLACE PROCEDURE INTENTA_CREAR_AVION_MASDE4 (NUEVO_ID_PIEZA  PIEZA.ID_PIEZA%TYPE) IS 
BEGIN
insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
VALUES (nuevo_id_pieza, null, 'Avion 2', null, null);
 insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
  VALUES (nuevo_id_pieza+1, nuevo_id_pieza, 'Fuselaje', 'SN-1008', 'PN-001'); 
  insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
  VALUES (nuevo_id_pieza+2, nuevo_id_pieza, 'Cabina', null, null);
  
     insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+3, nuevo_id_pieza+2, 'Asiento Piloto', null, null);
      
          insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
          VALUES (nuevo_id_pieza+4, nuevo_id_pieza+3, 'Asiento11', null, 'PN-002');
          insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
          VALUES (nuevo_id_pieza+5, nuevo_id_pieza+3, 'controles', null, 'PN-003');
          
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+6, nuevo_id_pieza+2, 'Asiento5', null, 'PN-002');
      
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+7, nuevo_id_pieza+2, 'Asiento6', null, 'PN-002');
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+8, nuevo_id_pieza+2, 'Asiento7', null, 'PN-002');
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+9, nuevo_id_pieza+2, 'Asiento8', null, 'PN-002');
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+10, nuevo_id_pieza+2, 'Asiento9', null, 'PN-002');
      insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
      VALUES (nuevo_id_pieza+11, nuevo_id_pieza+2, 'Asiento10', null, 'PN-002');
      
  insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
  VALUES (nuevo_id_pieza+12, nuevo_id_pieza, 'Motor1', null, 'PN-004');   
  insert into pieza (id_pieza, id_pieza_contenedora, nombre, sn, pn)
  VALUES (nuevo_id_pieza+13, nuevo_id_pieza, 'Motor2', null, 'PN-004'); 
  
END INTENTA_CREAR_AVION_MASDE4 ;
/
CREATE OR REPLACE FUNCTION COMPRUEBA_AVION(PADRE_ID_PIEZA  PIEZA.ID_PIEZA%TYPE) RETURN varchar2 AS 
cantidad Number;

BEGIN
cantidad := 0;
 for j in (select id_pieza_contenedora , sn
           FROM pieza
          START WITH id_pieza=PADRE_ID_PIEZA
          CONNECT BY PRIOR ID_PIEZA=id_pieza_contenedora)
LOOP   
        if j.sn is not null then
           cantidad := cantidad +1;
        end if; 
        if cantidad > 10 then
          raise_application_error (-20001,'Este avion contiene demasiadas piezas simples.');
        end if;   
    end loop;
  RETURN 'Este avion no excede de piezas simples';
END COMPRUEBA_AVION;
/
CREATE OR REPLACE FUNCTION COMPRUEBA_PIEZA RETURN varchar2 AS 
cantidad Number;
piezaCompuesta Number;
BEGIN
piezaCompuesta :=0;
cantidad := 0;
 for j in (select id_pieza_contenedora, sn
            FROM pieza
             order by id_pieza_contenedora)
LOOP   
      if piezaCompuesta <> j.id_pieza_contenedora then  
        piezaCompuesta := j.id_pieza_contenedora;
         cantidad := 0;
      end if;
        if j.sn is not null then
           cantidad := cantidad +1;
        end if; 
        if cantidad > 4 then
          raise_application_error (-20001,'Este conjunto de piezas contiene demasiadas piezas simples.');
        end if;  
    end loop;
  RETURN 'No excede de piezas simples.';
END COMPRUEBA_PIEZA;
/
CREATE OR REPLACE PROCEDURE BORRAR_AVIONES AS BEGIN
Delete
from pieza;
END BORRAR_AVIONES;
/

-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             1
-- CREATE INDEX                             1
-- ALTER TABLE                              2
-- CREATE VIEW                              1
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         7
-- CREATE FUNCTION                          2
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
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
