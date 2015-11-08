

SET TERM ^ ;

SET TERM ; ^

SET TERM ^ ;

CREATE OR ALTER PROCEDURE DROPDEPENDENCIAS (
    dependencia VARCHAR(200))
AS
declare RecordConstraint cursor for
  (select R.rdb$constraint_name as NameFKOrigem, R.RDB$RELATION_NAME NameTableOrigem,
        R2.RDB$CONSTRAINT_NAME as NamePkReference, R2.RDB$RELATION_NAME as NameTableReference from RDB$REF_CONSTRAINTS C
        inner join RDB$RELATION_CONSTRAINTS R on R.RDB$CONSTRAINT_NAME = C.RDB$CONSTRAINT_NAME           
        inner join RDB$RELATION_CONSTRAINTS R2 on R2.RDB$CONSTRAINT_NAME = C.RDB$CONST_NAME_UQ
       );
BEGIN

END^

SET TERM ; ^