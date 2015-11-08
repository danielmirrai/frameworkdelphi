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
unit uObjectActionMethod;

interface

uses
  uObjectAction, uObjectDaoMethod, Classes, Forms, SysUtils, uConstantTrack,
  uDMUtils, uObjectActionBlockTag, uDMList, uConstantCommand,
  uObjectActionBlockTagInDB, TypInfo, uObjectActionStructureDelphi,
  uObjectActionConst, uObjectActionStructure,
  uObjectActionVariable, uObjectActionDirectiveMethod;

type
  TCategoryMethod = (tcProcedure, tcProcedureStatic, tcFunction,
    tcFunctionStatic, tcParam, tcReturn, tcDirectiveMethod);

  /// <summary>
  /// Constrole ação de métodos do arquivo mapeado
  /// </summary>
  /// <remarks>
  /// Podendo ser dentro de Class ou unit
  /// </remarks>
  /// <example>
  /// <para>
  /// public
  /// </para>
  /// <para>
  /// function GetName: string;
  /// </para>
  /// </example>
  TObjectActionMethod = class(TObjectActionStructureDelphi)
  private
  protected
    procedure CaptureParams(oConfigBlockTag: TConfigBlockTag); virtual;
    procedure CaptureDirectives(oConfigBlockTag: TConfigBlockTag); virtual;
    procedure CaptureNameMethod(poConfigBlockTag: TConfigBlockTag); virtual;
    procedure CaptureReturnMethod(poConfigBlockTag: TConfigBlockTag); virtual;
    procedure ConfigureBlockMapping; Override;
    procedure SetObjectChildCanProcessStructor(poChild: TObjectActionStructure;
      const pbCanProcess: Boolean); Override;
  public
    FObjectDaoMethod: TObjectDaoMethod;
    FObjectActionConst: TObjectActionConst;
    FObjectActionVariable: TObjectActionVariable;
    FObjectActionParams: TObjectActionVariable;
    FObjectActionDirectiveMethod: TObjectActionDirectiveMethod;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    procedure AddData(const poListData: TStringList;
      const pnIDCategory: Integer; const poTagBeginBlock,
      pbTagEndBlock: TValueTag); reintroduce;
  end;

implementation

{ TObjectActionMethod }

uses uConstantUtils, uFactoryObject, uObjectActionUnit, uObjectActionClass,
  uObjectActionType;

procedure TObjectActionMethod.AddData(const poListData: TStringList;
  const pnIDCategory: Integer; const poTagBeginBlock, pbTagEndBlock: TValueTag);
var
  sName, sReturn: String;
begin
  if not Assigned(poListData) then
    Exit;
  case TCategoryMethod(pnIDCategory) of
    tcDirectiveMethod:
      FObjectActionDirectiveMethod.AddData(poListData, pnIDCategory,
        poTagBeginBlock, pbTagEndBlock);
    tcReturn:
      FObjectActionParams.AddReturn(poListData);
    tcParam:
      FObjectActionParams.AddParams(poListData);
    tcProcedure, tcFunction, tcProcedureStatic, tcFunctionStatic:
      begin
        sName := Trim(TDMUtils.GetValueList(poListData, 0));
        sReturn := Trim(TDMUtils.GetValueList(poListData, 3));
        if TDMUtils.IsEmpty(sName) then
          Exit;

        FindAddOrEdit([FObjectDaoMethod.CDSDadosNAME.FieldName,
          FObjectDaoMethod.CDSDadosIS_FUNCTION.FieldName,
          FObjectDaoMethod.CDSDadosIS_STATIC.FieldName],
          [sName, TCategoryMethod(pnIDCategory) in [tcFunction,
          tcFunctionStatic], TCategoryMethod(pnIDCategory)
          in [tcProcedureStatic, tcFunctionStatic]], True);
      end;
  end;
end;

procedure TObjectActionMethod.CaptureParams(oConfigBlockTag: TConfigBlockTag);
var
  oConfigItemTag: TConfigItemTag;
begin
  if not Assigned(oConfigBlockTag) then
    Exit;
  // ( até )
  oConfigItemTag := oConfigBlockTag.ListObjectActionChildren.Add
    ('|ID_Operator_5|', sCST_EmptyStr, sCST_EmptyStr, '|ID_Operator_6|');
  oConfigItemTag.SubBlock.IDCategory := Integer(tcParam);
  // Const testee = 'Ok'
  oConfigItemTag.SubBlock.ListObjectActionChildren.Add(sCST_EmptyStr,
    '|ID_WordDelphi_56|,|ID_Data_' + sCST_OtherValue +
    '|,|ID_Operator_2|,|ID_Data_' + sCST_OtherValue + '|');

  oConfigItemTag.SubBlock.ListObjectActionChildren.Add(
    // OK: Boolean
    '|ID_Data_' + sCST_OtherValue + '|,|ID_Operator_2|,|ID_Data_' +
    sCST_OtherValue + '|',
    // Var, Const, out, none
    ['|ID_WordDelphi_35|', '|ID_WordDelphi_56|', '|ID_Directive_109|',
    sCST_EmptyStr],
    // = 'Test', = 1
    ['|ID_Operator_23|,|ID_String_' + sCST_OtherValue + '|',
    '|ID_Operator_23|,|ID_Data_' + sCST_OtherValue + '|', sCST_EmptyStr],
    // ;
    '|ID_Operator_7|');
end;

procedure TObjectActionMethod.CaptureReturnMethod(poConfigBlockTag
  : TConfigBlockTag);
begin
  if Assigned(poConfigBlockTag) then
    poConfigBlockTag.ListObjectActionChildren.Add('|ID_Operator_2|',
      '|ID_Data_' + sCST_OtherValue + '|', sCST_EmptyStr, sCST_EmptyStr,
      Integer(tcReturn), False);
end;

procedure TObjectActionMethod.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
begin
  // 1 - class procedure até ;
  oConfigBlockTag := ListConfigBlockTag.Add
    ('|ID_WordDelphi_53|,|ID_WordDelphi_72|', '|ID_Operator_7|', True,
    Integer(tcProcedureStatic));
  CaptureNameMethod(oConfigBlockTag);
  CaptureParams(oConfigBlockTag);

  // 3 - class function até ;
  oConfigBlockTag := ListConfigBlockTag.Add
    ('|ID_WordDelphi_53|,|ID_WordDelphi_57|', '|ID_Operator_7|', True,
    Integer(tcFunctionStatic));
  CaptureNameMethod(oConfigBlockTag);
  CaptureParams(oConfigBlockTag);
  CaptureReturnMethod(oConfigBlockTag);

  // 1 - procedure até ;
  oConfigBlockTag := ListConfigBlockTag.Add('|ID_WordDelphi_72|',
    '|ID_Operator_7|', True, Integer(tcProcedure));
  CaptureNameMethod(oConfigBlockTag);
  CaptureParams(oConfigBlockTag);
  CaptureDirectives(oConfigBlockTag);

  // 4 - function até ;
  oConfigBlockTag := ListConfigBlockTag.Add('|ID_WordDelphi_57|',
    '|ID_Operator_7|', True, Integer(tcFunction));
  CaptureNameMethod(oConfigBlockTag);
  CaptureParams(oConfigBlockTag);
  CaptureReturnMethod(oConfigBlockTag);
  CaptureDirectives(oConfigBlockTag);

end;

procedure TObjectActionMethod.SetObjectChildCanProcessStructor
  (poChild: TObjectActionStructure; const pbCanProcess: Boolean);
begin
  if (poChild <> FObjectActionParams) and
    (poChild <> FObjectActionDirectiveMethod) then
    inherited;
end;

procedure TObjectActionMethod.AfterConstruction;
begin
  inherited;
  FObjectDaoMethod := GetObjectDao as TObjectDaoMethod;

  FObjectActionParams := ListObjectActionChildren.Add(TObjectActionVariable,
    Self) as TObjectActionVariable;

  FObjectActionDirectiveMethod := ListObjectActionChildren.Add
    (TObjectActionDirectiveMethod, Self) as TObjectActionDirectiveMethod;

  FObjectActionConst := ListObjectActionChildren.Add(TObjectActionConst, Self)
    as TObjectActionConst;
  FObjectActionVariable := ListObjectActionChildren.Add(TObjectActionVariable,
    Self) as TObjectActionVariable;

end;

procedure TObjectActionMethod.BeforeDestruction;
begin
  inherited;
end;

procedure TObjectActionMethod.CaptureDirectives(oConfigBlockTag
  : TConfigBlockTag);
begin
  if not Assigned(oConfigBlockTag) then
    Exit;
  // virtual
  oConfigBlockTag.ListObjectActionChildren.Add('|ID_Operator_7|',
    '|ID_Directive_90|', sCST_EmptyStr, sCST_EmptyStr,
    Integer(tcDirectiveMethod), False);
  // Overload
  oConfigBlockTag.ListObjectActionChildren.Add('|ID_Operator_7|',
    '|ID_Directive_91|', sCST_EmptyStr, sCST_EmptyStr,
    Integer(tcDirectiveMethod), False);
  // abstract
  oConfigBlockTag.ListObjectActionChildren.Add('|ID_Operator_7|',
    '|ID_Directive_96|', sCST_EmptyStr, sCST_EmptyStr,
    Integer(tcDirectiveMethod), False);
  // reintroduce
  oConfigBlockTag.ListObjectActionChildren.Add('|ID_Operator_7|',
    '|ID_Directive_112|', sCST_EmptyStr, sCST_EmptyStr,
    Integer(tcDirectiveMethod), False);
  // dynamic
  oConfigBlockTag.ListObjectActionChildren.Add('|ID_Operator_7|',
    '|ID_Directive_120|', sCST_EmptyStr, sCST_EmptyStr,
    Integer(tcDirectiveMethod), False);
end;

procedure TObjectActionMethod.CaptureNameMethod(poConfigBlockTag
  : TConfigBlockTag);
begin
  // TesteItem
  if Assigned(poConfigBlockTag) then
    poConfigBlockTag.ListObjectActionChildren.Add(sCST_EmptyStr,
      '|ID_Data_' + sCST_OtherValue + '|');
end;

initialization

RegisterClass(TObjectActionMethod);

end.
