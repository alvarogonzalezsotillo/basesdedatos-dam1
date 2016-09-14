create or replace FUNCTION SECUENCIA_PIEZA_ID RETURN number AS  
secuencia_pieza_id number
begin
if inserting then 
      if "avion_id" is not null then 
         select avion_id_SEQ.nextval into "avion_id" from dual; 
      end if;  
   end if;  
   return avion_id;
end;
/

create or replace FUNCTION SECUENCIA_SERIALNUMBER RETURN number AS  
secuencia_serial_number number
begin
if inserting then 
      if "serial_number" is not null then 
         select serial_number_SEQ.nextval into 'SN-'||"serial_number" from dual; 
      end if;  
   end if;  
   return serial_number;
end;
/

CREATE OR REPLACE FUNCTION COMPRUEBA_AVION RETURN VARCHAR2 AS 
BEGIN
AVIONES ALIAS FOR $$;
    IF EXISTS (SELECT PART_ID, COUNT(SERIAL_NUMBER) FROM PIEZAS_SIMPLES WHERE ) THEN
DBMS_OUTPUT.PUT_LINE('EL AVION EXISTE Y TIENE MENOS DE 10 PIEZAS');
ELSE
DBMS_OUTPUT.PUT_LINE('NO SE HA ENCONTRADO NINGUN AVION CON MENOS DE 10 PIEZAS');
END IF;
END COMPRUEBA_AVION;


CREATE OR REPLACE FUNCTION COMPRUEBA_PIEZA RETURN VARCHAR2 AS 
BEGIN
AVIONES ALIAS FOR $$;
    IF EXISTS (SELECT PART_ID, COUNT(SERIAL_NUMBER) FROM PIEZAS_SIMPLES WHERE COUNT(SERIAL_NUMBER)<10 ) THEN
DBMS_OUTPUT.PUT_LINE('EL AVION EXISTE Y TIENE MENOS DE 10 PIEZAS');
ELSE
DBMS_OUTPUT.PUT_LINE('NO SE HA ENCONTRADO NINGUN AVION CON MENOS DE 10 PIEZAS');
END IF;
END COMPRUEBA_PIEZA;



Create or replace procedure CREAR_AVION(avion in Avion.avion_id%type) is
numeroAvion number;
eNulo Exception;
Begin
If numeroAvion is null then
Raise eNulo;
End if;
DECLARE 
 SECUENCIA_PIEZA_ID AVION_id%TYPE; 
BEGIN 
 -- Extrae un nuevo avion_id
 SELECT SECUENCIA_PIEZA_ID.NEXTVAL 
 INTO v_AvionID 
 FROM dual; 
 -- Añade una fila a la tabla aviones 
 INSERT INTO aviones (avion_id,nombre_avion)
 VALUES (v_AvionID ,null); 
 -- Añade otra fila usando directamente el número 
 -- de secuencia en la orden INSERT 
 INSERT INTO AVIONES (avion_id,nombre_avion)
 VALUES (SECUENCIA_PIEZA_ID.NEXTVAL, 
null); 
END;
Exception
When no_data_found then
DBMS_OUTPUT.PUT_LINE(‘EL AVION INTRODUCIDO NO SE ENCUENTRA’);
WHEN eNulo THEN
DBMS_OUTPUT.PUT_LINE(‘DEBES INTRODUCIR UN  AVION’);
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE(‘ERROR: ‘||SQLCODE||’ MENSAJE ‘||SQLERRM);
end;/


 


CREATE VIEW AVIONES_PROFESOR 
SELECT pc.parte_id, pc.parte_padre, pc.nombre, ps.sn,ps.pn 
FROM piezas_compuestas pc, piezas_simples ps
WHERE ps.sn=pc.sn;


CREATE OR REPLACE PROCEDURE BORRAR_AVION(avion_id number)  
(pAvion_Id IN AVIONES.AVION_ID%TYPE) IS
eNulo EXCEPTION;
rAvion AVION_ID%ROWTYPE; --AQUI SE VAN A RECUPERAR DATOS POR LO CUAL NECESITAMOS EL REGISTRO 
BEGIN
    pError:=0;
    IF pAvion_Id IS NULL THEN
        RAISE eNulo;
    END IF;
	SELECT * INTO rAvion FROM AVION  --COMPRUEBA QUE TENEMOS EL EMPLEADO EN LA TABLA LO HACEMOS FUERA DE LOS IF (si encuentra algo en la tabla avión. Lo guarda en rAvion. (Into rAvion))
	WHERE Avion_Id= pAvion_Id;
	
    
    IF pAvion_Id IS NOT NULL THEN
			rAvion.Avion_Id:pAvion_Id;
	END IF;
	-- UNA VEZ COMPROBADO QUE NO ES NULO Y QUE EL REGISTRO NO HACE SALTAR LA EXCEPCION EJECUTAMOS LA ORDEN. 
		DELETE FROM AVION WHERE AVION_ID=pAvion_Id;
		DBMS_OUTPUT.PUT_LINE('SE HA BORRADO EL AVION '||pAvion_Id||' CORRECTAMENTE');

    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('NO SE HA ENCONTRADO EL NUMERO DE AVION');
		WHEN eNulo THEN
            DBMS_OUTPUT.PUT_LINE('DEBES INTRODUCIR UN NUMERO DE AVION PARA BORRAR');
            		WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: '||SQLCODE||' MENSAJE: '||SQLERRM);
     END;
/



CREATE OR REPLACE PROCEDURE BORRAR_AVIONES(avion_id number)  
(pAvion_Id IN AVIONES.AVION_ID%TYPE) AS
eNulo EXCEPTION;
rAvion AVION_ID%ROWTYPE; --AQUI SE VAN A RECUPERAR DATOS POR LO CUAL NECESITAMOS EL REGISTRO 
BEGIN
    pError:=0;
    IF pAvion_Id IS NULL THEN
        RAISE eNulo;
    END IF;
	SELECT * INTO rAvion FROM AVION  --COMPRUEBA QUE TENEMOS EL EMPLEADO EN LA TABLA LO HACEMOS FUERA DE LOS IF (si encuentra algo en la tabla avión. 
	--Lo guarda en rAvion. (Into rAvion))   
    IF pAvion_Id IS NOT NULL THEN
			rAvion.Avion_Id:pAvion_Id;
	END IF;
	-- UNA VEZ COMPROBADO QUE NO ES NULO Y QUE EL REGISTRO NO HACE SALTAR LA EXCEPCION EJECUTAMOS LA ORDEN. 
		DELETE FROM AVIONES;
		DBMS_OUTPUT.PUT_LINE('SE HA BORRADO TODOS LOS AVIONES CORRECTAMENTE');

    EXCEPTION
		WHEN NO_DATA_FOUND THEN
			DBMS_OUTPUT.PUT_LINE('NO SE HA ENCONTRADO NINGUN AVION PARA BORRAR');
		WHEN eNulo THEN
            DBMS_OUTPUT.PUT_LINE('DEBES INTRODUCIR UN AVION PARA BORRAR');
            		WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: '||SQLCODE||' MENSAJE: '||SQLERRM);
     END;




create or replace 
PROCEDURE COPIAR_AVION(avion_id number, copia_avion_id number) AS 
  avion_id_existente aviones%ROWTYPE;
BEGIN
  select * into avion_id from aviones where avion_id = avion_id_existente;
  
  select avion_id into avion_id_existente.avion_id from aviones;

  avion_id_existente.nombre := nombre_copia;  
  avion_id_existente.avion_id := avion_id_copia;
  
  insert into aviones values avion_id_existente;
  
END COPIAR_AVION;


CREATE OR REPLACE PROCEDURE INTENTA_CREAR_AVION_MASDE4(avion_id number) AS
 avion_id aviones%ROWTYPE;
BEGIN
SELECT * FROM information_schema.tables WHERE table_name = aviones;
    IF NOT EXISTS THEN
		execute 'CREATE TABLE ' || aviones || '(
            avion_id varchar2 not null,
            nombre_avion varchar2,
            primary key (avion_id)
        )';
    END IF;
END INTENTA_CREAR_AVION_MASDE4;
