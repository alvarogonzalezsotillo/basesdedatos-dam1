create table itv(fecha_itv date, 
		fecha_anterior date, 
		n_bastidor varchar2 (20));

create table mantenimiento (km_mantenimiento number (10),
				fecha_mantenimiento date,
				km_anterior number (10),
				n_bastidor varchar2 (20));

create table colores (color varchar (20),
			fecha date,
			n_bastidor varchar2 (20));
				

--PRIMARY KEY

alter table itv add constraint itv_pk primary key (fecha_itv);

alter table mantenimiento add constraint mantenimiento_pk primary key (km_mantenimiento);

alter table colores add constraint colores_pk primary key (color);


--FOREIGN KEY

alter table itv add constraint bastidoresfk foreign Key (n_bastidor) references coches (n_bastidor);
alter table colores add constraint bastidorescol_fk foreign Key (n_bastidor) references coches (n_bastidor);
alter table mantenimiento add constraint bastidores_mfk foreign Key (n_bastidor) references coches (n_bastidor);

--NULOS

alter table itv add constraint n_bastidoro_no_null check (n_bastidor is not null);
alter table mantenimiento add constraint km_mantenimienton_no_null check (km_mantenimiento is not null);
alter table colores add constraint colorn_no_null check (color is not null);
alter table colores add constraint n_bastidorn_no_null check (n_bastidor is not null);