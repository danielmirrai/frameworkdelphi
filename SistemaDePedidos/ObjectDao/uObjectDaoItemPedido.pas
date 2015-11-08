unit uObjectDaoItemPedido;

interface

uses
  SysUtils, uObjectDaoAplicacaoPedidos, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoItemPedido = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    SQLDADOSNUMERO: TIntegerField;
    SQLDADOSCODIGO_PRODUTO: TIntegerField;
    SQLDADOSCODIGO_PEDIDO: TIntegerField;
    SQLDADOSQUANTIDADE: TIntegerField;
    SQLDADOSFL_CANCELADO: TSmallintField;
    SQLDADOSVALOR_ACRESCIMO: TFloatField;
    SQLDADOSVALOR_DESCONTO: TFloatField;
    SQLDADOSVALOR_UNITARIO: TFloatField;
    CDSDadosCODIGO: TIntegerField;
    CDSDadosNUMERO: TIntegerField;
    CDSDadosCODIGO_PRODUTO: TIntegerField;
    CDSDadosCODIGO_PEDIDO: TIntegerField;
    CDSDadosQUANTIDADE: TIntegerField;
    CDSDadosFL_CANCELADO: TSmallintField;
    CDSDadosVALOR_ACRESCIMO: TFloatField;
    CDSDadosVALOR_DESCONTO: TFloatField;
    CDSDadosVALOR_UNITARIO: TFloatField;
    SQLDADOSDC_PEDIDO: TStringField;
    SQLDADOSDC_PRODUTO: TStringField;
    CDSDadosDC_PEDIDO: TStringField;
    CDSDadosDC_PRODUTO: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoItemPedido }

initialization

RegisterClass(TObjectDaoItemPedido);

end.
