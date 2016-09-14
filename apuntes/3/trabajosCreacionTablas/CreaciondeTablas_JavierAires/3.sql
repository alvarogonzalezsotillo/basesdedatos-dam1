CREATE TABLE pinturas (	color VARCHAR(15) NOT NULL,
						fecha DATE NOT NULL,
						bastidor VARCHAR(20) NOT NULL,
CONSTRAINT 	fk_pint_flo	FOREIGN KEY (bastidor) REFERENCES flotas(bastidor))

CREATE TABLE revisiones (tipo VARCHAR(15) NOT NULL,
						km_ant VARCHAR(10),
						km_sig VARCHAR(10),
						ant_fecha DATE,
						sig_fecha DATE,
CONSTRAINT	fk_rev_flo	FOREIGN KEY (bastidor) REFERENCES flotas(bastidor))

ALTER TABLE acabados ADD (asient_calef VARCHAR(2) DEFAULT no)
						