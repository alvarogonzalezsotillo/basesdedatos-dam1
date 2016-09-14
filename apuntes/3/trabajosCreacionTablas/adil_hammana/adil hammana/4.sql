INSERT INTO COCHES VALUES ('Mercedes','Clase B','verde','1234ABC','111111BB221','Advance','rojo',TO_DATE('01/06/11','dd/mm/yyyy'),TO_DATE('01/01/2011','dd/mm/yyyy'));


/*voy a meter otra columna mas para la 2º fecha de revisiones*/
alter table REVISIONES add fecha_revision2 DATE;


INSERT INTO COCHES VALUES ('Renault','Fluenze','rojo','1111ABC','222222BB221','Funcional',0,TO_DATE('','dd/mm/yyyy'),TO_DATE('','dd/mm/yyyy'));

INSERT INTO REVISIONES VALUES ('mantenimiento',4,15000,TO_DATE('01/03/2012','dd/mm/yyyy'),0,'222222BB221',TO_DATE('','dd/mm/yyyy'));

INSERT INTO COCHES VALUES ('Renault','Kanguroo','rojo','4321AB','98765432A1','Advance',0,TO_DATE('','dd/mm/yyyy'),TO_DATE('','dd/mm/yyyy'));


INSERT INTO REVISIONES VALUES ('mantenimiento',4,15000,TO_DATE('01/02/2012','dd/mm/yyyy'),0,'98765432A1',TO_DATE('01/10/2012','dd/mm/yyyy'));


INSERT INTO COCHES VALUES ('Mercedes','Clase B','verde','1234ABC','111111BB221','Advance','rojo',TO_DATE('','dd/mm/yyyy'),TO_DATE('01/01/2012','dd/mm/yyyy'));
INSERT INTO REVISIONES VALUES ('mantenimiento',4,20000,TO_DATE('01/04/2012','dd/mm/yyyy'),0,'111111BB221',TO_DATE('','dd/mm/yyyy'));
