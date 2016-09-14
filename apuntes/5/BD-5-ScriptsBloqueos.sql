select session_id "sid",SERIAL#  "Serial",
substr(object_name,1,20) "Object",
  substr(os_user_name,1,10) "Terminal",
  substr(oracle_username,1,10) "Locker",
  nvl(lockwait,'active') "Wait",
  decode(locked_mode,
    2, 'row share',
    3, 'row exclusive',
    4, 'share',
    5, 'share row exclusive',
    6, 'exclusive',  'unknown') "Lockmode",
  OBJECT_TYPE "Type"
FROM
  SYS.V_$LOCKED_OBJECT A,
  SYS.ALL_OBJECTS B,
  SYS.V_$SESSION c
WHERE
  A.OBJECT_ID = B.OBJECT_ID AND
  C.SID = A.SESSION_ID
ORDER BY 1 ASC, 5 Desc;


-- http://www.orafaq.com/node/854
select s1.username || '@' || s1.machine
  || ' ( SID=' || s1.sid || ' )  is blocking '
  || s2.username || '@' || s2.machine || ' ( SID=' || s2.sid || ' ) ' AS blocking_status
  from v$lock l1, v$session s1, v$lock l2, v$session s2
  where s1.sid=l1.sid and s2.sid=l2.sid
  and l1.BLOCK=1 and l2.request > 0
  and l1.id1 = l2.id1
  and l2.id2 = l2.id2 ;


-- SABER LA SENTENCIA SQL QUE PROVOCA EL BLOQUEO (hay que poner el sid bloqueante, no el bloqueado)
select s.sid, q.sql_text from v$sqltext q, v$session s
where q.address = s.sql_address
and s.sid = &sid
order by piece;


-- USUARIOS CONECTADOS
select
  username,
  osuser,
  terminal--,
  --utl_inaddr.get_host_address(terminal) IP_ADDRESS
from
  v$session
where
  username is not null
order by
  username,
  osuser;

SELECT s.username, s.program, s.logon_time
FROM v$session s, v$process p, sys.v_$sess_io si
WHERE s.paddr = p.addr(+)
AND si.sid(+) = s.sid
AND s.type = 'USER'; 

