
//de esta forma introduzco los tatos del primer alquiler, los apellidos estan unidos con _ por si surgia algun proble y H para referirme a hombre
insert into cliente(nombre, apellidos, dni_nie_pasaporte, edad, genero)
values('Pedro', 'Martinez_Martinez', '1234567D', 42, 'h');

insert into coches( marca, modelo, color_carroceria, matricula, n_bastidor)
values( 'mercedes', 'clase_b', 'verde', '1234abc','123456789123c45b6');

insert into acabado_coches(categoria, cambio_automatico, n_bastidor)
values( 'funcional', 's','123456789123c45b6');

insert into alquiler (delegacion_recogida, delegacion_vuelta, km_inicio, km_final, fecha_salida, fecha_llegada, n_bastidor, dni_nie_pasaporte)
values('madrid', 'madrid', 10000, 10200, to_date('01/01/2012','dd/MM/YYYY'), to_date('01/02/2013','dd/MM/YYYY'), '123456789123c45b6', '1234567D');



insert into coches(marca, modelo, color_carroceria, matricula, n_bastidor)
values( 'renault', 'fluence', 'gris', '1111abc','123456789123c45gg');

insert into acabado_coches(categoria, navegador, n_bastidor)
values('prestige', 's','123456789123c45gg');

insert into alquiler (delegacion_recogida, delegacion_vuelta, km_inicio, km_final, fecha_salida, fecha_llegada, n_bastidor, dni_nie_pasaporte)
values('madrid', 'Guadalajara', 10000, 10100, to_date('01/03/2012','dd/MM/YYYY'), to_date('01/04/2013','dd/MM/YYYY'), '123456789123c45gg', '1234567D');


//el precio se da en el tercer punto del apartado por lo que lo he introducido despues los datos de alquiler anterores de esta manera
update alquiler 
set precio= '2850' 
where n_bastidor='123456789123c45b6';

update alquiler 
set precio= '2850' 
where n_bastidor='123456789123c45gg';

//En este apartado cambio a categoria prestige los acabados con bluetooth, cambio_automatico y navegador
update acabado_coches 
set categoria= 'prestige' 
where bluetooth='s';

update acabado_coches 
set categoria= 'prestige' 
where cambio_automatico='s';

update acabado_coches 
set categoria= 'prestige' 
where navegador='s';

//otros datos a insertar
insert into cliente(nombre, apellidos, dni_nie_pasaporte, edad, genero)
values('Juan', 'perez_perez', '987654N', 37, 'h');

insert into coches( marca, modelo, color_carroceria, matricula, n_bastidor)
values( 'renault', 'rangoo', 'blanco', '4321abc','123456789123c4aaa');

insert into acabado_coches(categoria, bluetooth, n_bastidor)
values('prestige', 's','123456789123c4aaa');

insert into alquiler (delegacion_recogida, delegacion_vuelta, km_inicio, km_final, fecha_salida, fecha_llegada, n_bastidor, dni_nie_pasaporte, precio, descuento)
values('madrid', 'sevilla', 10000, 10600, to_date('01/03/2012','dd/MM/YYYY'), to_date('01/04/2013','dd/MM/YYYY'), '123456789123c4aaa', '987654N', 2800, 5);


//este cliente tiene que devolver el coche por lo que aun nos faltan algunos datos
insert into cliente(nombre, apellidos, dni_nie_pasaporte, edad, genero)
values('Manolo', 'Bombo_Bombo', '1234567P', 55, 'h');

insert into coches(marca, modelo, color_carroceria, matricula, n_bastidor)
values('Renault', 'Modus', 'verde', '1234cde','123456789123c4bbb');

insert into acabado_coches(categoria, bluetooth, n_bastidor)
values( 'prestige', 's','123456789123c4bbb');

insert into alquiler (delegacion_recogida, km_inicio, fecha_salida, n_bastidor, dni_nie_pasaporte)
values('Barcelona', 10000, to_date('01/01/2012','dd/MM/YYYY'), '123456789123c4bbb', '1234567P');






