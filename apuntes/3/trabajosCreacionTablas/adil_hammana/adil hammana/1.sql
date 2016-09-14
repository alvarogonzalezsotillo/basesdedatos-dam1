DROP TABLE CATEGORIAS cascade constraints; 
CREATE TABLE CATEGORIAS
(
	tipo_categoria VARCHAR (20) NOT NULL,
	precio_dia NUMBER(10) NOT NULL
);
alter table CATEGORIAS
add constraint categorias_pk
PRIMARY KEY (tipo_categoria);

DROP TABLE COCHES cascade constraints;
CREATE TABLE COCHES
(
	marca VARCHAR(20) NOT NULL,
	modelo VARCHAR (20) NOT NULL,
	color_actual VARCHAR (20)NOT NULL,
	matricula VARCHAR (20) NOT NULL,
	n_bastidor VARCHAR(50) NOT NULL,
	tipo_categoria VARCHAR( 20) NOT NULL
);
alter table COCHES
add constraint coches_pk
PRIMARY KEY (n_bastidor);
alter table COCHES
add constraint coches_categorias
FOREIGN KEY (tipo_categoria) REFERENCES CATEGORIAS (tipo_categoria);

DROP TABLE  ACABADO_UN_COCHE cascade constraints;
CREATE TABLE ACABADO_UN_COCHE
(
	n_bastidor VARCHAR(50) NOT NULL,
	aire_acondicionado VARCHAR(20) DEFAULT ('NO'),
	climatizador VARCHAR(20) DEFAULT ('NO'),
	navegador VARCHAR(20) DEFAULT ('NO'),
	bluetooth VARCHAR(20) DEFAULT ('NO'),
	mp3 VARCHAR(20) DEFAULT ('NO'),
	cambio VARCHAR(20) DEFAULT ('NO'),
	techo VARCHAR(20) DEFAULT ('NO')
);
alter table ACABADO_UN_COCHE
add constraint acabado_un_coche_pk
PRIMARY KEY (n_bastidor);

alter table ACABADO_UN_COCHE
add constraint acabado_un_coche__coches
FOREIGN KEY (n_bastidor) REFERENCES COCHES (n_bastidor);

DROP TABLE CLIENTES cascade constraints;
CREATE TABLE CLIENTES
 (
	nombre VARCHAR (20) NOT NULL,
	apellidos VARCHAR (20) NOT NULL,
	DNI VARCHAR (10) NOT NULL,
	edad NUMBER (3) NOT NULL,
	genero VARCHAR (10)
);
alter table CLIENTES
add constraint clientes_pk
PRIMARY KEY (DNI);

	
DROP TABLE ALQUILER cascade constraints;
CREATE TABLE ALQUILER
(
	id_alquiler NUMBER(20) NOT NULL,
	delegacion_recogida VARCHAR(20) NOT NULL,
	delegacion_entrega VARCHAR (20) NOT NULL,
	n_km_inicial NUMBER(20) NOT NULL,
	n_km_final NUMBER (20),
	fecha_inicio DATE NOT NULL,
	fecha_fin DATE,
	descuento NUMBER (10),
	DNI VARCHAR (10) NOT NULL,
	n_bastidor VARCHAR(50) NOT NULL	
);

alter table ALQUILER
add constraint alquiler_pk
PRIMARY KEY (id_alquiler);

alter table ALQUILER
add constraint alquiler_clientes
FOREIGN KEY (DNI) REFERENCES CLIENTES(DNI);

alter table ALQUILER
add constraint alquiler_coches
FOREIGN KEY (n_bastidor) REFERENCES COCHES (n_bastidor);