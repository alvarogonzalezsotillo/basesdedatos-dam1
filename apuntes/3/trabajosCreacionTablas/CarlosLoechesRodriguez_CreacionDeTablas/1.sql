--Creacion de tablas

create table categorias(tipo_categoria varchar2(50), 
			precio number(5));

create table coches(n_bastidor varchar2(50), 
                    marca varchar2(20),
                    modelo varchar2(50), 
                    color_carroceria varchar2(50),
                    matricula varchar2(20),
		                tipo_categoria varchar2(50));

create table acabados(id_acabado number(3),
		                   tipo_acabado varchar2(50));

create table alquileres(id_alquiler number(5),
                        del_recogida varchar2(50),
                        del_devolucion varchar2(50),
                        km_iniciales number(9),
                        km_finales number(9),
                        fecha_inicio date,
                        fecha_fin date,
                        descuento number(4),
			                  n_bastidor varchar2(50));

create table clientes(dni varchar2(20),
                      nombre varchar2(30),
                      apellidos varchar2(50),
                      edad number(3),
                      genero varchar2(10));

create table alquileres_clientes(id_alquiler number(5),
                                  dni varchar2(20));

create table acabados_coches(n_bastidor varchar2(50),
	                            id_acabado number(3));




--Creacion de constraints
--Primary keys

alter table categorias add constraint categorias_pk primary key(tipo_categoria);

alter table coches add constraint coches_pk primary key(n_bastidor);

alter table acabados add constraint acabados_pk primary key(id_acabado);

alter table alquileres add constraint alquileres_pk primary key(id_alquiler);

alter table clientes add constraint clientes_pk primary key(dni);

alter table alquileres_clientes add constraint alquileres_clientes_pk primary key(id_alquiler,dni);

alter table acabados_coches add constraint acabados_coches_pk primary key(n_bastidor,id_acabado);


--Foreign keys

alter table coches add constraint coches_categoria foreign key(tipo_categoria) references categorias(tipo_categoria);

alter table alquileres add constraint alquileres_coches foreign key(n_bastidor) references coches(n_bastidor);

alter table alquileres_clientes add constraint clientes_fk foreign key(dni) references clientes(dni);

alter table alquileres_clientes add constraint alquileres_fk foreign key(id_alquiler) references alquileres(id_alquiler); 

alter table acabados_coches add constraint acabados_fk foreign key(id_acabado) references acabados(id_acabado);

alter table acabados_coches add constraint coches_fk foreign key(n_bastidor) references coches(n_bastidor);


--NOT NULL


alter table categorias add constraint precio_notnull check(precio is not null);


alter table coches add constraint marca_notnull check(marca is not null);

alter table coches add constraint modelo_notnull check(modelo is not null);

alter table coches add constraint color_notnull check(color_carroceria is not null);

alter table coches add constraint matricula_notnull check(matricula is not null);

alter table coches add constraint tipo_categoria_notnull check(tipo_categoria is not null);


alter table acabados add constraint tipo_acabado_notnull check(tipo_acabado is not null);


alter table alquileres add constraint del_recogida_notnull check(del_recogida is not null);

alter table alquileres add constraint km_iniciales_notnull check(km_iniciales is not null);

alter table alquileres add constraint km_finales_notnull check(km_finales is not null);

alter table alquileres add constraint fecha_inicio_notnull check(fecha_inicio is not null);

alter table alquileres add constraint n_bastidor_notnull check(n_bastidor is not null);


alter table clientes add constraint nombre_notnull check(nombre is not null);

alter table clientes add constraint apellidos_notnull check(apellidos is not null);

alter table clientes add constraint edad_notnull check(edad is not null);

alter table clientes add constraint genero_notnull check(genero is not null);


alter table alquileres_clientes add constraint id_alquiler_notnull check(id_alquiler is not null);

alter table alquileres_clientes add constraint dni_notnull check(dni is not null);


alter table acabados_coches add constraint bastidor_notnull check(n_bastidor is not null);

alter table acabados_coches add constraint id_acabado_notnull check(id_acabado is not null);

