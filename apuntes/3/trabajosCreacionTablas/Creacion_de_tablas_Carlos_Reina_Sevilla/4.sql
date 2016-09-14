

insert into pintura(color_anterior,color_actual,fecha_anterior_pintura,fecha_pintado_actual,id_pintura)
values('rojo','verde',TO_DATE('01/01/2011 08:15','dd/MM/YYYY hh24:mi'),TO_DATE('01/06/2011 13:30','dd/MM/YYYY hh24:mi'),201);


insert into tiene(bastidor,id_pintura)
values(101,201);





insert into revision(tipo,km_ultima,km_siguiente,fecha_ultima,fecha_siguiente,id_revision)
values('mantenimiento',15000,30000,TO_DATE('01/02/2012 16:45','dd/MM/YYYY hh24:mi'),null,301);

insert into pasa(id_revision,bastidor)
values(301,102);



insert into revision(tipo,km_ultima,km_siguiente,fecha_ultima,fecha_siguiente,id_revision)
values('revision',0,15000,TO_DATE('01/02/2012 16:45','dd/MM/YYYY hh24:mi'),TO_DATE('01/04/2012 16:45','dd/MM/YYYY hh24:mi'),302);

insert into revision(tipo,km_ultima,km_siguiente,fecha_ultima,fecha_siguiente,id_revision)
values('revision',15000,30000,TO_DATE('01/04/2012 00:00','dd/MM/YYYY hh24:mi'),TO_DATE('01/10/2012 12:45','dd/MM/YYYY hh24:mi'),303);


insert into pasa(id_revision,bastidor)
values(302,103);

insert into pasa(id_revision,bastidor)
values(302,103);




insert into revision(tipo,km_ultima,km_siguiente,fecha_ultima,fecha_siguiente,id_revision)
values('revision',0,20000,TO_DATE('01/01/2011 07:00','dd/MM/YYYY hh24:mi'),TO_DATE('01/04/2011 00:00','dd/MM/YYYY hh24:mi'),304);

insert into pasa(id_revision,bastidor)
values(304,101);





insert into revision(tipo,km_ultima,km_siguiente,fecha_ultima,fecha_siguiente,id_revision)
values('ITV',0,null,TO_DATE('01/01/2011 00:00','dd/MM/YYYY hh24:mi'),TO_DATE('01/01/2015 07:00','dd/MM/YYYY hh24:mi'),305);


insert into revision(tipo,km_ultima,km_siguiente,fecha_ultima,fecha_siguiente,id_revision)
values('ITV',0,null,TO_DATE('01/02/2012 07:00','dd/MM/YYYY hh24:mi'),TO_DATE('01/02/2016 07:00','dd/MM/YYYY hh24:mi'),306);


insert into pasa(id_revision,bastidor)
values(305,101);

insert into pasa(id_revision,bastidor)
values(306,103);



