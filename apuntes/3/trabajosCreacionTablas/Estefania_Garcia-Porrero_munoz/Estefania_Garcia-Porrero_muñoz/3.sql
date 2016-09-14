//Considero que se necesita una tabla para la informacion de las revisiones
create table revision_coches(
f_ultima_revision date,
n_revision number(3) not null,
n_km number(10) not null,
f_prox_revision date,
marca varchar(25) not null,
matricula varchar(15) not null
);

//esta vez he elegido matricula como pk
alter table revision_coches add constraint revision_matricula_pk primary key (matricula);

//matricula es una FK de coches al igual que parca y las necesito en esta tabla
alter table revision_coches add constraint revision_coches_fk foreign key (matricula) references coches (matricula);
alter table revision_coches add constraint marca_coches_fk foreign key (marca) references coches (marca);


// esta segunda tabla es para cada vez que se hace un cambio de color queda registrado con la fecha y la matricula del coche
create table color_coches(
color varchar(25) not null,
fecha_color date,
matricula varchar(15) not null
);

//asigno matricula como PK que es FK de la tabla coches
alter table color_coches add constraint color_matricula_pk primary key (matricula);
alter table color_coches add constraint color_coches_fk foreign key (matricula) references coches (matricula);

























