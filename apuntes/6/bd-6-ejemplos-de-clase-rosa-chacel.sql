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