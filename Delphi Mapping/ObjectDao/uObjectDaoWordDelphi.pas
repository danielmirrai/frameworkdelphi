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
unit uObjectDaoWordDelphi;

interface

uses
  SysUtils, Classes, uObjectDaoCommand, uObjectDao, DB,
  DBClient, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registros de comandos do delphi
  /// </summary>
  /// <example>
  /// <para>
  /// Begin
  /// </para>
  /// <para>
  /// End
  /// </para>
  /// </example>
  TObjectDaoWordDelphi = class(TObjectDaoCommand)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses uObjectDaoApplication;

{$R *.dfm}
{ TObjectDaoWordDelphi }

initialization

RegisterClass(TObjectDaoWordDelphi);

end.
