DROP TABLE revisiones;
DROP TABLE colores;


CREATE TABLE revisiones
(
idrevision		varchar2(20) NOT NULL,
nbastidor	varchar2(20) NOT NULL,
fechamax		date NULL,
fechaprox date null,
fechaanterior		date  NULL,
km  number(10) NULL,
kmanteriores number(10) NULL,
compra date null
);



CREATE TABLE colores
(
colorfabrica   varchar2(20) NOT NULL,
fcompra  date NOT NULL,
nuevocolor		 varchar2(20) NOT NULL,
frepintado	 date NOT NULL,
nbastidor	varchar2(20) NOT NULL
);

---claves primarias
ALTER TABLE colores
ADD CONSTRAINT 
pkcolor PRIMARY KEY (colorfabrica,fcompra,nuevocolor,frepintado,nbastidor);

ALTER TABLE revisiones
ADD CONSTRAINT 
pkrevision PRIMARY KEY (idrevision,nbastidor,compra);


---claves ajenas
ALTER TABLE revisiones
ADD CONSTRAINT "fkrevisiones" FOREIGN KEY (nbastidor) REFERENCES coches (nbastidor);

ALTER TABLE colores
ADD CONSTRAINT "fkcolores" FOREIGN KEY (nbastidor) REFERENCES coches (nbastidor);