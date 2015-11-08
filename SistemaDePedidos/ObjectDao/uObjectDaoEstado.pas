unit uObjectDaoEstado;

interface

uses
  SysUtils, uObjectDaoAplicacaoPedidos, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoEstado = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    SQLDADOSNOME: TStringField;
    SQLDADOSUF: TStringField;
    SQLDADOSCODIGO_PAIS: TIntegerField;
    CDSDadosCODIGO: TIntegerField;
    CDSDadosNOME: TStringField;
    CDSDadosUF: TStringField;
    CDSDadosCODIGO_PAIS: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoEstado }

initialization

RegisterClass(TObjectDaoEstado);

end.
