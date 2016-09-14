insert into repintado(bastidor,color,colornuevo,fecha_repintado)
values('56789J','Rojo','Verde',to_date('01/06/2011', 'dd/MM/YYYY'));

---------------------------------------------------------------------------

insert into revisiones(bastidor,tipo_revision,km_revision,fecha_revision)
values('16289B','Mantenimiento',15000,to_date('01/03/2012', 'dd/MM/YYYY'));

insert into revisiones(bastidor,tipo_revision,km_revision,fecha_revision)
values('93759R','Mantenimiento',15000,to_date('01/04/2012', 'dd/MM/YYYY'));

insert into revisiones(bastidor,tipo_revision,km_revision,fecha_revision)
values('93759R','Mantenimiento',15000,to_date('01/10/2012', 'dd/MM/YYYY'));

insert into revisiones(bastidor,tipo_revision,km_revision,fecha_revision)
values('56789J','Mantenimiento',20000,to_date('01/04/2012', 'dd/MM/YYYY'));

---------------------------------------------------------------------------

insert into revisiones(bastidor,tipo_revision,fecha_revision)
values('56789J','ITV',to_date('01/01/2015', 'dd/MM/YYYY'));

insert into revisiones(bastidor,tipo_revision,fecha_revision)
values('16289B','ITV',to_date('01/10/2016', 'dd/MM/YYYY'));

insert into revisiones(bastidor,tipo_revision,fecha_revision)
values('93759R','ITV',to_date('01/02/2015', 'dd/MM/YYYY'));

insert into revisiones(bastidor,tipo_revision,fecha_revision)
values('06381M','ITV',to_date('01/04/2016', 'dd/MM/YYYY'));

---------------------------------------------------------------------------

update acabados
set asientoscalefactados = 1
where bastidor = '16289B';