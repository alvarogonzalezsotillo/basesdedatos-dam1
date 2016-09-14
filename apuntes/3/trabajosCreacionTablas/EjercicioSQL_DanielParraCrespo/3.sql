--creo las nuevas tablas
create table revisiones(
    nbastidor varchar2(20),
    tipo varchar2(15),
    numero_revision numeric(5),
    anterior_revision date,
    siguiente_revision date,
    km_revision numeric(10));
    
create table pinturas(
    nbastidor varchar2(20),
    pintura_inicial varchar2(15),
    fecha_inicio_pintura date, 
    pintura_final varchar2(15),
    fecha_final_pintura date);
  
--Creo las pk de estas tablas  
alter table revisiones add constraint bastidor_revision_pk primary key(nbastidor, numero_revision);
  
alter table pinturas add constraint bastidor_pinturas_pk primary key(nbastidor);


--creo las fk de las tablas nuevas
alter table pinturas add constraint pinturas_coches foreign key(nbastidor) references coches(nbastidor);
 
alter table revisiones add constraint revisiones_coches foreign key(nbastidor) references coches(nbastidor);


--introduzco un nuevo acabado de la tabla acabados
alter table acabados add asiento_calefaccion numeric(1);
    
    
--meto si puede ser null
alter table revisiones add constraint bastidor_no_nulo check( nbastidor is not null);   

alter table revisiones add constraint compra_no_nulo check( fecha_compra is not null);

alter table pinturas add constraint bastidor_pintura_no_nulo check( nbastidor is not null);
