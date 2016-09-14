--Primero introduzco los tipos de categorias y sus precios

insert into categorias(tipo_categoria, precio) values('Functional', 220);

insert into categorias(tipo_categoria, precio) values('Advance', 120);

insert into categorias(tipo_categoria, precio) values('Prestige', 95);



--Ahora introduzco los tipos de acabados que hay

insert into acabados(id_acabado, tipo_acabado) values(1, 'aire acondicionado');

insert into acabados(id_acabado, tipo_acabado) values(2, 'climatizador');

insert into acabados(id_acabado, tipo_acabado) values(3, 'navegador');

insert into acabados(id_acabado, tipo_acabado) values(4, 'bluetooth');

insert into acabados(id_acabado, tipo_acabado) values(5, 'mp3');

insert into acabados(id_acabado, tipo_acabado) values(6, 'cambio automatico');

insert into acabados(id_acabado, tipo_acabado) values(7, 'techo solar');



--Ahora introduzco los datos de los coches que se alquilan

insert into coches(n_bastidor, marca, modelo, color_carroceria, matricula, tipo_categoria) values('1A', 'Mercedes', 'Clase B', 'verde', '1234ABC', 'Prestige'); 

insert into coches(n_bastidor, marca, modelo, color_carroceria, matricula, tipo_categoria) values('4C', 'Renault', 'Fluenze', 'rojo', '1111ABC', 'Advance');

insert into coches(n_bastidor, marca, modelo, color_carroceria, matricula, tipo_categoria) values('7D', 'Renault', 'Kangoo', 'blanco', '4321ABC', 'Advance');

insert into coches(n_bastidor, marca, modelo, color_carroceria, matricula, tipo_categoria) values('5H', 'Renault', 'Modus', 'morado', '6543BCD', 'Advance');



--Relleno la tabla acabados_coches con los datos de cada coche

insert into acabados_coches(n_bastidor, id_acabado) values('1A', 6);

insert into acabados_coches(n_bastidor, id_acabado) values('4C', 3);

insert into acabados_coches(n_bastidor, id_acabado) values('4C', 4);

insert into acabados_coches(n_bastidor, id_acabado) values('7D', 4);

insert into acabados_coches(n_bastidor, id_acabado) values('5H', 4);



--Introduzco los datos de los clientes

insert into clientes(dni, nombre, apellidos, edad, genero) values('00000001A', 'Pedro', 'Martinez Martinez', 31, 'hombre');

insert into clientes(dni, nombre, apellidos, edad, genero) values('00000002B', 'Juan', 'Perez Perez', 27, 'hombre');

insert into clientes(dni, nombre, apellidos, edad, genero) values('00000003C', 'Manolo', 'Bombo Bombo', 43, 'hombre');



--Relleno la tabla alquileres

insert into alquileres(id_alquiler, del_recogida, del_devolucion, km_iniciales, km_finales, fecha_inicio, fecha_fin, n_bastidor) 
		values(1, 'Jaen', 'Salamanca', 18000, 18200, to_date('01/01/2012','dd/MM/YYYY'), to_date('01/02/2013','dd/MM/YYYY'), '1A');

insert into alquileres(id_alquiler, del_recogida, del_devolucion, km_iniciales, km_finales, fecha_inicio, fecha_fin, n_bastidor) 
		values(2, 'Barcelona', 'Zaragoza', 20000, 20100, to_date('01/03/2012','dd/MM/YYYY'), to_date('01/04/2013','dd/MM/YYYY'), '4C');

insert into alquileres(id_alquiler, del_recogida, del_devolucion, km_iniciales, km_finales, fecha_inicio, fecha_fin, descuento, n_bastidor) 
		values(3, 'Madrid', 'Sevilla', 35000, 35600, to_date('01/03/2012','dd/MM/YYYY'), to_date('01/04/2013','dd/MM/YYYY'), 5, '7D');

insert into alquileres(id_alquiler, del_recogida, km_iniciales, fecha_inicio, n_bastidor)
		values(4, 'Barcelona', 17000, to_date('01/03/2012','dd/MM/YYYY'), '5H');



--Relleno la tabla alquileres_clientes

insert into alquileres_clientes(id_alquiler, dni) values (1, '00000001A');

insert into alquileres_clientes(id_alquiler, dni) values (2, '00000001A');

insert into alquileres_clientes(id_alquiler, dni) values (3, '00000002B');

insert into alquileres_clientes(id_alquiler, dni) values (4, '00000003C');