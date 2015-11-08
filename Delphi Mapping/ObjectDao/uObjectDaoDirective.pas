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
unit uObjectDaoDirective;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient,
  uObjectDaoCommand, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registro de diretivas do delphi
  /// </summary>
  TObjectDaoDirective = class(TObjectDaoCommand)
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoDirective }

initialization

RegisterClass(TObjectDaoDirective);

end.
