


INSERT INTO colores VALUES('rojo', TO_DATE('01/01/11','dd/mm/yy'),'verde',TO_DATE('01/06/11','dd/mm/yy'),'1z8f644456855j');

INSERT INTO revisiones(idrevision,nbastidor,compra,fechaanterior,km,kmanteriores) 
    VALUES('mantenimiento','1z8f6447892lop',TO_DATE('01-02-12','dd/mm/yy'),TO_DATE('01/02/12','dd/mm/yy'),30000,15000);
INSERT INTO revisiones(idrevision,nbastidor,compra,fechaprox,fechaanterior,km,kmanteriores) 
    VALUES('mantenimiento','2q58ee6p995y',TO_DATE('01-02-12','dd/mm/yy'),TO_DATE('01-10-12','dd/mm/yy'),TO_DATE('01-04-12','dd/mm/yy'),30000,15000);


INSERT INTO revisiones(idrevision,nbastidor,compra,fechaanterior,km,kmanteriores) 
    VALUES('mantenimiento','1z8f644456855j',TO_DATE('01-01-12','dd/mm/yy'),TO_DATE('01-04-12','dd/mm/yy'),40000,20000);

INSERT INTO revisiones(idrevision,nbastidor,compra,fechamax) 
    VALUES('ITV','2q58ee6p995y',TO_DATE('01-02-12','dd/mm/yy'),TO_DATE('01-02-16','dd/mm/yy'));
INSERT INTO revisiones(idrevision,nbastidor,compra,fechamax) 
    VALUES('ITV','1z8f644456855j',TO_DATE('01-01-12','dd/mm/yy'),TO_DATE('01-02-16','dd/mm/yy'));
    

--insercion dentro de la tabla de acabados
INSERT INTO acabados VALUES('12','a.calefactados');

