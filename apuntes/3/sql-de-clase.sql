create table pedidos(
  idpedido number(10,0) primary key
);

create table productos(
  idproducto number(9,0) primary key,
  nombre varchar(50),
  precio number(6,2) check( precio > 0 )
); 

create table lineaspedidos(
  idpedido number(10,0),
  idproducto number(9,0),
  cantidad number (3,0) check (cantidad > 0 ),
  primary key (idpedido, idproducto),
  foreign key (idpedido) references pedidos(idpedido),
  foreign key (idproducto) references productos(idproducto)
);



-- CREAR UN USUARIO
create user school identified by school;

-- EL USUARIO PUEDE CONECTARSE
grant connect to school;

-- EL USUARIO PUEDE CREAR TABLAS
grant resource to school;
