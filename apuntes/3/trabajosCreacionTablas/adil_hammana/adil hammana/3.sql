
DROP TABLE REVISIONES cascade constraints;
CREATE TABLE REVISIONES
(
	tipo_revision VARCHAR(20) NOT NULL,
	ITV_revision NUMBER (2) NOT NULL,
	km_revision NUMBER(10) NOT NULL,
	fecha_revision1 DATE NOT NULL,
	km_revision_anteriores NUMBER(10),
	n_bastidor VARCHAR(50) NOT NULL
	);
	alter table REVISIONES 
	add constraint revisiones_coches_pk
	PRIMARY KEY (n_bastidor);
	
alter table COCHES add color_anterior VARCHAR (10);
alter table COCHES add fecha_cambio_color DATE;
alter table COCHES add fecha_compra DATE;