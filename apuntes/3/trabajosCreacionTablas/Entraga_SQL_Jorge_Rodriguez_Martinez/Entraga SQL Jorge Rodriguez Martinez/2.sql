
insert into cliente values('001122334z','Pedro','Martinez Martinez','88','varon');
insert into cliente values ('331122114a','Juan','Perez Perez','18','varon');
insert into cliente values ('992291932s','Manolo','Bombo Bombo','27','varon');

insert into categorias values('Functional', 220);
insert into categorias values('Advance', 120);
insert into categorias values('Prestige', 95);

insert into coches values('KUGJCPQML57463894' , 'Mercedes' , 'Clase B', 'Verde', 'Prestige' , '1234ABC'); 
insert into coches values('HDKEWLAQP12458357' , 'Renault' , 'Fluenze' , 'Negro' , 'Advance' , '1111ABC');
insert into coches values('LQNZHAIEP52364799' , 'Renault' , 'Kangoo' , 'Blanco' , 'Advance' , '4321ABC');
insert into coches values('XLQOSIREO88731494' , 'Renault' , 'Modus' , 'Negro' , 'Functional' , '4412DBC');

insert into acabado values (00000 , 'Aire Acondicionado');
insert into acabado values (00001 , 'Bluetooth');
insert into acabado values (00002 , 'Cambio Automatico');
insert into acabado values (00003 , 'Climatizador');
insert into acabado values (00004 , 'Mp3');
insert into acabado values (00005 , 'Navegador');
insert into acabado values (00006 , 'Techo Solar');

insert into acabado_coche values ('KUGJCPQML57463894' , 000002);
insert into acabado_coche values ('HDKEWLAQP12458357' , 000001);
insert into acabado_coche values ('HDKEWLAQP12458357' , 000050);
insert into acabado_coche values ('LQNZHAIEP52364799' , 000001);
insert into acabado_coche values ('XLQOSIREO88731494' , 000001);

insert into alquiler values ('00000' , 'KUGJCPQML57463894' , 'Jaen' , 'Bilbao' , '80000' , '80200' , to_date('01_01_2012','dd/MM/YYYY') , to_date('01_02_2013','dd/MM/YYYY'), '0');
insert into alquiler values ('00001' , 'HDKEWLAQP12458357' , 'Cordoba' , 'Caceres' , '12240' , '12340' , to_date('01_03_2012','dd/MM/YYYY') , to_date('01_04_2013','dd/MM/YYYY') , '0');
insert into alquiler values ('00002' , 'LQNZHAIEP52364799' , 'Madrid' , 'Sevilla' , '09348' , '34942' , to_date('01_03_2012','dd/MM/YYYY') , to_date('01_04_2013','dd/MM/YYYY') , '5');
-- insert into alquiler(id_alquiler , num_bastidor , recogida , km_iniciales , fecha_inicio , descuento) --
				  -- values ('00003' , 'XLQOSIREO88731494' , 'Barcelona' , '2931' , to_date('01_03_2013','dd/MM/YYYY') , '0'); -- No logro hacer que funcione.
				  
insert into alquileres values ('001122334z' , '00000');
insert into alquileres values ('001122334z' , '00001');
insert into alquileres values ('331122114a' , '00002');
-- insert into alquileres values ('992291932s' , '00003'); -- Línea asociada a lo que sería el tercer alquiler. --