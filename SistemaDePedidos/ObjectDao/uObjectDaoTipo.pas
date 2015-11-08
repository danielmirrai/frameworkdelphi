unit uObjectDaoTipo;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, uObjectDaoAplicacaoPedidos, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoTipo = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    SQLDADOSDESCRICAO: TStringField;
    SQLDADOSFL_ATIVO: TSmallintField;
    CDSDadosCODIGO: TIntegerField;
    CDSDadosDESCRICAO: TStringField;
    CDSDadosFL_ATIVO: TSmallintField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoTipo }

initialization

RegisterClass(TObjectDaoTipo);

end.
