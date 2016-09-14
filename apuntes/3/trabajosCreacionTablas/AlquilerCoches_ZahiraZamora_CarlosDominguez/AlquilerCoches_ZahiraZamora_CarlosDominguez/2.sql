--Base de Datos Alquiler de Coches
--Autor: Zahira Zamora y Carlos Dominguez
--Parte2 Insercion Datos1

--Insercion de clientes
INSERT INTO clientes
  (cod_cliente, nombre, apellidos, nif, edad, genero, direccion, ciudad)
  values(1,'pedro','martinez martinez','23234545r',45,'M','c/pez,13','pamplona');

INSERT INTO clientes
  (cod_cliente, nombre, apellidos, nif, edad, genero, direccion, ciudad, telefono)
  values(2,'juan','perez perez','87651294t',22,'M','c/barco,21','madrid','912345577');
  
INSERT INTO clientes
  (cod_cliente, nombre, apellidos, nif, edad, genero, direccion, ciudad, telefono)
  values(3,'manolo','bombo bombo','21877766y',50,'M','c/fresno,15,Bajo C','barcelona','923421123');     

--Insercion de categorias
--NOTA: Suponemos erroneo el enunciado, creyendo que los precios de las
--      categorias son al contrario. En un caso real llamariamos al cliente
--      para corroborar el error
INSERT INTO categorias
  (cod_categoria, nombre, precio_dia)
  values(1,'Functional',95);

INSERT INTO categorias
  (cod_categoria, nombre, precio_dia)
  values(2,'Advance',120);
  
INSERT INTO categorias
  (cod_categoria, nombre, precio_dia)
  values(3,'Prestige',200);

--Insercion acabados
INSERT INTO acabados --Mercedes Clase B verde con Matrícula 1234ABC
  (cod_acabado,cod_categoria,aire_acond,climatizador,
  navegador,bluetooth,mp3,cambio_auto,techo_solar)
  values(1,3,1,1,0,0,1,1,0);
  
INSERT INTO acabados --Renault Fluenze con Matrícula 1111ABC
                      --subimos de categoria al tener navegador
  (cod_acabado,cod_categoria,aire_acond,climatizador,
  navegador,bluetooth,mp3,cambio_auto,techo_solar)
  values(2,3,1,1,1,1,1,0,0);
  
INSERT INTO acabados --Renault Kangoo con Matrícula 4321ABC
  (cod_acabado,cod_categoria,aire_acond,climatizador,
  navegador,bluetooth,mp3,cambio_auto,techo_solar)
  values(3,2,1,1,0,1,1,0,0);
  
INSERT INTO acabados --Renault Modus
  (cod_acabado,cod_categoria,aire_acond,climatizador,
  navegador,bluetooth,mp3,cambio_auto,techo_solar)
  values(4,2,1,0,0,1,1,0,0);
    
--Insercion coches
INSERT INTO coches --Mercedes Clase B verde con Matrícula 1234ABC
  (nbastidor,matricula,marca,modelo,color,cod_acabado)
  values('O123456789BCDFTYH','1234ABC','mercedes','clase B','verde',1);
  
INSERT INTO coches --Renault Fluenze con Matrícula 1111ABC
  (nbastidor,matricula,marca,modelo,color,cod_acabado)
  values('IJK3456789BCDFTYH','1111ABC','renault','fluenze','blanco',2);

INSERT INTO coches --Renault Kangoo con Matrícula 4321ABC
  (nbastidor,matricula,marca,modelo,color,cod_acabado)
  values('12DFTYHIJK3456789','4321ABC','renault','kangoo','azul',3);    
  
INSERT INTO coches --Renault Modus con Matricula 4210GHT
  (nbastidor,matricula,marca,modelo,color,cod_acabado)
  values('2235678912DFTYHIJ','4210GHT','renault','modus','rojo',4);
  
--Insercion delegaciones
INSERT INTO delegaciones
  (cod_delegacion,direccion,ciudad,telefono)
  values(1,'c/aranjuez,22','madrid','913352245');
  
INSERT INTO delegaciones
  (cod_delegacion,direccion,ciudad,telefono)
  values(2,'c/almirante,10','barcelona','925652334');
  
INSERT INTO delegaciones
  (cod_delegacion,direccion,ciudad,telefono)
  values(3,'c/pastor,sn','sevilla','956335224');
      
INSERT INTO delegaciones
  (cod_delegacion,direccion,ciudad,telefono)
  values(4,'c/tornasol,120','toledo','963352238');
  
INSERT INTO delegaciones
  (cod_delegacion,direccion,ciudad,telefono)
  values(5,'c/raspa,36','oviedo','987752246');
  
  
--Insercion alquileres
INSERT INTO alquileres
  (cod_alquiler,nbastidor,cod_cliente,cod_deleg_ori,
  cod_deleg_des,descuento,km_inicio,km_fin,fecha_inicio,fecha_fin)
  values(1,'O123456789BCDFTYH',1,1,4,0,10100,10300,
          to_date('01/01/2012','dd/MM/YYYY'),to_date('01/02/2013','dd/MM/YYYY'));
          
INSERT INTO alquileres
  (cod_alquiler,nbastidor,cod_cliente,cod_deleg_ori,
  cod_deleg_des,descuento,km_inicio,km_fin,fecha_inicio,fecha_fin)
  values(2,'IJK3456789BCDFTYH',1,2,2,0,9500,9600,
          to_date('01/03/2012','dd/MM/YYYY'),to_date('01/04/2013','dd/MM/YYYY'));          
          
INSERT INTO alquileres
  (cod_alquiler,nbastidor,cod_cliente,cod_deleg_ori,
  cod_deleg_des,descuento,km_inicio,km_fin,fecha_inicio,fecha_fin)
  values(3,'12DFTYHIJK3456789',2,1,3,5,18300,19700,
          to_date('01/03/2012','dd/MM/YYYY'),to_date('01/04/2013','dd/MM/YYYY'));           
          
INSERT INTO alquileres
  (cod_alquiler,nbastidor,cod_cliente,cod_deleg_ori,
  descuento,km_inicio,fecha_inicio)
  values(4,'2235678912DFTYHIJ',3,2,0,12050,
          to_date('01/03/2013','dd/MM/YYYY'));           