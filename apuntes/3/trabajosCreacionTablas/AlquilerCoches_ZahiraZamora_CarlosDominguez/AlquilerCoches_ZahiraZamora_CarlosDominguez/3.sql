--Base de Datos Alquiler de Coches
--Autor: Zahira Zamora y Carlos Dominguez
--Parte3 Estructura2 modificacion del problema

--Parasolucionar el problema de las revisiones creamos dos tablas
--una para revisiones de itv y otra de mantenimiento.
CREATE TABLE revisiones_itv (
  cod_rev_itv     NUMBER(15,0),
  nbastidor       VARCHAR2(20),
  fecha_prevista  TIMESTAMP,
  fecha_realizada TIMESTAMP
);

CREATE TABLE revisiones_mant (
  cod_rev_mant    NUMBER(15,0),
  nbastidor       VARCHAR2(20),
  km_previsto     NUMBER(7,0),
  km_realizado    NUMBER(7,0),
  fecha_realizado TIMESTAMP
);

--PK
ALTER TABLE revisiones_itv
  add constraint revisiones_itv_pk
  primary key (cod_rev_itv);
ALTER TABLE revisiones_mant
  add constraint revisiones_mant_pk
  primary key (cod_rev_mant);  

--FK
ALTER TABLE revisiones_itv
  add constraint revisiones_itv_coches
  foreign key (nbastidor) references coches(nbastidor);  
ALTER TABLE revisiones_mant
  add constraint revisiones_mant_coches
  foreign key (nbastidor) references coches(nbastidor);

--NOT NULL  
ALTER TABLE revisiones_itv
  add constraint nbast_rev_itv_not_null
  check (nbastidor is not null);
ALTER TABLE revisiones_itv
  add constraint fpre_rev_itv_not_null
  check (fecha_prevista is not null);
ALTER TABLE revisiones_mant
  add constraint nbast_rev_mant_not_null
  check (nbastidor is not null);
ALTER TABLE revisiones_mant
  add constraint kmpre_rev_mant_not_null
  check (km_previsto is not null);  
  
  
--Para solucionar el problema del registro de colores de cada coche
--hemos creado una nueva tabla
CREATE TABLE registro_colores (
  cod_color     NUMBER(15,0),
  color         VARCHAR2(20),
  nbastidor     VARCHAR2(20),
  fecha_pintado TIMESTAMP
);
--PK
ALTER TABLE registro_colores
  add constraint registro_colores_pk
  primary key (cod_color);
--FK
ALTER TABLE registro_colores
  add constraint registro_colores_coches
  foreign key (nbastidor) references coches(nbastidor);
--NOT NULL
ALTER TABLE registro_colores
  add constraint color_reg_col_not_null
  check (color is not null);
ALTER TABLE registro_colores
  add constraint nbast_reg_col_not_null
  check (nbastidor is not null);
ALTER TABLE registro_colores
  add constraint fpint_reg_col_not_null
  check (fecha_pintado is not null);
--Insercion de los colores en la nueva tabla registro_colores para
--no perder los datos antes de borrar el campo color.
INSERT INTO registro_colores
  (cod_color,color,nbastidor,fecha_pintado)
  values(1,'rojo','O123456789BCDFTYH',to_date('01/01/2011','dd/MM/YYYY'));
  
INSERT INTO registro_colores
  (cod_color,color,nbastidor,fecha_pintado)
  values(2,'blanco','IJK3456789BCDFTYH',to_date('04/07/2011','dd/MM/YYYY'));
  
INSERT INTO registro_colores
  (cod_color,color,nbastidor,fecha_pintado)
  values(3,'azul','12DFTYHIJK3456789',to_date('01/02/2012','dd/MM/YYYY'));
  
INSERT INTO registro_colores
  (cod_color,color,nbastidor,fecha_pintado)
  values(4,'rojo','2235678912DFTYHIJ',to_date('03/08/2008','dd/MM/YYYY'));

--Eliminacion del campo COCHE.color que no es necesario al tener
--nbastidor en el registro de colores
ALTER TABLE coches
  DROP COLUMN color;


--Para solucionar el problema de la inclusión de una nueva caracteristica
--hemos incluido un nuevo campo calefactados
ALTER TABLE acabados
  ADD (calefactados NUMBER(1,0));
ALTER TABLE acabados
  add constraint calef_acabados_check_boolean
  check (calefactados=0 or calefactados=1);
--Para poder añadir la restriccion NOT NULL antes debemos incluir la
--informacion para cada registro de acabados
UPDATE acabados SET calefactados=0;
--NOT NULL
ALTER TABLE acabados
  add constraint calef_acabados_not_null
  check (calefactados is not null);       