unit uObjectActionVisibilityClass;

interface

uses
  uObjectAction, uObjectDaoVisibilityClass, Forms, SysUtils, Classes,
  uConstantVisibilityClass, TypInfo, uObjectActionStructureDelphi,
  uObjectActionBlockTagInDB, uConstantUtils, uObjectActionVariable, uDMUtils,
  uDMList, uObjectActionMethod,
  uObjectActionBlockTag, uObjectActionConst;

type
  TObjectActionVisibilityClass = Class(TObjectActionStructureDelphi)
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoVisibilityClass: TObjectDaoVisibilityClass;

    FObjectActionMethod: TObjectActionMethod;
    FObjectActionConst: TObjectActionConst;
    FObjectActionVariable: TObjectActionVariable;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

uses uFactoryObject;

procedure TObjectActionVisibilityClass.AfterConstruction;
begin
  inherited;
  FObjectDaoVisibilityClass := GetObjectDao as TObjectDaoVisibilityClass;

  { FObjectActionMethod := ListObjectActionChildren.Add(TObjectActionMethod, Self)
    as TObjectActionMethod;
    FObjectActionConst := ListObjectActionChildren.Add(TObjectActionConst, Self)
    as TObjectActionConst;
    FObjectActionVariable := ListObjectActionChildren.Add(TObjectActionVariable,
    Self) as TObjectActionVariable; }

end;

procedure TObjectActionVisibilityClass.BeforeDestruction;
begin
  inherited;
end;

procedure TObjectActionVisibilityClass.ConfigureBlockMapping;
var
  oData: TRecordParamValueSearch;
begin
  oData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oData.FieldDBName := FObjectDaoVisibilityClass.
      CDSDadosID_VISIBILITY.FieldName;

    oData.FixedValue := IntToStr(Integer(tvSTRICT_PRIVATE));
    oData.TagSearch := '|ID_Directive_39|,|ID_Directive_33|';
    ListConfigBlockTag.Add(nil, oData);

    oData.FixedValue := IntToStr(Integer(tvSTRICT_PROTECTED));
    oData.TagSearch := '|ID_Directive_39|,|ID_Directive_37|';
    ListConfigBlockTag.Add(nil, oData);

    oData.FixedValue := IntToStr(Integer(tvPRIVATE));
    oData.TagSearch := '|ID_Directive_33|';
    ListConfigBlockTag.Add(nil, oData);

    oData.FixedValue := IntToStr(Integer(tvPROTECTED));
    oData.TagSearch := '|ID_Directive_37|';
    ListConfigBlockTag.Add(nil, oData);

    oData.FixedValue := IntToStr(Integer(tvPUBLIC));
    oData.TagSearch := '|ID_Directive_6|';
    ListConfigBlockTag.Add(nil, oData);

    oData.FixedValue := IntToStr(Integer(tvPUBLISHED));
    oData.TagSearch := '|ID_Directive_12|';
    ListConfigBlockTag.Add(nil, oData);
  finally
    TDMUtils.DestroyObject(oData);
  end;
end;

initialization

RegisterClass(TObjectActionVisibilityClass);

end.
