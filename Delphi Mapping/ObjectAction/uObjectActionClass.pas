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
unit uObjectActionClass;

interface

uses
  uObjectAction, uDMList, uObjectDaoClass, Forms, SysUtils, uConstantTrack,
  uObjectActionBlockTagInDB, uObjectActionVisibilityClass, Classes,
  uObjectActionBlockTag, TypInfo, uDMUtils, uObjectActionStructureDelphi;

type
  TCategoryClass = (tccConcrete, tccAbstract, tccOwner);

  /// <summary>
  /// Controle ação das Class do delphi
  /// </summary>
  /// <example>
  /// TTeste = class;
  /// </example>
  TObjectActionClass = class(TObjectActionStructureDelphi)
  private
    procedure CaptureOwner(oConfigBlockTag: TConfigBlockTag;
      oName: TRecordParamValueSearch);
    {

      procedure CaptureClassAbstract;
      procedure CaptureClassConcrete; }
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoClass: TObjectDaoClass;
    FObjectActionVisibilityClass: TObjectActionVisibilityClass;
    procedure AfterConstruction; override;
    procedure Add; override;
    procedure BeforeDestruction; override;
  end;

implementation

{ TObjectActionClass }

uses uConstantUtils, uObjectActionUnit, uFactoryObject, uConstantCommand;

procedure TObjectActionClass.Add;
begin
  inherited;
  FObjectDaoClass.CDSDadosIS_ABSTRACT.AsBoolean := False;
end;

procedure TObjectActionClass.AfterConstruction;
begin
  inherited;
  FObjectDaoClass := GetObjectDao as TObjectDaoClass;

  FObjectActionVisibilityClass := ListObjectActionChildren.Add
    (TObjectActionVisibilityClass, Self) as TObjectActionVisibilityClass;

end;

procedure TObjectActionClass.BeforeDestruction;
begin

  inherited;
end;

procedure TObjectActionClass.CaptureOwner(oConfigBlockTag: TConfigBlockTag;
  oName: TRecordParamValueSearch);
begin
  oName.Clear;
  oName.Add(FObjectDaoClass.CDSDadosID_OWNER.FieldName, sCST_DataOtherValue);
  // ( Owner, IOwner até )
  oConfigBlockTag.ListObjectActionChildren.Add('|ID_Operator_5|', oName,
    '|ID_Operator_29|', '|ID_Operator_7|');
end;

procedure TObjectActionClass.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
  oName: TRecordParamValueSearch;
begin
  oName := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oName.Add(FObjectDaoClass.CDSDadosNAME.FieldName, sCST_DataOtherValue);
    oName.Add(FObjectDaoClass.CDSDadosIS_ABSTRACT.FieldName,
      '|ID_Operator_23|,|ID_WordDelphi_53|', sCST_True);
    // TDMUtils = class até ;
    oConfigBlockTag := ListConfigBlockTag.Add(oName, '|ID_Operator_7|', False,
      Integer(tccAbstract));
    CaptureOwner(oConfigBlockTag, oName);

    oName.Clear;
    oName.Add(FObjectDaoClass.CDSDadosNAME.FieldName, sCST_DataOtherValue);
    oName.Add(FObjectDaoClass.CDSDadosIS_ABSTRACT.FieldName,
      '|ID_Operator_23|,|ID_WordDelphi_53|', sCST_False);
    // TDMUtils = class até end;
    oConfigBlockTag := ListConfigBlockTag.Add(oName,
      '|ID_WordDelphi_32|,|ID_Operator_7|', False, Integer(tccConcrete));
    CaptureOwner(oConfigBlockTag, oName);
  finally
    TDMUtils.DestroyObject(oName);
  end;
end;

initialization

RegisterClass(TObjectActionClass);

end.
