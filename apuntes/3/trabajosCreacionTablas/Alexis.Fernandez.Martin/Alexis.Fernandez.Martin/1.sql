
create table clientes( dni       varchar2(20),
                       nombre    varchar2(30),
                       apellidos varchar2(50),
                       edad      number(2),
                       genero    varchar2(10)
                       );



create table coches(  num_bastidor  varchar2(30), 
                      matricula     varchar2(20),
                      marca         varchar2(20),
                      modelo        varchar2(30), 
                      color         varchar2(30),
                      categoria     varchar2(30)
                      );



create table alquiler(  id_alquiler       number(10),
                        deleg_recogida    varchar2(50),
                        deleg_devolucion  varchar2(50),
                        km_iniciales      number(9),
                        km_finales        number(9),
                        fech_inicio       date,
                        fech_fin          date,
                        descuento         number(10),
			                  num_bastidor varchar2(30)
);


create table categorias( categoria varchar2(30), 
			 precio    number(9)
                         );


create table acabados(cod_acabado   number(5),
		      tipo_acabado varchar2(30)
                      );




create table alquiler_clientes(  dni         varchar2(20),
                                 id_alquiler number(10)
                                  );

create table acabados_coches( num_bastidor  varchar2(30),
	                      cod_acabado    number(5)
                              );




--añadimos las claves primarias y ajenas--
-----------------------------------------------------------------------------


alter table clientes add constraint clientes_pk primary key(dni);


alter table coches add constraint coches_pk primary key(num_bastidor);


alter table alquiler add constraint alquiler_pk primary key(id_alquiler);


alter table categorias add constraint categorias_pk primary key(categoria);


alter table acabados add constraint acabados_pk primary key(cod_acabado);



alter table alquiler_clientes add constraint alquiler_clientes_pk primary key(dni,id_alquiler);


alter table acabados_coches add constraint acabados_coches_pk primary key(num_bastidor,cod_acabado);


------------------------------------------------------------------------------------------------------------------------------
alter table alquiler_clientes add constraint clientes_fk foreign key(dni) references clientes(dni);


alter table alquiler_clientes add constraint alquiler_fk foreign key(id_alquiler) references alquiler(id_alquiler); 


alter table coches add constraint coches_categoria foreign key(categoria) references categorias(categoria);


alter table alquiler add constraint alquiler_coches foreign key(num_bastidor) references coches(num_bastidor);


alter table acabados_coches add constraint acabados_fk foreign key(cod_acabado) references acabados(cod_acabado);


alter table acabados_coches add constraint coches_fk foreign key(num_bastidor) references coches(num_bastidor);



-------------------------------------------------------------------------------------------


alter table clientes add constraint nombre_notnull check(nombre is not null);

alter table clientes add constraint apellidos_notnull check(apellidos is not null);

alter table clientes add constraint edad_notnull check(edad is not null);

alter table clientes add constraint genero_notnull check(genero is not null);


alter table categorias add constraint precio_notnull check(precio is not null);


alter table coches add constraint marca_notnull check(marca is not null);

alter table coches add constraint modelo_notnull check(modelo is not null);

alter table coches add constraint color_notnull check(color_carroceria is not null);

alter table coches add constraint matricula_notnull check(matricula is not null);

alter table coches add constraint tipo_categoria_notnull check(tipo_categoria is not null);


alter table acabados add constraint tipo_acabado_notnull check(tipo_acabado is not null);


alter table alquiler add constraint del_recogida_notnull check(del_recogida is not null);

alter table alquiler add constraint km_iniciales_notnull check(km_iniciales is not null);

alter table alquiler add constraint km_finales_notnull check(km_finales is not null);

alter table alquiler add constraint fech_inicio_notnull check(fech_inicio is not null);

alter table alquiler add constraint num_bastidor_notnull check(num_bastidor is not null);




alter table alquiler_clientes add constraint id_alquiler_notnull check(id_alquiler is not null);

alter table alquiler_clientes add constraint dni_notnull check(dni is not null);


alter table acabados_coches add constraint n_bastidor_notnull check(num_bastidor is not null);

alter table acabados_coches add constraint cod_acabado_notnull check(cod_acabado is not null);

