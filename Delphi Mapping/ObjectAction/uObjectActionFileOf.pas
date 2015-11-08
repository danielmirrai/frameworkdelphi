unit uObjectActionFileOf;

interface

uses
  uObjectAction, uObjectDaoFileOf, Classes, Forms, SysUtils, uConstantFileOf,
  uObjectActionBlockTag, uDMList, TypInfo, uObjectActionStructureDelphi,
  uObjectActionBlockTagInDB, uConstantUtils, uDMUtils;

type
  TObjectActionFileOf = Class(TObjectActionStructureDelphi)
  private
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoFileOf: TObjectDaoFileOf;
    procedure AfterConstruction; override;
  end;

implementation

uses uConstantCommand, uFactoryObject;

procedure TObjectActionFileOf.AfterConstruction;
begin
  inherited;
  FObjectDaoFileOf := GetObjectDao as TObjectDaoFileOf;

end;

procedure TObjectActionFileOf.ConfigureBlockMapping;
var
  oValue, oValueEnd: TRecordParamValueSearch;
begin
  oValue := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  oValueEnd := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oValue.FieldDBName := FObjectDaoFileOf.CDSDadosNAME.FieldName;
    oValue.TagSearch := sCST_DataOtherValue +
      ',|ID_Operator_23|,|ID_WordDelphi_14|,|ID_WordDelphi_31|';

    oValueEnd.FieldDBName := FObjectDaoFileOf.CDSDadosID_CLASS.FieldName;
    oValueEnd.TagSearch := sCST_DataOtherValue + ',|ID_Operator_7|';
    // TDMUtils = file of até TObject;
    ListConfigBlockTag.Add(oValue, oValueEnd);
  finally
    TDMUtils.DestroyObject(oValue);
    TDMUtils.DestroyObject(oValueEnd);
  end;
end;

initialization

RegisterClass(TObjectActionFileOf);

end.
