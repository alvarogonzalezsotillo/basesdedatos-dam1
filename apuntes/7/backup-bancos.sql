-- Generado por Oracle SQL Developer Data Modeler 3.1.4.710
--   en:        2013-06-07 02:13:42 CEST
--   sitio:      Oracle Database 10g
--   tipo:      Oracle Database 10g



CREATE SMALLFILE TEMPORARY TABLESPACE TEMP 
    EXTENT MANAGEMENT LOCAL UNIFORM SIZE 1024 K 
;

CREATE SMALLFILE UNDO TABLESPACE UNDO 
    EXTENT MANAGEMENT LOCAL 
    RETENTION NOGUARANTEE 
;

CREATE USER AFERNANDEZ 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER AGONZALEZ 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER AHAMMANA 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER ALUMNO 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER ALVARO 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER ANONYMOUS 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER AVIONES 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER AVIONESPRUEBA 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER BANCOPROFE 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER BANCOPROFEI 
    IDENTIFIED BY  
        TEMPORARY TABLESPACE TEMP 
    ACCOUNT UNLOCK 
;

GRANT CREATE VIEW, CREATE DATABASE LINK, UNLIMITED TABLESPACE TO BANCOPROFEI 
;

CREATE USER C 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER CDOMINGUEZ 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER CLOECHES 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER CREINA 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER CTXSYS 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER CZ 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER DBSNMP 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER DIP 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER DMORERA 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER DPARRA 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER EC 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER EGARCIA 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER FLOWS_020100 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER FLOWS_FILES 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER HR 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER ID 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER IGARABALLU 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER INFORMATICA 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER J 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER JGIL 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER JL 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER L 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER LMIGUEL 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER LPORRERO 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER LUISP 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER OUTLN 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER RL 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER RMENDEZ 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER RR 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER RSANCHEZ 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER SYS 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER SYSTEM 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER TSMSYS 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER XDB 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;

CREATE USER ZZAMORA 
    IDENTIFIED BY  
    ACCOUNT UNLOCK 
;



CREATE OR REPLACE TYPE BANCOPROFEI.IDENTIFICADORCUENTA 
;
/




CREATE OR REPLACE TYPE BANCOPROFEI.IDENTIFICADORCUENTA 
    AS OBJECT 
    ( 
        
    ) FINAL 
;
/


CREATE TABLE BANCOPROFEI.CLIENTES 
    ( 
     IDCLIENTE NUMBER  NOT NULL , 
     NOMBRE VARCHAR2 (50 BYTE) 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE SYSTEM 
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


CREATE UNIQUE INDEX BANCOPROFEI.CLIENTES_PK ON BANCOPROFEI.CLIENTES 
    ( 
     IDCLIENTE ASC 
    ) 
    TABLESPACE SYSTEM 
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

ALTER TABLE BANCOPROFEI.CLIENTES 
    ADD CONSTRAINT CLIENTES_PK PRIMARY KEY ( IDCLIENTE ) 
    USING INDEX BANCOPROFEI.CLIENTES_PK ;



CREATE TABLE BANCOPROFEI.CUENTAS 
    ( 
     IDCUENTA VARCHAR2 (20 BYTE)  NOT NULL 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE SYSTEM 
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


CREATE UNIQUE INDEX BANCOPROFEI.CUENTAS_PK ON BANCOPROFEI.CUENTAS 
    ( 
     IDCUENTA ASC 
    ) 
    TABLESPACE SYSTEM 
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

ALTER TABLE BANCOPROFEI.CUENTAS 
    ADD CONSTRAINT CUENTAS_PK PRIMARY KEY ( IDCUENTA ) 
    USING INDEX BANCOPROFEI.CUENTAS_PK ;



CREATE TABLE BANCOPROFEI.CUENTAS_CLIENTES 
    ( 
     IDCUENTA VARCHAR2 (20 BYTE) , 
     IDCLIENTE NUMBER 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE SYSTEM 
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




CREATE TABLE BANCOPROFEI.MOVIMIENTOS 
    ( 
     IDCUENTA VARCHAR2 (20 BYTE) , 
     MARCADETIEMPO TIMESTAMP , 
     EUROS NUMBER (15,2) , 
     DESCRIPCION VARCHAR2 (200 BYTE) 
    ) 
        PCTFREE 10 
        PCTUSED 40 
        MAXTRANS 255 
        TABLESPACE SYSTEM 
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





ALTER TABLE BANCOPROFEI.CUENTAS_CLIENTES 
    ADD CONSTRAINT CUENTAS_CLIENTES_CLIENTES_FK FOREIGN KEY 
    ( 
     IDCLIENTE
    ) 
    REFERENCES BANCOPROFEI.CLIENTES 
    ( 
     IDCLIENTE
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE BANCOPROFEI.CUENTAS_CLIENTES 
    ADD CONSTRAINT CUENTAS_CLIENTES_CUENTAS_FK FOREIGN KEY 
    ( 
     IDCUENTA
    ) 
    REFERENCES BANCOPROFEI.CUENTAS 
    ( 
     IDCUENTA
    ) 
    NOT DEFERRABLE 
;


ALTER TABLE BANCOPROFEI.MOVIMIENTOS 
    ADD CONSTRAINT MOVIMIENTOS_CUENTA_FK FOREIGN KEY 
    ( 
     IDCUENTA
    ) 
    REFERENCES BANCOPROFEI.CUENTAS 
    ( 
     IDCUENTA
    ) 
    NOT DEFERRABLE 
;

CREATE OR REPLACE VIEW BANCOPROFEI.V_CLIENTES AS
SELECT "IDCLIENTE","NOMBRE"
    
FROM clientes ;



GRANT SELECT 
ON BANCOPROFEI.V_CLIENTES TO BANCOPROFE 
;


CREATE OR REPLACE VIEW BANCOPROFEI.V_CUENTAS AS
SELECT "IDCUENTA"
    
FROM cuentas ;



GRANT SELECT 
ON BANCOPROFEI.V_CUENTAS TO BANCOPROFE 
;


CREATE OR REPLACE VIEW BANCOPROFEI.V_MOVIMIENTOS AS
SELECT "IDCUENTA","MARCADETIEMPO","EUROS","DESCRIPCION"
    
FROM movimientos ;



GRANT SELECT 
ON BANCOPROFEI.V_MOVIMIENTOS TO BANCOPROFE 
;


CREATE SEQUENCE BANCOPROFEI.SECUENCIA_IDCLIENTE 
    INCREMENT BY 1 
    MAXVALUE 999999999999999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE SEQUENCE BANCOPROFEI.SECUENCIA_IDCUENTA 
    INCREMENT BY 1 
    MAXVALUE 999999999999999999999999999 
    MINVALUE 1 
    CACHE 20 
;

CREATE SYNONYM BANCOPROFE.CREAR_CLIENTE 
FOR BANCOPROFEI.CREAR_CLIENTE
;
CREATE SYNONYM BANCOPROFE.CREAR_CUENTA 
FOR BANCOPROFEI.CREAR_CUENTA
;
CREATE SYNONYM BANCOPROFE.NUEVO_MOVIMIENTO 
FOR BANCOPROFEI.NUEVO_MOVIMIENTO
;
CREATE SYNONYM BANCOPROFE.SALDO_CLIENTE 
FOR BANCOPROFEI.SALDO_CLIENTE
;
CREATE SYNONYM BANCOPROFE.SALDO_CUENTA 
FOR BANCOPROFEI.SALDO_CUENTA
;
CREATE SYNONYM BANCOPROFE.TRANSFERENCIA 
FOR BANCOPROFEI.TRANSFERENCIA
;
CREATE SYNONYM BANCOPROFE.V_CLIENTES 
FOR BANCOPROFEI.V_CLIENTES
;
CREATE SYNONYM BANCOPROFE.V_CUENTAS 
FOR BANCOPROFEI.V_CUENTAS
;
CREATE SYNONYM BANCOPROFE.V_MOVIMIENTOS 
FOR BANCOPROFEI.V_MOVIMIENTOS
;

CREATE OR REPLACE PROCEDURE BANCOPROFEI.BORRAR_TODO AS 
BEGIN
  delete from movimientos;
  delete from cuentas_clientes;
  delete from cuentas;
  delete from clientes;
END BORRAR_TODO;
/

CREATE OR REPLACE PROCEDURE BANCOPROFEI.CREAR_CLIENTE(
  nombre varchar2,
  id_cliente out number 
)
AS
BEGIN
  select secuencia_idcliente.nextval into id_cliente from dual;
  insert into 
  clientes(idcliente,nombre)
  values(id_cliente,nombre);
END CREAR_CLIENTE;
/


GRANT EXECUTE
ON BANCOPROFEI.CREAR_CLIENTE TO BANCOPROFE 
;

CREATE OR REPLACE PROCEDURE BANCOPROFEI.CREAR_CUENTA(
  p_idcliente number,
  p_idcuenta in out varchar2
)
AS 
  ncuentas number;
BEGIN
  
  -- MIRO SI EXISTE EL CLIENTE
  if existe_cliente(p_idcliente) = 0 then
    error_cliente_no_existe(p_idcliente);
  end if;

  -- MIRO SI LA CUENTA ES NULL, PARA CREARLA
  if p_idcuenta is null then
    p_idcuenta := nuevo_identificador_cuenta();
    insert into
    cuentas(idcuenta)
    values(p_idcuenta);
  end if;
  
  -- MIRO SI LA CUENTA EXISTE
  if existe_cuenta(p_idcuenta) = 0 then
    error_cuenta_no_existe( p_idcuenta );
  end if;
  
  -- AÑADO EL CLIENTE A LOS TITULARES DE LA CUENTA
  insert into
  cuentas_clientes(idcuenta,idcliente)
  values( p_idcuenta, p_idcliente );
  
END CREAR_CUENTA;
/


GRANT EXECUTE
ON BANCOPROFEI.CREAR_CUENTA TO BANCOPROFE 
;

CREATE OR REPLACE PROCEDURE BANCOPROFEI.ERROR_BANCO_NO_EXISTE(
  idcuentadestino varchar
)
AS 

BEGIN
  raise_application_error(-20103,'El banco destino no existe:' || idcuentadestino );
END ERROR_BANCO_NO_EXISTE;
/

CREATE OR REPLACE PROCEDURE BANCOPROFEI.ERROR_CLIENTE_NO_EXISTE(
  p_idcliente number
)
AS 
BEGIN
  raise_application_error( -20101, 'El cliente no existe:'|| p_idcliente );
END ERROR_CLIENTE_NO_EXISTE;
/

CREATE OR REPLACE PROCEDURE BANCOPROFEI.ERROR_CUENTA_AJENA(
  idcuentaorigen varchar
)AS 
BEGIN
  raise_application_error(-20104,'La cuenta no es de este banco:' || digitos_banco() || ' :' || idcuentaorigen );
END ERROR_CUENTA_AJENA;
/

CREATE OR REPLACE PROCEDURE BANCOPROFEI.ERROR_CUENTA_NO_EXISTE(
p_idcuenta varchar
)
AS 
BEGIN
  raise_application_error(-20102,'La cuenta ' || p_idcuenta || ' no existe' );
END ERROR_CUENTA_NO_EXISTE;
/

CREATE OR REPLACE PROCEDURE BANCOPROFEI.ERROR_SALDO_INSUFICIENTE(
  idcuentaorigen varchar,
  total_euros number
)
AS 
BEGIN
  raise_application_error(-20105, 'No ha suficiente saldo (' || idcuentaorigen || '):' || saldo_cuenta(idcuentaorigen) || ' -- ' || total_euros );
END ERROR_SALDO_INSUFICIENTE;
/

CREATE OR REPLACE PROCEDURE BANCOPROFEI.ERROR_TRANSFERENCIA_CERO_EUROS(
  euros number
)
AS 

BEGIN
  raise_application_error(-20106,'La transferencia es de cero euros o menor:' || euros );
END ERROR_TRANSFERENCIA_CERO_EUROS;
/

CREATE OR REPLACE PROCEDURE BANCOPROFEI.NUEVO_MOVIMIENTO(
  p_idcuenta varchar2,
  p_euros number,
  p_descripcion varchar2
)
AS 
  parent_not_found exception;
  pragma exception_init(parent_not_found, -2291);
BEGIN
  insert into
  movimientos(idcuenta,marcadetiempo,euros,descripcion)
  values(p_idcuenta,systimestamp,p_euros,p_descripcion);
  
  exception
    when parent_not_found
    then error_cuenta_no_existe(p_idcuenta); 
    
END NUEVO_MOVIMIENTO;
/


GRANT EXECUTE
ON BANCOPROFEI.NUEVO_MOVIMIENTO TO BANCOPROFE 
;

CREATE OR REPLACE PROCEDURE BANCOPROFEI.TRANSFERENCIA(
  idcuentaorigen varchar2,
  euros number, 
  descripcion varchar2,
  idcuentadestino varchar2
)
AS 
  conexion_remota varchar2(200);
  digitos_banco_destino varchar2(4);
  descripcion_completa varchar2(200);
  sqldinamico varchar2(1024);
  estransferencia boolean;
  total_euros number;
  comision number;
  cuenta_no_encontrada exception;
  pragma exception_init(cuenta_no_encontrada, -20101);
BEGIN
  -- MIRO SI LOS EUROS MENOR O IGUAL QUE CERO
  if euros <= 0 then
    error_transferencia_cero_euros(euros);
  end if;
  

  -- ME ASEGURO DE QUE LA CUENTA ES DE ESTE BANCO
  if extrae_digitos_de_banco(idcuentaorigen) <> digitos_banco() then
    error_cuenta_ajena(idcuentaorigen );
  end if;
  
  -- CALCULO LA DESCRIPCION COMPLETA DE LA TRANSFERENCIA
  descripcion_completa := 
    'origen:' || idcuentaorigen ||
    ' destino:' || idcuentadestino ||
    descripcion;

  -- MIRO SI ES UN TRASPASO (SIN COMISION)  
  digitos_banco_destino := EXTRAE_DIGITOS_DE_BANCO(idcuentadestino);
  estransferencia := digitos_banco_destino <> digitos_banco();
  comision := calcula_comision_transferencia(euros);
  if estransferencia then
    total_euros := euros + comision;
  else
    total_euros := euros;
  end if;
  
  -- MIRO SI HAY SUFICIENTE DINERO EN LA CUENTA
  if saldo_cuenta(idcuentaorigen) < total_euros then
    error_saldo_insuficiente(idcuentaorigen,total_euros);
  end if;
  
  -- CONSIGO LA CONEXION REMOTA
  conexion_remota := nombre_de_dblink(digitos_banco_destino);
  if conexion_remota is null then
    error_banco_no_existe(idcuentadestino);
  end if;
  
  -- REALIZO LOS MOVIMIENTOS DE LA CUENTA ORIGEN
  nuevo_movimiento(idcuentaorigen,-euros,descripcion_completa);
  if estransferencia then
    nuevo_movimiento(idcuentaorigen,-comision,'Comision ' || descripcion_completa);
  end if;

  -- REALIZO EL MOVIMIENTO EN LA CUENTA DESTINO
  sqldinamico := 'call nuevo_movimiento'||conexion_remota||'(:1,:2,:3)';
  EXECUTE IMMEDIATE sqldinamico
  using idcuentadestino, euros, descripcion_completa;
  
  commit;
  
END TRANSFERENCIA;
/


GRANT EXECUTE
ON BANCOPROFEI.TRANSFERENCIA TO BANCOPROFE 
;

CREATE OR REPLACE PACKAGE BANCOPROFEI.PRUEBAS AS 

  procedure crea_cliente_y_cuenta(nombre varchar2, p_idcliente out number, p_idcuenta out varchar2);

  procedure prueba_traspaso;
END PRUEBAS;
/

CREATE OR REPLACE PACKAGE BODY BANCOPROFEI.PRUEBAS AS

  procedure prueba_traspaso as
  begin
    null;
  end;
  
  procedure crea_cliente_y_cuenta(nombre varchar2, p_idcliente out number, p_idcuenta out varchar2) AS
  begin
    crear_cliente('prueba',p_idcliente);
    dbms_output.put_line('cliente:' || p_idcliente);
    
    crear_cuenta(p_idcliente,p_idcuenta);
    dbms_output.put_line('cuenta:' || p_idcuenta);
    dbms_output.put_line('saldo cuenta:' || saldo_cuenta(p_idcuenta) );
    dbms_output.put_line('saldo cliente:' || saldo_cliente(p_idcliente) );
    
    nuevo_movimiento(p_idcuenta,300,'Ingreso inicial');
    dbms_output.put_line('saldo cuenta:' || saldo_cuenta(p_idcuenta) );
    dbms_output.put_line('saldo cliente:' || saldo_cliente(p_idcliente) );
  
    nuevo_movimiento(p_idcuenta,-10,'Reintegro cajero');
    dbms_output.put_line('saldo cuenta:' || saldo_cuenta(p_idcuenta) );
    dbms_output.put_line('saldo cliente:' || saldo_cliente(p_idcliente) );
  END crea_cliente_y_cuenta;

END PRUEBAS;
/

CREATE OR REPLACE FUNCTION BANCOPROFEI.CALCULA_COMISION_TRANSFERENCIA(
  euros number
)
RETURN number AS 
  ret number;
BEGIN
  ret := euros*0.02;
  if ret < 3 then
    ret := 3;
  end if;
  return ret;
END CALCULA_COMISION_TRANSFERENCIA;
/

CREATE OR REPLACE FUNCTION BANCOPROFEI.DIGITOS_BANCO RETURN VARCHAR2 AS 
BEGIN
  RETURN '1000';
END DIGITOS_BANCO;
/

CREATE OR REPLACE FUNCTION BANCOPROFEI.EXISTE_CLIENTE(
  p_idcliente number
)
RETURN NUMBER AS 
  n number;
BEGIN
  select count(*) into n from clientes where idcliente = p_idcliente;
  return n;
END existe_cliente;
/

CREATE OR REPLACE FUNCTION BANCOPROFEI.EXISTE_CUENTA(
  p_idcuenta varchar
)
RETURN NUMBER AS 
  n number;
BEGIN
  select count(*) into n from cuentas where idcuenta = p_idcuenta;
  return n;
END EXISTE_CUENTA;
/

CREATE OR REPLACE FUNCTION BANCOPROFEI.EXTRAE_DIGITOS_DE_BANCO
(
  idcuenta varchar
)
RETURN VARCHAR2 AS 
BEGIN
  return substr(idcuenta,1,4);
END EXTRAE_DIGITOS_DE_BANCO;
/

CREATE OR REPLACE FUNCTION BANCOPROFEI.NOMBRE_DE_DBLINK (
  p_idcuenta varchar
)
RETURN VARCHAR2 
AS 
  identificador_banco varchar2(4);
  ret varchar2(50);
BEGIN
  identificador_banco := extrae_digitos_de_banco(p_idcuenta);
  
  ret := case identificador_banco
      when '1000' then ' '
      when '1134' then 'bancoAlex'
      when '1599' then '@bancodavid'
      when '3083' then '@foxbank'
      when '1407' then '@trufabank'
      when '6666' then '@forastero'
      when '2013' then '@banco2013'
      when '1313' then '@bancoadil'
      when '9000' then '@bancotopami'
      when '1118' then '@bancocloeches'
      when '1111' then '@bancoluna'
      when '2013' then '@banco2013'
      when '1407' then '@trufabank'    
      else '*'
  end;
  
  if ret = '*' then
    error_banco_no_existe(p_idcuenta);
  end if;
  
  return ret;
END NOMBRE_DE_DBLINK;
/

CREATE OR REPLACE FUNCTION BANCOPROFEI.NUEVO_IDENTIFICADOR_CUENTA RETURN VARCHAR2 AS 
siguiente_numero number;
BEGIN
  select secuencia_idcuenta.nextval into siguiente_numero from dual;
  
  RETURN DIGITOS_BANCO() ||
         '0001DC' || 
         lpad( siguiente_numero, 10, '0' );
END NUEVO_IDENTIFICADOR_CUENTA;
/

CREATE OR REPLACE FUNCTION BANCOPROFEI.SALDO_CLIENTE(
p_idcliente number,
p_marcadetiempo timestamp default null
)
RETURN number AS 
  ret number;
BEGIN

  if existe_cliente(p_idcliente) = 0 then
    error_cliente_no_existe(p_idcliente);
  end if;

  select sum(euros) 
  into ret
  from movimientos m, cuentas_clientes cc
  where m.idcuenta = cc.idcuenta
  and cc.idcliente = p_idcliente
  and marcadetiempo <= nvl(p_marcadetiempo,systimestamp);
  
  return nvl(ret,0);
END;
/


GRANT EXECUTE
ON BANCOPROFEI.SALDO_CLIENTE TO BANCOPROFE 
;

CREATE OR REPLACE FUNCTION BANCOPROFEI.SALDO_CUENTA(
p_idcuenta varchar2,
p_marcadetiempo timestamp default null
)
RETURN number AS 
  ret number;
BEGIN
  
  if existe_cuenta(p_idcuenta) = 0 then
    error_cuenta_no_existe(p_idcuenta);
  end if;

  select sum(euros) 
  into ret
  from movimientos
  where idcuenta = p_idcuenta 
  and marcadetiempo <= nvl(p_marcadetiempo,systimestamp);

  return nvl(ret,0);
END SALDO_CUENTA;
/


GRANT EXECUTE
ON BANCOPROFEI.SALDO_CUENTA TO BANCOPROFE 
;


-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             2
-- ALTER TABLE                              5
-- CREATE VIEW                              3
-- CREATE PACKAGE                           1
-- CREATE PACKAGE BODY                      1
-- CREATE PROCEDURE                        11
-- CREATE FUNCTION                          9
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE STRUCTURED TYPE                   1
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
-- CREATE SYNONYM                           9
-- CREATE TABLESPACE                        2
-- CREATE USER                             45
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
