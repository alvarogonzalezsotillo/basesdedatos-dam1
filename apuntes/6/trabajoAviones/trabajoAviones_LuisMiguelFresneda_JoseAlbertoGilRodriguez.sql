CREATE TABLE PIEZASCOMPUESTAS (
ID NUMBER  NOT NULL , 
NOMBRE_PC VARCHAR2 (50 BYTE)  NOT NULL , 
ID_PIEZA_COMPUESTA NUMBER);

CREATE TABLE PIEZASSIMPLES ( 
ID NUMBER  NOT NULL , 
NOMBRE_PS VARCHAR2 (50 BYTE)  NOT NULL , 
SERIAL_NUMBER VARCHAR2 (20 BYTE)  NOT NULL , 
PART_NUMBER VARCHAR2 (20 BYTE)  NOT NULL , 
ID_PIEZA_COMPUESTA NUMBER  NOT NULL );

ALTER TABLE PIEZASCOMPUESTAS 
ADD CONSTRAINT PK_PIEZA_COMPUESTA PRIMARY KEY (ID);

ALTER TABLE PIEZASSIMPLES 
ADD CONSTRAINT PK_PIEZA_SIMPLE PRIMARY KEY (ID);

ALTER TABLE PIEZASCOMPUESTAS 
ADD CONSTRAINT FK_COMPUESTA_A_COMPUESTA FOREIGN KEY 
(ID_PIEZA_COMPUESTA) REFERENCES PIEZASCOMPUESTAS (ID);

ALTER TABLE PIEZASSIMPLES 
ADD CONSTRAINT FK_SIMPLE_A_COMPUESTA FOREIGN KEY 
(ID_PIEZA_COMPUESTA) REFERENCES PIEZASCOMPUESTAS (ID);

CREATE OR REPLACE VIEW AVIONES_PROFESOR AS
SELECT ID AS PARTE_ID,
ID_PIEZA_COMPUESTA AS PARTE_PADRE,
NOMBRE_PS AS NOMBRE, 
SERIAL_NUMBER AS SN,
PART_NUMBER AS PN
FROM PIEZASSIMPLES
UNION
SELECT ID AS PARTE_ID,
ID_PIEZA_COMPUESTA AS PARTE_PADRE,
NOMBRE_PC AS NOMBRE,NULL,NULL
FROM PIEZASCOMPUESTAS ;

CREATE SEQUENCE SECUENCIA_PIEZA_ID 
INCREMENT BY 1 
MAXVALUE 999999999999999999999999999 
MINVALUE 1 
CACHE 20;

CREATE SEQUENCE SECUENCIA_SERIALNUMBER 
INCREMENT BY 1 
MAXVALUE 999999999999999999999999999 
MINVALUE 1 
CACHE 20;

CREATE OR REPLACE TRIGGER GENERAR_ID_PC 
    BEFORE INSERT ON PIEZASCOMPUESTAS 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end;
/

CREATE OR REPLACE TRIGGER GENERAR_ID_PS 
    BEFORE INSERT ON PIEZASSIMPLES 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."ID" is null then 
         select SECUENCIA_PIEZA_ID.nextval into :NEW."ID" from dual; 
      end if; 
   end if; 
end; 
/


CREATE OR REPLACE TRIGGER GENERAR_SN 
    BEFORE INSERT ON PIEZASSIMPLES 
    FOR EACH ROW 
begin  
   if inserting then 
      if :NEW."SERIAL_NUMBER" is null then 
          select 'SN-100'||SECUENCIA_SERIALNUMBER.nextval into :NEW."SERIAL_NUMBER" from dual; 
      end if; 
   end if; 
end; 
/


CREATE OR REPLACE FUNCTION ES_AVION(ID_AVION NUMBER) RETURN NUMBER AS 
RETORNO NUMBER;
COMP NUMBER;
BEGIN
  RETORNO := 0;
  for j in (SELECT ID FROM PIEZASCOMPUESTAS) 
  loop
    SELECT ID_PIEZA_COMPUESTA INTO COMP FROM piezascompuestas WHERE id = j.ID;
    if j.ID = ID_AVION and COMP IS NULL then
          RETORNO := 1;
          EXIT;
    end if;
  end loop;
  RETURN RETORNO;
END ES_AVION;
/


create or replace 
PROCEDURE BORRAR_AVION(AVION_ID NUMBER) AS
es_o_no_avion number;
BEGIN
  es_o_no_avion := es_avion(avion_id);
  
  if es_o_no_avion = 1 then
  
  for j in (SELECT ID FROM PIEZASCOMPUESTAS)
  loop
    if j.ID = AVION_ID then
      DELETE FROM PIEZASSIMPLES WHERE id_pieza_compuesta = avion_id;

      delete from piezassimples where id_pieza_compuesta in(
        select id from piezascompuestas where id_pieza_compuesta = avion_id
      );

      delete from piezassimples where id_pieza_compuesta in(
        select id from piezascompuestas where id_pieza_compuesta in(
          select id from piezascompuestas where id_pieza_compuesta = avion_id
        )
      );

      delete from piezascompuestas where id_pieza_compuesta in(
        select id from piezascompuestas where id_pieza_compuesta = avion_id
      );

      delete from piezascompuestas where id_pieza_compuesta = avion_id;

      delete from piezascompuestas where id = avion_id;
    exit;
    end if;
  end loop;
  ELSE
      raise_application_error(-20014, 'ESTE AVION_ID NO EXISTE');
  end if;

END BORRAR_AVION;
/


CREATE OR REPLACE PROCEDURE BORRAR_AVIONES AS 

MAX_ID NUMBER;
BEGIN
  for j in (SELECT * FROM PIEZASCOMPUESTAS) 
  loop
      MAX_ID := es_avion(j.id);
      IF MAX_ID = 1 then
      DELETE FROM PIEZASSIMPLES WHERE id_pieza_compuesta = j.id;
      
      delete from piezassimples where id_pieza_compuesta in(
        select id from piezascompuestas where id_pieza_compuesta = j.id
      );
      
      delete from piezassimples where id_pieza_compuesta in(
        select id from piezascompuestas where id_pieza_compuesta in(
          select id from piezascompuestas where id_pieza_compuesta = j.id
        )
      );
            
      delete from piezascompuestas where id_pieza_compuesta in(
        select id from piezascompuestas where id_pieza_compuesta = j.id
      );      
      
      delete from piezascompuestas where id_pieza_compuesta = j.id;
            
      delete from piezascompuestas where id = j.id;
    
    end if;
  end loop;
END BORRAR_AVIONES;
/

CREATE OR REPLACE PROCEDURE COPIA_PIEZA_SIMP(PIEZA_ORIGINAL NUMBER, PIEZA_NUEVA NUMBER) AS 
PARTE_EXISTENTE PIEZASSIMPLES%ROWTYPE;
parte_recien_creada number;

BEGIN

  for PARTE_EXISTENTE in (select * from PIEZASSIMPLES where id_pieza_compuesta=PIEZA_ORIGINAL)
  loop
    
    INSERT INTO PIEZASSIMPLES(NOMBRE_PS,part_number,id_pieza_compuesta)
    VALUES(PARTE_EXISTENTE.nombre_ps,PARTE_EXISTENTE.PART_NUMBER, PIEZA_NUEVA );
    
  end loop;
  
END COPIA_PIEZA_SIMP;
/

CREATE OR REPLACE PROCEDURE COPIA_PIEZA_COMPUESTA(PIEZA_ORIGINAL NUMBER, PIEZA_NUEVA NUMBER) AS 
PARTE_EXISTENTE piezascompuestas%ROWTYPE;
parte_recien_creada number;

BEGIN

  for PARTE_EXISTENTE in (select * from piezascompuestas where id_pieza_compuesta=PIEZA_ORIGINAL)
  loop
    
    INSERT INTO piezascompuestas(NOMBRE_PC,id_pieza_compuesta)
    VALUES(PARTE_EXISTENTE.nombre_pc, PIEZA_NUEVA );
    
    select SECUENCIA_PIEZA_ID.currval into parte_recien_creada from dual;
    copia_pieza_simp(PARTE_EXISTENTE.ID,parte_recien_creada);
    COPIA_PIEZA_COMPUESTA(PARTE_EXISTENTE.ID,parte_recien_creada);
  end loop;
  
END COPIA_PIEZA_COMPUESTA;
/

CREATE OR REPLACE PROCEDURE COPIAR_AVION 
(
  AVION_ID IN NUMBER  
, COPIA_AVION_ID IN NUMBER  
) AS 
  AVION_EXISTENTE PIEZASCOMPUESTAS%ROWTYPE;
BEGIN
  SELECT * INTO avion_EXISTENTE
  FROM PIEZASCOMPUESTAS
  WHERE ID = AVION_ID;
  
  INSERT INTO PIEZASCOMPUESTAS(ID,NOMBRE_PC,id_pieza_compuesta)
  VALUES(COPIA_AVION_ID,AVION_existente.nombre_pc, null);
  
  copia_pieza_simp(AVION_ID, COPIA_AVION_ID);
  COPIA_PIEZA_COMPUESTA(AVION_ID, COPIA_AVION_ID);
  
  
END COPIAR_AVION;
/

CREATE OR REPLACE PROCEDURE CREAR_AVION (AVION_ID NUMBER) AS 
id_compuesta1 number;
id_compuesta2 number;
BEGIN
  
  for j in (SELECT ID FROM PIEZASCOMPUESTAS) 
  loop
    if j.ID = AVION_ID then
      raise_application_error(-20014, 'ESTE AVION_ID YA EXISTE');
      exit;
    end if;
  end loop;
    
    INSERT INTO piezascompuestas (ID, nombre_pc) VALUES(AVION_ID, 'Avion 1');
    
    select secuencia_pieza_id.nextval into id_compuesta1 from dual;
    INSERT INTO piezascompuestas values(id_compuesta1, 'Cabina',AVION_ID);
    
    select secuencia_pieza_id.nextval into id_compuesta2 from dual;
    INSERT INTO piezascompuestas values(id_compuesta2, 'Asiento piloto', id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 1', 'PN-002', id_compuesta2);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Controles', 'PN-003', id_compuesta2);
    
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 2', 'PN-002', id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 3', 'PN-002', id_compuesta1);
    
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Fuselaje', 'PN-001', AVION_ID);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Motor 1', 'PN-004', AVION_ID);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Motor 2', 'PN-004', AVION_ID);
    
END CREAR_AVION;
/

CREATE OR REPLACE PROCEDURE INTENTA_CREAR_AVION_MASDE10(avion_id number) AS 
id_compuesta1 number;
id_compuesta2 number;
id_compuesta3 number;
BEGIN
    INSERT INTO piezascompuestas (ID, nombre_pc) VALUES(AVION_ID, 'Avion 3');
    
    
    select secuencia_pieza_id.nextval into id_compuesta1 from dual;
    INSERT INTO piezascompuestas values(id_compuesta1, 'Cabina',AVION_ID);
    
    select secuencia_pieza_id.nextval into id_compuesta2 from dual;
    INSERT INTO piezascompuestas values(id_compuesta2, 'Asiento piloto',id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 11', 'PN-002', id_compuesta2);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Controles', 'PN-003', id_compuesta2);
    
    select secuencia_pieza_id.nextval into id_compuesta3 from dual;
    INSERT INTO piezascompuestas values(id_compuesta3, 'Asiento copiloto',id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 12', 'PN-002', id_compuesta3);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Controles', 'PN-003', id_compuesta3);
    
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Fuselaje', 'PN-001', AVION_ID);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Motor 5', 'PN-004', AVION_ID);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Motor 6', 'PN-004', AVION_ID);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Motor 7', 'PN-004', AVION_ID);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Motor 8', 'PN-004', AVION_ID);
    
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Caja negra', 'PN-005', AVION_ID);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('GPS', 'PN-006', AVION_ID);
    
END INTENTA_CREAR_AVION_MASDE10;
/

CREATE OR REPLACE PROCEDURE INTENTA_CREAR_AVION_MASDE4(avion_id number) AS 
id_compuesta1 number;
id_compuesta2 number;
BEGIN
    INSERT INTO piezascompuestas (ID, nombre_pc) VALUES(AVION_ID, 'Avion 2');
    
    
    select secuencia_pieza_id.nextval into id_compuesta1 from dual;
    INSERT INTO piezascompuestas values(id_compuesta1, 'Cabina',AVION_ID);
    
    select secuencia_pieza_id.nextval into id_compuesta2 from dual;
    INSERT INTO piezascompuestas values(id_compuesta2, 'Asiento piloto',id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ( 'Asiento 4', 'PN-002', id_compuesta2);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Controles', 'PN-003', id_compuesta2);
    
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 5', 'PN-002', id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 6', 'PN-002', id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 7', 'PN-002', id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 8', 'PN-002', id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 9', 'PN-002', id_compuesta1);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Asiento 10', 'PN-002', id_compuesta1);
    
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Fuselaje', 'PN-001', AVION_ID);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Motor 3', 'PN-004', AVION_ID);
    INSERT INTO piezassimples (nombre_ps, part_number, id_pieza_compuesta) VALUES ('Motor 4', 'PN-004', AVION_ID);
    
END INTENTA_CREAR_AVION_MASDE4;
/

CREATE OR REPLACE FUNCTION CUANTAS_PIEZAS_SIMPLES(ID_PIEZA NUMBER) RETURN VARCHAR2 AS 
NUM_PIEZAS_SIMPLES NUMBER;
BEGIN
  SELECT COUNT(*) INTO NUM_PIEZAS_SIMPLES FROM PIEZASSIMPLES WHERE id_pieza_compuesta = ID_PIEZA;
  RETURN NUM_PIEZAS_SIMPLES;
END CUANTAS_PIEZAS_SIMPLES;
/

CREATE OR REPLACE FUNCTION COMPRUEBA_AVION(ID_AVION NUMBER) RETURN VARCHAR2 AS 
ES_UN_AVION NUMBER;
PIEZAS_SIMPLES NUMBER;
BEGIN
  ES_UN_AVION := ES_AVION(ID_AVION);
  IF es_un_avion != 1 THEN
    
    raise_application_error(-20010, 'ESTO NO ES UN AVION');
  ELSE
      PIEZAS_SIMPLES := 0;
      for j in (
        select id from piezascompuestas 
        start with id =  id_avion
        connect by prior id = id_pieza_compuesta
      ) 
      
      loop
        
        
        PIEZAS_SIMPLES := PIEZAS_SIMPLES + cuantas_piezas_simples(j.id);
      end loop;
    
    
    IF piezas_simples > 10 THEN
      raise_application_error(-20011, 'ESTE AVION TIENE MAS DE 10 PIEZAS SIMPLES EN TOTAL');
    END IF;
  END IF;
  RETURN 'TODO ESTA CORRECTO';
END COMPRUEBA_AVION;
/

CREATE OR REPLACE FUNCTION COMPRUEBA_PIEZA(ID_PIEZA NUMBER) RETURN VARCHAR2 AS 
ES_UN_AVION NUMBER;
PIEZAS_SIMPLES NUMBER;
BEGIN
  ES_UN_AVION := ES_AVION(ID_PIEZA);
  IF es_un_avion = 1 THEN
    raise_application_error(-20012, 'ESTO ES UN AVION');
  ELSE
      PIEZAS_SIMPLES := 0;
      for j in (
        select id from piezascompuestas 
        start with id =  ID_PIEZA
        connect by prior id = id_pieza_compuesta
      ) 
      loop
         PIEZAS_SIMPLES := PIEZAS_SIMPLES + cuantas_piezas_simples(j.id);
      end loop;
    
    IF piezas_simples > 4 THEN
      raise_application_error(-20013, 'ESTA PIEZA COMPUESTA TIENE MAS DE 4 PIEZAS SIMPLES EN TOTAL');
    END IF;
  END IF;
  RETURN 'TODO ESTA CORRECTO';
END COMPRUEBA_PIEZA;
/

















