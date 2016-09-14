INSERT INTO clientes VALUES('Pedro','Martínez Martínez','12345678X',33,'h');
INSERT INTO categorias VALUES('Prestige',95);
INSERT INTO coches VALUES('Mercedes','Clase B','Verde','1234ABC','1z8f644456855j');
INSERT INTO acabados VALUES('001','Cambio automatico');
INSERT INTO cochesacabados VALUES('001','1z8f644456855j');
INSERT INTO alquiler VALUES('0001','0', TO_DATE('01/01/12','dd/mm/yy'),TO_DATE('01/02/13','dd/mm/yy'),'Madrid','Madrid',1800,2000,'1z8f644456855j','Prestige','12345678X');
--------------------------------------------------------------

INSERT INTO coches VALUES('Renault','Fluenze','negro','1111ABC','1z8f6447892lop');
INSERT INTO acabados VALUES('002','Navegador');
INSERT INTO cochesacabados VALUES('002','1z8f6447892lop');
INSERT INTO alquiler VALUES('0002','0', TO_DATE('01/03/13','dd/mm/yy'),TO_DATE('01/04/13','dd/mm/yy'),'Madrid','Madrid',1700,1800,'1z8f6447892lop','Prestige','12345678X');


---------------------------------------------------------------
INSERT INTO clientes VALUES('Juan','Pérez Pérez','09043425p',25,'h');
INSERT INTO categorias VALUES('Advance',120);
INSERT INTO coches VALUES('Renault','Kangoo','blanco','4321ABC','2q58ee6p995y');
INSERT INTO acabados VALUES('003','bluetooth');
INSERT INTO cochesacabados VALUES('003','2q58ee6p995y');
INSERT INTO alquiler VALUES('0003','5', TO_DATE('01/03/12','dd/mm/yy'),TO_DATE('01/04/13','dd/mm/yy'),'Madrid','Sevilla',10000,11000,'2q58ee6p995y','Advance','09043425p');

----------------------------------------------------------------
INSERT INTO clientes VALUES('Manolo','Bombo Bombo','51613485h',38,'h');
INSERT INTO coches VALUES('Renault','Modus','Colorao','7777QDR','2d55d56pjkkjd6');
INSERT INTO cochesacabados VALUES('003','2d55d56pjkkjd6');
INSERT INTO alquiler(contrato,descuento,fecharecogida,lugarrecogida,kmrecogida,nbastidor,idcategoria,dni) VALUES('0004','0', TO_DATE('01/03/13','dd/mm/yy'),'Barcelona',85000,'2d55d56pjkkjd6','Advance','09043425p');



