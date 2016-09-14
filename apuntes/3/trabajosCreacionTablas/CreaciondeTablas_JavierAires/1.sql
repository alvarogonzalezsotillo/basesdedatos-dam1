CREATE TABLE categorias (	nombre_cat VARCHAR(15) NOT NULL, 
							precio_dia NUMBER(5,2) NOT NULL, 
CONSTRAINT	 pk_categorias 	PRIMARY KEY (nombre_cat))
							
CREATE TABLE acabados 	(	id_acabado NUMBER(2) NOT NULL, 
							aire_acond VARCHAR(2) DEFAULT no, 
							climatizador VARCHAR(2) DEFAULT no, 
							navegador VARCHAR(2) DEFAULT no,
							bluetooth VARCHAR(2) DEFAULT no,
							mp3 VARCHAR(2) DEFAULT no,
							automatico VARCHAR(2) DEFAULT no,
							techo_solar VARCHAR(2) DEFAULT no,
							nombre_cat VARCHAR(15) NOT NULL, 
CONSTRAINT	pk_acabados	 	PRIMARY KEY (id_acabado),
			fk_acab_cat		FOREIGN KEY (nombre_cat) REFERENCES categorias(nombre_cat))
							
CREATE TABLE flotas		(	marca VARCHAR(10) NOT NULL, 
							modelo VARCHAR(10) NOT NULL,
							color VARCHAR(15) NOT NULL,
							matricula VARCHAR(8) NOT NULL,
							bastidor VARCHAR(20) NOT NULL,
							id_acabado NUMBER(2) NOT NULL, 
CONSTRAINT 	pk_flotas 		PRIMARY KEY (bastidor),
			fk_flo_acab		FOREIGN KEY (id_acabado) REFERENCES acabados(id_acabado))
							
CREATE TABLE clientes	(	nombre VARCHAR(20) NOT NULL,
							apellidos VARCHAR(40) NOT NULL,
							genero VARCHAR(6) NOT NULL,
							edad NUMBER(2) NOT NULL, 
							dni_nie VARCHAR(15) NOT NULL,
CONSTRAINT	 pk_cliente 	PRIMARY KEY (dni_nie))

							
CREATE TABLE alquileres	(	deleg_inicio VARCHAR(15) NOT NULL, 
							deleg_fin VARCHAR(15),
							km_inicio NUMBER(6) NOT NULL,
							km_fin NUMBER(6),
							fecha_inicio DATE NOT NULL,
							fecha_fin DATE, 
							descuento VARCHAR(3) DEFAULT 0%,
							bastidor VARCHAR(20) NOT NULL,
							dni_nie VARCHAR(15) NOT NULL,
CONSTRAINT 	fk_alq_flo	 	FOREIGN KEY (bastidor) REFERENCES flotas(bastidor),
			fk_alq_cli		FOREIGN KEY (dni_nie) REFERENCES acabados(id_acabado))
;