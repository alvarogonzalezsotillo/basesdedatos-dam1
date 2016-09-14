-- 1.sql


-- 1. Entorno del problema
--  - Una compañía de alquiler de coches desea informatizar su gestión
--  - Su flota de coches se divide en tres categorías: Functional, Advance y Prestige. 
--    Cada categoría puede tener diferentes modelos de coche con diferentes acabados. 
--    Un modelo concreto puede pertenecer a varias categorías, si el acabado es distinto. 
--    El precio por día del alquiler depende de la categoría asignada al coche.
--  - Se desea saber los siguientes datos en el acabado de los coches:
--     · aire acondicionado, climatizador, navegador, bluetooth, mp3, cambio automático, techo solar
--  - De cada coche de la flota se desea saber:
--    · Marca
--    · Modelo
--    · Categoría
--    · Acabado
--    · Color de carrocería
--    · Matrícula y nº de bastidor
--  - De cada alquiler de coche se desea saber:
--    · Datos del cliente (nombre, apellidos, DNI/NIE/pasaporte, edad, género)
--    · Delegación donde se recoge el coche, y delegación donde se dejará el coche
--    · Nº de Km inicial y final
--    · Fecha e inicio y fin del alquiler
--    · Descuento comercial aplicado


-- CREO LAS TABLAS CLIENTE, CATEGORIA, ACABADO, COHE, ALQUILER.

CREATE TABLE CLIENTE(
DNI_NIE_PASAPORTE VARCHAR(9) NOT NULL, 
NOMBRE VARCHAR(50) NOT NULL, 
APELLIDOS VARCHAR(50) NOT NULL, 
EDAD INT NOT NULL CHECK (EDAD >= 18),
GENERO VARCHAR(1) NOT NULL CHECK (GENERO IN ('H','M')),
CONSTRAINT PK_DNI_NIE_PASAPORTE PRIMARY KEY (DNI_NIE_PASAPORTE)
);

CREATE TABLE CATEGORIA(
ID_CATEGORIA INT NOT NULL,
TIPO_CATEGORIA VARCHAR(15) NOT NULL CHECK (TIPO_CATEGORIA IN ('FUNCTIONAL','ADVANCE','PRESTIGE')), 
PRECIO_DIA INT NOT NULL CHECK (PRECIO_DIA > 0),
CONSTRAINT PK_ID_CATEGORIA PRIMARY KEY (ID_CATEGORIA)
);

CREATE TABLE ACABADO(
ID_ACABADO INT NOT NULL, 
AIRE_ACONDICIONADO VARCHAR(2) DEFAULT ('NO') CHECK (AIRE_ACONDICIONADO IN ('NO','SI')), 
CLIMATIZADOR VARCHAR(2) DEFAULT ('NO') CHECK (CLIMATIZADOR IN ('NO','SI')), 
NAVEGADOR VARCHAR(2) DEFAULT ('NO') CHECK (NAVEGADOR IN ('NO','SI')), 
BLUETOOHT VARCHAR(2) DEFAULT ('NO') CHECK (BLUETOOHT IN ('NO','SI')), 
MP3 VARCHAR(2) DEFAULT ('NO') CHECK (MP3 IN ('NO','SI')), 
CAMBIO_AUTOMATICO VARCHAR(2) DEFAULT ('NO') CHECK (CAMBIO_AUTOMATICO IN ('NO','SI')), 
TECHO_SOLAR VARCHAR(2) DEFAULT ('NO') CHECK (TECHO_SOLAR IN ('NO','SI')),
CONSTRAINT PK_IDACABADO PRIMARY KEY (ID_ACABADO)
);

CREATE TABLE COCHE(
BASTIDOR VARCHAR(17) NOT NULL,
MARCA VARCHAR(25) NOT NULL, 
MODELO VARCHAR(25) NOT NULL, 
MATRICULA VARCHAR(7) NOT NULL UNIQUE, 
COLOR_ORIGINAL VARCHAR(15) NOT NULL, 
ID_CAT INT NOT NULL,
ACABADO INT NOT NULL,
CONSTRAINT PK_COCHE_BASTIDOR PRIMARY KEY (BASTIDOR),
CONSTRAINT FK_CATEGORIA_IDCAT 
FOREIGN KEY (ID_CAT) REFERENCES CATEGORIA (ID_CATEGORIA),
CONSTRAINT FK_ACABADO 
FOREIGN KEY (ACABADO) REFERENCES ACABADO (ID_ACABADO)
);

CREATE TABLE ALQUILER(
ID_ALQUILER INT NOT NULL, 
NUM_BASTIDOR VARCHAR(17) NOT NULL, 
DNI_CLIENTE VARCHAR(9) NOT NULL, 
DELEGACION_RECOGER VARCHAR(50) NOT NULL, 
DELEGACION_DEJAR VARCHAR(50) NOT NULL, 
KMS_INICIALES INT NOT NULL, 
KMS_FINALES INT NULL, 
FECHA_INICIO DATE NOT NULL, 
FECHA_FIN DATE NULL,
DESCUENTO INT NULL,
CONSTRAINT PK_ID_ALQUILER PRIMARY KEY (ID_ALQUILER),
CONSTRAINT FK_NUMBASTIDOR 
FOREIGN KEY (NUM_BASTIDOR) REFERENCES COCHE (BASTIDOR),
CONSTRAINT FK_CLIENTE_DNI 
FOREIGN KEY (DNI_CLIENTE) REFERENCES CLIENTE (DNI_NIE_PASAPORTE),
CONSTRAINT CK_KMSFINALES CHECK (KMS_FINALES > KMS_INICIALES)
);