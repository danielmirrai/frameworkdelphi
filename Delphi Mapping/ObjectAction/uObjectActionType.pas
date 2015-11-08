unit uObjectActionType;

interface

uses
  uObjectAction, uObjectDaoType, Classes, Forms, SysUtils, uConstantType,
  TypInfo, uObjectActionInterface, uObjectActionExistingType,
  uObjectActionBlockTagInDB, uObjectActionBlockTag, uObjectActionArrayOf,
  uObjectActionClassOf,
  uDMList, uConstantUtils, uDMUtils, uObjectActionClass,
  uObjectActionDispinterface,
  uObjectActionRecord, uObjectActionTypeExpression,
  uObjectActionStructureDelphi, uObjectActionEnumerated;

type
  TObjectActionType = Class(TObjectActionStructureDelphi)
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoType: TObjectDaoType;

    FObjectActionClass: TObjectActionClass;
    FObjectActionClassOf: TObjectActionClassOf;
    FObjectActionInterface: TObjectActionInterface;
    FObjectActionTypeExpression: TObjectActionTypeExpression;
    FObjectActionRecord: TObjectActionRecord;
    FObjectActionExistingType: TObjectActionExistingType;
    FObjectActionEnumerated: TObjectActionEnumerated;
    FObjectActionDispinterface: TObjectActionDispinterface;
    FObjectActionArrayOf: TObjectActionArrayOf;
    procedure AfterConstruction; override;
  end;

implementation

uses uFactoryObject;

procedure TObjectActionType.AfterConstruction;
begin
  inherited;
  FObjectDaoType := GetObjectDao as TObjectDaoType;
  FObjectActionExistingType := ListObjectActionChildren.Add
    (TObjectActionExistingType, Self) as TObjectActionExistingType;
  FObjectActionClass := ListObjectActionChildren.Add(TObjectActionClass, Self)
    as TObjectActionClass;

  { FObjectActionClassOf := ListObjectActionChildren.Add(TObjectActionClassOf, Self) as TObjectActionClassOf;




    FObjectActionInterface := ListObjectActionChildren.Add(TObjectActionInterface,
    Self) as TObjectActionInterface;
    FObjectActionTypeExpression := ListObjectActionChildren.Add
    (TObjectActionTypeExpression, Self) as TObjectActionTypeExpression;
    FObjectActionRecord := ListObjectActionChildren.Add(TObjectActionRecord, Self)
    as TObjectActionRecord;
    FObjectActionEnumerated := ListObjectActionChildren.Add
    (TObjectActionEnumerated, Self) as TObjectActionEnumerated;
    FObjectActionDispinterface := ListObjectActionChildren.Add
    (TObjectActionDispinterface, Self) as TObjectActionDispinterface;
    FObjectActionArrayOf := ListObjectActionChildren.Add(TObjectActionArrayOf,
    Self) as TObjectActionArrayOf; }
end;

procedure TObjectActionType.ConfigureBlockMapping;
var
  oData: TRecordParamValueSearch;
begin
  oData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oData.FieldDBName := FObjectDaoType.CDSDadosID_TYPE.FieldName;
    oData.TagSearch := '|ID_WordDelphi_73|';
    // type
    ListConfigBlockTag.Add(oData, nil);
  finally
    TDMUtils.DestroyObject(oData);
  end;
end;

initialization

RegisterClass(TObjectActionType);

end.
