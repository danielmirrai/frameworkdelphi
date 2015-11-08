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
unit uObjectDaoUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uObjectDaoApplication,
  Dialogs, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registros de units do projeto e delphi
  /// </summary>
  TObjectDaoUnit = class(TObjectDao)
    CDSDadosID_UNIT: TIntegerField;
    CDSDadosMD5: TStringField;
    SQLDADOSID_UNIT: TIntegerField;
    SQLDADOSMD5: TStringField;
    SQLDADOSFILEPATH: TStringField;
    CDSDadosFILEPATH: TStringField;
    SQLDADOSNAME: TStringField;
    CDSDadosNAME: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}
{ TObjectDaoUnit }

initialization

RegisterClass(TObjectDaoUnit);

end.
