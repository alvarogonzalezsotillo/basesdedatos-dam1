drop table itv cascade constraints;
drop table revision cascade constraints;
drop table gcolor cascade constraints;

-- He decidido separar las revisiones de las ITV porque las ITV se realizan cada X años y los mantemientos son un --
-- concepto de la casa asociado al nº de km (cierto es que también puede ir asociado a fechas pero simplifico). --
create table itv(
					num_bastidor  		varchar2	(17) 	NOT NULL,
					fech_max   			date				NOT NULL,
					fech_ant 			date				NOT NULL);

create table revision(
					num_bastidor		varchar2	(17)	NOT NULL,
					kilometros			number		(6)		NOT NULL,
					km_anterior 		number		(6)		NOT NULL);

create table gcolor(
					num_bastidor 		varchar2	(17)	NOT NULL,
					color_anterior		varchar2	(20)	NOT NULL,
					color_actual		varchar2 	(20)	NOT NULL,
					fecha_compra		date				NOT NULL,
					fecha_pintado		date				NOT NULL);
					
					
--- Definición de Pk's --
alter table itv 		add constraint 	pk_itv		primary key	(num_bastidor , fech_max);

alter table revision	add constraint 	pk_revision	primary key	(num_bastidor , kilometros);

alter table gcolor		add constraint	pk_gcolor	primary key	(num_bastidor , color_actual);


-- Definición de FK's --
alter table itv 		add constraint	fk_itv		foreign key (num_bastidor)		references 	coches(num_bastidor);

alter table revision	add constraint	fk_revision	foreign key (num_bastidor)		references	coches(num_bastidor);

alter table	gcolor		add constraint	fk_gcolor	foreign key	(num_bastidor)		references	coches(num_bastidor);