
* MATRICULAR UN HERMANO
Un hermano comparte todos los datos, excepto el nombre y el tratamiento
#+begin_src sql
create or replace 
PROCEDURE MATRICULAR_HERMANO(student_id_existente number, saludo_hermano varchar, nombre_hermano varchar) AS 
  alumno_existente student%ROWTYPE;
BEGIN
  select * into alumno_existente from student where student_id = student_id_existente;
  
  select max(student_id)+1 into alumno_existente.student_id from student;

  alumno_existente.salutation := saludo_hermano;  
  alumno_existente.first_name := nombre_hermano;
  
  insert into student values alumno_existente;
  
END MATRICULAR_HERMANO;
#+end_src
--------------------------------------------------------------------------------
#+begin_src sql
create or replace 
FUNCTION MEDIA_DE_GRADES(minimo number) RETURN number AS 
  total number;
  numero number;
BEGIN
  total := 0;
  numero := 0;
  for g in (select numeric_grade from grade) 
  loop
    if g.numeric_grade > minimo then
      total := total + g.numeric_grade;
      numero := numero + 1;
    end if;
  end loop;
  
  return total/numero;
  
END MEDIA_DE_GRADES;
#+end_src
--------------------------------------------------------------------------------
#+begin_src sql
create or replace 
FUNCTION SUMACOSTES RETURN NUMBER AS 
  CURSOR c_courses is select cost, course_no from course;
  resultado number;
  coste number;
  numerocurso number;
BEGIN
  resultado := 0;
  open c_courses;
  
  fetch c_courses into coste, numerocurso;
  while not c_courses%NOTFOUND LOOP
    if coste is not null then
      resultado := resultado + coste;
    else
      SYS.dbms_output.put_line( 'Es null:' || numerocurso );
    end if;
    fetch c_courses into coste, numerocurso;
  end loop;
  
  close c_courses;
  return resultado;
END;
#+end_src
---------------------------------------------------------------------------------
#+begin_src sql
CREATE OR REPLACE TRIGGER "ALUMNO"."PONER_ID_A_STUDENT" 
   before insert on "ALUMNO"."STUDENT" 
   for each row 
begin  
   if inserting then 
      if :NEW."STUDENT_ID" is null then 
         select STUDENT_ID_SEQ.nextval into :NEW."STUDENT_ID" from dual; 
      end if; 
   end if; 
end;
ALTER TRIGGER "ALUMNO"."PONER_ID_A_STUDENT" ENABLE;
#+end_src
---------------------------------------------------------------------------------
#+begin_src sql
CREATE TRIGGER COMPROBAR_SUELDO
BEFORE
INSERT OR UPDATE OF SALARIO, PUESTO ON EMPLEADOS
FOR EACH ROW
WHEN (NEW.PUESTO <> 'PRESIDENTE')
DECLARE
SUELDO_FUERA_RANGO EXCEPTION;
BEGIN
IF (:NEW.SALARIO < 100000 OR
:NEW.SALARIO > 1000000) THEN
RAISE SUELDO_FUERA_RANGO;
END IF;
END;
#+end_src
-------------------------------------------------------------------------------------

#+begin_src sql
CREATE OR REPLACE TRIGGER MASA_SALARIAL_BORRANDO 
BEFORE DELETE ON SUELDOS 
FOR EACH ROW 
BEGIN
  UPDATE masasalarialtotal set total = total - :old.sueldo;
END; 
#+end_src
--------------------------------------------------------------------------------------
#+begin_src sql
CREATE OR REPLACE TRIGGER MENOR_DE_UN_MILLON 
BEFORE INSERT or update ON SUELDOS
for each row
declare
  masasalarial number;
  sueldo_fuera_de_rango exception;
BEGIN

  if inserting then
    select sum(sueldo) into masasalarial from sueldos;
    if masasalarial is null then
      masasalarial := 0;
    end if;
    masasalarial := masasalarial + :new.sueldo;
  end if;
  
  if updating then
    select total into masasalarial from masasalarialtotal where id=1;
    masasalarial := masasalarial - :old.sueldo + :new.sueldo;
  end if;
  
  if  masasalarial > 1000000  then
    raise  sueldo_fuera_de_rango;
  end if;
  
  update masasalarialtotal set total = masasalarial;
END;
#+end_src
--------------------------------------------------------------------------------------
#+begin_src sql
CREATE OR REPLACE PROCEDURE INICIALIZA_MASA_SALARIAL_TOTAL AS 
  t number;
BEGIN
  select sum(sueldo) into t from sueldos;
  update masasalarialtotal set total = t;
END INICIALIZA_MASA_SALARIAL_TOTAL;
#+end_src
