


CREATE TABLE coche(
marca varchar(25) not null,
modelo varchar(25) not null,
color varchar(25) not null,
matricula varchar(7) not null,
bastidor NUMERIC(15) not null,
categoria varchar(10) not null
);

alter table coche
add constraint coche_PK
primary key(bastidor);


CREATE TABLE categorias(
categoria varchar(10)
);

alter table categorias
add constraint categorias_PK
primary key(categoria);

CREATE TABLE cliente(
nombre varchar(25) not null,
apellidos varchar(40) not null,
dni varchar(25) not null,
edad NUMERIC(3) not null,
genero varchar(1) not null
);


alter table cliente
add constraint cliente_PK
primary key(dni);

CREATE TABLE acabado(
aire_acondicionado varchar(1) DEFAULT ('N'),
climatizador varchar(1)  DEFAULT ('N'),
navegador varchar(1) DEFAULT ('N'),
bluetooth varchar(1) DEFAULT ('N'),
mp3 varchar(1) DEFAULT ('N'),
cambio_automatico varchar(1) DEFAULT ('N'),
techo_solar varchar(1) DEFAULT ('N'),
bastidor NUMERIC(15) not null,
id_acabado NUMERIC(10) not null
);

alter table acabado
add constraint acabado_PK
primary key(id_acabado);

CREATE TABLE alquila(
id_alquiler NUMERIC(10) not null,
km_inicio NUMERIC(7) not null,
km_final NUMERIC(7),
fecha_inicio TIMESTAMP not null,
fecha_final TIMESTAMP,
descuento NUMERIC(6),
recoje varchar(15) not null,
devuelve varchar(15),
dni varchar(25) not null
);


alter table alquila
add constraint alquila_PK
primary key(id_alquiler);

CREATE TABLE se(
id_alquiler NUMERIC(10) not null,
bastidor NUMERIC(15) not null
);

alter table alquila
add constraint alquila_cliente
foreign key(dni)references cliente(dni);


alter table se
add constraint se_alquila
foreign key(id_alquiler)references alquila(id_alquiler);

alter table se
add constraint se_coche
foreign key(bastidor)references coche(bastidor);


alter table acabado
add constraint acabado_coche
foreign key(bastidor)references coche(bastidor);

alter table coche
add constraint coche_categorias
foreign key(categoria)references categorias(categoria);


Carlos Reina Sevilla