create table clientes(
  nombre_cliente VARCHAR2(50),
  apellido_cliente VARCHAR2(50),
  dni_cliente VARCHAR2(10),
  edad_cliente NUMBER(2),
  genero_cliente VARCHAR2(1)
);

alter table clientes
  add constraint clientes_pk
  primary key (dni_cliente);

---------------------------------------------------------------------------

create table coches(
  marca VARCHAR2(20),
  modelo VARCHAR2(40),
  color VARCHAR2(10),
  matricula VARCHAR2(7),
  bastidor VARCHAR2(7),
  categoria VARCHAR2(7)
); 

alter table coches
  add constraint coches_pk
  primary key (bastidor);

---------------------------------------------------------------------------

create table acabados(
  bastidor VARCHAR2(7),
  acondicionado NUMBER(1),
  climatizador NUMBER(1),
  navegador NUMBER(1),
  bluetooth NUMBER(1),
  mp3 NUMBER(1),
  automatico NUMBER(1),
  techosolar NUMBER(1)
); 

alter table acabados
  add constraint acabados_pk
  primary key (bastidor);

---------------------------------------------------------------------------

create table alquiler(
  cod_alquiler VARCHAR2(7),
  bastidor VARCHAR2(7),
  dni_cliente VARCHAR2(10),
  km_inicial NUMBER(6),
  km_final NUMBER(6),
  fecha_recogida date,
  fecha_devolucion date,
  delegacion_recogida VARCHAR2(30),
  delegacion_devolucion VARCHAR2(30),
  descuento NUMBER(2),
  precio NUMBER(4)
); 

alter table alquiler
  add constraint alquiler_pk
  primary key (cod_alquiler);

alter table alquiler
  add constraint alquiler_clientes
  foreign key (dni_cliente) references clientes(dni_cliente);

alter table alquiler
  add constraint alquiler_coches
  foreign key (bastidor) references coches(bastidor);

---------------------------------------------------------------------------

alter table clientes
  add constraint nombre_cliente_null check(nombre_cliente is not null);
  add constraint dni_cliente_null check(dni_cliente is not null);
  add constraint edad_cliente_null check(edad_cliente is not null);
  add constraint genero_cliente_null check(genero_cliente is not null);

alter table coches
  add constraint marca_null check(marca is not null);
  add constraint modelo_null check(modelo is not null);
  add constraint color_null check(color is not null);
  add constraint matricula_null check(matricula is not null);
  add constraint bastidor_null check(bastidor is not null);

alter table acabados
  add constraint bastidor_null check(bastidor is not null);

alter table alquiler
  add constraint cod_alquiler_null check(cod_alquiler is not null);
  add constraint bastidor_null check(bastidor is not null);
  add constraint dni_cliente check(dni_cliente is not null);
  add constraint fecha_recogida_null check(fecha_recogida is not null);
  add constraint delegacion_recogida_null check(delegacion_recogida is not null);
  add constraint km_inicial_null check(km_inicial is not null);