


insert into categorias
values('Functional');

insert into categorias
values('Advance');

insert into categorias
values('Prestige');




insert into cliente(nombre,apellidos,dni,edad,genero)
values('Pedro','Martinez Martinez','00000001A',22,'V');

insert into coche(marca,modelo,color,matricula,bastidor,categoria)
values('Mercedes','Clase B','rojo','1234ABC',101,'Prestige');


insert into acabado (aire_acondicionado,climatizador,navegador,bluetooth,mp3,cambio_automatico,techo_solar,bastidor,id_acabado)
values('N','S','S','N','N','S','N',101,1111);

insert into alquila(id_alquiler,km_inicio,km_final,fecha_inicio,fecha_final,descuento,recoje,devuelve,dni)
values(1,80000,80200,TO_DATE('01/10/2012 11:00','dd/MM/YYYY hh24:mi'),TO_DATE('15/10/2012 08:00','dd/MM/YYYY hh24:mi') ,0,'Valencia','Valencia','00000001A');

insert into se(id_alquiler,bastidor)
values(1,101);




insert into coche(marca,modelo,color,matricula,bastidor,categoria)
values('Renault','Fluenze','azul','1111ABC',102,'Advance');

insert into acabado(aire_acondicionado,climatizador,navegador,bluetooth,mp3,cambio_automatico,techo_solar,bastidor,id_acabado)
values('N','S','S','S','N','N','N',102,2222);

insert into alquila(id_alquiler,km_inicio,km_final,fecha_inicio,fecha_final,descuento,recoje,devuelve,dni)
values(2,60000,60100,TO_DATE('22/11/2012 13:00','dd/MM/YYYY hh24:mi'),TO_DATE('01/12/2012 22:00','dd/MM/YYYY hh24:mi'),0,'Valencia','Madrid','00000001A');

insert into se(id_alquiler,bastidor)
values(2,102);





insert into cliente(nombre,apellidos,dni,edad,genero)
values('Juan','Perez Perez','00000003A',37,'V');

insert into coche(marca,modelo,color,matricula,bastidor,categoria)
values('Renault','Kangoo','Blanco','4321ABC',103,'Advance');

insert into acabado  (aire_acondicionado,climatizador,navegador,bluetooth,mp3,cambio_automatico,techo_solar,bastidor,id_acabado)
values('N','N','S','S','N','N','N',103,3333);

insert into alquila(id_alquiler,km_inicio,km_final,fecha_inicio,fecha_final,descuento,recoje,devuelve,dni)
values(3,100000,101000,TO_DATE('14/09/2012 13:00','dd/MM/YYYY hh24:mi'),TO_DATE('30/09/2012 19:00','dd/MM/YYYY hh24:mi'),500,'Madrid','Sevilla','00000003A');

insert into se(id_alquiler,bastidor)
values(3,103);



insert into cliente(nombre,apellidos,dni,edad,genero)
values('Manolo','Bombo Bombo','00000004A',42,'V');

insert into coche(marca,modelo,color,matricula,bastidor,categoria)
values('Renault','Modus','Verde','1001ABC',104,'Advance');

insert into acabado(aire_acondicionado,climatizador,navegador,bluetooth,mp3,cambio_automatico,techo_solar,bastidor,id_acabado)
values('N','N','S','S','N','S','S',104,4444);

insert into alquila(id_alquiler,km_inicio,km_final,fecha_inicio,fecha_final,descuento,recoje,devuelve,dni)
values(4,5000,null,TO_DATE('24/12/2012 08:00','dd/MM/YYYY hh24:mi'),null,0,'Madrid',null,'00000004A');


insert into se(id_alquiler,bastidor)
values(4,104);
