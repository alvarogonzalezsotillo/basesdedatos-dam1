drop table acabado cascade constraints;
drop table acabado_coche cascade constraints;
drop table alquileres cascade constraints;
drop table categorias cascade constraints;
drop table cliente cascade constraints; 
drop table coches cascade constraints;
drop table alquiler cascade constraints;


select table_name from tabs; 

-- 1) ENTORNO DEL PROBLEMA --

-- Creación de tablas y definición de columnas --
create table cliente  ( ipf					varchar2	(10)	NOT NULL,
                       	nombre				varchar2	(20)	NOT NULL,
                       	apellidos			varchar2	(30)	NOT NULL,
                       	edad				number		(3)		NOT NULL,
                       	genero				varchar2	(10)	NOT NULL);

create table coches   (	num_bastidor		varchar2	(17)	NOT NULL, 
						marca				varchar2	(20)	NOT NULL,
						modelo				varchar2	(20)	NOT NULL, 
						color				varchar2	(40)	NOT NULL,
						categoria			varchar2	(20)	NOT NULL,
						matricula			varchar2	(7)		NOT NULL);
						
create table alquiler(	id_alquiler			number		(5)		NOT NULL,
						num_bastidor		varchar2	(17)	NOT NULL,
						recogida			varchar2	(30)	NOT NULL,
						devolucion			varchar2	(30)	NOT NULL,
						km_iniciales		number		(6)		NOT NULL,
						km_finales			number		(6)		NOT NULL,	-- Entiendo que en esta columna y en la de fecha fin en el caso de no haber devuelto el coche estableciendo el valor default --
						fecha_inicio		date				NOT NULL,	--  podemos intervenir para evitar nulos o incumplir restricciones pero por alguna razón que no consigo averiguar no funciona. --
						fecha_fin			date				NOT NULL,
						descuento			number		(10)	NOT NULL);

create table categorias(
						categoria			varchar2	(20) 	NOT NULL,
						precio				number		(6)		NOT NULL);

create table acabado(	id_acabado   		number		(10)	NOT NULL,
						datos_acabado 		varchar2	(80)	NOT NULL);
						
create table alquileres(
						ipf					varchar2	(10)	NOT NULL,
						id_alquiler			number		(10)	NOT NULL);

create table acabado_coche(
						num_bastidor  		varchar2	(17)	NOT NULL,
						id_acabado    		varchar2	(5)		NOT NULL);
						
-- Especificación de PK´s --
alter table cliente 			add constraint cliente_pk 				primary key(ipf);

alter table coches 				add constraint coches_pk 				primary key(num_bastidor);

alter table alquiler 			add constraint alquiler_pk 				primary key(id_alquiler);

alter table categorias 			add constraint categorias_pk 			primary key(categoria);

alter table acabado 			add constraint acabados_pk 				primary key(id_acabado);

alter table alquileres		 	add constraint alquileres_pk 			primary key(ipf, id_alquiler);

alter table acabado_coche 		add constraint acabado_coche_pk 		primary key(num_bastidor, id_acabado);

-- Especificación de FK´s --
alter table alquileres			add constraint ipf_cliente_fk			foreign key(ipf) 			references cliente(ipf);
alter table alquileres			add constraint alquiler_id_fk			foreign key(id_alquiler)	references alquiler(id_alquiler);

alter table coches				add constraint cat_fk 					foreign key(categoria) 		references categorias(categoria);

alter table alquiler			add constraint coch_alq_fk				foreign key(num_bastidor)	references coches(num_bastidor);

alter table acabado_coche		add constraint acabado_fk				foreign key(id_acabado)		references acabado(id_acabado);
alter table acabado_coche		add constraint coch_bast_fk				foreign key(num_bastidor)	references coches(num_bastidor);
