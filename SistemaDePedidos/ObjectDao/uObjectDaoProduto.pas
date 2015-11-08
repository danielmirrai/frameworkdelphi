unit uObjectDaoProduto;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, uObjectDaoAplicacaoPedidos, Provider, SqlExpr;

type
  TObjectDaoProduto = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    SQLDADOSNOME: TStringField;
    SQLDADOSDESCRICAO: TStringField;
    SQLDADOSBARCODE: TIntegerField;
    SQLDADOSVALOR_UNITARIO: TIntegerField;
    SQLDADOSOBSERVACAO: TMemoField;
    SQLDADOSFL_ATIVO: TSmallintField;
    SQLDADOSCODIGO_EMPRESA: TSmallintField;
    CDSDadosCODIGO: TIntegerField;
    CDSDadosNOME: TStringField;
    CDSDadosDESCRICAO: TStringField;
    CDSDadosBARCODE: TIntegerField;
    CDSDadosVALOR_UNITARIO: TIntegerField;
    CDSDadosOBSERVACAO: TMemoField;
    CDSDadosFL_ATIVO: TSmallintField;
    CDSDadosCODIGO_EMPRESA: TSmallintField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoProduto }

initialization

RegisterClass(TObjectDaoProduto);

end.
