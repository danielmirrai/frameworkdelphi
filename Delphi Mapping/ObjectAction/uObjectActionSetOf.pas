unit uObjectActionSetOf;

interface

uses
  uObjectAction, uObjectDaoSetOf, Classes, Forms, SysUtils, uConstantSetOf,
  uObjectActionBlockTag,
  uObjectActionBlockTagInDB, TypInfo, uObjectActionStructureDelphi,
  uConstantUtils, uDMUtils;

type

  TObjectActionSetOf = Class(TObjectActionStructureDelphi)
  private
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoSetOf: TObjectDaoSetOf;
    procedure AfterConstruction; override;
  end;

implementation

uses uConstantCommand, uFactoryObject;

procedure TObjectActionSetOf.AfterConstruction;
begin
  inherited;
  FObjectDaoSetOf := GetObjectDao as TObjectDaoSetOf;
end;

procedure TObjectActionSetOf.ConfigureBlockMapping;
var
  oName: TRecordParamValueSearch;
begin
  oName := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oName.Add(FObjectDaoSetOf.CDSDadosNAME.FieldName, sCST_DataOtherValue);
    oName.Add('', '|ID_Operator_23|');
    oName.Add('', '|ID_WordDelphi_57|');
    oName.Add('', '|ID_WordDelphi_31|');
    oName.Add(FObjectDaoSetOf.CDSDadosVALUE_SETOF.FieldName, sCST_OtherValue);
    // Teste  = Set of 1*4..(1*5);
    ListConfigBlockTag.Add(oName, '|ID_Operator_7|');
  finally
    TDMUtils.DestroyObject(oName);
  end;
end;

initialization

RegisterClass(TObjectActionSetOf);

end.
