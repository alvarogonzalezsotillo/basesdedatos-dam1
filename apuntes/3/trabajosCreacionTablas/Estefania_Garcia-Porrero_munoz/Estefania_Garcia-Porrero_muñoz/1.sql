//creo la primera tabla llamada coches, aqui todos los atributos son obligarorios
create table coches(
marca varchar(25) not null,
modelo varchar(25) not null,
color_carroceria varchar(25) not null,
matricula varchar(15) not null,
n_bastidor varchar(20) not null
);

//como PK le asigno n_bastidor puesto que en cada coche tiene el suyo unico
alter table coches add constraint coches_pk primary key (n_bastidor);

// en la segunda tabla estan todos los acabados de de coches y como defecto N al no_ asignarle ningun valor
create table acabado_coches(
categoria varchar(25) not null,
aire_acondicionado varchar(1) default('N'),
climatizador varchar(1) default('N'),
navegador varchar(1) default('N'),
bluetooth varchar(1) default('N'),
mp3 varchar(1) default('N'),
cambio_automatico varchar(1) default('N'),
techo_solar varchar(1) default('N'),
n_bastidor varchar(20) not null
);

//n_bastidor lo uso aqui tambn de PK que es una FK de la tabla coches
alter table acabado_coches add constraint acabado_coches_pk primary key (n_bastidor);
alter table acabado_coches add constraint acabado_coches_fk foreign key (n_bastidor) references coches (n_bastidor);

//La tercera tabla es para todos los valores relacionados con clientes
create table cliente(
nombre varchar(20) not null,
apellidos varchar(30) not null,
dni_nie_pasaporte varchar(30) not null,
edad number(3) not null,
genero varchar(1)not null
);

//He elegido el dni como PK
alter table cliente add constraint cliente_pk primary key (dni_nie_pasaporte);

//La ultima tabla alquiler son todos los datos relanionados con el alquiler de un coche relacionando la tabla coches con clientes
create table alquiler(
delegacion_recogida varchar(20) not null,
delegacion_vuelta varchar(20) default('esperando'),
km_inicio number(10) not null,
km_final number(10) default('0'),
fecha_salida date,
fecha_llegada date null,
n_bastidor varchar(20) not null,
dni_nie_pasaporte varchar(30) not null
);

// Esta es otra forma de introducir una columna a la tabla una vez creada
alter table alquiler add precio number(6) default(0);
alter table alquiler add descuento number(3) default(0);


//n_bastidor sera la PK de esta tabla que es FK de la tabla coches
alter table alquiler add constraint alquiler_pk primary key (n_bastidor);
alter table alquiler add constraint alquiler_fk foreign key (n_bastidor) references coches (n_bastidor);

//He añadido a la tabla el dni de los clientes para de esta forma saber que cliente ha hecho dicho alquiler
alter table alquiler add constraint alquiler_cliente foreign key (dni_nie_pasaporte) references cliente (dni_nie_pasaporte);