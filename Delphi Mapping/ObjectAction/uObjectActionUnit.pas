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
unit uObjectActionUnit;

interface

uses
  uObjectAction, uObjectDaoUnit, Classes, Forms, SysUtils, uConstantTrack,
  DB, uObjectActionUses, uObjectActionClass, uObjectActionVisibilityUnit,
  uObjectActionBlockTagInDB, uObjectActionStructureDelphi, Dialogs,
  uConstantUtils;

type

  /// <summary>
  /// Constrole ação de unit do Delphi
  /// </summary>
  /// <example>
  /// <para>
  /// unit uObjectActionUnit;
  /// </para>
  /// </example>
  TObjectActionUnit = class(TObjectActionStructureDelphi)
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoUnit: TObjectDaoUnit;

    FObjectActionVisibilityUnit: TObjectActionVisibilityUnit;

    procedure Save; Override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

{ TObjectActionUnit }

uses uFactoryObject, uDMUtils, uConstantCommand, MD5, uObjectActionBlockTag,
  uDMUtilsDao;

{ TObjectActionUnit }

procedure TObjectActionUnit.AfterConstruction;
begin
  inherited;
  FObjectDaoUnit := GetObjectDao as TObjectDaoUnit;
  FObjectActionVisibilityUnit := ListObjectActionChildren.Add
    (TObjectActionVisibilityUnit, Self) as TObjectActionVisibilityUnit;
end;

procedure TObjectActionUnit.BeforeDestruction;
begin
  FObjectActionVisibilityUnit := nil;

  inherited;
end;

procedure TObjectActionUnit.ConfigureBlockMapping;
var
  FConfigBlockTag: TConfigBlockTag;
begin
  // unit até end.
  FConfigBlockTag := ListConfigBlockTag.Add('|ID_WordDelphi_77|',
    '|ID_WordDelphi_32|,|ID_Operator_1|');
  // uObjectAction;
  FConfigBlockTag.ListObjectActionChildren.Add(sCST_EmptyStr,
    FObjectDaoUnit.CDSDadosNAME, sCST_EmptyStr, '|ID_Operator_7|');
end;

procedure TObjectActionUnit.Save;
begin
  if FObjectDaoUnit.Editing then
    FObjectDaoUnit.CDSDadosNAME.AsString :=
      TDMUtils.GetFileName(FObjectDaoUnit.CDSDadosFILEPATH.AsString);
  inherited;

end;

initialization

RegisterClass(TObjectActionUnit);

end.
