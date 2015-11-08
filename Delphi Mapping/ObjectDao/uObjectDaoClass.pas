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
unit uObjectDaoClass;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  Dialogs, uObjectDao, DB, DBClient, Classes, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registros das Class do delphi
  /// </summary>
  /// <example>
  /// TTeste = class;
  /// </example>
  TObjectDaoClass = class(TObjectDao)
    CDSDadosID_CLASS: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_TYPE: TIntegerField;
    CDSDadosID_OWNER: TStringField;
    SQLDADOSID_CLASS: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_TYPE: TIntegerField;
    SQLDADOSIS_ABSTRACT: TStringField;
    SQLDADOSID_OWNER: TStringField;
    CDSDadosIS_ABSTRACT: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }

  end;

implementation

{$R *.dfm}
{ TObjectDaoClass }

initialization

RegisterClass(TObjectDaoClass);

end.
