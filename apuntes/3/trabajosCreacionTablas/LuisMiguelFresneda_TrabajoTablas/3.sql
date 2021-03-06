-- 3.sql

--CREACI�N DE NUEVAS TABLAS

--CREAMOS LA TABLA COLORDEUNCOCHE QUE LLEVARA EL HISTORICO DE LOS COLORES QUE VA 
--TENIENDO UN COCHE EN PARTICULAR
--La fecha_hasta puede ser null ya que si lo es, sera porque es el color actual
CREATE TABLE COLORDEUNCOCHE(BASTIDOR VARCHAR(17) NOT NULL, 
COLOR VARCHAR(20) NOT NULL, 
FECHA_DESDE DATE NOT NULL, 
FECHA_HASTA DATE NULL);

--SE CREAN DOS TABLAS PARA LAS REVISIONES, YA QUE DIFIEREN EN QUE LOS MANTENIMIENTOS
--SI VAN TANTO POR FECHA O KMS Y LAS ITV'S SOLO VAN POR FECHAS
--ASI NO TENDREMOS TANTOS NULL
--LOS KMS_REVISION Y FECHA_REVISION SON LOS KMS O LA FECHA EN LA QUE SE PASA LA REVISION
--SI LOS KMS ACTUALES SON CERO, LA FECHA_ACTUAL ES LA FECHA DE COMPRA DEL VEHICULO
CREATE TABLE REVISION_MANT(BASTIDOR VARCHAR(17) NOT NULL, 
FECHA_REVISION DATE NOT NULL, 
FECHA_PROXIMA DATE NOT NULL, 
KMS_REVISION NUMERIC(6,0) NOT NULL, 
KMS_PROXIMA NUMERIC(6,0) NOT NULL);

CREATE TABLE REVISION_ITV(BASTIDOR VARCHAR(17) NOT NULL, 
FECHA_REVISION DATE NOT NULL, 
FECHA_PROXIMA DATE NOT NULL);

--INSERTAMOS LAS PRIMARY KEYS
ALTER TABLE COLORDEUNCOCHE ADD CONSTRAINT PK_COLOR 
PRIMARY KEY (BASTIDOR, FECHA_DESDE);
ALTER TABLE REVISION_MANT ADD CONSTRAINT PK_REVISION_MANT
PRIMARY KEY (BASTIDOR,  FECHA_REVISION);
ALTER TABLE REVISION_ITV ADD CONSTRAINT PK_REVISION_ITV
PRIMARY KEY (BASTIDOR,  FECHA_REVISION);

--INSERTAMOS LAS FOREIGN KEYS
ALTER TABLE COLORDEUNCOCHE ADD CONSTRAINT FK_COLOR_COCHE 
FOREIGN KEY (BASTIDOR) REFERENCES COCHE(BASTIDOR);
ALTER TABLE REVISION_MANT ADD CONSTRAINT FK_REVISION_MANT_COCHE 
FOREIGN KEY (BASTIDOR) REFERENCES COCHE(BASTIDOR);
ALTER TABLE REVISION_ITV ADD CONSTRAINT FK_REVISION_ITV_COCHE 
FOREIGN KEY (BASTIDOR) REFERENCES COCHE(BASTIDOR);

--INSERTAMOS UN NUEVO ACABADO
ALTER TABLE ACABADODEUNCOCHE ADD ASIENTOS_CALEF VARCHAR(2) DEFAULT('NO');