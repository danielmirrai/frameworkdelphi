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
unit uObjectDaoCommand;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  /// <summary>
  /// Registros de comandos do delphi
  /// </summary>
  TObjectDaoCommand = class(TObjectDao)
    SQLDADOSID_COMMAND: TIntegerField;
    SQLDADOSCOMMAND: TStringField;
    SQLDADOSSPECIFIC_NOT_COMMAND: TStringField;
    SQLDADOSCOMMAND_FORMATTED: TStringField;
    SQLDADOSSPECIFIC_NOT_COMMAND_FORMATTED: TStringField;
    SQLDADOSID_TYPE_COMMAND: TIntegerField;
    CDSDadosID_COMMAND: TIntegerField;
    CDSDadosCOMMAND: TStringField;
    CDSDadosSPECIFIC_NOT_COMMAND: TStringField;
    CDSDadosCOMMAND_FORMATTED: TStringField;
    CDSDadosSPECIFIC_NOT_COMMAND_FORMATTED: TStringField;
    CDSDadosID_TYPE_COMMAND: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoCommand }

{ TObjectDaoCommand }

initialization

RegisterClass(TObjectDaoCommand);

end.
