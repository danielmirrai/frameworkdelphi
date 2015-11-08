unit uObjectActionClassOf;

interface

uses
  uObjectAction, uObjectDaoClassOf, Classes, Forms, SysUtils, uConstantClassOf,
  uObjectActionBlockTagInDB, TypInfo, uDMList, uObjectActionStructureDelphi,
  uObjectActionBlockTag, uConstantUtils, uDMUtils;

type
  TCategoryClassOf = (tccName, tccOwner);

  TObjectActionClassOf = Class(TObjectActionStructureDelphi)
  private
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoClassOf: TObjectDaoClassOf;
    procedure AfterConstruction; override;
  end;

implementation

uses uConstantCommand, uFactoryObject;

procedure TObjectActionClassOf.AfterConstruction;
begin
  inherited;
  FObjectDaoClassOf := GetObjectDao as TObjectDaoClassOf;
end;

procedure TObjectActionClassOf.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
  oValue: TRecordParamValueSearch;
begin
  oValue := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oValue.Add(FObjectDaoClassOf.CDSDadosNAME.FieldName, sCST_DataOtherValue);
    // TDMUtils = class of até ;
    oConfigBlockTag := ListConfigBlockTag.Add('|ID_Data_' + sCST_OtherValue +
      '|,|ID_Operator_23|,|ID_WordDelphi_53|,|ID_WordDelphi_31|',
      '|ID_Operator_7|');
    // TObject
    oConfigBlockTag.ListObjectActionChildren.Add
      ('|ID_Data_' + sCST_OtherValue + '|');
  finally
    TDMUtils.DestroyObject(oValue);
  end;

  { poListData.ValueFound.ConverteKeyFound(DeKeyToDate);
    poTagBeginBlock.ValueFound.ConverteKeyFound(DeKeyToDate);
    if not (TDMUtils.ExistValue(poTagBeginBlock.ValueFound.ValueConverted.Count) and
    TDMUtils.ExistValue(poListData.ValueFound.ValueConverted.Count)) then
    Exit;
    sName := Trim(poTagBeginBlock.ValueFound.ValueConverted.Items[0].Strings[0]);
    sOwner := Trim(poListData.ValueFound.ValueConverted.Items[0].Strings[0]);
    if TDMUtils.IsEmpty(sName) or TDMUtils.isempty(sOwner) then
    Exit;

    FindAddOrEdit([FObjectDaoClassOf.CDSDadosNAME.FieldName,
    FObjectDaoClassOf.CDSDadosID_CLASS.FieldName], [sName, sOwner], True); }
end;

initialization

RegisterClass(TObjectActionClassOf);

end.
