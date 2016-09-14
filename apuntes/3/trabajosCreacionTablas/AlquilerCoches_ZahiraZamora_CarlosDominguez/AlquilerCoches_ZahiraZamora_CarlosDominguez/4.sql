--Base de Datos Alquiler de Coches
--Autor: Zahira Zamora y Carlos Dominguez
--Parte4 Insercion Datos2

--Datos para Mercedes Clase B con 
--Matrícula 1234ABC (error enunciado cogemos fecha compra 1/1/2011)
INSERT INTO revisiones_itv
  (cod_rev_itv,nbastidor,fecha_prevista)
  values (1,'O123456789BCDFTYH',to_date('01/01/2015','dd/MM/YYYY'));

INSERT INTO revisiones_mant
  (cod_rev_mant,nbastidor,km_previsto,km_realizado,fecha_realizado)
  values(1,'O123456789BCDFTYH',20000,20000,to_date('01/04/2012','dd/MM/YYYY'));
--Para mantener coherencia añadimos una revision prevista a los 40000 km
INSERT INTO revisiones_mant 
  (cod_rev_mant,nbastidor,km_previsto)
  values(2,'O123456789BCDFTYH',40000);
  
INSERT INTO registro_colores
  (cod_color,color,nbastidor,fecha_pintado)
  values(5,'verde','O123456789BCDFTYH',to_date('01/06/2011','dd/MM/YYYY'));  

--Datos para Renault Fluenze con Matrícula 1111ABC
INSERT INTO revisiones_itv
  (cod_rev_itv,nbastidor,fecha_prevista)
  values (2,'IJK3456789BCDFTYH',to_date('04/07/2015','dd/MM/YYYY'));

INSERT INTO revisiones_mant
  (cod_rev_mant,nbastidor,km_previsto,km_realizado,fecha_realizado)
  values(3,'IJK3456789BCDFTYH',15000,15000,to_date('01/03/2012','dd/MM/YYYY'));
--Para mantener coherencia añadimos una revision prevista a los 30000 km
INSERT INTO revisiones_mant 
  (cod_rev_mant,nbastidor,km_previsto)
  values(4,'IJK3456789BCDFTYH',30000);
  
--Datos para Renault Kangoo con Matrícula 4321ABC
INSERT INTO revisiones_itv
  (cod_rev_itv,nbastidor,fecha_prevista)
  values (3,'12DFTYHIJK3456789',to_date('01/02/2016','dd/MM/YYYY'));

INSERT INTO revisiones_mant
  (cod_rev_mant,nbastidor,km_previsto,km_realizado,fecha_realizado)
  values(5,'12DFTYHIJK3456789',15000,15000,to_date('01/04/2012','dd/MM/YYYY'));
INSERT INTO revisiones_mant
  (cod_rev_mant,nbastidor,km_previsto,km_realizado,fecha_realizado)
  values(6,'12DFTYHIJK3456789',30000,30000,to_date('01/10/2012','dd/MM/YYYY'));  
--Para mantener coherencia añadimos una revision prevista a los 45000 km
INSERT INTO revisiones_mant 
  (cod_rev_mant,nbastidor,km_previsto)
  values(7,'12DFTYHIJK3456789',45000);
  
--Datos para Renault Modus con Matricula 4210GHT
INSERT INTO revisiones_itv
  (cod_rev_itv,nbastidor,fecha_prevista,fecha_realizada)
  values (4,'2235678912DFTYHIJ',to_date('03/08/2012','dd/MM/YYYY'),to_date('01/08/2012','dd/MM/YYYY'));
INSERT INTO revisiones_itv
  (cod_rev_itv,nbastidor,fecha_prevista)
  values (5,'2235678912DFTYHIJ',to_date('01/08/2016','dd/MM/YYYY'));  

INSERT INTO revisiones_mant
  (cod_rev_mant,nbastidor,km_previsto,km_realizado,fecha_realizado)
  values(8,'2235678912DFTYHIJ',15000,15000,to_date('08/04/2009','dd/MM/YYYY'));
INSERT INTO revisiones_mant
  (cod_rev_mant,nbastidor,km_previsto,km_realizado,fecha_realizado)
  values(9,'2235678912DFTYHIJ',30000,30000,to_date('13/10/2011','dd/MM/YYYY'));  
--Para mantener coherencia añadimos una revision prevista a los 45000 km
INSERT INTO revisiones_mant 
  (cod_rev_mant,nbastidor,km_previsto)
  values(10,'2235678912DFTYHIJ',45000);
  
--Coche Matricula 1111ABC calefactado con cod_acabado = 4
UPDATE acabados SET calefactados=1 WHERE cod_acabado=4;