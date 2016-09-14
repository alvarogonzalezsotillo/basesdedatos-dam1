
--introducimos los datos de los clientes,los campos no detallados se rellenan a gusto del alumno:--


insert into clientes(dni, nombre, apellidos, edad, genero) values('53568349s', 'Pedro', 'Martinez Martinez', 29, 'varon');

insert into clientes(dni, nombre, apellidos, edad, genero) values('56578459a', 'Juan', 'Perez Perez', 28, 'varon');

insert into clientes(dni, nombre, apellidos, edad, genero) values('93572359c', 'Manolo', 'Bombo Bombo', 30, 'varon');


--datos de los coches--

insert into coches(num_bastidor, marca, modelo, color, matricula, categoria) values('00001a', 'Mercedes', 'Clase B', 'Negro', '1234ABC', 'Advance'); 

insert into coches(num_bastidor, marca, modelo, color, matricula, categoria) values('00002b', 'Renault', 'Fluenze', 'Blanco', '1111ABC', 'Prestige');

insert into coches(num_bastidor, marca, modelo, color, matricula, categoria) values('00003c', 'Renault', 'Kangoo', 'Amarillo', '4321ABC', 'Prestige');

insert into coches(num_bastidor, marca, modelo, color, matricula, categoria) values('00004d', 'Renault', 'Modus', 'Rosa', '6543BCD', 'Functional');




 ----introduzco los tipos de categorias y sus precios(sino no podremos insertar datos en los coches)!!----

insert into categorias(categoria, precio) values('Functional', 220);

insert into categorias(categoria, precio) values('Advance', 120);

insert into categorias(categoria, precio) values('Prestige', 95);
----------------------------------------------------------------------------------------


--introducimos los datos en la tabla de acabados---------------------------------------

insert into acabados(cod_acabado, tipo_acabado) values(1,'aire acondicionado');

insert into acabados(cod_acabado, tipo_acabado) values(2, 'mp3');

insert into acabados(cod_acabado, tipo_acabado) values(3, 'climatizador');

insert into acabados(cod_acabado, tipo_acabado) values(4, 'navegador');

insert into acabados(cod_acabado, tipo_acabado) values(5, 'techo solar');

insert into acabados(cod_acabado, tipo_acabado) values(6, 'bluetooth');

insert into acabados(cod_acabado, tipo_acabado) values(7, 'cambio automatico');



--introducimos los datos en la relacion acabados_coches----------------



insert into acabados_coches(num_bastidor, cod_acabado) values('00001a', 1);

insert into acabados_coches(num_bastidor, cod_acabado) values('00004d', 3);

insert into acabados_coches(num_bastidor, cod_acabado) values('00004d', 4);

insert into acabados_coches(num_bastidor, cod_acabado) values('00002b', 6);

insert into acabados_coches(num_bastidor,cod_acabado) values('00003c', 7);







--introducimos los datos en la tabla alquiler------------------

insert into alquiler(id_alquiler, deleg_recogida, deleg_devolucion, km_iniciales, km_finales, fech_inicio, fech_fin, descuento, num_bastidor) 
		values(03, 'Madrid', 'Sevilla', 2400, 3000, to_date('01/03/2012','dd/MM/YYYY'), to_date('01/04/2013','dd/MM/YYYY'), 5, '00003c');


insert into alquiler(id_alquiler, deleg_recogida, deleg_devolucion, km_iniciales, km_finales, fech_inicio, fech_fin, num_bastidor) 
		values(01, 'Madrid', 'Madrid', 20000, 20200, to_date('01/01/2012','dd/MM/YYYY'), to_date('01/02/2013','dd/MM/YYYY'), '00001a');

insert into alquiler(id_alquiler, deleg_recogida, deleg_devolucion, km_iniciales, km_finales, fech_inicio, fech_fin, num_bastidor) 
		values(02, 'Madrid', 'Barcelona', 1900, 2000, to_date('01/03/2012','dd/MM/YYYY'), to_date('01/04/2013','dd/MM/YYYY'), '00002b');




--insertamos datos en la tabla alquiler_clientes-------------

insert into alquiler_clientes(id_alquiler, dni) values (01, '53568349s');

insert into alquiler_clientes(id_alquiler, dni) values (02, '53568349s');

insert into alquiler_clientes(id_alquiler, dni) values (03, '56578459a');

insert into alquiler_clientes(id_alquiler, dni) values (04, '93572359c');