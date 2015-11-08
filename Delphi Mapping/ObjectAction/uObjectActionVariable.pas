{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Senior Delphi Programmer }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Phones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ www.danielmirrai.com }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }
unit uObjectActionVariable;

interface

uses
  uObjectAction, uObjectDaoVariable, Classes, Forms, SysUtils, uConstantTrack,
  uObjectActionBlockTagInDB, uObjectActionBlockTag, uDMList, uDMUtils,
  uConstantUtils, uObjectActionStructureDelphi;

type
  TTypeInstanceVar = (teNormal, teSingleton);

  /// <summary>
  /// Constrole ação de Variável
  /// </summary>
  /// <remarks>
  /// <para>
  /// * Variável de Global de Unit
  /// </para>
  /// <para>
  /// * Variável de Class
  /// </para>
  /// <para>
  /// * Variável de Método
  /// </para>
  /// <para>
  /// * Parâmetro
  /// </para>
  /// </remarks>
  TObjectActionVariable = class(TObjectActionStructureDelphi)
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoVariable: TObjectDaoVariable;
    procedure AfterConstruction; override;

    /// <summary>
    /// Adiciona paramâmetros do método
    /// </summary>
    procedure AddParams(const poListData: TStringList);

    /// <summary>
    /// Adiciona returno da função
    /// </summary>
    procedure AddReturn(const poListData: TStringList);

    /// <summary>
    /// Adiciona valores do enumerado
    /// </summary>
    procedure AddEnumValue(const poListData: TStringList);
    procedure Add; Override;
  end;

implementation

uses
  uObjectActionClass, uObjectActionMethod, uObjectActionUnit, uFactoryObject,
  uConstantCommand;
{ TObjectActionVariable }

procedure TObjectActionVariable.Add;
begin
  inherited;
  FObjectDaoVariable.CDSDadosIS_PARAM.AsBoolean := False;
  FObjectDaoVariable.CDSDadosIS_STATIC.AsBoolean := False;
  FObjectDaoVariable.CDSDadosIS_RETURN.AsBoolean := False;
end;

procedure TObjectActionVariable.AddEnumValue(const poListData: TStringList);
var
  sName: String;
  nIndex: Integer;
begin
  sName := TDMUtils.GetValueList(poListData, nCST_Zero);
  nIndex := TDMUtils.StrToInt2(TDMUtils.GetValueList(poListData, nCST_two));

  if TDMUtils.IsEmpty(sName) then
    Exit;

  FindAddOrEdit([FObjectDaoVariable.CDSDadosNAME.FieldName,
    FObjectDaoVariable.CDSDadosNAME.FieldName], [sName, nIndex], True);
end;

procedure TObjectActionVariable.AddParams(const poListData: TStringList);
var
  sTypeModify, sName, sType, sDefault: String;
  nIDModify: Integer;
begin
  if not Assigned(poListData) then
    Exit;

  sTypeModify := sCST_EmptyStr;
  nIDModify := nCST_Zero;

  if poListData.Count in [4, 6] then
  begin
    sTypeModify := TDMUtils.GetValueList(poListData, 0);
    nIDModify := 1;
  end;
  sName := TDMUtils.GetValueList(poListData, 0 + nIDModify);
  sType := TDMUtils.GetValueList(poListData, 2 + nIDModify);
  sDefault := TDMUtils.GetValueList(poListData, 4 + nIDModify);
  if TDMUtils.ExistValue(sName) and Assigned(FObjectDaoVariable) then
    FindAddOrEdit([FObjectDaoVariable.CDSDadosNAME.FieldName,
      FObjectDaoVariable.CDSDadosIS_PARAM.FieldName,
      FObjectDaoVariable.CDSDadosID_TYPE_VALUE.FieldName,
      FObjectDaoVariable.CDSDadosDEFAULT_VAR.FieldName,
      FObjectDaoVariable.CDSDadosTYPE_MODIFY.FieldName],
      [sName, True, sType, sDefault, sTypeModify], True);
end;

procedure TObjectActionVariable.AddReturn(const poListData: TStringList);
var
  sType: string;
begin
  sType := TDMUtils.GetValueList(poListData, nCST_Zero);
  if TDMUtils.ExistValue(sType) then
    FindAddOrEdit([FObjectDaoVariable.CDSDadosNAME.FieldName,
      FObjectDaoVariable.CDSDadosID_TYPE_VALUE.FieldName,
      FObjectDaoVariable.CDSDadosIS_RETURN.FieldName],
      ['Return', sType, True], True);
end;

procedure TObjectActionVariable.AfterConstruction;
begin
  FObjectDaoVariable := GetObjectDao as TObjectDaoVariable;
  inherited;
end;

procedure TObjectActionVariable.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
  oValue: TRecordParamValueSearch;
begin
  oValue := TFactoryObject.CreateComponent(TRecordParamValueSearch, Self)
    as TRecordParamValueSearch;
  try
    oValue.Clear;
    oValue.Add(FObjectDaoVariable.CDSDadosIS_STATIC.FieldName, '|ID_WordDelphi_53|', 'T');
    oValue.Add('', '|ID_WordDelphi_35|');
    // class var
    oConfigBlockTag := ListConfigBlockTag.Add(oValue, sCST_EmptyStr,
      True);
    oValue.Clear;
    oValue.Add(FObjectDaoVariable.CDSDadosNAME.FieldName, sCST_DataOtherValue);
    oValue.Add('', '|ID_Operator_2|');
    oValue.Add(FObjectDaoVariable.CDSDadosID_TYPE_VALUE.FieldName, sCST_DataOtherValue);
    // nTeste1: Integer;
    oConfigBlockTag.ListObjectActionChildren.Add(sCST_EmptyStr, oValue, '',  '|ID_Operator_7|', -1, True);

                     {
    // var
    oValue.Clear;
    oValue.Add(FObjectDaoVariable.CDSDadosIS_STATIC.FieldName, '|ID_WordDelphi_35|', 'F');
    oConfigBlockTag := ListConfigBlockTag.Add(oValue, sCST_EmptyStr,
      True);
    oValue.Clear;
    oValue.Add(FObjectDaoVariable.CDSDadosNAME.FieldName, sCST_DataOtherValue);
    oValue.Add('', '|ID_Operator_2|');
    oValue.Add(FObjectDaoVariable.CDSDadosID_TYPE_VALUE.FieldName, sCST_DataOtherValue);
    // nTeste1: Integer;
    oConfigBlockTag.ListObjectActionChildren.Add(sCST_EmptyStr, oValue, '',  '|ID_Operator_7|', -1, True);    }
  finally
    TDMUtils.DestroyObject(oValue);
  end;

  {
    var
    sName, sType, sDefault: String;
    begin
    sName := Trim(TDMUtils.GetValueList(poListData, 0));
    sType := Trim(TDMUtils.GetValueList(poListData, 2));
    sDefault := Trim(TDMUtils.GetValueList(poListData, 4));
    if TDMUtils.IsEmpty(sName) then
    Exit;

    FindAddOrEdit([FObjectDaoVariable.CDSDadosNAME.FieldName,
    FObjectDaoVariable.CDSDadosID_TYPE_VALUE.FieldName,
    FObjectDaoVariable.CDSDadosDEFAULT_VAR.FieldName,
    FObjectDaoVariable.CDSDadosIS_STATIC.FieldName,
    FObjectDaoVariable.CDSDadosIS_PARAM.FieldName],
    [sName, sType, sDefault, (TTypeInstanceVar(pnIDCategory) = teSingleton), False], True); }
end;

initialization

RegisterClass(TObjectActionVariable);

end.
