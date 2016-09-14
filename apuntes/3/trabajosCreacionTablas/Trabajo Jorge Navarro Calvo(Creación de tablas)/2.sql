--Pedro Martínez Martínez alquiló un Mercedes Clase B verde con Matrícula 1234ABC el 1-1-12 al 1-2-13. Tenía cambio automático, y realizó 200 km.
--Pedro Martínez Martínez alquiló un Renault Fluenze con Matrícula 1111ABC el 1-3-12 al 1-4-13. Tenía navegador, y realizó 100 km.
--Los precios por día de las categorías Functional, Advance y Prestige son de 200€, 120€ y 95€, respectivamente
--Los coches con cambio automático o navegador se están clasificando como categoría Prestige. Los que tienen bluetooth, en la categoría Advance.
--Juan Pérez Pérez alquiló un Renault Kangoo con Matrícula 4321ABC el 1-3-12 al 1-4-13. Tenía bluetooth, y se le aplicó un descuento del 5%. Recogió el coche en Madrid, y lo devolvió en Sevilla.

insert into clientes (nombre,apellidos,dni,edad,genero) values ('Pedro','Martinez Martinez','09045484s','26','Masculino');
insert into coches (marca, modelo, color, matricula, n_bastidor, tipo_categorias) values ('Mercedes','Clase B','Verde','1234ABC','54sd','Prestige');

insert into acabados(clase_acabado) values ('aire_acondicionado');
insert into acabados(clase_acabado) values ('climatizador');
insert into acabados(clase_acabado) values ('navegador');
insert into acabados(clase_acabado) values ('bluetooth');
insert into acabados(clase_acabado) values ('mp3');
insert into acabados(clase_acabado) values ('cambio_automatico');
insert into acabados(clase_acabado) values ('techo_solar');

insert into categorias(tipo_categorias,precio) values ('Functional','200');
insert into categorias(tipo_categorias,precio) values ('Advance','120');
insert into categorias(tipo_categorias,precio) values ('Prestige','95');

insert into alquileres(lugar_recogida,lugar_dejar,km_inicial,km_final,fecha_fin,fecha_inicio,dni,id_alquiler) values ('Local','Local','12300','12500',to_date('01/01/2012','dd/MM/YYYY'),to_date('01/02/2013','dd/MM/YYYY'),'09045484s',1);

insert into alquileres(lugar_recogida,lugar_dejar,km_inicial,km_final,fecha_fin,fecha_inicio,dni,id_alquiler) values ('Local','Local','15300','15400',to_date('01/03/2012','dd/MM/YYYY'),to_date('01/04/2013','dd/MM/YYYY'),'09045484s',2);
insert into coches (marca, modelo, color, matricula, n_bastidor, tipo_categorias) values ('Renault','Fluence','Verde','1111ABC','84td','Prestige');

insert into clientes (nombre,apellidos,dni,edad,genero) values ('Juan','Perez Perez','78044874s','29','Masculino');
insert into coches (marca, modelo, color, matricula, n_bastidor, tipo_categorias) values ('Renault','Kangoo','Rojo','4321ABC','7257d','Advance');
insert into alquileres(lugar_recogida,lugar_dejar,km_inicial,km_final,fecha_fin,fecha_inicio,dni,id_alquiler,descuento) values ('Madrid','Sevilla','11400','14100',to_date('01/03/2012','dd/MM/YYYY'),to_date('01/08/2013','dd/MM/YYYY'),'78044874s',3,5);


insert into clientes (nombre,apellidos,dni,edad,genero) values ('Manolo','Bombo Bombo','45454784s','54','Masculino');
insert into coches (marca, modelo, color, matricula, n_bastidor, tipo_categorias) values ('Renault','Modus','Azul Cielo','4545asC','545fdd','Advance');
insert into alquileres(lugar_recogida,lugar_dejar,km_inicial,fecha_inicio,dni,id_alquiler) values ('Granada','Alcala de Henares','11400',to_date('01/03/2013','dd/MM/YYYY'),'45454784s',4);


insert into coches_acabados( n_bastidor,clase_acabado) values ('54sd','cambio_automatico');
		            
insert into alquileres_clientes( dni,id_alquiler) values ('09045484s',1);

insert into coches_alquileres( n_bastidor,id_alquiler) values ('54sd',1);


insert into coches_acabados( n_bastidor,clase_acabado) values ('84td','navegador');
		            
insert into alquileres_clientes( dni,id_alquiler) values ('09045484s',2);

insert into coches_alquileres( n_bastidor,id_alquiler) values ('84td',2);


insert into coches_acabados( n_bastidor,clase_acabado) values ('7257d','bluetooth');
		            
insert into alquileres_clientes( dni,id_alquiler) values ('78044874s',3);

insert into coches_alquileres( n_bastidor,id_alquiler) values ('7257d',3);



insert into coches_acabados( n_bastidor,clase_acabado) values ('545fdd','bluetooth');
		            
insert into alquileres_clientes( dni,id_alquiler) values ('45454784s',4);

insert into coches_alquileres( n_bastidor,id_alquiler) values ('545fdd',4);
