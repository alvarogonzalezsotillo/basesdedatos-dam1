-- Archivo 4.sql creado por Raquel Mendez Santiago y Rafael Sanchez Ocasar

--Introduciendo datos del apartado 4, necesitamos saber la fecha de compra del coche, asi que 
--modificamos la tabla coches del apartado 1 añadiendo el campo fecha_compra
alter table Coches
	add fecha_compra date;

-- Punto 1: El coche con matricula 1234ABC tiene el numero de bastidor MMaa1245689314798
-- creamos la informacion de dicho coche

-- añadimos fecha de compra del coche.
update Coches
	set fecha_compra=to_date('01/01/2011','dd/MM/YYYY')
	where n_bastidor='MMaa1245689314798';
	
-- añadimos fecha de primer color
Insert into Pinturas (ID_pintura, fecha, color, n_bastidor)
	values (12345,to_date('01/01/2011','dd/MM/YYYY'),'rojo','MMaa1245689314798');
	
-- añadimos fecha de segundo color, al ser la mas actual la aplicacion entendera que es el color actual
Insert into Pinturas (ID_pintura, fecha, color, n_bastidor)
	values (12346,to_date('01/06/2011','dd/MM/YYYY'),'verde','MMaa1245689314798');
	
-- Punto 2: Introducimos los datos de revision del coche con matricula 1111ABC.
--Sera la aplicacion la que se encargue de mirar los kilometros y segun estos hacer o no revision
--Introducimos los datos de revision del coche con matricula 4321ABC y la fecha de compra

Insert into Mantenimiento(ID_mantenimiento ,kms ,fecha_realizacion, n_bastidor)
	values(346891, 15000, to_date('01/03/2012','dd/MM/YYYY'),'HHee8578537373928');
	
--añadimos la fecha de compra del coche con matricula 4231ABC 
update Coches
	set fecha_compra=to_date('01/02/2012','dd/MM/YYYY')
	where n_bastidor='YTfd8458484849256';
	
--añadimos las revisiones del coche con matricula 4321ABC
Insert into Mantenimiento(ID_mantenimiento , kms ,fecha_realizacion, n_bastidor)
	values(336861,15000,to_date('01/04/2012','dd/MM/YYYY'),'YTfd8458484849256');
	
Insert into Mantenimiento(ID_mantenimiento , kms ,fecha_realizacion, n_bastidor)
	values(347851,30000,to_date('01/10/2012','dd/MM/YYYY'),'YTfd8458484849256');

--Punto 3: revision del coche con matricula 1234ABC. La fecha de compra esta en conflicto con el primero,
--mantenemos la primera fecha de compra.Sera la aplicacion la que se encargue de mirar los kilometros y 
--avisar si es el momento de la revision.

Insert into Mantenimiento(ID_mantenimiento , kms ,fecha_realizacion, n_bastidor)
	values(475861,20000,to_date('01/04/2012','dd/MM/YYYY'),'YTfd8458484849256');

--Punto 4: la aplicacion determinara a partir de la fecha de compra la realizacion de ITV.
--Para ello vamos a añadir la fecha de compra a todos los vehículos.
-- añadimos fecha de compra del coche.
update Coches
	set fecha_compra=to_date('07/05/2010','dd/MM/YYYY')
	where n_bastidor='UTlp7557575848939';
	
update Coches
	set fecha_compra=to_date('04/03/2011','dd/MM/YYYY')
	where n_bastidor='HHee8578537373928';