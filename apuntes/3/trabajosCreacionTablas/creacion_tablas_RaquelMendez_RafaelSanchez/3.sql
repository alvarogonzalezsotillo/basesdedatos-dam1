-- Archivo 3.sql creado por Raquel Mendez Santiago y Rafael Sanchez Ocasar

-- creamos una tabla que contenga los colores relacionados con la fecha,
-- se elimina el atributo color de la tabla coche y sera la aplicacion
-- la que determine el color original como el ultimo color por medio
-- de las fechas

-- creamos la tabla pinturas, ningun valor sera null
create table Pinturas (ID_pintura numeric(6), fecha date not null, color varchar2(25) not null, n_bastidor varchar2(20) not null);

-- asignamos la PK al ID porque no podemos asegurar que sean absolutamente unicos los valores
alter table Pinturas
	add constraint Pinturas_PK
	primary key(ID_pintura);

-- asignamos las FK que apuntan a coches
alter table Pinturas
	add constraint Pinturas_Coches
	foreign key (n_bastidor) references Coches(n_bastidor);
	
-- una vez creada la tabla eliminamos el atributo de la tabla coche
alter table Coches drop column color;

-- en cuanto a las revisiones creamos dos nuevas tablas como la anterior, pero que contenga
-- el tipo de revision que se hace ITV por un lado y mantenimiento por el otro, sera la 
-- aplicacion la que se encargue de seguir la periodicidad de las pruebas.

-- creamos la tabla ITV que guardara el historial de esta revision por fechas
create table Itv (ID_itv numeric(6), fecha date not null, n_bastidor varchar2(20) not null);

-- asignamos la PK al ID igual que en el caso anterior
alter table Itv
	add constraint Itv_PK
	primary key(ID_Itv);
	
-- asignamos las FK que apuntan a coches
alter table Itv
	add constraint Itv_Coches
	foreign key (n_bastidor) references Coches(n_bastidor);
	
-- creamos la tabla mantenimiento que guardara el historial de esta revision por kilometraje y fecha de realizacion
create table Mantenimiento (ID_mantenimiento numeric(6), kms numeric(6) not null, fecha_realizacion date, n_bastidor varchar2(20) not null);

-- asignamos la PK al ID igual que en el caso anterior
alter table Mantenimiento
	add constraint Mantenimiento_PK
	primary key(ID_mantenimiento);
	
-- asignamos las FK que apuntan a coches
alter table Mantenimiento
	add constraint Mantenimiento_Coches
	foreign key (n_bastidor) references Coches(n_bastidor);

