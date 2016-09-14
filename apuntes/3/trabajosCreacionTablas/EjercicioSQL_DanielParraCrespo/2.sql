
--Meto los datos de las tablas


--Pedro Martinez(mercedes)

insert into clientes(nombre, apellidos, dni, edad, genero)
values('Pedro', 'Martinez Martinez', '123456789R', 23, 'hombre');

insert into coches(nbastidor, matricula, marca, modelo, color)
values('1234567890abcdefg', '1234ABC', 'mercedes', 'clase B', 'verde');

insert into alquiler(nalquiler, dni, km_inicial, km_final, nbastidor, delegacion_recogida, fecha_recogida, delegacion_devolucion, fecha_devolucion, precio, descuento)
values(1234, '123456789R', 500, 700, '1234567890abcdefg', 'Madrid', to_date('01/01/2012', 'dd/MM/YYYY'), 'Barcelona', to_date('01/02/2013', 'dd/MM/YYYY'), 200, 0);

insert into acabados(nbastidor, aire_acondicionado, climatizador, navegador, bluetooth, mp3, cambio_automatico, techo_solar)
values('1234567890abcdefg', 0, 0, 0, 0, 0, 0, 1);


--Pedro Martinez(renault)

insert into coches(nbastidor, matricula, marca, modelo, color)
values('3564fe34hg984bf2g', '1111ABC', 'renault', 'fluenze', 'gris');

insert into alquiler(nalquiler, dni, km_inicial, km_final, nbastidor, delegacion_recogida, fecha_recogida, delegacion_devolucion, fecha_devolucion, precio, descuento)
values(5678, '123456789R', 100, 200, '3564fe34hg984bf2g','Madrid', to_date('01/03/2012', 'dd/MM/YYYY'), 'Madrid', to_date('01/04/2013', 'dd/MM/YYYY'), 200, 0);

insert into acabados(nbastidor, aire_acondicionado, climatizador, navegador, bluetooth, mp3, cambio_automatico, techo_solar)
values('3564fe34hg984bf2g', 0, 0, 1, 0, 0, 0, 0);


--Juan Perez

insert into clientes(nombre, apellidos, dni, edad, genero)
values('Juan', 'Perez Perez', '09037654R', 33, 'hombre');

insert into coches(nbastidor, matricula, marca, modelo, color)
values('123456789012345er', '4321ABC', 'Renault', 'Kangoo', 'Amarillo');

insert into alquiler(nalquiler, dni, km_inicial, km_final, nbastidor, delegacion_recogida, fecha_recogida, delegacion_devolucion, fecha_devolucion, precio, descuento)
values(2222, '09037654R', 1232, 5670, '123456789012345er', 'Madrid', to_date('01/03/2012', 'dd/MM/YYYY'), 'Sevilla', to_date('01/04/2013', 'dd/MM/YYYY'), 120, 5);

insert into acabados(nbastidor, aire_acondicionado, climatizador, navegador, bluetooth, mp3, cambio_automatico, techo_solar)
values('123456789012345er', 0, 0, 0, 1, 0, 0, 0);



--Manolo Bombo

insert into clientes(nombre, apellidos, dni, edad, genero)
values('Manolo', 'Bombo Bombo', '09456034a', 11, 'hombre');

insert into coches(nbastidor, matricula, marca, modelo, color)
values('09876543210987654', '1414DPC', 'Renault', 'Modus', 'Azul');

insert into alquiler(nalquiler, dni, km_inicial, km_final, nbastidor, delegacion_recogida, fecha_recogida, precio, descuento)
values(1243, '09456034a', 3500, 3950, '09876543210987654', 'Barcelona', to_date('01/03/2013', 'dd/MM/YYYY'), 120, 0);

insert into acabados(nbastidor, aire_acondicionado, climatizador, navegador, bluetooth, mp3, cambio_automatico, techo_solar)
values('09876543210987654', 0, 0, 0, 1, 0, 0, 0);