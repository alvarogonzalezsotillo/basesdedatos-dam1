

--Se puede pintar varias veces el coche al dia y puede tener varias revisiones al dia--
                                                                                                                                                    



CREATE TABLE pintura(
color_anterior varchar(20) not null, 
color_actual varchar(20) not null,
fecha_anterior_pintura TIMESTAMP not null,
fecha_pintado_actual TIMESTAMP not null,
id_pintura NUMERIC(6) not null,
PRIMARY KEY (id_pintura));

CREATE TABLE revision(
tipo varchar(20) not null,
km_ultima NUMERIC(8) not null,
km_siguiente NUMERIC(8),
fecha_ultima TIMESTAMP not null,
fecha_siguiente TIMESTAMP,
id_revision NUMERIC(6)not null,
PRIMARY KEY(id_revision)
);

CREATE TABLE pasa(
id_revision NUMERIC(6) not null,
bastidor NUMERIC(15) not null
);

alter table pasa
add constraint pasa_coche
foreign key(bastidor)references coche(bastidor);

alter table pasa
add constraint pasa_revision
foreign key(id_revision)references revision(id_revision);

CREATE TABLE tiene(
bastidor NUMERIC(15) not null,
id_pintura NUMERIC(6)
);

alter table tiene
add constraint tiene_pintura
foreign key(id_pintura)references pintura(id_pintura);


alter table tiene
add constraint tiene_coche
foreign key(bastidor)references coche(bastidor);


