--Introduzco los datos del cambio de color del coche con matrícula 1234ABC. Uso el n_bastidor porque la matrícula puede cambiar en algún momento.

insert into colores(n_bastidor, color, fecha_inicio, fecha_fin) values('1A', 'rojo', to_date('01/01/2011','dd/MM/YYYY'), to_date('01/06/2011','dd/MM/YYYY'));

insert into colores(n_bastidor, color, fecha_inicio) values('1A', 'verde', to_date('01/06/2011','dd/MM/YYYY'));



--Introduzco en la tabla mantenimientos los datos de los coches Renault

insert into mantenimientos(n_bastidor, kilometros, kilometros_anterior) values('4C', 30000, 15000);

insert into mantenimientos(n_bastidor, kilometros, kilometros_anterior) values('7D', 45000, 30000);



--Introduzco en la tabla mantenimientos los datos del Mercedes.

insert into mantenimientos(n_bastidor, kilometros, kilometros_anterior) values('1A', 40000, 20000);



--Introduzco los datos en la tabla itv, solo de los coches que pone cuando fueron comprados.

insert into itv(n_bastidor, fecha_maxima) values('1A', to_date('01/01/2016','dd/MM/YYYY'));

insert into itv(n_bastidor, fecha_maxima) values('7D', to_date('01/02/2016','dd/MM/YYYY'));


--Introduzco en la tabla acabados_coches el nuevo acabado.

insert into acabados_coches(n_bastidor, id_acabado) values('4C', 8);