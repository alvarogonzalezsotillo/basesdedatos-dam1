

--creo las tablas

create table clientes(
   nombre varchar2(20),
   apellidos varchar2(20),
   dni varchar2(10),
   edad numeric(3),
   genero varchar2(15));

create table coches(
   nbastidor varchar2(20),
   matricula varchar2(7),
   fecha_compra date,
   marca varchar2(15),
   modelo varchar2(20),
   color varchar2(15));

create table alquiler(
   nalquiler numeric(20),
   nbastidor varchar2(20),
   dni varchar2(10),
   km_inicial numeric(10),
   km_final numeric(10),
   delegacion_recogida varchar2(25),
   fecha_recogida date,
   delegacion_devolucion varchar2(25),
   fecha_devolucion date,
   precio numeric(5),
   descuento numeric(3));

create table acabados(
   nbastidor varchar2(20),
   aire_acondicionado numeric(1),   
   climatizador numeric(1),
   navegador numeric(1),
   bluetooth numeric(1),
   mp3 numeric(1),
   cambio_automatico numeric(1),
   techo_solar numeric(1));


--creo las claves primarias

alter table acabados add constraint acabados_pk primary key(nbastidor);

alter table alquiler add constraint alquiler_pk primary key(nalquiler);

alter table coches add constraint coches_pk primary key (nbastidor);

alter table clientes add constraint clientes_pk primary key(dni);


--creo claves foraneas

alter table acabados add constraint acabados_coches foreign key(nbastidor) references coches(nbastidor);
   
alter table alquiler add constraint coches_clientes foreign key(dni) references clientes(dni);

alter table alquiler add constraint alquiler_coches foreign key(nbastidor) references coches(nbastidor);


--inserto si es null o no

alter table clientes add constraint dni_no_nulo check( dni is not null);

alter table clientes add constraint nombre_no_nulo check( nombre is not null);

alter table clientes add constraint apellidos_no_nulo check( apellidos is not null);

alter table clientes add constraint genero_no_nulo check( genero is not null);

alter table clientes add constraint drecogida_no_nulo check( delegacion_recogida is not null);

alter table clientes add constraint frecogida_no_nulo check( fecha_recogida is not null);

alter table coches add constraint bastidor_no_nulo check( nbastidor is not null);

alter table coches add constraint matricula_no_nulo check( matricula is not null);

alter table coches add constraint color_no_nulo check( color is not null);

alter table coches add constraint marca_no_nulo check( marca is not null);

alter table coches add constraint modelo_no_nulo check( modelo is not null);

alter table alquiler add constraint alquiler_no_nulo check( nalquiler is not null);

alter table alquiler add constraint kmi_no_nulo check( km_inicial is not null);

alter table acabados add constraint aire_no_nulo check( aire_acondicionado is not null);

alter table acabados add constraint navegador_no_nulo check( navegador is not null);

alter table acabados add constraint climatizador_no_nulo check( climatizador is not null);

alter table acabados add constraint bluetooth_no_null check(bluetooth is not null);

alter table acabados add constraint mp3_no_null check(mp3 is not null);

alter table acabados add constraint cambio_no_null check(cambio_automatico is not null);

alter table acabados add constraint techo_no_null check(techo_solar is not null);




 