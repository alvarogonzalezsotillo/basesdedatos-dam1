-- Mecanización de los nuevos datos --

insert into	gcolor		VALUES('KUGJCPQML57463894' , 'rojo' , 'verde' , to_date('01_01_2011' , 'dd/MM/YYYY') , to_date('01_06_2011','dd/MM/YYYY'));

insert into revision		VALUES('HDKEWLAQP12458357' , '10000' , '75000');
insert into revision		VALUES('LQNZHAIEP52364799' , '10058' , '30000');

insert into revision		VALUES('KUGJCPQML57463894' , '100000' , '80000');

-- Las fechas de revisión sin saber estableces el default no puedo rellenarlas en la BBDD --
-- insert into	itv				VALUES('HDKEWLAQP12458357' , to_date('') , to_date(''));
-- insert into	itv				VALUES('LQNZHAIEP52364799' , to_date('01_02_2016','dd/MM/YYYY') , to_date('01_02_2012','dd/MM/YYYY'));
-- insert into	itv				VALUES('XLQOSIREO88731494' , to_date('') , to_date(''));



insert into categorias values ('Grand Class' , 550);

-- PODRIA SER ASI:
-- update coches categoria where num_bastidor = 'HDKEWLAQP12458357'; --