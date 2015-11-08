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
unit uObjectActionConst;

interface

uses
  uObjectActionBlockTagInDB, uObjectAction, uObjectDaoConst,
  uObjectActionStructureDelphi, Classes, Forms,
  SysUtils, uConstantTrack, uDMUtils, uDMList, uConstantUtils,
  uObjectActionBlockTag;

type
  TCategoryConst = (tcData, tcDataTypeInformed);

  /// <summary>
  /// Controle ação das constante declarada na unit que será mapeado
  /// </summary>
  TObjectActionConst = class(TObjectActionStructureDelphi)
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoConst: TObjectDaoConst;
    procedure AfterConstruction; override;
  end;

implementation

uses uObjectActionClass, uObjectActionUnit, uObjectActionMethod,
  uConstantCommand, uFactoryObject;

{ TObjectActionConst }


procedure TObjectActionConst.AfterConstruction;
begin
  inherited;
  FObjectDaoConst := GetObjectDao as TObjectDaoConst;
end;

procedure TObjectActionConst.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
  oItem: TConfigItemTag;
  oValue: TRecordParamValueSearch;
begin
  oValue := TFactoryObject.CreateComponent(TRecordParamValueSearch, Self)
    as TRecordParamValueSearch;
  try
    // const
    oConfigBlockTag := ListConfigBlockTag.Add('|ID_WordDelphi_56|', '', True);

    oValue.Add(FObjectDaoConst.CDSDadosNAME.FieldName, sCST_DataOtherValue);
    oValue.Add('', '|ID_Operator_23|');
    oValue.Add(FObjectDaoConst.CDSDadosVALUE_CONST.FieldName, sCST_OtherValue);
    // nCST_Trinta = Value;
    oConfigBlockTag.ListObjectActionChildren.Add('', oValue, '', '|ID_Operator_7|');
    oValue.Clear;
    oValue.Add(FObjectDaoConst.CDSDadosNAME.FieldName, sCST_DataOtherValue);
    oValue.Add(FObjectDaoConst.CDSDadosID_TYPE_VALUE.FieldName, sCST_DataOtherValue);
    oValue.Add(sCST_EmptyStr, '|ID_Operator_23|');
    oValue.Add(FObjectDaoConst.CDSDadosVALUE_CONST.FieldName, sCST_OtherValue);
    // nCST_Trinta Type = Value;
    oItem := oConfigBlockTag.ListObjectActionChildren.Add('', oValue, '', '|ID_Operator_7|');
    oItem.CanExportForFile := False;
  finally
    TDMUtils.DestroyObject(oValue);
  end;
end;

initialization

RegisterClass(TObjectActionConst);

end.
