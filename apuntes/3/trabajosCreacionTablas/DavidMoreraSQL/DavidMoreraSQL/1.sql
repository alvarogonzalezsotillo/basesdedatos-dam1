DROP TABLE alquiler;
DROP TABLE clientes;
DROP TABLE categorias;
DROP TABLE cochesacabados;
DROP TABLE acabados;
DROP TABLE coches;

CREATE TABLE alquiler
(
contrato	varchar2(50) NOT NULL,
descuento	number(2)	NULL,
fecharecogida date NOT NULL,
fechaentrega		date NULL,
lugarrecogida varchar(50) NOT NULL,
lugarentrega varchar(50)  NULL,
kmrecogida number(7) NOT NULL,
kmentrega number(7) NULL,
nbastidor varchar2(20) NOT NULL,
idcategoria varchar2(50) NOT NULL,
dni varchar2(9) NOT NULL
);

CREATE TABLE clientes
(
nombre		varchar2(50) NOT NULL,
apellidos	varchar2(50) NOT NULL,
dni		varchar2(9) NOT NULL,
edad		number(2) NOT NULL,
genero		varchar2(1) NOT NULL
);

CREATE TABLE categorias
(
idcategoria	varchar2(50) NOT NULL,
precio  number(3) NOT NULL
);

CREATE TABLE cochesacabados
(
idacabado	varchar2(50) NOT NULL,
nbastidor	varchar2(50) NOT NULL
);


CREATE TABLE acabados
(
idacabado	varchar2(50) NOT NULL,
tipoacabado varchar2(50) NOT NULL
);

CREATE TABLE coches
(
marca	varchar2(50) NOT NULL,
modelo	varchar2(50) NOT NULL,
color	varchar2(50) NOT NULL,
matricula	varchar2(7) NOT NULL,
nbastidor	varchar2(20)  NOT NULL
);


-- Claves primarias

ALTER TABLE alquiler
ADD CONSTRAINT 
pkalquiler PRIMARY KEY (contrato);

ALTER TABLE clientes
ADD CONSTRAINT 
pkcliente PRIMARY KEY (dni);

ALTER TABLE categorias
ADD CONSTRAINTS 
pkcategorias PRIMARY KEY (idcategoria);

ALTER TABLE cochesacabados
ADD CONSTRAINT 
pkcochesacabados PRIMARY KEY (nbastidor,idacabado);

ALTER TABLE acabados
ADD CONSTRAINTS 
pkacabado PRIMARY KEY (idacabado);


ALTER TABLE coches
ADD CONSTRAINT 
pkcoche PRIMARY KEY (nbastidor);

ALTER TABLE coches 
ADD CONSTRAINT 
uni UNIQUE (matricula);

-- claves ajenas


ALTER TABLE alquiler
ADD CONSTRAINT "fkalquilercoches" FOREIGN KEY (nbastidor) REFERENCES coches (nbastidor);

ALTER TABLE alquiler
ADD CONSTRAINT "fkalquilercategoria" FOREIGN KEY (idcategoria) REFERENCES categorias (idcategoria);

ALTER TABLE alquiler
ADD CONSTRAINT "fkalquilercliente" FOREIGN KEY (dni) REFERENCES clientes (dni);


ALTER TABLE cochesacabados
ADD CONSTRAINT "fkcoches" FOREIGN KEY (nbastidor) REFERENCES coches (nbastidor);


ALTER TABLE cochesacabados
ADD CONSTRAINT "fkacabado" FOREIGN KEY (idacabado) REFERENCES acabados (idacabado);




ALTER TABLE clientes
ADD CONSTRAINT "edad" CHECK (edad>18);

