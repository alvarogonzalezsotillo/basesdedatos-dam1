﻿-- RESPONDE A CADA PREGUNTA CON UNA SOLA SENTENCIA SQL

-- ¿Cuáles son las descripciones de los cursos que son requisito para otro curso?

-- Lista de alumnos, ordenados por apellidos y nombre (saludo, apellidos, nombre, estado de origen)

-- Lista de los 20 primeros alumnos, ordenados (ascendente) por apellidos y nombre (saludo, apellidos, nombre, estado de origen)

select salutation, last_name, first_name, state
from(
  select salutation, upper(last_name) as last_name, first_name, state
  from student s, zipcode z
  where s.zip = z.zip
  order by 2 asc, first_name asc
)
where rownum <= 20

-- Lista de los 20 siguientes alumnos, ordenados (ascendente) por apellidos y nombre (saludo, apellidos, nombre, estado de origen)
select fila, salutation, last_name, first_name, state
from(
  select rownum as fila, salutation, last_name, first_name, state
  from(
    select salutation, upper(last_name) as last_name, first_name, state
    from student s, zipcode z
    where s.zip = z.zip
    order by 2 asc, first_name asc
  )
)
where fila > 20 and fila <= 40


-- Lista de los 20 últimos alumnos, ordenados (ascendente) por apellidos y nombre (saludo, apellidos, nombre, estado de origen)
select fila, salutation, last_name, first_name, state
from(
  select rownum as fila, salutation, last_name, first_name, state
  from(
    select salutation, upper(last_name) as last_name, first_name, state
    from student s, zipcode z
    where s.zip = z.zip
    order by 2 asc, first_name asc
  )
)
where --fila es de las últimas 20
fila > (select count(*) from student)-20

-- Lista de las secciones con el número máximo de alumnos que podrían estar en esa seccion
select section_id 
from section s
where capacity = (select count(*) 
                   from enrollment where 
                   section_id=s.section_id)

-- Lista de todos los usuarios de la base de datos (sin duplicados) que han creado o modificado filas
select distinct u
from 
(
  select created_by u from grade_conversion 
  union
  select modified_by u from grade_conversion 
  union
  select created_by u from grade_type 
  union
  select modified_by u from grade_type 
  union
  select created_by u from grade
  union
  select modified_by u from grade
  union
  select created_by u from grade_type_weight 
  union
  select modified_by u from grade_type_weight 
  union
  select created_by u from enrollment 
  union
  select modified_by u from enrollment 
  union
  select created_by u from section 
  union
  select modified_by u from section 
  union
  select created_by u from course 
  union
  select modified_by u from course 
  union
  select created_by u from instructor 
  union
  select modified_by u from instructor 
  union
  select created_by u from student 
  union
  select modified_by u from student 
  union
  select created_by u from zipcode 
  union
  select modified_by u from zipcode 
)

-- Lista de las notas parciales obtenidas por los reverendos (nombre y apellidos del alumno, nota numérica, curso, tipo de nota)

-- Lista de las notas parciales otorgadas por los reverendos (nombre y apellidos del alumno, nota numérica, curso, tipo de nota)

-- Lista del número de alumnos de cada estado que asisten al curso "Operating Systems"

-- Lista de los profesores y los cursos que imparten (nombre, apellidos, descripción del curso)

-- Lista de los profesores y las secciones que imparten (nombre, apellidos, descripción del curso, identificador de sección)

-- ¿Qué profesor o profesores imparten más cursos?

-- ¿Qué profesor o profesores imparten en menos secciones?

-- Lista de profesores y número de alumnos a los que imparten algún curso (nombre, apellidos, número de alumnos)

-- Lista de profesores y número de alumnos a los que imparten algún curso, por sección (nombre, apellidos, descripción del curso, identificador de sección, número de alumnos)

-- Lista de las notas que se van a asignar en la sección 102 (tipo de nota, cuántas notas de ese tipo, cuánto cuenta este tipo de nota en la nota del curso)

-- Lista de las notas que se van a asignar (identificador de sección, tipo de nota, cuántas notas de ese tipo, cuánto cuenta este tipo de nota en la nota del curso)

-- Lista de las descripciones de los cursos que está siguiendo Angela Torres

-- Lista de la capacidad máxima y capacidad usada de cada sección (descripción del curso, identificador de sección, profesor, capacidad máxima, número de alumnos matriculados)

-- Notas parciales medias obtenidas por los alumnos por cada tipo de nota (descripción de tipo de nota, nota media obtenida)

-- Notas parciales medias obtenidas por los alumnos por cada tipo de nota, clasificado por estado de origen (descripción de tipo de nota, estado, nota media obtenida)

-- Notas parciales medias obtenidas por los alumnos por cada tipo de nota, clasificado por estado de origen (descripción de tipo de nota, estado, nota media obtenida)

-- Notas parciales medias obtenidas por los alumnos, clasificado por profesor (nombre del profesor, apellidos, nota media)

-- Nombre y apellidos del profesor que suele poner notas más altas

-- Nota numérica de la alumna Angela Torres en la sección 102
-- Cálculo: Se realiza un promedio de cada tipo de nota. Estos promedios se ponderan con el peso especificado.
-- Nota: ignoramos el criterio de no contar la más baja

-- Notas numéricas de la alumna Angela Torres en todos sus cursos (nota numérica, descripción del curso)

-- Notas de la alumna Angela Torres en todos sus cursos (nota numérica, nota alfabética, descripción del curso)

-- Notas numéricas de todos los alumnos en sus cursos (nombre, apellidos, nota numérica, descripción del curso)

-- Notas numéricas los alumnos de la sección número (nombre, apellidos, nota numérica, descripción del curso)

-- ¿Cuánto dinero se ha ingresado por las matrículas en los cursos?

-- Lista de los profesores que también son alumnos (nombre, apellidos)

-- Lista de los alumnos que no son profesores (nombre, apellidos)

-- Lista ordenada de los 10 mejores alumnos de acuerdo a la media de sus notas parciales (ranking, nombre, apellidos, nota media)

-- Lista ordenada de los 10 siguientes mejores alumnos de acuerdo a la media de sus notas parciales (ranking, nombre, apellidos, nota media)

-- Lista de secciones con menos de 15 alumnos matriculados (descripción del curso, identificador de sección, número de alumnos)

-- Lista de ingresos por curso (descripción de curso, ingresos)

-- Lista de ingresos por profesor (nombre, apellidos, ingresos)

-- Lista de ingresos por alumno (nombre, apellidos, ingresos)

