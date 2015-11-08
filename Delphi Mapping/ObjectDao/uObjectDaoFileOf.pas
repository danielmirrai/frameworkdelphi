unit uObjectDaoFileOf;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoFileOf = class(TObjectDao)
    CDSDadosID_FILE_OF: TIntegerField;
    CDSDadosID_TYPE: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_CLASS: TStringField;
    SQLDADOSID_FILE_OF: TIntegerField;
    SQLDADOSID_TYPE: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_CLASS: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoFileOf }

initialization

RegisterClass(TObjectDaoFileOf);

end.
