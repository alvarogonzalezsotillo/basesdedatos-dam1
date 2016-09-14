-- Creación de usuario
create user agonzalez identified by agonzalez default tablespace users;

-- Otorgar privilegios
grant connect to agonzalez
grant create table to agonzalez
grant select on alumno.student to agonzalez
grant update(first_name) on alumno.student to agonzalez

-- Crear roles
create role manejadordezips;
grant select, update, delete on alumno.zipcode to manejadordezips

-- Otorgar roles 
grant manejadordezips to agonzalez

-- Roles del usuario actual
SELECT * 
FROM user_role_privs;

-- Permisos asignados a cada rol del usuario actual
SELECT *
FROM role_sys_privs;

-- Quitar roles y permisos
revoke manejadordezips from agonzalez

