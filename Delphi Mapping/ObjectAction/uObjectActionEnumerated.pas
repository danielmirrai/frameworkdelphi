unit uObjectActionEnumerated;

interface

uses
  uObjectAction, uObjectDaoEnumerated, Classes, Forms, SysUtils,
  uConstantEnumerated, TypInfo, uObjectActionVariable,
  uObjectActionBlockTagInDB, uObjectActionStructureDelphi, uDMList,
  uObjectActionBlockTag, uConstantUtils, uDMUtils;

type
  TCategoryEnumerated = (tceName, tceValue, tceValueIndexDefined);

  TObjectActionEnumerated = Class(TObjectActionStructureDelphi)
  private
    procedure CaptureValues(poConfigBlockTag: TConfigBlockTag);
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoEnumerated: TObjectDaoEnumerated;

    FObjectActionVariable: TObjectActionVariable;
    procedure AfterConstruction; override;
    destructor Destroy; override;
  end;

implementation

uses uConstantCommand, uFactoryObject;

procedure TObjectActionEnumerated.AfterConstruction;
begin
  inherited;
  FObjectDaoEnumerated := GetObjectDao as TObjectDaoEnumerated;

  FObjectActionVariable := ListObjectActionChildren.Add(TObjectActionVariable,
    Self) as TObjectActionVariable;
  FObjectActionVariable.CanCreateObjectDao := False;

end;

procedure TObjectActionEnumerated.CaptureValues(poConfigBlockTag
  : TConfigBlockTag);
var
  oData: TRecordParamValueSearch;
begin
  if not Assigned(poConfigBlockTag) then
    Exit;
  oData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oData.FieldDBName := FObjectActionVariable.FObjectDaoVariable.CDSDadosNAME.
      FieldName + ',,' + FObjectActionVariable.FObjectDaoVariable.
      CDSDadosINDEX_VAR.FieldName;
    oData.TagSearch := sCST_DataOtherValue + ',|ID_Operator_23|,|ID_Data_9|';

    // tcSegunda = 3, tcTerça
    poConfigBlockTag.ListObjectActionChildren.Add(nil, oData,
      '|ID_Operator_29|', sCST_EmptyStr, Integer(tceValueIndexDefined));

    oData.Clear;
    oData.FieldDBName := FObjectActionVariable.FObjectDaoVariable.
      CDSDadosNAME.FieldName;
    // tcSegunda, tcTerça
    poConfigBlockTag.ListObjectActionChildren.Add(nil, oData,
      '|ID_Operator_29|', sCST_EmptyStr, Integer(tceValue), False);
  finally
    TDMUtils.DestroyObject(oData);
  end;
end;

procedure TObjectActionEnumerated.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
  oData: TRecordParamValueSearch;
begin
  oData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oData.FieldDBName := FObjectDaoEnumerated.CDSDadosNAME.FieldName;
    oData.TagSearch := sCST_DataOtherValue +
      ',|ID_Operator_23|,|ID_Operator_5|';

    // TDMUtils = ( até );
    oConfigBlockTag := ListConfigBlockTag.Add(oData,
      '|ID_Operator_23|,|ID_Operator_7|', False, Integer(tceName));
    CaptureValues(oConfigBlockTag);
  finally
    TDMUtils.DestroyObject(oData);
  end;
end;

destructor TObjectActionEnumerated.Destroy;
begin
  FObjectDaoEnumerated := nil;
  FObjectActionVariable := nil;
  inherited;
end;

initialization

RegisterClass(TObjectActionEnumerated);

end.
