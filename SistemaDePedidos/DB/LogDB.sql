
/*------ SYSDBA 05/11/2015 20:56:18 --------*/

select * from RDB$REF_CONSTRAINTS;
/*------ SYSDBA 05/11/2015 20:56:42 --------*/

select RDB$CONSTRAINT_NAME, RDB$CONST_NAME_UQ from RDB$REF_CONSTRAINTS;
/*------ SYSDBA 05/11/2015 20:57:21 --------*/


select RDB$CONSTRAINT_NAME, RDB$CONST_NAME_UQ from RDB$REF_CONSTRAINTS;
/*------ SYSDBA 05/11/2015 20:58:41 --------*/


select RDB$CONSTRAINT_NAME, RDB$RELATION_NAME from RDB$RELATION_CONSTRAINTS ;
/*------ SYSDBA 05/11/2015 21:01:11 --------*/


select R.RDB$CONSTRAINT_NAME, R.RDB$RELATION_NAME, C.RDB$CONST_NAME_UQ from RDB$REF_CONSTRAINTS C
 inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME;

select R.RDB$CONSTRAINT_NAME, R.RDB$RELATION_NAME,R2.RDB$CONSTRAINT_NAME, R2.RDB$RELATION_NAME,  from RDB$REF_CONSTRAINTS C
 inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
 inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ
/*------ SYSDBA 05/11/2015 21:02:08 --------*/


select R.RDB$CONSTRAINT_NAME, R.RDB$RELATION_NAME,R2.RDB$CONSTRAINT_NAME, R2.RDB$RELATION_NAME  from RDB$REF_CONSTRAINTS C
 inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
 inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ;
/*------ SYSDBA 05/11/2015 21:04:39 --------*/


select R.RDB$CONSTRAINT_NAME, R.RDB$RELATION_NAME,R2.RDB$CONSTRAINT_NAME, R2.RDB$RELATION_NAME  from RDB$REF_CONSTRAINTS C
 inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
 inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ;
/*------ SYSDBA 05/11/2015 21:04:55 --------*/


select R.RDB$CONSTRAINT_NAME, R.RDB$RELATION_NAME,R2.RDB$CONSTRAINT_NAME, R2.RDB$RELATION_NAME  from RDB$REF_CONSTRAINTS C
 inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
 FULL join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ;
/*------ SYSDBA 05/11/2015 21:05:29 --------*/


select R.RDB$CONSTRAINT_NAME, R.RDB$RELATION_NAME from RDB$REF_CONSTRAINTS C
 inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME;
/*------ SYSDBA 05/11/2015 21:06:53 --------*/


select R.RDB$CONSTRAINT_NAME, R.RDB$RELATION_NAME,R2.RDB$CONSTRAINT_NAME, R2.RDB$RELATION_NAME  from RDB$REF_CONSTRAINTS C
 inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
 inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ
;
/*------ SYSDBA 05/11/2015 21:07:51 --------*/


select R.RDB$CONSTRAINT_NAME, R.RDB$RELATION_NAME,R2.RDB$CONSTRAINT_NAME, R2.RDB$RELATION_NAME  from RDB$REF_CONSTRAINTS C
 inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
 inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ;
/*------ SYSDBA 05/11/2015 21:13:53 --------*/


select R.rdb$constraint_name as NameFKOrigem, R.RDB$RELATION_NAME NameTableOrigem,
    R2.RDB$CONSTRAINT_NAME as NamePkReference, R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
 inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
 inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ
  where  R2.RDB$RELATION_NAME = 'PAIS';
/*------ SYSDBA 05/11/2015 21:14:56 --------*/

    select rdb$get_context('SYSTEM', 'DB_NAME') from rdb$database;
ROLLBACK WORK;

/*------ SYSDBA 05/11/2015 21:42:25 --------*/

select R.rdb$constraint_name as NameFKOrigem, R.RDB$RELATION_NAME NameTableOrigem,
        R2.RDB$CONSTRAINT_NAME as NamePkReference, R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ;
/*------ SYSDBA 05/11/2015 21:48:12 --------*/

select R.rdb$constraint_name as NameFKOrigem, R.RDB$RELATION_NAME NameTableOrigem,
        R2.RDB$CONSTRAINT_NAME as NamePkReference, R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ;
ROLLBACK WORK;

NameTableOrigem
Create procedure GeneratorViewDepedenceDB as
declare variable as NameTableOrigem Varchar(200);
declare variable NameTableReference Varchar(200);

declare CursorDependencia cursor for
  (select distinct R.RDB$RELATION_NAME NameTableOrigem,R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :RNAME;
       IF (ROW_COUNT = 0) THEN
          LEAVE;
       SUSPEND;
    END
    CLOSE C;
end
Create procedure GeneratorViewDepedenceDB as
declare  NameTableOrigem Varchar(200);
declare  NameTableReference Varchar(200);

declare CursorDependencia cursor for
  (select distinct R.RDB$RELATION_NAME NameTableOrigem,R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :RNAME;
       IF (ROW_COUNT = 0) THEN
          LEAVE;
       SUSPEND;
    END
    CLOSE C;
end
Create procedure GeneratorViewDepedenceDB as
declare NameTableOrigem Varchar(200);
declare NameTableReference Varchar(200);

declare CursorDependencia cursor for
  (select distinct R.RDB$RELATION_NAME NameTableOrigem,R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :NameTableOrigem, :NameTableReference;
       IF (ROW_COUNT = 0) THEN
          LEAVE;
       SUSPEND;
    END
    CLOSE C;
end
/*------ SYSDBA 05/11/2015 22:00:49 --------*/


SET TERM ^ ;

Create procedure GeneratorViewDepedenceDB as
declare NameTableOrigem Varchar(200);
declare NameTableReference Varchar(200);

declare CursorDependencia cursor for
  (select distinct R.RDB$RELATION_NAME NameTableOrigem,R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :NameTableOrigem, :NameTableReference;
       IF (ROW_COUNT = 0) THEN
          LEAVE;
       SUSPEND;
    END
    CLOSE CursorDependencia;
end^

SET TERM ; ^
/*------ SYSDBA 05/11/2015 22:01:32 --------*/

select distinct R.RDB$RELATION_NAME NameTableOrigem,R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ;
/*------ SYSDBA 05/11/2015 22:02:21 --------*/


       select * from RDB$RELATION_FIELDS;
/*------ SYSDBA 05/11/2015 22:02:27 --------*/


       select * from RDB$RELATION_FIELDS;
/*------ SYSDBA 05/11/2015 22:03:20 --------*/


       select * from RDB$RELATION_FIELDS where rdb$relation_name = 'PAIS';
/*------ SYSDBA 05/11/2015 22:04:31 --------*/

select distinct R.RDB$RELATION_NAME NameTableOrigem,R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ
;
/*------ SYSDBA 05/11/2015 22:11:42 --------*/

select f.rdb$relation_name, f.rdb$field_name
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0)
order by 1, f.rdb$field_position;
/*------ SYSDBA 05/11/2015 22:12:08 --------*/

select f.*, f.rdb$relation_name, f.rdb$field_name
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0)
order by 1, f.rdb$field_position;
/*------ SYSDBA 05/11/2015 22:14:22 --------*/

select distinct R.RDB$RELATION_NAME NameTableOrigem,R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ
;
/*------ SYSDBA 05/11/2015 22:16:17 --------*/


       SELECT RDB$INDEX_NAME
FROM RDB$INDICES;
/*------ SYSDBA 05/11/2015 22:16:28 --------*/


       SELECT *
FROM RDB$INDICES;
SELECT RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS field_name,
RDB$INDICES.RDB$DESCRIPTION AS description,
(RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION + 1) AS field_position
FROM RDB$INDEX_SEGMENTS
LEFT JOIN RDB$INDICES ON RDB$INDICES.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS ON RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
WHERE
AND RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE IS NULL
ORDER BY RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION
/*------ SYSDBA 05/11/2015 22:17:47 --------*/

SELECT RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS field_name,
RDB$INDICES.RDB$DESCRIPTION AS description,
(RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION + 1) AS field_position
FROM RDB$INDEX_SEGMENTS
LEFT JOIN RDB$INDICES ON RDB$INDICES.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS ON RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
WHERE
 RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE IS NULL
ORDER BY RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION;
/*------ SYSDBA 05/11/2015 22:18:24 --------*/

SELECT RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS field_name,
RDB$INDICES.RDB$DESCRIPTION AS description,
(RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION + 1) AS field_position
FROM RDB$INDEX_SEGMENTS
LEFT JOIN RDB$INDICES ON RDB$INDICES.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS ON RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
ORDER BY RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION;
/*------ SYSDBA 05/11/2015 22:18:43 --------*/

SELECT RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS field_name,
RDB$INDICES.RDB$DESCRIPTION AS description,
(RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION + 1) AS field_position
FROM RDB$INDEX_SEGMENTS
LEFT JOIN RDB$INDICES ON RDB$INDICES.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS ON RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
WHERE
 not RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE IS NULL
ORDER BY RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION;
/*------ SYSDBA 05/11/2015 22:20:27 --------*/

SELECT RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS field_name,
RDB$INDICES.RDB$DESCRIPTION AS description,
(RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION + 1) AS field_position
FROM RDB$INDEX_SEGMENTS
LEFT JOIN RDB$INDICES ON RDB$INDICES.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS ON RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
WHERE
  RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION;
/*------ SYSDBA 05/11/2015 22:20:49 --------*/

SELECT RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS field_name,
RDB$INDICES.RDB$DESCRIPTION AS description,
(RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION + 1) AS field_position, RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE
FROM RDB$INDEX_SEGMENTS
LEFT JOIN RDB$INDICES ON RDB$INDICES.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS ON RDB$RELATION_CONSTRAINTS.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
WHERE
  RDB$RELATION_CONSTRAINTS.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION;
/*------ SYSDBA 05/11/2015 22:21:25 --------*/

SELECT RDB$INDEX_SEGMENTS.RDB$FIELD_NAME AS field_name,
RDB$INDICES.RDB$DESCRIPTION AS description,
(RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION + 1) AS field_position, C.*
FROM RDB$INDEX_SEGMENTS
LEFT JOIN RDB$INDICES ON RDB$INDICES.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = RDB$INDEX_SEGMENTS.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY RDB$INDEX_SEGMENTS.RDB$FIELD_POSITION;
SELECT S.RDB$FIELD_NAME AS field_name,
I.RDB$DESCRIPTION AS description,
(S.RDB$FIELD_POSITION + 1) AS field_position, S.*
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY3
/*------ SYSDBA 05/11/2015 22:23:30 --------*/

SELECT S.RDB$FIELD_NAME AS field_name,
I.RDB$DESCRIPTION AS description,
(S.RDB$FIELD_POSITION + 1) AS field_position, S.*
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 3;
/*------ SYSDBA 05/11/2015 22:23:54 --------*/

SELECT S.RDB$FIELD_NAME AS field_name,
I.RDB$DESCRIPTION AS description,
(S.RDB$FIELD_POSITION + 1) AS field_position, I.*
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 3;
/*------ SYSDBA 05/11/2015 22:24:09 --------*/

SELECT S.RDB$FIELD_NAME AS field_name,
I.RDB$DESCRIPTION AS description,
(S.RDB$FIELD_POSITION + 1) AS field_position, I.*
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 3;
/*------ SYSDBA 05/11/2015 22:24:16 --------*/

SELECT S.RDB$FIELD_NAME AS field_name,
I.RDB$DESCRIPTION AS description,
(S.RDB$FIELD_POSITION + 1) AS field_position, I.*
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2;
/*------ SYSDBA 05/11/2015 22:27:20 --------*/

SELECT S.RDB$FIELD_NAME AS field_name, I.rdb$index_name,  i.rdb$relation_name, i.rdb$foreign_key
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2;
/*------ SYSDBA 05/11/2015 22:27:57 --------*/

SELECT S.RDB$FIELD_NAME AS field_name, I.rdb$index_name,  i.rdb$relation_name, i.rdb$foreign_key, i.*
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2;
/*------ SYSDBA 05/11/2015 22:28:46 --------*/

SELECT S.RDB$FIELD_NAME AS field_name, I.rdb$index_name,  i.rdb$relation_name, i.rdb$foreign_key, f.*
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2;
/*------ SYSDBA 05/11/2015 22:29:18 --------*/

SELECT S.RDB$FIELD_NAME AS field_name, I.rdb$index_name,  i.rdb$relation_name, i.rdb$foreign_key, f.rdb$relation_name
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2;
/*------ SYSDBA 05/11/2015 22:31:02 --------*/

select * from RDB$INDICES I ;
/*------ SYSDBA 05/11/2015 22:31:46 --------*/

SELECT S.RDB$FIELD_NAME AS field_name, I.rdb$index_name,  i.rdb$relation_name, i.rdb$foreign_key, f.rdb$relation_name
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDICES IP ON IP.RDB$INDEX_NAME = f.RDB$INDEX_NAME

WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2;
SELECT S.RDB$FIELD_NAME AS field_name, I.rdb$index_name,  i.rdb$relation_name, i.rdb$foreign_key, f.rdb$relation_name, Sp.RDB$FIELD_NAME AS field_name
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
                                                                       ]
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2
/*------ SYSDBA 05/11/2015 22:32:37 --------*/

SELECT S.RDB$FIELD_NAME AS field_name, I.rdb$index_name,  i.rdb$relation_name, i.rdb$foreign_key, f.rdb$relation_name, Sp.RDB$FIELD_NAME AS field_name
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2;
/*------ SYSDBA 05/11/2015 22:34:32 --------*/

SELECT i.rdb$relation_name as TableOrigem, I.rdb$index_name as IndexOrigem,
S.RDB$FIELD_NAME as FieldNameOrigem,
f.rdb$relation_name as TableReference, i.rdb$foreign_key as IndexReference, Sp.RDB$FIELD_NAME AS FieldNameReference
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2;
/*------ SYSDBA 05/11/2015 22:37:50 --------*/


SELECT i.rdb$relation_name as TableOrigem, I.rdb$index_name as IndexOrigem,
S.RDB$FIELD_NAME as FieldNameOrigem,
f.rdb$relation_name as TableReference, i.rdb$foreign_key as IndexReference, Sp.RDB$FIELD_NAME AS FieldNameReference
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2;

SELECT i.rdb$relation_name as TableOrigem, I.rdb$index_name as IndexOrigem,
S.RDB$FIELD_NAME as FieldNameOrigem,
f.rdb$relation_name as TableReference, i.rdb$foreign_key as IndexReference, Sp.RDB$FIELD_NAME AS FieldNameReference
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 2
   order by 1, 2
/*------ SYSDBA 05/11/2015 22:38:26 --------*/


SELECT i.rdb$relation_name as TableOrigem, I.rdb$index_name as IndexOrigem,
S.RDB$FIELD_NAME as FieldNameOrigem,
f.rdb$relation_name as TableReference, i.rdb$foreign_key as IndexReference, Sp.RDB$FIELD_NAME AS FieldNameReference
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE')
ORDER BY 1, 2;
/*------ SYSDBA 05/11/2015 22:39:36 --------*/


SELECT i.rdb$relation_name as TableOrigem, I.rdb$index_name as IndexOrigem,
S.RDB$FIELD_NAME as FieldNameOrigem,
f.rdb$relation_name as TableReference, i.rdb$foreign_key as IndexReference, Sp.RDB$FIELD_NAME AS FieldNameReference
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE') and (not (i.rdb$relation_name like 'rdb$%'))
ORDER BY 1, 2;
/*------ SYSDBA 05/11/2015 22:40:07 --------*/


SELECT i.rdb$relation_name as TableOrigem, I.rdb$index_name as IndexOrigem,
S.RDB$FIELD_NAME as FieldNameOrigem,
f.rdb$relation_name as TableReference, i.rdb$foreign_key as IndexReference, Sp.RDB$FIELD_NAME AS FieldNameReference
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE') and (not (i.rdb$relation_name like '$%'))
ORDER BY 1, 2;
/*------ SYSDBA 05/11/2015 22:40:13 --------*/


SELECT i.rdb$relation_name as TableOrigem, I.rdb$index_name as IndexOrigem,
S.RDB$FIELD_NAME as FieldNameOrigem,
f.rdb$relation_name as TableReference, i.rdb$foreign_key as IndexReference, Sp.RDB$FIELD_NAME AS FieldNameReference
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE') and (not (i.rdb$relation_name like '%$%'))
ORDER BY 1, 2;
ROLLBACK WORK;

/*------ SYSDBA 05/11/2015 22:42:37 --------*/

select * from ShowDBDependence;
ROLLBACK WORK;

/*------ SYSDBA 05/11/2015 22:43:34 --------*/

select f.*, f.rdb$relation_name, f.rdb$field_name
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0)
order by 1, f.rdb$field_position;
/*------ SYSDBA 05/11/2015 22:43:58 --------*/

select distinct R.RDB$RELATION_NAME NameTableOrigem,R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ;
Create procedure GeneratorViewDepedenceDB as
declare NameTableOrigem Varchar(200);
declare NameTableReference Varchar(200);

declare CursorDependencia cursor for
  (select * from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :NameTableOrigem, :NameTableReference;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
Create procedure GeneratorViewDepedenceDB as
declare NameTableOrigem Varchar(200);
declare NameTableReference Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :NameTableOrigem, :NameTableReference;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
ROLLBACK WORK;


       select * from RDB$RELATION_FIELDS where rdb$relation_name = 'PAIS' and rdb$field_name <>

/*------ SYSDBA 05/11/2015 22:45:17 --------*/


       select * from RDB$RELATION_FIELDS where rdb$relation_name = 'PAIS' ;
Create procedure GeneratorViewDepedenceDB as
declare NameTableOrigem Varchar(200);
declare NameTableReference Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :NameTableOrigem, :NameTableReference;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
/*------ SYSDBA 05/11/2015 22:45:38 --------*/


SET TERM ^ ;

Create procedure GeneratorViewDepedenceDB as
declare NameTableOrigem Varchar(200);
declare NameTableReference Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN

       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end^

SET TERM ; ^
Create procedure GeneratorViewDepedenceDB as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :NameTableOrigem, :NameTableReference;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
Create procedure GeneratorViewDepedenceDB as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
Create or replace procedure GeneratorViewDepedenceDB as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
Create procedure GeneratorViewDepedenceDB as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
Create procedure GeneratorViewDepedenceDB as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
Create procedure GeneratorViewDepedenceDB as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
drop procedure GeneratorViewDepedenceDB;
Create procedure GeneratorViewDepedenceDB as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end
/*------ SYSDBA 05/11/2015 22:48:34 --------*/

drop procedure GeneratorViewDepedenceDB;
/*------ SYSDBA 05/11/2015 22:48:37 --------*/


SET TERM ^ ;


Create procedure GeneratorViewDepedenceDB as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin
 OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

       SUSPEND;
    END
    CLOSE CursorDependencia;
end^

SET TERM ; ^
SET TERM ^ ;

create or alter procedure "GeneratorViewDependencies"
as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin

OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

    END
    CLOSE CursorDependencia;
  suspend;
end^

SET TERM ; ^

/* Existing privileges on this procedure */

GRANT EXECUTE ON PROCEDURE "GeneratorViewDependencies" TO SYSDBA;


create or alter procedure "GeneratorViewDependencies"
as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin

OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

    END
    CLOSE CursorDependencia;
  suspend;
end^

SET TERM ; ^

/* Existing privileges on this procedure */

GRANT EXECUTE ON PROCEDURE "GeneratorViewDependencies" TO SYSDBA;


create or alter procedure "GeneratorViewDependencies"
as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin

OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

    END
    CLOSE CursorDependencia;
  suspend;
end

SET TERM ; ^

/* Existing privileges on this procedure */

GRANT EXECUTE ON PROCEDURE "GeneratorViewDependencies" TO SYSDBA;


create or alter procedure "GeneratorViewDependencies"
as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin

OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

    END
    CLOSE CursorDependencia;
  suspend;
end


/* Existing privileges on this procedure */

GRANT EXECUTE ON PROCEDURE "GeneratorViewDependencies" TO SYSDBA;
/*------ SYSDBA 05/11/2015 22:52:59 --------*/



create or alter procedure "GeneratorViewDependencies"
as
declare FIELDNAMEORIGEM Varchar(200);
declare TABLEREFERENCE Varchar(200);
declare INDEXORIGEM integer;
declare TABLEORIGEM Varchar(200);
declare INDEXREFERENCE integer;
declare FIELDNAMEREFERENCE Varchar(200);

declare CursorDependencia cursor for
  (select TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE from ShowDBDependence);
begin

OPEN CursorDependencia;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CursorDependencia INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

    END
    CLOSE CursorDependencia;
  suspend;
end;
COMMIT WORK;

/*------ SYSDBA 05/11/2015 22:53:59 --------*/

SELECT RDB$FIELD_NAME
FROM RDB$RELATION_FIELDS
WHERE RDB$RELATION_NAME='TEST2';
/*------ SYSDBA 05/11/2015 22:54:07 --------*/

SELECT RDB$FIELD_NAME
FROM RDB$RELATION_FIELDS
WHERE RDB$RELATION_NAME='CIDADE';
/*------ SYSDBA 05/11/2015 22:54:20 --------*/


select f.*, f.rdb$relation_name, f.rdb$field_name
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0)
order by 1, f.rdb$field_position;
/*------ SYSDBA 05/11/2015 22:55:04 --------*/


select f.rdb$relation_name, f.rdb$field_name
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0)
order by 1, f.rdb$field_position;
CREATE OR ALTER VIEW SHOWDBDEPENDENCE(
    TABLENAME,
    FIELDNAME)
AS

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and (not (i.rdb$relation_name like '%$%'))
ORDER BY 1, 2
/*------ SYSDBA 05/11/2015 22:57:15 --------*/

CREATE OR ALTER VIEW SHOWDBDEPENDENCE(
    TABLENAME,
    FIELDNAME)
AS

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY 1, 2;
/*------ SYSDBA 05/11/2015 22:58:05 --------*/

CREATE OR ALTER VIEW SHOWListFieldDB(
    TABLENAME,
    FIELDNAME)
AS

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY 1, 2;
ROLLBACK WORK;

/*------ SYSDBA 05/11/2015 22:58:18 --------*/

CREATE OR ALTER VIEW SHOWListFieldDB(
    TABLENAME,
    FIELDNAME)
AS

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY 1, 2;
COMMIT WORK;

/*------ SYSDBA 05/11/2015 22:58:35 --------*/

select * from SHOWListFieldDB;
ROLLBACK WORK;


create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200);
declare CURSORDEPENDENCIES cursor for (
    select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE);          
declare CURSORFIELDS cursor for (
    select TABLENAME, FIELDNAME
    from SHOWLISTFIELDDB);
begin

OPEN CURSORDEPENDENCIES;   
OPEN CURSORFIELDS;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CURSORDEPENDENCIES INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

    END
    CLOSE CURSORDEPENDENCIES; 
    CLOSE CURSORFIELDS;
  suspend;
end^

SET TERM ; ^
/*------ SYSDBA 05/11/2015 23:00:56 --------*/


create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200);
declare CURSORDEPENDENCIES cursor for (
    select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE);          
declare CURSORFIELDS cursor for (
    select TABLENAME, FIELDNAME
    from SHOWLISTFIELDDB);
begin

OPEN CURSORDEPENDENCIES;   
OPEN CURSORFIELDS;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CURSORDEPENDENCIES INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;

    END
    CLOSE CURSORDEPENDENCIES; 
    CLOSE CURSORFIELDS;
  suspend;
end;
COMMIT WORK;


create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200);
declare CURSORDEPENDENCIES cursor for (
    select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE);
declare CURSORFIELDS cursor;
begin

OPEN CURSORDEPENDENCIES;   
OPEN CURSORFIELDS;
    WHILE (1 = 1) DO
    BEGIN
       FETCH CURSORDEPENDENCIES INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE;
       IF (ROW_COUNT = 0) THEN
          LEAVE;
    for (select TABLENAME, FIELDNAME
        from SHOWLISTFIELDDB) into CURSORFIELDS do
    end;

    END
    CLOSE CURSORDEPENDENCIES; 
    CLOSE CURSORFIELDS;
  suspend;
end
/*------ SYSDBA 05/11/2015 23:04:09 --------*/

SELECT DISTINCT
rc.RDB$CONSTRAINT_NAME AS "constraint_name",
rc.RDB$RELATION_NAME AS "on table",
d1.RDB$FIELD_NAME AS "on field",
d2.RDB$DEPENDED_ON_NAME AS "references table",
d2.RDB$FIELD_NAME AS "references field",
refc.RDB$UPDATE_RULE AS "on update",
refc.RDB$DELETE_RULE AS "on delete"
FROM RDB$RELATION_CONSTRAINTS AS rc
LEFT JOIN RDB$REF_CONSTRAINTS refc ON rc.RDB$CONSTRAINT_NAME = refc.RDB$CONSTRAINT_NAME
LEFT JOIN RDB$DEPENDENCIES d1 ON d1.RDB$DEPENDED_ON_NAME = rc.RDB$RELATION_NAME
LEFT JOIN RDB$DEPENDENCIES d2 ON d1.RDB$DEPENDENT_NAME = d2.RDB$DEPENDENT_NAME
WHERE rc.RDB$CONSTRAINT_TYPE = 'FOREIGN KEY'
AND d1.RDB$DEPENDED_ON_NAME <> d2.RDB$DEPENDED_ON_NAME
AND d1.RDB$FIELD_NAME <> d2.RDB$FIELD_NAME
AND rc.RDB$RELATION_NAME = 'b'  -- table nam;
/*------ SYSDBA 05/11/2015 23:04:18 --------*/

SELECT DISTINCT
rc.RDB$CONSTRAINT_NAME AS "constraint_name",
rc.RDB$RELATION_NAME AS "on table",
d1.RDB$FIELD_NAME AS "on field",
d2.RDB$DEPENDED_ON_NAME AS "references table",
d2.RDB$FIELD_NAME AS "references field",
refc.RDB$UPDATE_RULE AS "on update",
refc.RDB$DELETE_RULE AS "on delete"
FROM RDB$RELATION_CONSTRAINTS AS rc
LEFT JOIN RDB$REF_CONSTRAINTS refc ON rc.RDB$CONSTRAINT_NAME = refc.RDB$CONSTRAINT_NAME
LEFT JOIN RDB$DEPENDENCIES d1 ON d1.RDB$DEPENDED_ON_NAME = rc.RDB$RELATION_NAME
LEFT JOIN RDB$DEPENDENCIES d2 ON d1.RDB$DEPENDENT_NAME = d2.RDB$DEPENDENT_NAME
WHERE rc.RDB$CONSTRAINT_TYPE = 'FOREIGN KEY'
AND d1.RDB$DEPENDED_ON_NAME <> d2.RDB$DEPENDED_ON_NAME
AND d1.RDB$FIELD_NAME <> d2.RDB$FIELD_NAME;
SELECT DISTINCT
rc.RDB$CONSTRAINT_NAME AS constraint_name,
rc.RDB$RELATION_NAME AS table,
d1.RDB$FIELD_NAME AS field,
d2.RDB$DEPENDED_ON_NAME AS ReferencesTable,
d2.RDB$FIELD_NAME AS ReferencesField,
refc.RDB$UPDATE_RULE AS OnUpdate,
refc.RDB$DELETE_RULE AS OnDelete
FROM RDB$RELATION_CONSTRAINTS AS rc
LEFT JOIN RDB$REF_CONSTRAINTS refc ON rc.RDB$CONSTRAINT_NAME = refc.RDB$CONSTRAINT_NAME
LEFT JOIN RDB$DEPENDENCIES d1 ON d1.RDB$DEPENDED_ON_NAME = rc.RDB$RELATION_NAME
LEFT JOIN RDB$DEPENDENCIES d2 ON d1.RDB$DEPENDENT_NAME = d2.RDB$DEPENDENT_NAME
WHERE rc.RDB$CONSTRAINT_TYPE = 'FOREIGN KEY'
AND d1.RDB$DEPENDED_ON_NAME <> d2.RDB$DEPENDED_ON_NAME
AND d1.RDB$FIELD_NAME <> d2.RDB$FIELD_NAME
ROLLBACK WORK;

COMMIT WORK;

SET TERM ^ ;

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200);
begin

  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
  end;

  suspend;
end^

SET TERM ; ^

/* Following GRANT statetements are generated automatically */

GRANT SELECT ON SHOWDBDEPENDENCE TO PROCEDURE "GeneratorViewDependencies";
GRANT SELECT ON SHOWLISTFIELDDB TO PROCEDURE "GeneratorViewDependencies";

/* Existing privileges on this procedure */

GRANT EXECUTE ON PROCEDURE "GeneratorViewDependencies" TO SYSDBA;

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200);
begin

  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
  end;

  suspend;
end
/*------ SYSDBA 06/11/2015 03:50:57 --------*/


create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200);
begin

  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
  end

  suspend;
end;

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200);
begin

  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end
/*------ SYSDBA 06/11/2015 03:53:39 --------*/


create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);
begin

  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end;
/*------ SYSDBA 06/11/2015 03:54:13 --------*/

select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE;
/*------ SYSDBA 06/11/2015 03:55:45 --------*/

select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE;

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM, TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);

begin

  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQL varchar(200);

begin

    SQL := '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQL varchar(200);

begin
  SQL = '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQLJoin varchar(200);         
declare variable SQLColunas varchar(200);

begin
  SQLColunas = '';   
  SQLJoin = '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    SQLColunas = 'T1.*';
    SQLJoin = 'FROM ' + :TABLEORIGEM + ' as T1';
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME = :TABLEREFERENCE into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQLJoin varchar(200);         
declare variable SQLColunas varchar(200);

begin
  SQLColunas = '';   
  SQLJoin = '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    SQLColunas = 'T1.*';
    SQLJoin = 'FROM ' + :TABLEORIGEM + ' as T1';
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME = :TABLEREFERENCE into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end
/*------ SYSDBA 06/11/2015 03:59:13 --------*/


create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQLJoin varchar(200);         
declare variable SQLColunas varchar(200);

begin
  SQLColunas = '';   
  SQLJoin = '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    SQLColunas = 'T1.*';
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME = :TABLEREFERENCE into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end;
/*------ SYSDBA 06/11/2015 03:59:19 --------*/


create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQLJoin varchar(200);         
declare variable SQLColunas varchar(200);

begin
  SQLColunas = '';   
  SQLJoin = '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    SQLColunas = 'T1.*';
    SQLJoin = 'FROM ' || :TABLEORIGEM || ' as T1';
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME = :TABLEREFERENCE into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end;

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQLJoin varchar(200);         
declare variable SQLColunas varchar(200);      
declare variable SQLIndex integer;

begin
  SQLColunas = '';   
  SQLJoin = '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    SQLIndex := 1;
    SQLColunas = 'T1.*';
    SQLJoin = 'FROM ' || :TABLEORIGEM || ' as T1'; 
    SQLJoin := SQLJoin || 'LEFT JOIN ' || :TABLEREFERENCE || ' AS T' || SQLIndex || ' ON T' || SQLIndex || '.' || :INDEXREFERENCE || ' = T1.' || :FIELDNAMEORIGEM;
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME = :TABLEREFERENCE into :TABLENAME, :FIELDNAME do
    begin
     SQLIndex = SQLIndex + 1;
    end
  end

  suspend;
end

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQLJoin varchar(200);         
declare variable SQLColunas varchar(200);      
declare variable SQLIndex integer;

begin
  SQLColunas = '';   
  SQLJoin = '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    SQLColunas = 'T1.*';
    SQLJoin = 'FROM ' || :TABLEORIGEM || ' as T1'; 
    SQLJoin := SQLJoin || 'LEFT JOIN ' || :TABLEREFERENCE || ' AS T' || SQLIndex || ' ON T' || SQLIndex || '.' || :INDEXREFERENCE || ' = T1.' || :FIELDNAMEORIGEM;
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME = :TABLEREFERENCE into :TABLENAME, :FIELDNAME do
    begin
     SQLIndex = SQLIndex + 1;
    end
  end

  suspend;
end

create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQLJoin varchar(200);         
declare variable SQLColunas varchar(200);      
declare variable SQLIndex integer;

begin
  SQLColunas = '';   
  SQLJoin = '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    SQLColunas = 'T1.*';
    SQLJoin = 'FROM ' || :TABLEORIGEM || ' as T1'; 
    SQLJoin := SQLJoin || 'LEFT JOIN ' || :TABLEREFERENCE || ' AS T' || SQLIndex || ' ON T' || SQLIndex || '.' || :INDEXREFERENCE || ' = T1.' || :FIELDNAMEORIGEM;
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME = :TABLEREFERENCE into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end
/*------ SYSDBA 06/11/2015 04:05:49 --------*/


create or alter procedure "GeneratorViewDependencies"
as
declare variable FIELDNAMEORIGEM varchar(200);
declare variable TABLEREFERENCE varchar(200);
declare variable INDEXORIGEM integer;
declare variable TABLEORIGEM varchar(200);
declare variable INDEXREFERENCE integer;
declare variable FIELDNAMEREFERENCE varchar(200); 
declare variable TABLENAME varchar(200);
declare variable FIELDNAME varchar(200);       
declare variable SQLJoin varchar(200);         
declare variable SQLColunas varchar(200);      
declare variable SQLIndex integer;

begin
  SQLColunas = '';   
  SQLJoin = '';
  FOR select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE
    from SHOWDBDEPENDENCE  INTO :TABLEORIGEM,
    :INDEXORIGEM,
    :FIELDNAMEORIGEM,
    :TABLEREFERENCE,
    :INDEXREFERENCE,
    :FIELDNAMEREFERENCE do
  begin
    SQLColunas = 'T1.*';
    SQLJoin = 'FROM ' || :TABLEORIGEM || ' as T1'; 
    SQLJoin = SQLJoin || 'LEFT JOIN ' || :TABLEREFERENCE || ' AS T' || SQLIndex || ' ON T' || SQLIndex || '.' || :INDEXREFERENCE || ' = T1.' || :FIELDNAMEORIGEM;
    for select TABLENAME, FIELDNAME
     from SHOWLISTFIELDDB B where b.TABLENAME = :TABLEREFERENCE into :TABLENAME, :FIELDNAME do
    begin
    end
  end

  suspend;
end;
ROLLBACK WORK;

/*------ SYSDBA 06/11/2015 07:24:50 --------*/

select * from SHOWDBDEPENDENCE;
ROLLBACK WORK;


select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.8
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY 1, 2
/*------ SYSDBA 06/11/2015 07:34:30 --------*/


select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.*
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY 1, 2;
/*------ SYSDBA 06/11/2015 07:36:07 --------*/


select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.*
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY 1, 2;
ROLLBACK WORK;

/*------ SYSDBA 06/11/2015 17:47:59 --------*/

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY f.rdb$relation_name, f.rdb$field_position;
/*------ SYSDBA 06/11/2015 17:48:01 --------*/

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY f.rdb$relation_name, f.rdb$field_position;
/*------ SYSDBA 06/11/2015 17:48:15 --------*/

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag, f.*
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY f.rdb$relation_name, f.rdb$field_position;
/*------ SYSDBA 06/11/2015 17:55:19 --------*/

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag, FE.rdb$field_type
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name and r.rdb$view_blr is null
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
LEFT JOIN RDB$FIELDS FE ON F.RDB$FIELD_SOURCE = f.RDB$FIELD_NAME
ORDER BY f.rdb$relation_name, f.rdb$field_position;
/*------ SYSDBA 06/11/2015 17:57:37 --------*/


SELECT r.RDB$FIELD_NAME AS field_name,
r.RDB$DESCRIPTION AS field_description,
r.RDB$DEFAULT_VALUE AS field_default_value,
r.RDB$NULL_FLAG AS field_not_null_constraint,
f.RDB$FIELD_LENGTH AS field_length,
f.RDB$FIELD_PRECISION AS field_precision,
f.RDB$FIELD_SCALE AS field_scale,
CASE f.RDB$FIELD_TYPE
WHEN 261 THEN 'BLOB'
WHEN 14 THEN 'CHAR'
WHEN 40 THEN 'CSTRING'
WHEN 11 THEN 'D_FLOAT'
WHEN 27 THEN 'DOUBLE'
WHEN 10 THEN 'FLOAT'
WHEN 16 THEN 'INT64'
WHEN 8 THEN 'INTEGER'
WHEN 9 THEN 'QUAD'
WHEN 7 THEN 'SMALLINT'
WHEN 12 THEN 'DATE'
WHEN 13 THEN 'TIME'
WHEN 35 THEN 'TIMESTAMP'
WHEN 37 THEN 'VARCHAR'
ELSE 'UNKNOWN'
END AS field_type,
f.RDB$FIELD_SUB_TYPE AS field_subtype,
coll.RDB$COLLATION_NAME AS field_collation,
cset.RDB$CHARACTER_SET_NAME AS field_charset
FROM RDB$RELATION_FIELDS r
LEFT JOIN RDB$FIELDS f ON r.RDB$FIELD_SOURCE = f.RDB$FIELD_NAME
LEFT JOIN RDB$COLLATIONS coll ON f.RDB$COLLATION_ID = coll.RDB$COLLATION_ID
LEFT JOIN RDB$CHARACTER_SETS cset ON f.RDB$CHARACTER_SET_ID = cset.RDB$CHARACTER_SET_ID
ORDER BY r.RDB$FIELD_POSITION;
r
r
select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag, FE.rdb$field_type
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name and r.rdb$view_blr is null
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
LEFT JOIN RDB$FIELDS FE ON r.RDB$FIELD_SOURCE = FE.RDB$FIELD_NAME
ORDER BY f.rdb$relation_name, f.rdb$field_position
/*------ SYSDBA 06/11/2015 17:58:50 --------*/

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag, FE.rdb$field_type
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name and r.rdb$view_blr is null
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
LEFT JOIN RDB$FIELDS FE ON f.RDB$FIELD_SOURCE = FE.RDB$FIELD_NAME
ORDER BY f.rdb$relation_name, f.rdb$field_position;
ROLLBACK WORK;

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag, FE.rdb$field_type,
CASE f.RDB$FIELD_TYPE
WHEN 261 THEN 'BLOB'
WHEN 14 THEN 'CHAR'
WHEN 40 THEN 'CSTRING'
WHEN 11 THEN 'D_FLOAT'
WHEN 27 THEN 'DOUBLE'
WHEN 10 THEN 'FLOAT'
WHEN 16 THEN 'INT64'
WHEN 8 THEN 'INTEGER'
WHEN 9 THEN 'QUAD'
WHEN 7 THEN 'SMALLINT'
WHEN 12 THEN 'DATE'
WHEN 13 THEN 'TIME'
WHEN 35 THEN 'TIMESTAMP'
WHEN 37 THEN 'VARCHAR'
ELSE 'UNKNOWN' as DC_FIEL_DTYPE
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name and r.rdb$view_blr is null
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
LEFT JOIN RDB$FIELDS FE ON f.RDB$FIELD_SOURCE = FE.RDB$FIELD_NAME
ORDER BY f.rdb$relation_name, f.rdb$field_position
select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag, FE.rdb$field_type,
CASE f.RDB$FIELD_TYPE
WHEN 261 THEN 'BLOB'
WHEN 14 THEN 'CHAR'
WHEN 40 THEN 'CSTRING'
WHEN 11 THEN 'D_FLOAT'
WHEN 27 THEN 'DOUBLE'
WHEN 10 THEN 'FLOAT'
WHEN 16 THEN 'INT64'
WHEN 8 THEN 'INTEGER'
WHEN 9 THEN 'QUAD'
WHEN 7 THEN 'SMALLINT'
WHEN 12 THEN 'DATE'
WHEN 13 THEN 'TIME'
WHEN 35 THEN 'TIMESTAMP'
WHEN 37 THEN 'VARCHAR'
ELSE 'UNKNOWN' as DC_FIEL_DTYPE
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name and r.rdb$view_blr is null
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
LEFT JOIN RDB$FIELDS FE ON f.RDB$FIELD_SOURCE = FE.RDB$FIELD_NAME
ORDER BY f.rdb$relation_name, f.rdb$field_position
select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag, FE.rdb$field_type,
CASE f.RDB$FIELD_TYPE
WHEN 261 THEN 'BLOB'
WHEN 14 THEN 'CHAR'
WHEN 40 THEN 'CSTRING'
WHEN 11 THEN 'D_FLOAT'
WHEN 27 THEN 'DOUBLE'
WHEN 10 THEN 'FLOAT'
WHEN 16 THEN 'INT64'
WHEN 8 THEN 'INTEGER'
WHEN 9 THEN 'QUAD'
WHEN 7 THEN 'SMALLINT'
WHEN 12 THEN 'DATE'
WHEN 13 THEN 'TIME'
WHEN 35 THEN 'TIMESTAMP'
WHEN 37 THEN 'VARCHAR'
ELSE 'UNKNOWN' END as DC_FIEL_DTYPE
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name and r.rdb$view_blr is null
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
LEFT JOIN RDB$FIELDS FE ON f.RDB$FIELD_SOURCE = FE.RDB$FIELD_NAME
ORDER BY f.rdb$relation_name, f.rdb$field_position
/*------ SYSDBA 06/11/2015 18:00:27 --------*/

select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag, FE.rdb$field_type,
CASE fe.RDB$FIELD_TYPE
WHEN 261 THEN 'BLOB'
WHEN 14 THEN 'CHAR'
WHEN 40 THEN 'CSTRING'
WHEN 11 THEN 'D_FLOAT'
WHEN 27 THEN 'DOUBLE'
WHEN 10 THEN 'FLOAT'
WHEN 16 THEN 'INT64'
WHEN 8 THEN 'INTEGER'
WHEN 9 THEN 'QUAD'
WHEN 7 THEN 'SMALLINT'
WHEN 12 THEN 'DATE'
WHEN 13 THEN 'TIME'
WHEN 35 THEN 'TIMESTAMP'
WHEN 37 THEN 'VARCHAR'
ELSE 'UNKNOWN' END as DC_FIEL_DTYPE
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name and r.rdb$view_blr is null
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
LEFT JOIN RDB$FIELDS FE ON f.RDB$FIELD_SOURCE = FE.RDB$FIELD_NAME
ORDER BY f.rdb$relation_name, f.rdb$field_position;
ROLLBACK WORK;

/*------ SYSDBA 06/11/2015 22:16:24 --------*/

select TABLENAME, FIELDNAME, NULLFLAG, FIELDTYPE, DCFIELDTYPE from SHOWLISTFIELDDB;
ROLLBACK WORK;


select CC.NOME, CC.CODIGO_ESTADO, END.CODIGO, END.CODIGO_PESSOA, END.TIPO_ENDERECO, END.CODIGO_CIDADE, END.BAIRRO, END.CEP, END.RUA, END.NUMERO, END.NUMERO_BLOCO, END.NUMERO_APARTAMENTO, END.OBSERVACAO from ENDERECO as END
INNER JOIN CIDADE CC on (CC.CODIGO = END.CODIGO_CIDADE)
select CC.NOME, CC.CODIGO_ESTADO, END.CODIGO, END.CODIGO_PESSOA, END.TIPO_ENDERECO, END.CODIGO_CIDADE, END.BAIRRO, END.CEP, END.RUA, END.NUMERO, END.NUMERO_BLOCO, END.NUMERO_APARTAMENTO, END.OBSERVACAO from ENDERECO as END
INNER JOIN CIDADE CC on (CC.CODIGO = END.CODIGO_CIDADE)
/*------ SYSDBA 07/11/2015 01:18:35 --------*/


select CID.CODIGO, CID.NOME, CID.CODIGO_ESTADO, CE.NOME, CE.UF, CE.CODIGO_PAIS from CIDADE as CID
INNER JOIN ESTADO CE on (CE.CODIGO = CID.CODIGO_ESTADO);
/*------ SYSDBA 07/11/2015 01:18:51 --------*/


select CC.NOME, CC.CODIGO_ESTADO, END1.CODIGO, END1.CODIGO_PESSOA, END1.TIPO_ENDERECO, END1.CODIGO_CIDADE, END1.BAIRRO, END1.CEP, END1.RUA, END1.NUMERO, END1.NUMERO_BLOCO, END1.NUMERO_APARTAMENTO, END1.OBSERVACAO from ENDERECO as END1
INNER JOIN CIDADE CC on (CC.CODIGO = END1.CODIGO_CIDADE);
/*------ SYSDBA 07/11/2015 01:19:03 --------*/


select EST.CODIGO, EST.NOME, EST.UF, EST.CODIGO_PAIS, CP.NOME, CP.DDI, CP.SIGLA from ESTADO as EST
INNER JOIN PAIS CP on (CP.CODIGO = EST.CODIGO_PAIS);
/*------ SYSDBA 07/11/2015 01:19:32 --------*/


select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME, CP.DESCRICAO, CP.BARCODE, CP.VALOR_UNITARIO, CP.OBSERVACAO, CP.FL_ATIVO, CP.CODIGO_EMPRESA, IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CPI.DESCRICAO, CPI.NUMERO, CPI.DATA_EMISSAO, CPI.DATA_VENCIMENTO, CPI.DATA_ENTREGA, CPI.CODIGO_ENDERECO_CLIENTE, CPI.CODIGO_VENDEDOR, CPI.PERC_COMISSAO_VERDEDOR, CPI.VALOR_TOTAL, CPI.NFE, CPI.OBSERVACAO, CPI.CODIGO_CLIENTE, CPI.CODIGO_SITUACAO_PEDIDO, CPI.CODIGO_EMPRESA from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO);
---------------------------
Sistema de Pedidos
---------------------------
select PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CC.NOME, CC.RAZAO_SOCIAL, CC.CPF, CC.CNPJ, CC.TELEFONE, CC.EMAIL, CC.FL_ATIVO, CED.CODIGO_PESSOA, CED.TIPO_ENDERECO, CED.CODIGO_CIDADE, CED.BAIRRO, CED.CEP, CED.RUA, CED.NUMERO, CED.NUMERO_BLOCO, CED.NUMERO_APARTAMENTO, CED.OBSERVACAO, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CV.NOME, CV.RAZAO_SOCIAL, CV.CPF, CV.CNPJ, CV.TELEFONE, CV.EMAIL, CV.FL_ATIVO, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CST.DESCRICAO, CST.FL_ATIVO, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CE.NOME, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO from PEDIDO as PED
INNER JOIN PESSOA CC on (CC.CODIGO = PED.CODIGO_CLIENTE)
LEFT JOIN ENDERECO CED on (CED.CODIGO = PED.CODIGO_ENDERECO_CLIENTE)
LEFT JOIN PESSOA CV on (CV.CODIGO = PED.CODIGO_VENDEDOR)
INNER JOIN SITUACAO_PEDIDO CST on (CST.CODIGO = PED.CODIGO_SITUACAO_PEDIDO)
INNER JOIN PESSOA CE on (CE.CODIGO = PED.CODIGO_EMPRESA)
---------------------------
OK   
---------------------------
/*------ SYSDBA 07/11/2015 01:19:52 --------*/


select PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CC.NOME, CC.RAZAO_SOCIAL, CC.CPF, CC.CNPJ, CC.TELEFONE, CC.EMAIL, CC.FL_ATIVO, CED.CODIGO_PESSOA, CED.TIPO_ENDERECO, CED.CODIGO_CIDADE, CED.BAIRRO, CED.CEP, CED.RUA, CED.NUMERO, CED.NUMERO_BLOCO, CED.NUMERO_APARTAMENTO, CED.OBSERVACAO, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CV.NOME, CV.RAZAO_SOCIAL, CV.CPF, CV.CNPJ, CV.TELEFONE, CV.EMAIL, CV.FL_ATIVO, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CST.DESCRICAO, CST.FL_ATIVO, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CE.NOME, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO from PEDIDO as PED
INNER JOIN PESSOA CC on (CC.CODIGO = PED.CODIGO_CLIENTE)
LEFT JOIN ENDERECO CED on (CED.CODIGO = PED.CODIGO_ENDERECO_CLIENTE)
LEFT JOIN PESSOA CV on (CV.CODIGO = PED.CODIGO_VENDEDOR)
INNER JOIN SITUACAO_PEDIDO CST on (CST.CODIGO = PED.CODIGO_SITUACAO_PEDIDO)
INNER JOIN PESSOA CE on (CE.CODIGO = PED.CODIGO_EMPRESA);
/*------ SYSDBA 07/11/2015 01:20:20 --------*/


select CE.NOME, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO, PRO.CODIGO, PRO.NOME, PRO.DESCRICAO, PRO.BARCODE, PRO.VALOR_UNITARIO, PRO.OBSERVACAO, PRO.FL_ATIVO, PRO.CODIGO_EMPRESA from PRODUTO as PRO
INNER JOIN PESSOA CE on (CE.CODIGO = PRO.CODIGO_EMPRESA);
ROLLBACK WORK;

/*------ SYSDBA 07/11/2015 02:23:12 --------*/


select CID.CODIGO, CID.NOME, CID.CODIGO_ESTADO, CE.NOME as CENOME, CE.UF, CE.CODIGO_PAIS from CIDADE as CID
INNER JOIN ESTADO CE on (CE.CODIGO = CID.CODIGO_ESTADO)
;
/*------ SYSDBA 07/11/2015 02:23:16 --------*/


select END1.CODIGO, END1.CODIGO_PESSOA, END1.TIPO_ENDERECO, END1.CODIGO_CIDADE, END1.BAIRRO, END1.CEP, END1.RUA, END1.NUMERO, END1.NUMERO_BLOCO, END1.NUMERO_APARTAMENTO, END1.OBSERVACAO, CC.NOME, CC.CODIGO_ESTADO from ENDERECO as END1
INNER JOIN CIDADE CC on (CC.CODIGO = END1.CODIGO_CIDADE);
/*------ SYSDBA 07/11/2015 02:23:20 --------*/


select EST.CODIGO, EST.NOME, EST.UF, EST.CODIGO_PAIS, CP.NOME as CPNOME, CP.DDI, CP.SIGLA from ESTADO as EST
INNER JOIN PAIS CP on (CP.CODIGO = EST.CODIGO_PAIS);
/*------ SYSDBA 07/11/2015 02:23:23 --------*/


select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME, CP.DESCRICAO as CPDESCRICAO, CP.BARCODE, CP.VALOR_UNITARIO as CPVALOR_UNITARIO, CP.OBSERVACAO as CPOBSERVACAO, CP.FL_ATIVO, CP.CODIGO_EMPRESA as CPCODIGO_EMPRESA, CPI.DESCRICAO, CPI.NUMERO as CPINUMERO, CPI.DATA_EMISSAO, CPI.DATA_VENCIMENTO, CPI.DATA_ENTREGA, CPI.CODIGO_ENDERECO_CLIENTE, CPI.CODIGO_VENDEDOR, CPI.PERC_COMISSAO_VERDEDOR, CPI.VALOR_TOTAL, CPI.NFE, CPI.OBSERVACAO, CPI.CODIGO_CLIENTE, CPI.CODIGO_SITUACAO_PEDIDO, CPI.CODIGO_EMPRESA from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO);
/*------ SYSDBA 07/11/2015 02:23:29 --------*/


select PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CC.NOME as CCNOME, CC.RAZAO_SOCIAL as CCRAZAO_SOCIAL, CC.CPF as CCCPF, CC.CNPJ as CCCNPJ, CC.TELEFONE as CCTELEFONE, CC.EMAIL as CCEMAIL, CC.FL_ATIVO as CCFL_ATIVO, CED.CODIGO_PESSOA, CED.TIPO_ENDERECO, CED.CODIGO_CIDADE, CED.BAIRRO, CED.CEP, CED.RUA, CED.NUMERO as CEDNUMERO, CED.NUMERO_BLOCO, CED.NUMERO_APARTAMENTO, CED.OBSERVACAO as CEDOBSERVACAO, CV.NOME as CVNOME, CV.RAZAO_SOCIAL as CVRAZAO_SOCIAL, CV.CPF as CVCPF, CV.CNPJ as CVCNPJ, CV.TELEFONE as CVTELEFONE, CV.EMAIL as CVEMAIL, CV.FL_ATIVO as CVFL_ATIVO, CST.DESCRICAO as CSTDESCRICAO, CST.FL_ATIVO as CSTFL_ATIVO, CE.NOME, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO from PEDIDO as PED
INNER JOIN PESSOA CC on (CC.CODIGO = PED.CODIGO_CLIENTE)
LEFT JOIN ENDERECO CED on (CED.CODIGO = PED.CODIGO_ENDERECO_CLIENTE)
LEFT JOIN PESSOA CV on (CV.CODIGO = PED.CODIGO_VENDEDOR)
INNER JOIN SITUACAO_PEDIDO CST on (CST.CODIGO = PED.CODIGO_SITUACAO_PEDIDO)
INNER JOIN PESSOA CE on (CE.CODIGO = PED.CODIGO_EMPRESA);
/*------ SYSDBA 07/11/2015 02:23:32 --------*/


select PRO.CODIGO, PRO.NOME, PRO.DESCRICAO, PRO.BARCODE, PRO.VALOR_UNITARIO, PRO.OBSERVACAO, PRO.FL_ATIVO, PRO.CODIGO_EMPRESA, CE.NOME as CENOME, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO as CEFL_ATIVO from PRODUTO as PRO
INNER JOIN PESSOA CE on (CE.CODIGO = PRO.CODIGO_EMPRESA);
ROLLBACK WORK;


CREATE OR ALTER VIEW VIEWPRODUTO
(
CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, DC_CLIENTE, DC_VENDEDOR, DC_SITUACAO_PEDIDO, DC_EMPRESA
)
AS
select PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CC.NOME as DC_CLIENTE, CV.NOME as DC_VENDEDOR, CST.DESCRICAO as DC_SITUACAO_PEDIDO, CE.NOME as DC_EMPRESA from PEDIDO as PED
INNER JOIN PESSOA CC on (CC.CODIGO = PED.CODIGO_CLIENTE)
LEFT JOIN ENDERECO CED on (CED.CODIGO = PED.CODIGO_ENDERECO_CLIENTE)
LEFT JOIN PESSOA CV on (CV.CODIGO = PED.CODIGO_VENDEDOR)
INNER JOIN SITUACAO_PEDIDO CST on (CST.CODIGO = PED.CODIGO_SITUACAO_PEDIDO)
INNER JOIN PESSOA CE on (CE.CODIGO = PED.CODIGO_EMPRESA)
/*------ SYSDBA 07/11/2015 05:20:00 --------*/


CREATE OR ALTER VIEW VIEWTIPO_PESSOA
(
CODIGO, NOME, DESCRICAO, BARCODE, VALOR_UNITARIO, OBSERVACAO, FL_ATIVO, CODIGO_EMPRESA, DC_EMPRESA
)
AS
select PRO.CODIGO, PRO.NOME, PRO.DESCRICAO, PRO.BARCODE, PRO.VALOR_UNITARIO, PRO.OBSERVACAO, PRO.FL_ATIVO, PRO.CODIGO_EMPRESA, CE.NOME as DC_EMPRESA from PRODUTO as PRO
INNER JOIN PESSOA CE on (CE.CODIGO = PRO.CODIGO_EMPRESA)
;

CREATE OR ALTER VIEW VIEWPRODUTO
(
CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, DC_CLIENTE, DC_VENDEDOR, DC_SITUACAO_PEDIDO, DC_EMPRESA
)
AS
select PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CC.NOME as DC_CLIENTE, CV.NOME as DC_VENDEDOR, CST.DESCRICAO as DC_SITUACAO_PEDIDO, CE.NOME as DC_EMPRESA from PEDIDO as PED
INNER JOIN PESSOA CC on (CC.CODIGO = PED.CODIGO_CLIENTE)
LEFT JOIN ENDERECO CED on (CED.CODIGO = PED.CODIGO_ENDERECO_CLIENTE)
LEFT JOIN PESSOA CV on (CV.CODIGO = PED.CODIGO_VENDEDOR)
INNER JOIN SITUACAO_PEDIDO CST on (CST.CODIGO = PED.CODIGO_SITUACAO_PEDIDO)
INNER JOIN PESSOA CE on (CE.CODIGO = PED.CODIGO_EMPRESA)


CREATE OR ALTER VIEW VIEWPEDIDO
(
CODIGO, NUMERO, CODIGO_PRODUTO, CODIGO_PEDIDO, QUANTIDADE, FL_CANCELADO, VALOR_ACRESCIMO, VALOR_DESCONTO, VALOR_UNITARIO, CODIGO, NUMERO, CODIGO_PRODUTO, CODIGO_PEDIDO, QUANTIDADE, FL_CANCELADO, VALOR_ACRESCIMO, VALOR_DESCONTO, VALOR_UNITARIO, DC_PRODUTO, DC_PEDIDO
)
AS
select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME as DC_PRODUTO, CPI.DESCRICAO as DC_PEDIDO from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO)

/*------ SYSDBA 07/11/2015 05:20:16 --------*/


CREATE OR ALTER VIEW VIEWITEM_PEDIDO
(
CODIGO, NOME, UF, CODIGO_PAIS, DC_PAIS
)
AS
select EST.CODIGO, EST.NOME, EST.UF, EST.CODIGO_PAIS, CP.NOME as DC_PAIS from ESTADO as EST
INNER JOIN PAIS CP on (CP.CODIGO = EST.CODIGO_PAIS)
;
/*------ SYSDBA 07/11/2015 05:20:20 --------*/


CREATE OR ALTER VIEW VIEWESTADO
(
CODIGO, CODIGO_PESSOA, TIPO_ENDERECO, CODIGO_CIDADE, BAIRRO, CEP, RUA, NUMERO, NUMERO_BLOCO, NUMERO_APARTAMENTO, OBSERVACAO, DC_CIDADE
)
AS
select END1.CODIGO, END1.CODIGO_PESSOA, END1.TIPO_ENDERECO, END1.CODIGO_CIDADE, END1.BAIRRO, END1.CEP, END1.RUA, END1.NUMERO, END1.NUMERO_BLOCO, END1.NUMERO_APARTAMENTO, END1.OBSERVACAO, CC.NOME as DC_CIDADE from ENDERECO as END1
INNER JOIN CIDADE CC on (CC.CODIGO = END1.CODIGO_CIDADE)
;
/*------ SYSDBA 07/11/2015 05:20:24 --------*/


CREATE OR ALTER VIEW VIEWENDERECO
(
CODIGO, NOME, CODIGO_ESTADO, DC_ESTADO
)
AS
select CID.CODIGO, CID.NOME, CID.CODIGO_ESTADO, CE.NOME as DC_ESTADO from CIDADE as CID
INNER JOIN ESTADO CE on (CE.CODIGO = CID.CODIGO_ESTADO)
;

CREATE OR ALTER VIEW VIEWPEDIDO
(
CODIGO, NUMERO, CODIGO_PRODUTO, CODIGO_PEDIDO, QUANTIDADE, FL_CANCELADO, VALOR_ACRESCIMO, VALOR_DESCONTO, VALOR_UNITARIO, CODIGO, NUMERO, CODIGO_PRODUTO, CODIGO_PEDIDO, QUANTIDADE, FL_CANCELADO, VALOR_ACRESCIMO, VALOR_DESCONTO, VALOR_UNITARIO, DC_PRODUTO, DC_PEDIDO
)
AS
select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME as DC_PRODUTO, CPI.DESCRICAO as DC_PEDIDO from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO)

/*------ SYSDBA 07/11/2015 05:20:52 --------*/

select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME as DC_PRODUTO, CPI.DESCRICAO as DC_PEDIDO from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO)
;
/*------ SYSDBA 07/11/2015 05:20:53 --------*/

select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME as DC_PRODUTO, CPI.DESCRICAO as DC_PEDIDO from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO)
;
/*------ SYSDBA 07/11/2015 05:30:27 --------*/


CREATE OR ALTER VIEW VIEWPEDIDO
(
CODIGO, NUMERO, CODIGO_PRODUTO, CODIGO_PEDIDO, QUANTIDADE, FL_CANCELADO, VALOR_ACRESCIMO, VALOR_DESCONTO, VALOR_UNITARIO, DC_PRODUTO, DC_PEDIDO
)
AS
select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME as DC_PRODUTO, CPI.DESCRICAO as DC_PEDIDO from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO)
;
/*------ SYSDBA 07/11/2015 05:30:52 --------*/


CREATE OR ALTER VIEW VIEWENDERECO
(
CODIGO, NOME, CODIGO_ESTADO, DC_ESTADO
)
AS
select CID.CODIGO, CID.NOME, CID.CODIGO_ESTADO, CE.NOME as DC_ESTADO from CIDADE as CID
INNER JOIN ESTADO CE on (CE.CODIGO = CID.CODIGO_ESTADO)
;
/*------ SYSDBA 07/11/2015 05:30:55 --------*/


CREATE OR ALTER VIEW VIEWESTADO
(
CODIGO, CODIGO_PESSOA, TIPO_ENDERECO, CODIGO_CIDADE, BAIRRO, CEP, RUA, NUMERO, NUMERO_BLOCO, NUMERO_APARTAMENTO, OBSERVACAO, DC_CIDADE
)
AS
select END1.CODIGO, END1.CODIGO_PESSOA, END1.TIPO_ENDERECO, END1.CODIGO_CIDADE, END1.BAIRRO, END1.CEP, END1.RUA, END1.NUMERO, END1.NUMERO_BLOCO, END1.NUMERO_APARTAMENTO, END1.OBSERVACAO, CC.NOME as DC_CIDADE from ENDERECO as END1
INNER JOIN CIDADE CC on (CC.CODIGO = END1.CODIGO_CIDADE)
;
/*------ SYSDBA 07/11/2015 05:30:58 --------*/


CREATE OR ALTER VIEW VIEWITEM_PEDIDO
(
CODIGO, NOME, UF, CODIGO_PAIS, DC_PAIS
)
AS
select EST.CODIGO, EST.NOME, EST.UF, EST.CODIGO_PAIS, CP.NOME as DC_PAIS from ESTADO as EST
INNER JOIN PAIS CP on (CP.CODIGO = EST.CODIGO_PAIS)
;
/*------ SYSDBA 07/11/2015 05:31:02 --------*/


CREATE OR ALTER VIEW VIEWPEDIDO
(
CODIGO, NUMERO, CODIGO_PRODUTO, CODIGO_PEDIDO, QUANTIDADE, FL_CANCELADO, VALOR_ACRESCIMO, VALOR_DESCONTO, VALOR_UNITARIO, DC_PRODUTO, DC_PEDIDO
)
AS
select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME as DC_PRODUTO, CPI.DESCRICAO as DC_PEDIDO from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO)
;
/*------ SYSDBA 07/11/2015 05:31:06 --------*/


CREATE OR ALTER VIEW VIEWPRODUTO
(
CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, DC_CLIENTE, DC_VENDEDOR, DC_SITUACAO_PEDIDO, DC_EMPRESA
)
AS
select PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CC.NOME as DC_CLIENTE, CV.NOME as DC_VENDEDOR, CST.DESCRICAO as DC_SITUACAO_PEDIDO, CE.NOME as DC_EMPRESA from PEDIDO as PED
INNER JOIN PESSOA CC on (CC.CODIGO = PED.CODIGO_CLIENTE)
LEFT JOIN ENDERECO CED on (CED.CODIGO = PED.CODIGO_ENDERECO_CLIENTE)
LEFT JOIN PESSOA CV on (CV.CODIGO = PED.CODIGO_VENDEDOR)
INNER JOIN SITUACAO_PEDIDO CST on (CST.CODIGO = PED.CODIGO_SITUACAO_PEDIDO)
INNER JOIN PESSOA CE on (CE.CODIGO = PED.CODIGO_EMPRESA)
;
/*------ SYSDBA 07/11/2015 05:31:09 --------*/


CREATE OR ALTER VIEW VIEWTIPO_PESSOA
(
CODIGO, NOME, DESCRICAO, BARCODE, VALOR_UNITARIO, OBSERVACAO, FL_ATIVO, CODIGO_EMPRESA, DC_EMPRESA
)
AS
select PRO.CODIGO, PRO.NOME, PRO.DESCRICAO, PRO.BARCODE, PRO.VALOR_UNITARIO, PRO.OBSERVACAO, PRO.FL_ATIVO, PRO.CODIGO_EMPRESA, CE.NOME as DC_EMPRESA from PRODUTO as PRO
INNER JOIN PESSOA CE on (CE.CODIGO = PRO.CODIGO_EMPRESA)
;
ROLLBACK WORK;


CREATE OR ALTER VIEW VIEWENDERECO
(
CODIGO, NOME, CODIGO_ESTADO, DC_ESTADO, UF, CODIGO_PAIS
)
AS
select CID.CODIGO, CID.NOME, CID.CODIGO_ESTADO, CE.NOME as DC_ESTADO, CE.UF, CE.CODIGO_PAIS from CIDADE as CID
INNER JOIN ESTADO CE on (CE.CODIGO = CID.CODIGO_ESTADO)
;

CREATE OR ALTER VIEW VIEWESTADO
(
CODIGO, CODIGO_PESSOA, TIPO_ENDERECO, CODIGO_CIDADE, BAIRRO, CEP, RUA, NUMERO, NUMERO_BLOCO, NUMERO_APARTAMENTO, OBSERVACAO, DC_CIDADE, CODIGO_ESTADO
)
AS
select END1.CODIGO, END1.CODIGO_PESSOA, END1.TIPO_ENDERECO, END1.CODIGO_CIDADE, END1.BAIRRO, END1.CEP, END1.RUA, END1.NUMERO, END1.NUMERO_BLOCO, END1.NUMERO_APARTAMENTO, END1.OBSERVACAO, CC.NOME as DC_CIDADE, CC.CODIGO_ESTADO from ENDERECO as END1
INNER JOIN CIDADE CC on (CC.CODIGO = END1.CODIGO_CIDADE)
;

CREATE OR ALTER VIEW VIEWITEM_PEDIDO
(
CODIGO, NOME, UF, CODIGO_PAIS, DC_PAIS, DDI, SIGLA
)
AS
select EST.CODIGO, EST.NOME, EST.UF, EST.CODIGO_PAIS, CP.NOME as DC_PAIS, CP.DDI, CP.SIGLA from ESTADO as EST
INNER JOIN PAIS CP on (CP.CODIGO = EST.CODIGO_PAIS)
;

CREATE OR ALTER VIEW VIEWPEDIDO
(
CODIGO, NUMERO, CODIGO_PRODUTO, CODIGO_PEDIDO, QUANTIDADE, FL_CANCELADO, VALOR_ACRESCIMO, VALOR_DESCONTO, VALOR_UNITARIO, DC_PRODUTO, DESCRICAO, BARCODE, CP_VALOR_UNITARIO, CP_OBSERVACAO, FL_ATIVO, CP_CODIGO_EMPRESA, DC_PEDIDO, CPI_NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA
)
AS
select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME as DC_PRODUTO, CP.DESCRICAO, CP.BARCODE, CP.VALOR_UNITARIO as CP_VALOR_UNITARIO, CP.OBSERVACAO as CP_OBSERVACAO, CP.FL_ATIVO, CP.CODIGO_EMPRESA as CP_CODIGO_EMPRESA, CPI.DESCRICAO as DC_PEDIDO, CPI.NUMERO as CPI_NUMERO, CPI.DATA_EMISSAO, CPI.DATA_VENCIMENTO, CPI.DATA_ENTREGA, CPI.CODIGO_ENDERECO_CLIENTE, CPI.CODIGO_VENDEDOR, CPI.PERC_COMISSAO_VERDEDOR, CPI.VALOR_TOTAL, CPI.NFE, CPI.OBSERVACAO, CPI.CODIGO_CLIENTE, CPI.CODIGO_SITUACAO_PEDIDO, CPI.CODIGO_EMPRESA from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO)
;

CREATE OR ALTER VIEW VIEWPRODUTO
(
CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, DC_CLIENTE, CC_RAZAO_SOCIAL, CC_CPF, CC_CNPJ, CC_TELEFONE, CC_EMAIL, CC_FL_ATIVO, CODIGO_PESSOA, TIPO_ENDERECO, CODIGO_CIDADE, BAIRRO, CEP, RUA, CED_NUMERO, NUMERO_BLOCO, NUMERO_APARTAMENTO, CED_OBSERVACAO, DC_VENDEDOR, CV_RAZAO_SOCIAL, CV_CPF, CV_CNPJ, CV_TELEFONE, CV_EMAIL, CV_FL_ATIVO, DC_SITUACAO_PEDIDO, CST_FL_ATIVO, DC_EMPRESA, RAZAO_SOCIAL, CPF, CNPJ, TELEFONE, EMAIL, FL_ATIVO
)
AS
select PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CC.NOME as DC_CLIENTE, CC.RAZAO_SOCIAL as CC_RAZAO_SOCIAL, CC.CPF as CC_CPF, CC.CNPJ as CC_CNPJ, CC.TELEFONE as CC_TELEFONE, CC.EMAIL as CC_EMAIL, CC.FL_ATIVO as CC_FL_ATIVO, CED.CODIGO_PESSOA, CED.TIPO_ENDERECO, CED.CODIGO_CIDADE, CED.BAIRRO, CED.CEP, CED.RUA, CED.NUMERO as CED_NUMERO, CED.NUMERO_BLOCO, CED.NUMERO_APARTAMENTO, CED.OBSERVACAO as CED_OBSERVACAO, CV.NOME as DC_VENDEDOR, CV.RAZAO_SOCIAL as CV_RAZAO_SOCIAL, CV.CPF as CV_CPF, CV.CNPJ as CV_CNPJ, CV.TELEFONE as CV_TELEFONE, CV.EMAIL as CV_EMAIL, CV.FL_ATIVO as CV_FL_ATIVO, CST.DESCRICAO as DC_SITUACAO_PEDIDO, CST.FL_ATIVO as CST_FL_ATIVO, CE.NOME as DC_EMPRESA, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO from PEDIDO as PED
INNER JOIN PESSOA CC on (CC.CODIGO = PED.CODIGO_CLIENTE)
LEFT JOIN ENDERECO CED on (CED.CODIGO = PED.CODIGO_ENDERECO_CLIENTE)
LEFT JOIN PESSOA CV on (CV.CODIGO = PED.CODIGO_VENDEDOR)
INNER JOIN SITUACAO_PEDIDO CST on (CST.CODIGO = PED.CODIGO_SITUACAO_PEDIDO)
INNER JOIN PESSOA CE on (CE.CODIGO = PED.CODIGO_EMPRESA)
;

CREATE OR ALTER VIEW VIEWTIPO_PESSOA
(
CODIGO, NOME, DESCRICAO, BARCODE, VALOR_UNITARIO, OBSERVACAO, FL_ATIVO, CODIGO_EMPRESA, DC_EMPRESA, RAZAO_SOCIAL, CPF, CNPJ, TELEFONE, EMAIL, CE_FL_ATIVO
)
AS
select PRO.CODIGO, PRO.NOME, PRO.DESCRICAO, PRO.BARCODE, PRO.VALOR_UNITARIO, PRO.OBSERVACAO, PRO.FL_ATIVO, PRO.CODIGO_EMPRESA, CE.NOME as DC_EMPRESA, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO as CE_FL_ATIVO from PRODUTO as PRO
INNER JOIN PESSOA CE on (CE.CODIGO = PRO.CODIGO_EMPRESA)
;

CREATE OR ALTER VIEW VIEWENDERECO
(
CODIGO, NOME, CODIGO_ESTADO, DC_ESTADO, UF, CODIGO_PAIS
)
AS
select CID.CODIGO, CID.NOME, CID.CODIGO_ESTADO, CE.NOME as DC_ESTADO, CE.UF, CE.CODIGO_PAIS from CIDADE as CID
INNER JOIN ESTADO CE on (CE.CODIGO = CID.CODIGO_ESTADO);

CREATE OR ALTER VIEW VIEWESTADO
(
CODIGO, CODIGO_PESSOA, TIPO_ENDERECO, CODIGO_CIDADE, BAIRRO, CEP, RUA, NUMERO, NUMERO_BLOCO, NUMERO_APARTAMENTO, OBSERVACAO, DC_CIDADE, CODIGO_ESTADO
)
AS
select END1.CODIGO, END1.CODIGO_PESSOA, END1.TIPO_ENDERECO, END1.CODIGO_CIDADE, END1.BAIRRO, END1.CEP, END1.RUA, END1.NUMERO, END1.NUMERO_BLOCO, END1.NUMERO_APARTAMENTO, END1.OBSERVACAO, CC.NOME as DC_CIDADE, CC.CODIGO_ESTADO from ENDERECO as END1
INNER JOIN CIDADE CC on (CC.CODIGO = END1.CODIGO_CIDADE)
;

CREATE OR ALTER VIEW VIEWITEM_PEDIDO
(
CODIGO, NOME, UF, CODIGO_PAIS, DC_PAIS, DDI, SIGLA
)
AS
select EST.CODIGO, EST.NOME, EST.UF, EST.CODIGO_PAIS, CP.NOME as DC_PAIS, CP.DDI, CP.SIGLA from ESTADO as EST
INNER JOIN PAIS CP on (CP.CODIGO = EST.CODIGO_PAIS)
;

CREATE OR ALTER VIEW VIEWPEDIDO
(
CODIGO, NUMERO, CODIGO_PRODUTO, CODIGO_PEDIDO, QUANTIDADE, FL_CANCELADO, VALOR_ACRESCIMO, VALOR_DESCONTO, VALOR_UNITARIO, DC_PRODUTO, DESCRICAO, BARCODE, CP_VALOR_UNITARIO, CP_OBSERVACAO, FL_ATIVO, CP_CODIGO_EMPRESA, DC_PEDIDO, CPI_NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA
)
AS
select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME as DC_PRODUTO, CP.DESCRICAO, CP.BARCODE, CP.VALOR_UNITARIO as CP_VALOR_UNITARIO, CP.OBSERVACAO as CP_OBSERVACAO, CP.FL_ATIVO, CP.CODIGO_EMPRESA as CP_CODIGO_EMPRESA, CPI.DESCRICAO as DC_PEDIDO, CPI.NUMERO as CPI_NUMERO, CPI.DATA_EMISSAO, CPI.DATA_VENCIMENTO, CPI.DATA_ENTREGA, CPI.CODIGO_ENDERECO_CLIENTE, CPI.CODIGO_VENDEDOR, CPI.PERC_COMISSAO_VERDEDOR, CPI.VALOR_TOTAL, CPI.NFE, CPI.OBSERVACAO, CPI.CODIGO_CLIENTE, CPI.CODIGO_SITUACAO_PEDIDO, CPI.CODIGO_EMPRESA from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO)
;

CREATE OR ALTER VIEW VIEWPRODUTO
(
CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, DC_CLIENTE, CC_RAZAO_SOCIAL, CC_CPF, CC_CNPJ, CC_TELEFONE, CC_EMAIL, CC_FL_ATIVO, CODIGO_PESSOA, TIPO_ENDERECO, CODIGO_CIDADE, BAIRRO, CEP, RUA, CED_NUMERO, NUMERO_BLOCO, NUMERO_APARTAMENTO, CED_OBSERVACAO, DC_VENDEDOR, CV_RAZAO_SOCIAL, CV_CPF, CV_CNPJ, CV_TELEFONE, CV_EMAIL, CV_FL_ATIVO, DC_SITUACAO_PEDIDO, CST_FL_ATIVO, DC_EMPRESA, RAZAO_SOCIAL, CPF, CNPJ, TELEFONE, EMAIL, FL_ATIVO
)
AS
select PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CC.NOME as DC_CLIENTE, CC.RAZAO_SOCIAL as CC_RAZAO_SOCIAL, CC.CPF as CC_CPF, CC.CNPJ as CC_CNPJ, CC.TELEFONE as CC_TELEFONE, CC.EMAIL as CC_EMAIL, CC.FL_ATIVO as CC_FL_ATIVO, CED.CODIGO_PESSOA, CED.TIPO_ENDERECO, CED.CODIGO_CIDADE, CED.BAIRRO, CED.CEP, CED.RUA, CED.NUMERO as CED_NUMERO, CED.NUMERO_BLOCO, CED.NUMERO_APARTAMENTO, CED.OBSERVACAO as CED_OBSERVACAO, CV.NOME as DC_VENDEDOR, CV.RAZAO_SOCIAL as CV_RAZAO_SOCIAL, CV.CPF as CV_CPF, CV.CNPJ as CV_CNPJ, CV.TELEFONE as CV_TELEFONE, CV.EMAIL as CV_EMAIL, CV.FL_ATIVO as CV_FL_ATIVO, CST.DESCRICAO as DC_SITUACAO_PEDIDO, CST.FL_ATIVO as CST_FL_ATIVO, CE.NOME as DC_EMPRESA, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO from PEDIDO as PED
INNER JOIN PESSOA CC on (CC.CODIGO = PED.CODIGO_CLIENTE)
LEFT JOIN ENDERECO CED on (CED.CODIGO = PED.CODIGO_ENDERECO_CLIENTE)
LEFT JOIN PESSOA CV on (CV.CODIGO = PED.CODIGO_VENDEDOR)
INNER JOIN SITUACAO_PEDIDO CST on (CST.CODIGO = PED.CODIGO_SITUACAO_PEDIDO)
INNER JOIN PESSOA CE on (CE.CODIGO = PED.CODIGO_EMPRESA)
;

CREATE OR ALTER VIEW VIEWTIPO_PESSOA
(
CODIGO, NOME, DESCRICAO, BARCODE, VALOR_UNITARIO, OBSERVACAO, FL_ATIVO, CODIGO_EMPRESA, DC_EMPRESA, RAZAO_SOCIAL, CPF, CNPJ, TELEFONE, EMAIL, CE_FL_ATIVO
)
AS
select PRO.CODIGO, PRO.NOME, PRO.DESCRICAO, PRO.BARCODE, PRO.VALOR_UNITARIO, PRO.OBSERVACAO, PRO.FL_ATIVO, PRO.CODIGO_EMPRESA, CE.NOME as DC_EMPRESA, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO as CE_FL_ATIVO from PRODUTO as PRO
INNER JOIN PESSOA CE on (CE.CODIGO = PRO.CODIGO_EMPRESA)
;

CREATE OR ALTER VIEW VIEWENDERECO
(
CODIGO, NOME, CODIGO_ESTADO, DC_ESTADO, UF, CODIGO_PAIS
)
AS
select CID.CODIGO, CID.NOME, CID.CODIGO_ESTADO, CE.NOME as DC_ESTADO, CE.UF, CE.CODIGO_PAIS from CIDADE as CID
INNER JOIN ESTADO CE on (CE.CODIGO = CID.CODIGO_ESTADO);

CREATE OR ALTER VIEW VIEWESTADO
(
CODIGO, CODIGO_PESSOA, TIPO_ENDERECO, CODIGO_CIDADE, BAIRRO, CEP, RUA, NUMERO, NUMERO_BLOCO, NUMERO_APARTAMENTO, OBSERVACAO, DC_CIDADE, CODIGO_ESTADO
)
AS
select END1.CODIGO, END1.CODIGO_PESSOA, END1.TIPO_ENDERECO, END1.CODIGO_CIDADE, END1.BAIRRO, END1.CEP, END1.RUA, END1.NUMERO, END1.NUMERO_BLOCO, END1.NUMERO_APARTAMENTO, END1.OBSERVACAO, CC.NOME as DC_CIDADE, CC.CODIGO_ESTADO from ENDERECO as END1
INNER JOIN CIDADE CC on (CC.CODIGO = END1.CODIGO_CIDADE);
/*------ SYSDBA 07/11/2015 05:34:33 --------*/


CREATE OR ALTER VIEW VIEWENDERECO
(
CODIGO, NOME, CODIGO_ESTADO, DC_ESTADO, UF, CODIGO_PAIS
)
AS
select CID.CODIGO, CID.NOME, CID.CODIGO_ESTADO, CE.NOME as DC_ESTADO, CE.UF, CE.CODIGO_PAIS from CIDADE as CID
INNER JOIN ESTADO CE on (CE.CODIGO = CID.CODIGO_ESTADO);

/*------ SYSDBA 07/11/2015 05:34:37 --------*/


CREATE OR ALTER VIEW VIEWESTADO
(
CODIGO, CODIGO_PESSOA, TIPO_ENDERECO, CODIGO_CIDADE, BAIRRO, CEP, RUA, NUMERO, NUMERO_BLOCO, NUMERO_APARTAMENTO, OBSERVACAO, DC_CIDADE, CODIGO_ESTADO
)
AS
select END1.CODIGO, END1.CODIGO_PESSOA, END1.TIPO_ENDERECO, END1.CODIGO_CIDADE, END1.BAIRRO, END1.CEP, END1.RUA, END1.NUMERO, END1.NUMERO_BLOCO, END1.NUMERO_APARTAMENTO, END1.OBSERVACAO, CC.NOME as DC_CIDADE, CC.CODIGO_ESTADO from ENDERECO as END1
INNER JOIN CIDADE CC on (CC.CODIGO = END1.CODIGO_CIDADE);
/*------ SYSDBA 07/11/2015 05:34:45 --------*/



CREATE OR ALTER VIEW VIEWITEM_PEDIDO
(
CODIGO, NOME, UF, CODIGO_PAIS, DC_PAIS, DDI, SIGLA
)
AS
select EST.CODIGO, EST.NOME, EST.UF, EST.CODIGO_PAIS, CP.NOME as DC_PAIS, CP.DDI, CP.SIGLA from ESTADO as EST
INNER JOIN PAIS CP on (CP.CODIGO = EST.CODIGO_PAIS);
/*------ SYSDBA 07/11/2015 05:34:51 --------*/



CREATE OR ALTER VIEW VIEWPEDIDO
(
CODIGO, NUMERO, CODIGO_PRODUTO, CODIGO_PEDIDO, QUANTIDADE, FL_CANCELADO, VALOR_ACRESCIMO, VALOR_DESCONTO, VALOR_UNITARIO, DC_PRODUTO, DESCRICAO, BARCODE, CP_VALOR_UNITARIO, CP_OBSERVACAO, FL_ATIVO, CP_CODIGO_EMPRESA, DC_PEDIDO, CPI_NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA
)
AS
select IP.CODIGO, IP.NUMERO, IP.CODIGO_PRODUTO, IP.CODIGO_PEDIDO, IP.QUANTIDADE, IP.FL_CANCELADO, IP.VALOR_ACRESCIMO, IP.VALOR_DESCONTO, IP.VALOR_UNITARIO, CP.NOME as DC_PRODUTO, CP.DESCRICAO, CP.BARCODE, CP.VALOR_UNITARIO as CP_VALOR_UNITARIO, CP.OBSERVACAO as CP_OBSERVACAO, CP.FL_ATIVO, CP.CODIGO_EMPRESA as CP_CODIGO_EMPRESA, CPI.DESCRICAO as DC_PEDIDO, CPI.NUMERO as CPI_NUMERO, CPI.DATA_EMISSAO, CPI.DATA_VENCIMENTO, CPI.DATA_ENTREGA, CPI.CODIGO_ENDERECO_CLIENTE, CPI.CODIGO_VENDEDOR, CPI.PERC_COMISSAO_VERDEDOR, CPI.VALOR_TOTAL, CPI.NFE, CPI.OBSERVACAO, CPI.CODIGO_CLIENTE, CPI.CODIGO_SITUACAO_PEDIDO, CPI.CODIGO_EMPRESA from ITEM_PEDIDO as IP
INNER JOIN PRODUTO CP on (CP.CODIGO = IP.CODIGO_PRODUTO)
INNER JOIN PEDIDO CPI on (CPI.CODIGO = IP.CODIGO_PEDIDO);
/*------ SYSDBA 07/11/2015 05:34:57 --------*/



CREATE OR ALTER VIEW VIEWPRODUTO
(
CODIGO, DESCRICAO, NUMERO, DATA_EMISSAO, DATA_VENCIMENTO, DATA_ENTREGA, CODIGO_ENDERECO_CLIENTE, CODIGO_VENDEDOR, PERC_COMISSAO_VERDEDOR, VALOR_TOTAL, NFE, OBSERVACAO, CODIGO_CLIENTE, CODIGO_SITUACAO_PEDIDO, CODIGO_EMPRESA, DC_CLIENTE, CC_RAZAO_SOCIAL, CC_CPF, CC_CNPJ, CC_TELEFONE, CC_EMAIL, CC_FL_ATIVO, CODIGO_PESSOA, TIPO_ENDERECO, CODIGO_CIDADE, BAIRRO, CEP, RUA, CED_NUMERO, NUMERO_BLOCO, NUMERO_APARTAMENTO, CED_OBSERVACAO, DC_VENDEDOR, CV_RAZAO_SOCIAL, CV_CPF, CV_CNPJ, CV_TELEFONE, CV_EMAIL, CV_FL_ATIVO, DC_SITUACAO_PEDIDO, CST_FL_ATIVO, DC_EMPRESA, RAZAO_SOCIAL, CPF, CNPJ, TELEFONE, EMAIL, FL_ATIVO
)
AS
select PED.CODIGO, PED.DESCRICAO, PED.NUMERO, PED.DATA_EMISSAO, PED.DATA_VENCIMENTO, PED.DATA_ENTREGA, PED.CODIGO_ENDERECO_CLIENTE, PED.CODIGO_VENDEDOR, PED.PERC_COMISSAO_VERDEDOR, PED.VALOR_TOTAL, PED.NFE, PED.OBSERVACAO, PED.CODIGO_CLIENTE, PED.CODIGO_SITUACAO_PEDIDO, PED.CODIGO_EMPRESA, CC.NOME as DC_CLIENTE, CC.RAZAO_SOCIAL as CC_RAZAO_SOCIAL, CC.CPF as CC_CPF, CC.CNPJ as CC_CNPJ, CC.TELEFONE as CC_TELEFONE, CC.EMAIL as CC_EMAIL, CC.FL_ATIVO as CC_FL_ATIVO, CED.CODIGO_PESSOA, CED.TIPO_ENDERECO, CED.CODIGO_CIDADE, CED.BAIRRO, CED.CEP, CED.RUA, CED.NUMERO as CED_NUMERO, CED.NUMERO_BLOCO, CED.NUMERO_APARTAMENTO, CED.OBSERVACAO as CED_OBSERVACAO, CV.NOME as DC_VENDEDOR, CV.RAZAO_SOCIAL as CV_RAZAO_SOCIAL, CV.CPF as CV_CPF, CV.CNPJ as CV_CNPJ, CV.TELEFONE as CV_TELEFONE, CV.EMAIL as CV_EMAIL, CV.FL_ATIVO as CV_FL_ATIVO, CST.DESCRICAO as DC_SITUACAO_PEDIDO, CST.FL_ATIVO as CST_FL_ATIVO, CE.NOME as DC_EMPRESA, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO from PEDIDO as PED
INNER JOIN PESSOA CC on (CC.CODIGO = PED.CODIGO_CLIENTE)
LEFT JOIN ENDERECO CED on (CED.CODIGO = PED.CODIGO_ENDERECO_CLIENTE)
LEFT JOIN PESSOA CV on (CV.CODIGO = PED.CODIGO_VENDEDOR)
INNER JOIN SITUACAO_PEDIDO CST on (CST.CODIGO = PED.CODIGO_SITUACAO_PEDIDO)
INNER JOIN PESSOA CE on (CE.CODIGO = PED.CODIGO_EMPRESA);
/*------ SYSDBA 07/11/2015 05:35:09 --------*/


CREATE OR ALTER VIEW VIEWTIPO_PESSOA
(
CODIGO, NOME, DESCRICAO, BARCODE, VALOR_UNITARIO, OBSERVACAO, FL_ATIVO, CODIGO_EMPRESA, DC_EMPRESA, RAZAO_SOCIAL, CPF, CNPJ, TELEFONE, EMAIL, CE_FL_ATIVO
)
AS
select PRO.CODIGO, PRO.NOME, PRO.DESCRICAO, PRO.BARCODE, PRO.VALOR_UNITARIO, PRO.OBSERVACAO, PRO.FL_ATIVO, PRO.CODIGO_EMPRESA, CE.NOME as DC_EMPRESA, CE.RAZAO_SOCIAL, CE.CPF, CE.CNPJ, CE.TELEFONE, CE.EMAIL, CE.FL_ATIVO as CE_FL_ATIVO from PRODUTO as PRO
INNER JOIN PESSOA CE on (CE.CODIGO = PRO.CODIGO_EMPRESA);
ROLLBACK WORK;
