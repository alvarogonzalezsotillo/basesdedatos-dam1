-- Archivo 2.sql creado por Raquel Mendez Santiago y Rafael Sanchez Ocasar

--creacion de categorias, no tienen FK
--punto 1, 2 y 3
Insert into Categorias(nombre, precio)
	values('Advance',120);
	
--punto 3
Insert into Categorias(nombre, precio)
	values('Funcional',200);
	
Insert into Categorias(nombre, precio)
	values('Prestige',95);
	
--creacion de modelos, no tienen FK
--punto 1
Insert into Modelos(modelo, marca)
	values('Clase B', 'Mercedes');
	
--punto 2
Insert into Modelos(modelo, marca)
	values('Fluenze', 'Renault');
	
--punto 5
Insert into Modelos(modelo, marca)
	values('Kangoo', 'Renault');
	
--punto 6
Insert into Modelos(modelo, marca)
	values('Modus', 'Renault');
	
--creacion de Acabados, no tienen FK
--punto 4: con cambio automatico o navegador (Prestige). bluetooth (Advance)
--punto 1
Insert into Acabados_coches(ID_acabado, aire_acondicionado, climatizador, navegador , bluetooth, 
							mp3 , cambio_automatico)
	values(234567,1,0,0,0,1,1);
	
--punto 2
Insert into Acabados_coches(ID_acabado, aire_acondicionado, climatizador, navegador , bluetooth, 
							mp3 , cambio_automatico)
	values(353765,1,0,1,0,1,0);
	
--punto 5
Insert into Acabados_coches(ID_acabado, aire_acondicionado, climatizador, navegador , bluetooth, 
							mp3 , cambio_automatico)
	values(859039,1,0,0,1,1,0);
	
--punto 6
Insert into Acabados_coches(ID_acabado, aire_acondicionado, climatizador, navegador , bluetooth, 
							mp3 , cambio_automatico)
	values(532069,1,0,0,1,1,0);
	
--creacion de coches, depende de categorias, acabados y modelos
--punto 1
Insert into Coches(n_bastidor,n_matricula, color, nombre_categoria, ID_acabado, modelo)
	values('MMaa1245689314798','1234ABC','verde','Prestige',234567,'Clase B');
	
--punto 2
Insert into Coches(n_bastidor,n_matricula, color, nombre_categoria, ID_acabado, modelo)
	values('HHee8578537373928','1111ABC','negro','Prestige',353765,'Fluenze');
	
--punto 5
Insert into Coches(n_bastidor,n_matricula, color, nombre_categoria, ID_acabado, modelo)
	values('YTfd8458484849256','4321ABC','blanco','Advance',859039,'Kangoo');

--punto 6
Insert into Coches(n_bastidor,n_matricula, color, nombre_categoria, ID_acabado, modelo)
	values('UTlp7557575848939','6427ERT','rojo','Advance',532069,'Modus');
	
--creacion de delegaciones, no tienen FK
--punto 1 y 6
Insert into Delegaciones(ID_delegacion, ciudad)
	values('27234BC','Barcelona');
	
Insert into Delegaciones(ID_delegacion, ciudad)
	values('56823MD','Madrid');

--punto 5
Insert into Delegaciones(ID_delegacion, ciudad)
	values('92384SV','Sevilla');
	
--creacion de clientes, no tienen FK
--punto 1
Insert into Clientes(DNI,nombre,apellidos,edad,genero) 
	values('340576346K','Pedro','Martínez Martínez',43,'V');

--punto 5
Insert into Clientes(DNI,nombre,apellidos,edad,genero) 
	values('90432874K', 'Juan', 'Pérez Pérez', 36, 'V');
	
--punto 6
Insert into Clientes(DNI,nombre,apellidos,edad,genero) 
	values('02534021P','Manolo', 'Bombo Bombo', 65,'V');
	
--ceacion de alquileres, depende de coches, clientes y delegaciones
--punto 1
Insert into Alquileres (fecha_inicio,fecha_fin, km_inicio , km_fin , num_bastidor ,DNI , 
						ID_delegacion_recogida , ID_delegacion_entrega )
	values (to_date('01/01/2012','dd/MM/YYYY'),to_date('01/02/2013','dd/MM/YYYY'),1600,
			1800,'MMaa1245689314798', '340576346K','27234BC','56823MD');
--punto 2	
Insert into Alquileres (fecha_inicio,fecha_fin, km_inicio , km_fin , num_bastidor ,DNI , 
						ID_delegacion_recogida , ID_delegacion_entrega )
	values (to_date('01/03/2012','dd/MM/YYYY'),to_date('01/04/2013','dd/MM/YYYY'),1700,
			1800,'HHee8578537373928', '340576346K','27234BC','56823MD');
			
--punto 5
Insert into Alquileres (fecha_inicio,fecha_fin,descuento_comercial, km_inicio , km_fin , num_bastidor ,DNI , 
						ID_delegacion_recogida , ID_delegacion_entrega )
	values (to_date('01/03/2012','dd/MM/YYYY'),to_date('01/04/2013','dd/MM/YYYY'),5,2000,
			2600,'YTfd8458484849256', '90432874K','56823MD','92384SV');
			
--punto 6
Insert into Alquileres (fecha_inicio, km_inicio, num_bastidor, DNI, ID_delegacion_recogida )
	values (to_date('01/03/2013','dd/MM/YYYY'),2200, 'YTfd8458484849256', '90432874K','27234BC');