--Creo tablas para ITV y mantenimiento

create table itv(n_bastidor varchar(50),
		 fecha_maxima date,
		 fecha_anterior date);

create table mantenimientos(n_bastidor varchar(50),
			    kilometros number(10),
			    kilometros_anterior number(10));

--Creo la tabla para guardar los colores de los coches

create table colores(n_bastidor varchar(50),
		     color varchar2(50),
		     fecha_inicio date,
		     fecha_fin date);

--Añado el acabado de asientos calefactados

insert into acabados(id_acabado, tipo_acabado) values(8, 'asientos calefactados');



--Creación de constraints para las nuevas tablas
--Primary key

alter table itv add constraint itv_pk primary key(n_bastidor, fecha_maxima);

alter table mantenimientos add constraint mantenimientos_pk primary key(n_bastidor, kilometros);

alter table colores add constraint colores_pk primary key(n_bastidor, color, fecha_inicio);



--Foreign key

alter table itv add constraint itv_coches foreign key(n_bastidor) references coches(n_bastidor);

alter table mantenimientos add constraint mantenimientos_coches foreign key(n_bastidor) references coches(n_bastidor);

alter table colores add constraint colores_coches foreign key(n_bastidor) references coches(n_bastidor);



