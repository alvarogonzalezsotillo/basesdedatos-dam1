
--introduzco los datos del combio de pintura
insert into pinturas(nbastidor, pintura_inicial, fecha_inicio_pintura, pintura_final, fecha_final_pintura)
values('1234567890abcdefg', 'rojo', to_date('01/01/2011', 'dd/MM/YYYY'), 'verde', to_date('01/06/2011', 'dd/MM/YYYY'));


--introduzco los datos de los mantenimientos
insert into revisiones(nbastidor, tipo, numero_revision, anterior_revision, km_revision)
values('3564fe34hg984bf2g', 'mantenimiento', 1, to_date('01/03/2012', 'dd/MM/YYYY'), 1500);

insert into revisiones(nbastidor, tipo, numero_revision, anterior_revision, km_revision)
values('123456789012345er', 'mantenimiento', 1, to_date('01/04/2012', 'dd/MM/YYYY'), 15000);

insert into revisiones(nbastidor, tipo, numero_revision, anterior_revision, km_revision)
values('123456789012345er', 'mantenimiento', 2, to_date('01/10/2012', 'dd/MM/YYYY'), 15000);

insert into revisiones(nbastidor, tipo, numero_revision, anterior_revision, km_revision)
values('1234567890abcdefg', 'mantenimiento', 1, to_date('01/04/2012', 'dd/MM/YYYY'), 20000);


--introduzco los datos de las ITV
insert into revisiones(nbastidor, tipo, numero_revision, siguiente_revision)
values('1234567890abcdefg', 'ITV', 2, to_date('01/01/2015', 'dd/MM/YYYY'));

insert into revisiones(nbastidor, tipo, numero_revision, siguiente_revision)
values('3564fe34hg984bf2g', 'ITV', 2, to_date('04/04/2015', 'dd/MM/YYYY'));

insert into revisiones(nbastidor, tipo, numero_revision, siguiente_revision)
values('123456789012345er', 'ITV', 3, to_date('01/02/2016', 'dd/MM/YYYY'));

insert into revisiones(nbastidor, tipo, numero_revision, siguiente_revision)
values('09876543210987654', 'ITV', 1, to_date('03/05/2016', 'dd/MM/YYYY'));


--introduzco updates para 
update coches set fecha_compra = to_date('01/01/2011', 'dd/MM/YYYY') where nbastidor = '1234567890abcdefg';

update coches set fecha_compra = to_date('01/12/2011', 'dd/MM/YYYY') where nbastidor = '3564fe34hg984bf2g';

update coches set fecha_compra = to_date('01/02/2012', 'dd/MM/YYYY') where nbastidor = '123456789012345er';

update coches set fecha_compra = to_date('01/07/2011', 'dd/MM/YYYY') where nbastidor = '09876543210987654';


--introduzco asiento calefactado
update acabados set asiento_calefaccion = 1 where nbastidor = '3564fe34hg984bf2g';


