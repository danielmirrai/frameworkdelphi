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
unit uObjectActionUses;

interface

uses
  uObjectAction, uObjectDaoUses, uObjectActionStructureDelphi, Classes, Forms,
  uConstantUtils,
  SysUtils, uConstantTrack;

type
  /// <summary>
  /// Constrole ação de uses do arquivo mapeado
  /// </summary>
  /// <example>
  /// <para>
  /// interface uses uObjectAction;
  /// </para>
  /// <para>
  /// implementation uses uDMUtils;
  /// </para>
  /// </example>
  TObjectActionUses = class(TObjectActionStructureDelphi)
  protected
    procedure ConfigureBlockMapping; Override;
  public
    FObjectDaoUses: TObjectDaoUses;
    procedure AfterConstruction; override;
  end;

implementation

uses uDMUtils, uObjectActionUnit, uConstantCommand, uObjectActionBlockTag;

{ TObjectActionUses }

procedure TObjectActionUses.AfterConstruction;
begin
  inherited;
  FObjectDaoUses := GetObjectDao as TObjectDaoUses;

end;

procedure TObjectActionUses.ConfigureBlockMapping;
var
  oConfigBlockTag: TConfigBlockTag;
begin
  // uses até ;
  oConfigBlockTag := ListConfigBlockTag.Add('|ID_WordDelphi_85|',
    '|ID_Operator_7|');
  // Windows, System
  oConfigBlockTag.ListObjectActionChildren.Add(sCST_EmptyStr,
    FObjectDaoUses.CDSDadosNAME, '|ID_Operator_29|', '', -1, True);
  inherited;

end;

initialization

RegisterClass(TObjectActionUses);

end.
