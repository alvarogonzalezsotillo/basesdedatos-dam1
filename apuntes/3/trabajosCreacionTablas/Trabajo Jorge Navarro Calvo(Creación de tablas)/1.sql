create table categorias(tipo_categorias varchar2 (20), precio number (8));
create table coches(marca varchar2 (20), 
		    modelo varchar2 (20), 
		    color varchar2 (20),
		    matricula varchar2 (20),
		    n_bastidor varchar2 (20),
		   tipo_categorias varchar2 (20));

create table acabados(clase_acabado varchar2 (20));

create table alquileres(lugar_recogida varchar2 (20), 
		       lugar_dejar varchar2 (20), 
		       km_inicial number (8),
		       km_final number (8),
		       fecha_fin varchar2 (20),
		       fecha_inicio varchar2 (20),
		       descuento number (8),
		       dni varchar2 (20),
		       id_alquiler number (8));

create table clientes(nombre varchar2 (20), 
		     apellidos varchar2 (20), 
		     dni varchar2 (20),
		     edad varchar2 (20),
		     genero varchar2 (20));

create table coches_acabados( n_bastidor varchar2 (20),
		    	    clase_acabado varchar2 (20));
		            
create table alquileres_clientes( dni varchar2 (20),
		    	    id_alquiler number (8));

create table coches_alquileres( n_bastidor varchar2 (20),
		    	    id_alquiler number (8));



--PRIMARY KEY

alter table categorias add constraint categorias_pk primary key (tipo_categorias);

alter table coches add constraint coches_pk primary key (n_bastidor);

alter table acabados add constraint acabados_pk primary key (clase_acabado);

alter table alquileres add constraint alquileres_pk primary key (id_alquiler);

alter table clientes add constraint clientes_pk primary key (dni);

alter table coches_acabados add constraint coches_acabados_pk primary key (n_bastidor,clase_acabado);

alter table alquileres_clientes add constraint alquileres_clientes_pk primary key (id_alquiler,dni);

alter table coches_alquileres add constraint coches_alquileres_pk primary key (id_alquiler,n_bastidor);


--FOREIGN KEY

alter table coches add constraint categorias_cochesfk foreign Key (tipo_categorias) references categorias (tipo_categorias);

alter table coches_acabados add constraint c_a_nfk foreign Key (n_bastidor) references coches (n_bastidor);

alter table coches_acabados add constraint c_a_cfk foreign Key (clase_acabado) references acabados (clase_acabado);

alter table coches_alquileres add constraint c_a_ifk foreign Key (id_alquiler) references alquileres (id_alquiler);

alter table coches_alquileres add constraint c_a_bfk foreign Key (n_bastidor) references coches (n_bastidor);

alter table alquileres_clientes add constraint a_c_ifk foreign Key (id_alquiler) references alquileres (id_alquiler);

alter table alquileres_clientes add constraint a_c_dfk foreign Key (dni) references clientes (dni);


--NULOS

alter table categorias add constraint precio_no_null check (precio is not null);

alter table coches add constraint marca_no_null check (marca is not null);

alter table coches add constraint modelo_no_null check (modelo is not null);

alter table coches add constraint color_no_null check (color is not null);

alter table coches add constraint matricula_no_null check (matricula is not null);

alter table alquileres add constraint lugar_recogida_no_null check (lugar_recogida is not null);

alter table alquileres add constraint lugar_dejar_no_null check (lugar_dejar is not null);

alter table alquileres add constraint km_inicial_no_null check (km_inicial is not null);

alter table alquileres add constraint fecha_inicio_no_null check (fecha_inicio is not null);

alter table alquileres add constraint dni_no_null check (dni is not null);

alter table clientes add constraint nombre_no_null check (nombre is not null);

alter table clientes add constraint apellidos_no_null check (apellidos is not null);

alter table clientes add constraint edad_no_null check (edad is not null);

alter table clientes add constraint genero_no_null check (genero is not null);









