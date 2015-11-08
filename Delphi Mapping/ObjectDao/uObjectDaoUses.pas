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
unit uObjectDaoUses;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registro uses do arquivo mapeado
  /// </summary>
  /// <example>
  /// <para>
  /// interface uses uObjectAction;
  /// </para>
  /// <para>
  /// implementation uses uDMUtils;
  /// </para>
  /// </example>
  TObjectDaoUses = class(TObjectDao)
    CDSDadosID_USES: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_VISIBILITY_UNIT: TIntegerField;
    SQLDADOSID_USES: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_VISIBILITY_UNIT: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses uObjectDaoApplication;

initialization

RegisterClass(TObjectDaoUses);

end.
