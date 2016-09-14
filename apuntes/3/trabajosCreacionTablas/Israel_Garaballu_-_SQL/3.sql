create table revisiones(
  bastidor VARCHAR2(7),
  tipo_revision VARCHAR2(15),
  km_revision NUMBER(6),
  fecha_revision date
); 

alter table revisiones
  add constraint revisiones_pk
  primary key (bastidor, tipo_revision, fecha_revision);

alter table revisiones
  add constraint bastidor_null check(bastidor is not null);
  add constraint tipo_revision_null check(tipo_revision is not null);

---------------------------------------------------------------------------

create table repintado(
  bastidor VARCHAR2(7),
  color VARCHAR2(10),
  colornuevo VARCHAR2(10),
  fecha_repintado DATE
); 

alter table repintado
  add constraint repintado_pk
  primary key (bastidor);

alter table repintado
  add constraint repintado_coches
  foreign key (bastidor) references coches(bastidor);

alter table repintado
  add constraint bastidor_null check(bastidor is not null);
  add constraint color_null check(color is not null);
  add constraint colornuevo_null check(colornuevo is not null);
  add constraint fecha_repintado_null check(fecha_repintado is not null);

---------------------------------------------------------------------------

alter table acabados add asientoscalefactados NUMBER(1);

