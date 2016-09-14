

--Introduzco los datos en la tabla itv,para hacer la revision dentro de 4 años------

insert into itv(num_bastidor, fech_limite) values('00001a', to_date('01/01/2016','dd/MM/YYYY'));

insert into itv(num_bastidor, fech_limite) values('00003c', to_date('01/02/2016','dd/MM/YYYY'));


--añadimos los 2 mantenimientos----

insert into mantenimiento(num_bastidor, kilometros, kilometros_anterior) values('00002b', 30000, 15000);

insert into mantenimiento(num_bastidor, kilometros, kilometros_anterior) values('00003c', 45000, 30000);

insert into mantenimiento(num_bastidor, kilometros, kilometros_anterior) values('00001a', 40000, 20000);

insert into colores(num_bastidor, color, fech_inicio) values('00001a', 'Verde', to_date('01/06/2011','dd/MM/YYYY'));

insert into colores(num_bastidor, color, fech_inicio, fech_fin) values('00001a', 'Rojo', to_date('01/01/2011','dd/MM/YYYY'), to_date('01/06/2011','dd/MM/YYYY'));



--añadimos el nuevo complemento al coche------------------

insert into acabados_coches(num_bastidor,cod_acabado) values('00002b', 8);