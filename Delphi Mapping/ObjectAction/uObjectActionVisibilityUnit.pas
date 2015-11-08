unit uObjectActionVisibilityUnit;

interface

uses
  uObjectAction, uObjectDaoVisibilityUnit, Classes, Forms, SysUtils,
  uConstantVisibilityUnit, TypInfo, uConstantUtils, uDMUtils,
  uObjectActionMethod, uObjectActionConst, uDMList, uObjectActionBlockTag,
  uObjectActionBlockTagInDB, uObjectActionVariable,
  uObjectActionStructureDelphi,
  uObjectActionClass, uObjectActionType, uObjectActionUses;

type
  TObjectActionVisibilityUnit = Class(TObjectActionStructureDelphi)
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoVisibilityUnit: TObjectDaoVisibilityUnit;

    FObjectActionUses: TObjectActionUses;
    FObjectActionType: TObjectActionType;
    FObjectActionConst: TObjectActionConst;
    FObjectActionVariable: TObjectActionVariable;
    FObjectActionMethod: TObjectActionMethod;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

uses uFactoryObject;

procedure TObjectActionVisibilityUnit.AfterConstruction;
begin
  inherited;
  FObjectDaoVisibilityUnit := GetObjectDao as TObjectDaoVisibilityUnit;

    FObjectActionUses := ListObjectActionChildren.Add(TObjectActionUses, Self)
    as TObjectActionUses;
    FObjectActionConst := ListObjectActionChildren.Add(TObjectActionConst, Self)
    as TObjectActionConst;
    FObjectActionVariable := ListObjectActionChildren.Add(TObjectActionVariable,
    Self) as TObjectActionVariable;
                            {
    FObjectActionMethod := ListObjectActionChildren.Add(TObjectActionMethod, Self)
    as TObjectActionMethod;
    FObjectActionType := ListObjectActionChildren.Add(TObjectActionType, Self)
    as TObjectActionType; }
end;

procedure TObjectActionVisibilityUnit.BeforeDestruction;
begin
  FObjectActionUses := nil;
  FObjectActionType := nil;
  FObjectActionConst := nil;
  FObjectActionVariable := nil;
  FObjectActionMethod := nil;
  inherited;

end;

procedure TObjectActionVisibilityUnit.ConfigureBlockMapping;
var
  oValue: TRecordParamValueSearch;
begin
  oValue := TFactoryObject.CreateComponent(TRecordParamValueSearch, Self)
    as TRecordParamValueSearch;
  try
    oValue.FieldDBName := FObjectDaoVisibilityUnit.CDSDadosIS_PUBLIC.FieldName;
    oValue.TagSearch := '|ID_WordDelphi_33|';
    oValue.FixedValue := 'T';

    // interface até implementation
    ListConfigBlockTag.Add(oValue, '|ID_WordDelphi_68|', False,
      Integer(tvPublic));

    // implementation até end.
    oValue.TagSearch := '|ID_WordDelphi_68|';
    oValue.FixedValue := 'F';
    ListConfigBlockTag.Add(oValue,
      '|ID_WordDelphi_32|,|ID_Operator_1|', False, Integer(tvPrivate));
  finally
    TDMUtils.DestroyObject(oValue);
  end;
end;

initialization

RegisterClass(TObjectActionVisibilityUnit);

end.
