--creacion de las tablas para la itv ,mantenimiento y los colores---

create table itv(  num_bastidor  varchar(30),
		   fech_limite   date,
		   fech_anterior date
                 );

create table mantenimiento( num_bastidor varchar(30),
			    kilometros   number(10),
			    kilometros_anterior number(10));



create table colores(num_bastidor varchar(30),
		     color varchar2(30),
		     fech_inicio date,
		     fech_fin date);

--añadimos nuevo acabado--

insert into acabados(cod_acabado, tipo_acabado) values(8, 'asientos calefactados');



--añadimos las claves a las nuevas tablas--

alter table itv add constraint itv_pk primary key(num_bastidor, fech_limite);

alter table mantenimiento add constraint mantenimiento_pk primary key(num_bastidor, kilometros);

alter table colores add constraint colores_pk primary key(num_bastidor, color, fech_inicio);


---------------------------------------------------------------------

alter table itv add constraint itv_coches foreign key(num_bastidor) references coches(num_bastidor);

alter table mantenimiento add constraint mantenimientos_coches foreign key(num_bastidor) references coches(num_bastidor);

alter table colores add constraint colores_coches foreign key(num_bastidor) references coches(num_bastidor);



