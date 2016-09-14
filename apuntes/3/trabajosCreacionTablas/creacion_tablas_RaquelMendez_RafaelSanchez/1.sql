-- Archivo 1.sql creado por Raquel Mendez Santiago y Rafael Sanchez Ocasar

-- creamos la tabla categorias, el precio no podra ser null y el nombre tampoco 
-- pero al ser una primary key no es necesario especificarlo
create table categorias (nombre varchar2(50), precio numeric(5,2) not null);

-- alteramos la tabla annadiendo la PK,el nombre de dicha categoría
alter table categorias 
	add constraint categorias_PK 
	primary Key(nombre);
	
-- creamos la tabla acabados_coches que contendra los diferentes acabados de un coche concreto, 
-- cada acabado-coche tendra un identificador unico
create table Acabados_coches(ID_acabado numeric(6), aire_acondicionado numeric(1) not null, 
climatizador numeric(1) not null, navegador numeric(1) not null, bluetooth numeric(1) not null, 
mp3 numeric(1) not null, cambio_automatico numeric(1) not null);

-- asignamos PK a Id_acabado
alter table Acabados_coches 
	add constraint Acabados_coches_PK
	primary Key(Id_acabado);

-- creamos tabla coches contendra toda la informacion referente a los coches
-- el numero de bastidor se entiende como unico
create table Coches (n_bastidor varchar2(20),n_matricula varchar2(8) not null,
color varchar2(25) not null, nombre_categoria varchar2(50) not null, 
ID_acabado numeric(6) not null, modelo varchar2(50) not null);

-- asignamos PK a n_bastidor
alter table Coches 
	add constraint Coches_PK
	primary Key(n_bastidor);
	
-- asignamos las FK, dirigidas a categorias, acabados y modelos
alter table Coches
	add constraint Coches_Categorias
	foreign key(nombre_categoria) references categorias(nombre);

alter table Coches
	add constraint Coches_Acabados
	foreign key(ID_acabado) references Acabados_coches(ID_acabado);

alter table Coches
	add constraint Coches_Modelo
	foreign key(modelo) references Modelos(modelo);
	
-- la matricula no es PK, pero es unique
alter table Coches
	add constraint Matricula_unique
	unique(n_matricula);
	
-- creamos tabla modelos, solo guarda el modelo y su marca, que no puede ser null
create table Modelos(modelo varchar2(50), marca varchar(50) not null);

-- asignamos modelo como PK
alter table Modelos
	add constraint Modelos_PK
	primary key (modelo);
	
-- creamos tabla clientes, guarda toda la informacion de los mismos
create table Clientes(DNI varchar2(12), nombre varchar2(50) not null, 
apellidos varchar2(50) not null, edad numeric(3) not null, genero char not null);

-- asignamos la PK que es el DNI
alter table Clientes
	add constraint Cliente_PK
	primary key (DNI);
	
-- creamos la tabla delegaciones, se le asigna un identificador y ese refiere a la ciudad
create table Delegaciones(ID_delegacion varchar2(10), ciudad varchar2(50) not null);

-- asignamos la PK al identificador
alter table Delegaciones
	add constraint Delegaciones_PK
	primary key (ID_delegacion);
	
-- creamos la tabla alquileres, los elementos fecha_fin, descuento_comercial, km_fin
-- y delegacion_entrega pueden ser null
create table Alquileres (fecha_inicio date, fecha_fin date, descuento_comercial numeric(3,2), 
km_inicio numeric(6) not null, km_fin numeric(6), num_bastidor varchar2(50),
DNI varchar2(12), ID_delegacion_recogida varchar2(50) not null, ID_delegacion_entrega varchar2(50));

-- la PK en este caso es compuesta
alter table Alquileres
	add constraint Alquiler_PK
	primary key(DNI, num_bastidor,fecha_inicio);

-- asignamos las FK, dirigidas a coches, clientes y delegaciones
alter table Alquileres
	add constraint Alquileres_Coches
	foreign key (num_bastidor) references Coches(n_bastidor);
	
alter table Alquileres
	add constraint Alquileres_Clientes
	foreign key (DNI) references Clientes(DNI);
	
alter table Alquileres
	add constraint Alquileres_Del_Recogidas
	foreign key (ID_delegacion_recogida) references Delegaciones(ID_delegacion);
	
alter table Alquileres
	add constraint Alquileres_Del_Entregas
	foreign key (ID_delegacion_entrega) references Delegaciones(ID_delegacion);
	
