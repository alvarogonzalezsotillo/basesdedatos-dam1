--Base de Datos Alquiler de Coches
--Autor: Zahira Zamora y Carlos Dominguez
--Parte1 Estructura1

--CREACION DE TABLAS
CREATE TABLE coches (
  nbastidor   VARCHAR2(20), 
  matricula   VARCHAR2(10),
  marca       VARCHAR2(20),
  modelo      VARCHAR2(30),
  color       VARCHAR2(20),
  cod_acabado NUMBER(3,0)
  );
  
CREATE TABLE acabados (
  cod_acabado   NUMBER(3,0),
  cod_categoria NUMBER(2,0),
  aire_acond    NUMBER(1,0),
  climatizador  NUMBER(1,0),
  navegador     NUMBER(1,0),
  bluetooth     NUMBER(1,0),
  mp3           NUMBER(1,0),
  cambio_auto   NUMBER(1,0),
  techo_solar   NUMBER(1,0)
  );
  
CREATE TABLE categorias (  
  cod_categoria NUMBER(2,0),
  nombre        VARCHAR2(20),
  precio_dia    NUMBER(6,2)
  );
  
CREATE TABLE clientes (
  cod_cliente   NUMBER(15,0),
  nombre        VARCHAR2(50),
  apellidos     VARCHAR2(50),
  nif           VARCHAR2(12),
  edad          NUMBER(3,0),
  genero        VARCHAR2(1),
  direccion     VARCHAR2(100),
  ciudad        VARCHAR2(50),
  telefono      VARCHAR2(15)
);

CREATE TABLE alquileres (
  cod_alquiler  NUMBER(30,0),
  nbastidor     VARCHAR2(20),
  cod_cliente   NUMBER(15,0),
  cod_deleg_ori NUMBER(6,0),
  cod_deleg_des NUMBER(6,0),
  descuento     NUMBER(5,2),
  km_inicio     NUMBER(7,0),
  km_fin        NUMBER(7,0),
  fecha_inicio  TIMESTAMP,
  fecha_fin     TIMESTAMP
);

CREATE TABLE delegaciones (
  cod_delegacion  NUMBER(6,0),
  direccion       VARCHAR2(100),
  ciudad          VARCHAR2(50),
  telefono        VARCHAR2(15)
);

--PRIMARY KEY TABLAS
ALTER TABLE coches
  add constraint coches_pk
  primary key (nbastidor);

ALTER TABLE acabados
  add constraint acabados_pk
  primary key (cod_acabado);
  
ALTER TABLE categorias
  add constraint categorias_pk
  primary key (cod_categoria);  

ALTER TABLE clientes
  add constraint clientes_pk
  primary key (cod_cliente);

ALTER TABLE alquileres
  add constraint alquileres_pk
  primary key (cod_alquiler);
  
ALTER TABLE delegaciones
  add constraint delegaciones_pk
  primary key (cod_delegacion);  
  
--FOREIGN KEY TABLAS 
ALTER TABLE coches
  add constraint coches_acabados
  foreign key (cod_acabado) references acabados(cod_acabado);
  
ALTER TABLE acabados
  add constraint acabados_categorias
  foreign key (cod_categoria) references categorias(cod_categoria);
  
ALTER TABLE alquileres
  add constraint alquileres_clientes
  foreign key (cod_cliente) references clientes(cod_cliente);
  
ALTER TABLE alquileres
  add constraint alquileres_coches
  foreign key (nbastidor) references coches(nbastidor);
  
ALTER TABLE alquileres
  add constraint alquileres_delegaciones
  foreign key (cod_deleg_ori) references delegaciones(cod_delegacion);
  
ALTER TABLE alquileres
  add constraint alquileres_delegaciones1
  foreign key (cod_deleg_des) references delegaciones(cod_delegacion);

--UNIQUE TABLAS
ALTER TABLE coches
  add constraint matricula_coches_unique
  unique (matricula);

ALTER TABLE clientes
  add constraint nif_clientes_unique
  unique (nif);
  
--NOT NULL TABLA coches
ALTER TABLE coches
  add constraint matricula_coches_not_null
  check (matricula is not null);
  
ALTER TABLE coches
  add constraint marca_coches_not_null
  check (marca is not null);
  
ALTER TABLE coches
  add constraint modelo_coches_not_null
  check (modelo is not null);    
  
ALTER TABLE coches
  add constraint color_coches_not_null
  check (color is not null);  

ALTER TABLE coches
  add constraint cod_acabado_coches_not_null
  check (cod_acabado is not null);  
  
--NOT NULL TABLA acabados
ALTER TABLE acabados
  add constraint cod_cat_acabados_not_null
  check (cod_categoria is not null);
  
ALTER TABLE acabados
  add constraint aire_acond_acabados_not_null
  check (aire_acond is not null);
  
ALTER TABLE acabados
  add constraint climatizador_acabados_not_null
  check (climatizador is not null);  

ALTER TABLE acabados
  add constraint navegador_acabados_not_null
  check (navegador is not null);
  
ALTER TABLE acabados
  add constraint bluetooth_acabados_not_null
  check (bluetooth is not null);
  
ALTER TABLE acabados
  add constraint mp3_acabados_not_null
  check (mp3 is not null);
  
ALTER TABLE acabados
  add constraint cambio_auto_acabados_not_null
  check (cambio_auto is not null);

ALTER TABLE acabados
  add constraint techo_solar_acabados_not_null
  check (techo_solar is not null);
  
--NOT NULL TABLA categorias
ALTER TABLE categorias
  add constraint nombre_categorias_not_null
  check (nombre is not null);
  
ALTER TABLE categorias
  add constraint precio_dia_categorias_not_null
  check (precio_dia is not null);  
  
--NOT NULL TABLA clientes
ALTER TABLE clientes
  add constraint nombre_clientes_not_null
  check (nombre is not null);
  
ALTER TABLE clientes
  add constraint apellidos_clientes_not_null
  check (apellidos is not null);  
  
ALTER TABLE clientes
  add constraint nif_clientes_not_null
  check (nif is not null);  

ALTER TABLE clientes
  add constraint edad_clientes_not_null
  check (edad is not null);  
  
ALTER TABLE clientes
  add constraint genero_clientes_not_null
  check (genero is not null);  
  
ALTER TABLE clientes
  add constraint direccion_clientes_not_null
  check (direccion is not null);  
  
ALTER TABLE clientes
  add constraint ciudad_clientes_not_null
  check (ciudad is not null);
  
--NOT NULL TABLA alquileres
ALTER TABLE alquileres
  add constraint nbastidor_alquileres_not_null
  check (nbastidor is not null);  

ALTER TABLE alquileres
  add constraint cod_cli_alquileres_not_null
  check (cod_cliente is not null);  
  
ALTER TABLE alquileres
  add constraint cod_dl_o_alquileres_not_null
  check (cod_deleg_ori is not null);
 
ALTER TABLE alquileres
  add constraint descuento_alquileres_not_null
  check (descuento is not null);
  
ALTER TABLE alquileres
  add constraint km_inicio_alquileres_not_null
  check (km_inicio is not null);
  
ALTER TABLE alquileres
  add constraint f_inicio_alquileres_not_null
  check (fecha_inicio is not null);

--NOT NULL TABLA delegaciones
ALTER TABLE delegaciones
  add constraint dir_delegaciones_not_null
  check (direccion is not null);
  
ALTER TABLE delegaciones
  add constraint ciudad_delegaciones_not_null
  check (ciudad is not null);
    
--Check boolean TABLA clientes
ALTER TABLE clientes
  add constraint gen_clientes_check_boolean
  check (genero='F' or genero='M');
  
--Check boolean TABLA acabados
ALTER TABLE acabados
  add constraint aire_acabados_check_boolean
  check (aire_acond=0 or aire_acond=1);

ALTER TABLE acabados
  add constraint clima_acabados_check_boolean
  check (climatizador=0 or climatizador=1);  

ALTER TABLE acabados
  add constraint nav_acabados_check_boolean
  check (navegador=0 or navegador=1);

ALTER TABLE acabados
  add constraint bt_acabados_check_boolean
  check (bluetooth=0 or bluetooth=1);

ALTER TABLE acabados
  add constraint mp3_acabados_check_boolean
  check (mp3=0 or mp3=1);
  
ALTER TABLE acabados
  add constraint camb_acabados_check_boolean
  check (cambio_auto=0 or cambio_auto=1);
  
ALTER TABLE acabados
  add constraint techo_acabados_check_boolean
  check (techo_solar=0 or techo_solar=1);  
          