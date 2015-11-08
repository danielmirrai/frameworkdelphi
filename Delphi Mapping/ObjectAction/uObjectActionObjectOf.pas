unit uObjectActionObjectOf;

interface

uses
  uObjectAction, uObjectDaoObjectOf, Classes, Forms, SysUtils,
  uObjectActionVariable,
  uObjectActionBlockTag, uConstantCommand, uConstantObjectOf, TypInfo,
  uObjectActionBlockTagInDB, uObjectActionStructureDelphi,
  uConstantUtils, uDMList, uDMUtils;

type
  TCategoryMethod = (tcDeclaration, tcParam, tcReturn);

  TObjectActionObjectOf = Class(TObjectActionStructureDelphi)
  private
    procedure CaptureParams(oConfigBlockTag: TConfigBlockTag); virtual;
    procedure CaptureReturnMethod(poConfigBlockTag: TConfigBlockTag); virtual;
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoObjectOf: TObjectDaoObjectOf;
    FObjectActionParams: TObjectActionVariable;
    procedure AfterConstruction; override;
  end;

implementation

uses uFactoryObject;

procedure TObjectActionObjectOf.AfterConstruction;
begin
  inherited;
  FObjectDaoObjectOf := GetObjectDao as TObjectDaoObjectOf;

end;

procedure TObjectActionObjectOf.CaptureParams(oConfigBlockTag: TConfigBlockTag);
var
  oConfigItemTag: TConfigItemTag;
  oValueTypeModifyVar, oValueTypeModifyConst, oValueTypeModifyOut,
    oValueTypeModifyNone, oValueDefaultData, oValueDefaultString,
    oValueDefaultNone, oValueParam: TRecordParamValueSearch;
begin
  if not Assigned(oConfigBlockTag) then
    Exit;

  oValueParam := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  oValueDefaultData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  oValueDefaultString := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  oValueDefaultNone := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  oValueTypeModifyVar := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  oValueTypeModifyConst := TFactoryObject.CreateComponent
    (TRecordParamValueSearch) as TRecordParamValueSearch;
  oValueTypeModifyOut := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  oValueTypeModifyNone := TFactoryObject.CreateComponent
    (TRecordParamValueSearch) as TRecordParamValueSearch;
  try
    // ( até )
    oConfigItemTag := oConfigBlockTag.ListObjectActionChildren.Add
      ('|ID_Operator_5|', sCST_EmptyStr, sCST_EmptyStr, '|ID_Operator_6|',
      Integer(tcParam));

    oValueParam.Add(FObjectActionParams.FObjectDaoVariable.CDSDadosNAME.
      FieldName, sCST_OtherValue);
    oValueParam.Add('', '|ID_Operator_2|');
    oValueParam.Add(FObjectActionParams.FObjectDaoVariable.
      CDSDadosID_TYPE_VALUE.FieldName, sCST_OtherValue);

    oValueTypeModifyVar.Add
      (FObjectActionParams.FObjectDaoVariable.CDSDadosTYPE_MODIFY.FieldName,
      '|ID_WordDelphi_35|');
    oValueTypeModifyConst.Add
      (FObjectActionParams.FObjectDaoVariable.CDSDadosTYPE_MODIFY.FieldName,
      '|ID_WordDelphi_56|');
    oValueTypeModifyOut.Add
      (FObjectActionParams.FObjectDaoVariable.CDSDadosTYPE_MODIFY.FieldName,
      '|ID_Directive_109|');
    oValueTypeModifyNone.Add
      (FObjectActionParams.FObjectDaoVariable.CDSDadosTYPE_MODIFY.FieldName);
    oValueDefaultString.Add(sCST_EmptyStr, '|ID_Operator_23|');
    oValueDefaultString.Add
      (FObjectActionParams.FObjectDaoVariable.CDSDadosDEFAULT_VAR.FieldName,
      sCST_StringOtherValue);
    oValueDefaultData.Add(sCST_EmptyStr, '|ID_Operator_23|');
    oValueDefaultData.Add(FObjectActionParams.FObjectDaoVariable.
      CDSDadosDEFAULT_VAR.FieldName, sCST_DataOtherValue);
    oValueDefaultNone.Add(sCST_EmptyStr);
    oConfigItemTag.SubBlock.ListObjectActionChildren.Add(
      // OK: Boolean
      oValueParam,
      // Var, Const, out, none
      [oValueTypeModifyVar, oValueTypeModifyConst, oValueTypeModifyOut,
      oValueTypeModifyNone],
      // = 'Test', = 1
      [oValueDefaultString, oValueDefaultData, oValueDefaultNone],
      // ;
      '|ID_Operator_7|');
  finally
    TDMUtils.DestroyObject(oValueParam);
    TDMUtils.DestroyObject(oValueDefaultData);
    TDMUtils.DestroyObject(oValueDefaultString);
    TDMUtils.DestroyObject(oValueDefaultNone);
    TDMUtils.DestroyObject(oValueTypeModifyVar);
    TDMUtils.DestroyObject(oValueTypeModifyConst);
    TDMUtils.DestroyObject(oValueTypeModifyOut);
    TDMUtils.DestroyObject(oValueTypeModifyNone);
  end;
end;

procedure TObjectActionObjectOf.CaptureReturnMethod(poConfigBlockTag
  : TConfigBlockTag);
begin
  if Assigned(poConfigBlockTag) then
    poConfigBlockTag.ListObjectActionChildren.Add('|ID_Operator_2|',
      '|ID_Data_' + sCST_OtherValue + '|', sCST_EmptyStr, sCST_EmptyStr,
      Integer(tcReturn), False);
end;

procedure TObjectActionObjectOf.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
  oValue: TRecordParamValueSearch;
begin
  oValue := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oValue.Add(FObjectDaoObjectOf.CDSDadosNAME.FieldName, sCST_DataOtherValue);
    oValue.Add('', '|ID_Operator_23|');

    // TName = até Object of;
    oConfigBlockTag := ListConfigBlockTag.Add(oValue,
      '|ID_WordDelphi_31|,|ID_WordDelphi_27|,|ID_Operator_7|');

    oValue.Clear;
    // Class
    oValue.Add(FObjectDaoObjectOf.CDSDadosIS_STATIC.FieldName,
      '|ID_WordDelphi_53|', sCST_True);
    // Procedude
    oValue.Add(FObjectDaoObjectOf.CDSDadosIS_FUNCTION.FieldName,
      '|ID_WordDelphi_72|', sCST_False);

    // class procedure até ;
    oConfigBlockTag := oConfigBlockTag.ListObjectActionChildren.Add(oValue,
      sCST_EmptyStr, sCST_EmptyStr, '|ID_Operator_7|').SubBlock;
    CaptureParams(oConfigBlockTag);

    oValue.Clear;
    // Procedude
    oValue.Add(FObjectDaoObjectOf.CDSDadosIS_FUNCTION.FieldName,
      '|ID_WordDelphi_72|', sCST_False);

    // 1 - procedure até ;
    oConfigBlockTag := oConfigBlockTag.ListObjectActionChildren.Add(oValue,
      sCST_EmptyStr, sCST_EmptyStr, '|ID_Operator_7|').SubBlock;
    CaptureParams(oConfigBlockTag);

    oValue.Clear;
    // Class
    oValue.Add(FObjectDaoObjectOf.CDSDadosIS_STATIC.FieldName,
      '|ID_WordDelphi_53|', sCST_True);
    // function
    oValue.Add(FObjectDaoObjectOf.CDSDadosIS_FUNCTION.FieldName,
      '|ID_WordDelphi_57|', sCST_True);

    // 3 - class function até ;
    oConfigBlockTag := oConfigBlockTag.ListObjectActionChildren.Add(oValue,
      sCST_EmptyStr, sCST_EmptyStr, '|ID_Operator_7|').SubBlock;
    CaptureParams(oConfigBlockTag);
    CaptureReturnMethod(oConfigBlockTag);

    oValue.Clear;
    // function
    oValue.Add(FObjectDaoObjectOf.CDSDadosIS_FUNCTION.FieldName,
      '|ID_WordDelphi_57|', sCST_True);
    // 4 - function até ;
    oConfigBlockTag := oConfigBlockTag.ListObjectActionChildren.Add(oValue,
      sCST_EmptyStr, sCST_EmptyStr, '|ID_Operator_7|').SubBlock;
    CaptureParams(oConfigBlockTag);
    CaptureReturnMethod(oConfigBlockTag);
  finally
    TDMUtils.DestroyObject(oValue);
  end;
end;

initialization

RegisterClass(TObjectActionObjectOf);

end.
