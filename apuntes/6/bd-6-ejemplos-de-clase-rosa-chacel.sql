declare
  posibleprimo numeric(10,0) := 1000003;
  limitededivisores numeric(10,0);
  esprimo boolean := true;
begin
  limitededivisores := sqrt(posibleprimo)+1;
  for posibledivisor in 2..limitededivisores loop
     esprimo := mod(posibleprimo,posibledivisor) <> 0;
     exit when not esprimo;
  end loop;
  if( esprimo ) then
    dbms_output.put_line( posibleprimo || ' es primo'  );
  else
    dbms_output.put_line( posibleprimo || ' NO es primo'  );
  end if;
end;
/


create or replace function es_primo(posibleprimo IN number) return char
is
  esprimo boolean := true;
begin
  for posibledivisor in 2..(sqrt(posibleprimo)) loop
     esprimo := mod(posibleprimo,posibledivisor) <> 0;
     exit when not esprimo;
  end loop;
  return case esprimo
    when true then 's'
    else 'n' 
  end;  
end;
/

begin
  for i in 2 .. 1000 loop
    if( es_primo(i) = 's' ) then
      dbms_output.put_line( 'Es primo:' || i );
    end if;
  end loop;
end;
/


create or replace function bool2char(b in boolean) return varchar 
is
begin
  return (case b when true then 'si' else 'no' end );
end;
/

begin
  dbms_output.put_line( es_primo(1000003) );
end;
/


create or replace procedure sumaUno(n in out numeric)
is
begin
  n := n +1;
end;
/

declare
  numero numeric(10,0);
begin
  numero := 3;
  sumauno(3);
  dbms_output.put_line(numero);
end;
/

select * from student 
where es_primo(student_id)='s';

select es_primo(student_id), s.*
from student s;




create or replace function cuantos_se_llaman(nombre_o_apellidos in varchar) return numeric
as
  cuantosnombres numeric;
  cuantosapellidos numeric;

begin
  select count(*) 
     into cuantosnombres 
     from student 
     where first_name = nombre_o_apellidos;
  
  select count(*) 
     into cuantosapellidos 
     from student 
     where last_name = nombre_o_apellidos;
  
  return cuantosnombres + cuantosapellidos;

end;
/

begin
  dbms_output.put_line( cuantos_se_llaman('González') );
end;
/

select cuantos_se_llaman(last_name), last_name from student order by last_name;


create or replace procedure dar_de_alta_alumno(
  saludo in varchar,
  nombre in varchar,
  apellidos in varchar,
  nuevoid out numeric )
as
begin
  -- select max(student_id)+1 into nuevoid from student;
  
  select id_para_estudiantes.nextval into nuevoid from dual;
  
  insert into student(
    student_id,
    salutation,
    first_name,
    last_name,
    street_address,
    zip,
    phone,
    registration_date,
    created_by,
    created_date,
    modified_by,
    modified_date
  )
  values (
    nuevoid,
    saludo,
    nombre,
    apellidos,
    'Falta la calle',
    '00914',
    'n/a',
    SYSDATE,
    user,
    SYSDATE,
    user,
    SYSDATE
  );
end;
/

declare
  nuevoid numeric;
begin
  dar_De_alta_alumno('Mr.', 'Pepe', 'Bombo', nuevoid);
  dbms_output.put_line('Recién creado:' || nuevoid );
end;
/

create sequence ejemplosecuencia;

select ejemplosecuencia.nextval from dual;

select es_primo(2347) from dual;

create sequence id_para_estudiantes start with 1000;



SELECT * FROM STUDENT where last_name='Bombo';

commit;

select user from dual;




create or replace procedure copiar_hermano(
  id_existente numeric,
  nuevo_saludo varchar,
  nuevo_nombre varchar,
  id_creado out numeric )
as
    fila_existente student%rowtype;
begin

  select *
  into fila_existente
  from student
  --where student_id = id_existente
  ;




 select id_para_estudiantes.nextval into id_creado from dual;
  
  insert into student(
    student_id,
    salutation,
    first_name,
    last_name,
    street_address,
    zip,
    phone,
    registration_date,
    created_by,
    created_date,
    modified_by,
    modified_date
  )
  values (
    id_creado,
    nuevo_saludo,
    nuevo_nombre,
    fila_existente.last_name,
    fila_existente.street_address,
    fila_existente.zip,
    fila_existente.phone,
    SYSDATE,
    user,
    SYSDATE,
    user,
    SYSDATE
  );

end;
/
  
declare
  nuevoid numeric;
begin
  copiar_hermano(360,'Ms.', 'Lola', nuevoid );
  dbms_output.put_line(nuevoid);
end;
/

select * from student where student_id in (360, 1008, 1009);



create or replace function maxima_minima_nota(
  maximo out numeric,
  minimo out numeric
)
return varchar
as
  retorno varchar(15) := 'sin datos';
begin
  maximo := -1000;
  minimo := 1000;
  for g in (select * from grade) loop
    retorno := 'ok';
    maximo := greatest(maximo,g.numeric_grade);
    minimo := least(minimo,g.numeric_grade);
  end loop;
  return retorno;
end;
/

declare
  maximo numeric;
  minimo numeric;
  retorno varchar(5);
begin
  retorno := maxima_minima_nota(maximo,minimo);
  dbms_output.put_line( retorno || ': ' || maximo || ' -- ' || minimo );
end;
/




create or replace trigger ponle_id_al_student
before insert
on student
for each row
begin
  if( :new.student_id is null ) then
    :new.student_id := id_para_estudiantes.nextval;
  end if;
end;
/

create or replace trigger actualiza_lo_de_modificado
before update
on student
for each row
begin
  :new.modified_by := user;
  :new.modified_date := sysdate;
end;
/


insert into student(
  salutation,first_name,last_name,
  street_address,zip,phone,employer,
  registration_date,
  created_by,created_date, modified_by,modified_date)
values(
  'sal','nom','ape',
  'calle','00914','tel','emplo',
  SYSDATE,
  USER,SYSDATE,user,SYSDATE
);

select * from student where student_id=1013;

update clases.student set salutation='Mr.' where student_id=1013;

select sysdate from dual;

commit;

create or replace procedure inicializa_masa_salarial
as
  masa numeric;
begin
  select sum(sueldo) into masa from sueldos;
  update agregados set valor=masa where nombre='Masa salarial';
end;
/

create or replace procedure mantenimiento_masa_salarial(
  nuevosueldo numeric,
  viejosueldo numeric )
as
  aumento numeric;
  masa numeric;
  presupuesto numeric;
begin
  aumento := nuevosueldo - viejosueldo;
  dbms_output.put_line('aumento:' || aumento );
  select valor into masa from agregados where nombre='Masa salarial' for update;
  select valor into presupuesto from agregados where nombre='Presupuesto' for update;
  if( masa + aumento > presupuesto ) then
    raise_application_error( -20000, 'Te pasas de prespuesto, es ' || presupuesto || ' y querías gastarte ' || (masa + aumento) );
  end if;

  if( masa + aumento < 0 ) then
    raise_application_error( -20000, 'Algo pasa, me queda menos de 0 de masa salarial' );
  end if;

  update agregados set valor=masa+aumento where nombre='Masa salarial';

end;
/

create or replace trigger nuevo_sueldo
before insert on sueldos for each row
declare
begin
  mantenimiento_masa_salarial(:new.sueldo,0);
end;
/

create or replace trigger borrado_sueldo
before delete on sueldos for each row
declare
begin
  mantenimiento_masa_salarial(0,:old.sueldo);
end;
/

create or replace trigger cambio_sueldo
before update on sueldos for each row
declare
begin
  mantenimiento_masa_salarial(:new.sueldo,:old.sueldo);
end;
/


create table Sueldos( empleado varchar(50) primary key, sueldo numeric(10,2) );

create table agregados( nombre varchar(50) primary key, valor numeric(10,2) );

insert into sueldos values( 'Pepe', 1200 );
insert into sueldos values( 'María', 1205 );
insert into sueldos values( 'Juan', 605 );
insert into sueldos values( 'Susana', 100 );
insert into sueldos values( 'Pepa', 300 );

update sueldos set sueldo=450 where empleado='Pepa';


insert into agregados values( 'Masa salarial', 1200 +1205 );
insert into agregados values( 'Presupuesto', 4000 );

select 'suma', sum(sueldo) from sueldos
union
select 'agregado', valor from agregados where nombre = 'Masa salarial';

delete from sueldos where empleado in ('Susana','Pepa');
commit;
rollback;

select * from sueldos;

begin inicializa_masa_salarial; end;
/



