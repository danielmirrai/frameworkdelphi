

ALTER TABLE CIDADE
ADD COD_DS INTEGER
NOT NULL ;



UPDATE CIDADE
SET COD_DS = 1;



ALTER TABLE ESTADO
ADD COD_DS INTEGER
NOT NULL ;



UPDATE ESTADO
SET COD_DS = 1;



ALTER TABLE CIDADE
ADD CONSTRAINT UNQ1_CIDADE
UNIQUE (COD_DS);



ALTER TABLE ESTADO
ADD CONSTRAINT FK_ESTADO_2
FOREIGN KEY (COD_DS)
REFERENCES CIDADE(COD_DS);



ALTER TABLE ESTADO DROP CONSTRAINT FK_ESTADO_2;

ALTER TABLE ESTADO
ADD CONSTRAINT FK_DS1
FOREIGN KEY (COD_DS)
REFERENCES CIDADE(COD_DS)
USING INDEX FK_ESTADO_2;



ALTER TABLE ESTADO DROP COD_DS;



ALTER TABLE CIDADE DROP COD_DS;



DROP PROCEDURE DROPDEPENDENCIAS;



create view ShowDBDependence (TableOrigem, IndexOrigem, FieldNameOrigem, TableReference, IndexReference, FieldNameReference)
as

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
ORDER BY 1, 2
;



SET TERM ^ ;

create or alter procedure "GeneratorViewDependencies"
as
begin
  /* Procedure Text */
  suspend;
end^

SET TERM ; ^



CREATE OR ALTER VIEW SHOWDBDEPENDENCE(
    TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE,
    CONSTRAINT_TYPE)
AS
SELECT i.rdb$relation_name as TableOrigem, I.rdb$index_name as IndexOrigem,
S.RDB$FIELD_NAME as FieldNameOrigem,
f.rdb$relation_name as TableReference, i.rdb$foreign_key as IndexReference, Sp.RDB$FIELD_NAME AS FieldNameReference, C.RDB$CONSTRAINT_TYPE C
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE') and (not (i.rdb$relation_name like '%$%'))
ORDER BY 1, 2
;



CREATE OR ALTER VIEW SHOWDBDEPENDENCE(
    TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE,
    CONSTRAINT_TYPE)
AS
SELECT i.rdb$relation_name as TableOrigem, I.rdb$index_name as IndexOrigem,
S.RDB$FIELD_NAME as FieldNameOrigem,
f.rdb$relation_name as TableReference, i.rdb$foreign_key as IndexReference, Sp.RDB$FIELD_NAME AS FieldNameReference, C.RDB$CONSTRAINT_TYPE C
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE') and (not (i.rdb$relation_name like '%$%'))
ORDER BY 1, 2
;



CREATE OR ALTER VIEW SHOWLISTFIELDDB(
    TABLENAME,
    FIELDNAME,
    NULLFLAG)
AS
select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY 1, 2
;



CREATE OR ALTER VIEW SHOWLISTFIELDDB(
    TABLENAME,
    FIELDNAME,
    NULLFLAG)
AS
select f.rdb$relation_name as TABLENAME, f.rdb$field_name as FIELDNAME, f.rdb$null_flag
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name
and r.rdb$view_blr is null 
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
ORDER BY f.rdb$relation_name, f.rdb$field_position
;



alter table ENDERECO
alter CODIGO position 1;

alter table ENDERECO
alter CODIGO_PESSOA position 2;

alter table ENDERECO
alter TIPO_ENDERECO position 3;

alter table ENDERECO
alter CODIGO_CIDADE position 4;

alter table ENDERECO
alter BAIRRO position 5;

alter table ENDERECO
alter CEP position 6;

alter table ENDERECO
alter RUA position 7;

alter table ENDERECO
alter NUMERO position 8;

alter table ENDERECO
alter NUMERO_BLOCO position 9;

alter table ENDERECO
alter NUMERO_APARTAMENTO position 10;

alter table ENDERECO
alter OBSERVACAO position 11;



CREATE OR ALTER VIEW SHOWLISTFIELDDB(
    TABLENAME,
    FIELDNAME,
    NULLFLAG, FIELDTYPE, DCFIELDTYPE)
AS
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
ORDER BY f.rdb$relation_name, f.rdb$field_position
;



CREATE OR ALTER VIEW SHOWDBDEPENDENCE(
    TABLEORIGEM,
    INDEXORIGEM,
    FIELDNAMEORIGEM,
    TABLEREFERENCE,
    INDEXREFERENCE,
    FIELDNAMEREFERENCE,
    CONSTRAINT_TYPE)
AS
SELECT trim(i.rdb$relation_name) as TableOrigem, trim(I.rdb$index_name) as IndexOrigem,
trim(S.RDB$FIELD_NAME) as FieldNameOrigem,
trim(f.rdb$relation_name) as TableReference, trim(i.rdb$foreign_key) as IndexReference, trim(Sp.RDB$FIELD_NAME) AS FieldNameReference,
trim(C.RDB$CONSTRAINT_TYPE) C
FROM RDB$INDEX_SEGMENTS S
LEFT JOIN RDB$INDICES I ON I.RDB$INDEX_NAME = S.RDB$INDEX_NAME
LEFT JOIN RDB$RELATION_CONSTRAINTS C ON C.RDB$INDEX_NAME = S.RDB$INDEX_NAME    
LEFT JOIN RDB$RELATION_CONSTRAINTS f ON f.RDB$INDEX_NAME = i.rdb$foreign_key 
LEFT JOIN RDB$INDEX_SEGMENTS SP ON SP.RDB$INDEX_NAME = f.RDB$INDEX_NAME
WHERE
  C.RDB$CONSTRAINT_TYPE in ('FOREIGN KEY', 'PRIMARY KEY', 'UNIQUE') and (not (i.rdb$relation_name like '%$%'))
ORDER BY 1, 2
;



CREATE OR ALTER VIEW SHOWLISTFIELDDB(
    TABLENAME,
    FIELDNAME,
    NULLFLAG,
    FIELDTYPE,
    DCFIELDTYPE)
AS
select trim(f.rdb$relation_name) as TABLENAME, trim(f.rdb$field_name) as FIELDNAME, trim(f.rdb$null_flag), trim(FE.rdb$field_type),
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
ORDER BY f.rdb$relation_name, f.rdb$field_position
;



CREATE OR ALTER VIEW SHOWLISTFIELDDB(
    TABLENAME,
    FIELDNAME,
    NULLFLAG,
    FIELDTYPE,
    DCFIELDTYPE)
AS
select trim(f.rdb$relation_name) as TABLENAME, trim(f.rdb$field_name) as FIELDNAME, trim(f.rdb$null_flag), trim(FE.rdb$field_type),
Trim(CASE fe.RDB$FIELD_TYPE
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
ELSE 'UNKNOWN' END) as DC_FIEL_DTYPE
from rdb$relation_fields f
join rdb$relations r on f.rdb$relation_name = r.rdb$relation_name and r.rdb$view_blr is null
and (r.rdb$system_flag is null or r.rdb$system_flag = 0) and
(not (f.rdb$relation_name like '%$%'))
LEFT JOIN RDB$FIELDS FE ON f.RDB$FIELD_SOURCE = FE.RDB$FIELD_NAME
ORDER BY f.rdb$relation_name, f.rdb$field_position
;

