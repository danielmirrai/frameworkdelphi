unit uObjectDaoDispinterface;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoDispinterface = class(TObjectDao)
    CDSDadosID_TYPE: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_OWNER: TIntegerField;
    CDSDadosID_DISPINTERFACE: TIntegerField;
    SQLDADOSID_DISPINTERFACE: TIntegerField;
    SQLDADOSID_TYPE: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_OWNER: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoDispinterface }

initialization

RegisterClass(TObjectDaoDispinterface);

end.
