//Estos datos se introduciran en la tabla que he creado para los colores de los coches
insert into color_coches(color, fecha_color, matricula)
values(rojo, to_date('01/01/2011','dd/MM/YYYY'), '1234abc');

insert into color_coches(color, fecha_color, matricula)
values(verde, to_date('01/06/2011','dd/MM/YYYY'), '1234abc');




//estos datos se introduciran en la tabla que he creado en el punto anterior para las revisiones
insert into revision_coches(f_ultima_revision, n_revision, n_km, f_prox_revision, marca, matricula)
values(to_date('01/03/2012','dd/MM/YYYY'), 1, 15000, to_date('01/03/2016','dd/MM/YYYY'), 'renault' '1111abc');



insert into revision_coches(f_ultima_revision, n_revision, n_km, f_prox_revision, marca, matricula)
values(to_date('01/04/2012','dd/MM/YYYY'), 1, 30000, to_date('01/04/2016','dd/MM/YYYY'), 'renault' '4321abc');

insert into revision_coches(f_ultima_revision, n_revision, n_km, f_prox_revision, marca, matricula)
values(to_date('01/10/2012','dd/MM/YYYY'), 2, 60000, to_date('01/10/2016','dd/MM/YYYY'), 'renault' '4321abc');


insert into revision_coches(f_ultima_revision, n_revision, n_km, f_prox_revision, marca, matricula)
values(to_date('01/04/2012','dd/MM/YYYY'), 1, 20000, to_date('01/04/2016','dd/MM/YYYY'), 'mercedes' '4321abc');
























