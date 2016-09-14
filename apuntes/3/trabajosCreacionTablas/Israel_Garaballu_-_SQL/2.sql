insert into clientes(nombre_cliente,apellido_cliente,dni_cliente,edad_cliente,genero_cliente)
values('Pedro','Martínez Martínez','11111111A',30,'H');

insert into coches(marca,modelo,color,matricula,bastidor,categoria)
values('Mercedes','Clase B','Rojo','1234ABC','56789J','Prest');

insert into acabados(bastidor,automatico)
values('56789J',1);

insert into alquiler(cod_alquiler,bastidor,dni_cliente,fecha_recogida,fecha_devolucion,delegacion_recogida,km_inicial,km_final,precio)
values('000001','56789J','11111111A',to_date('01/01/2012', 'dd/MM/YYYY'),to_date('01/02/2013', 'dd/MM/YYYY'),'Madrid',000000,000200,95);

---------------------------------------------------------------------------

insert into coches(marca,modelo,color,matricula,bastidor,categoria)
values('Renault','Fluenze','Rojo','1111ABC','16289B','Advance');

insert into acabados(bastidor,navegador,bluetooth)
values('16289B',1,1);

insert into alquiler(cod_alquiler,bastidor,dni_cliente,fecha_recogida,fecha_devolucion,delegacion_recogida,km_inicial,km_final,precio)
values('000002','16289B','11111111A',to_date('01/03/2012', 'dd/MM/YYYY'),to_date('01/04/2013', 'dd/MM/YYYY'),'Barcelona',000000,000100,120);

---------------------------------------------------------------------------

insert into clientes(nombre_cliente,apellido_cliente,dni_cliente,edad_cliente,genero_cliente)
values('Juan','Pérez Pérez','2222222B',25,'H');

insert into coches(marca,modelo,color,matricula,bastidor,categoria)
values('Renault','Kangoo','Azul','4321ABC','93759R','Advance');

insert into acabados(bastidor,bluetooth)
values('93759R',1);

insert into alquiler(cod_alquiler,bastidor,dni_cliente,fecha_recogida,fecha_devolucion,delegacion_recogida,delegacion_devolucion,km_inicial,km_final,descuento,precio)
values('000003','93759R','2222222B',to_date('01/03/2012', 'dd/MM/YYYY'),to_date('01/04/2013', 'dd/MM/YYYY'),'Madrid','Sevilla',000000,000150,5,120);

---------------------------------------------------------------------------

insert into clientes(nombre_cliente,apellido_cliente,dni_cliente,edad_cliente,genero_cliente)
values('Manolo','Bombo Bombo','33333333C',33,'H');

insert into coches(marca,modelo,color,matricula,bastidor,categoria)
values('Renault','Modus','Blanco','8370CDE','06381M','Advance');

insert into acabados(bastidor,bluetooth)
values('06381M',1);

insert into alquiler(cod_alquiler,bastidor,dni_cliente,fecha_recogida,delegacion_recogida,km_inicial,precio)
values('000004','06381M','33333333C',to_date('01/03/2013', 'dd/MM/YYYY'),'Barcelona',000000,120);