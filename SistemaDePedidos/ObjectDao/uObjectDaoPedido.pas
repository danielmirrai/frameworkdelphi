unit uObjectDaoPedido;

interface

uses
  SysUtils, Classes, uObjectDao, DB, uObjectDaoAplicacaoPedidos, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoPedido = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    SQLDADOSDESCRICAO: TStringField;
    SQLDADOSNUMERO: TIntegerField;
    SQLDADOSDATA_EMISSAO: TSQLTimeStampField;
    SQLDADOSDATA_VENCIMENTO: TSQLTimeStampField;
    SQLDADOSDATA_ENTREGA: TSQLTimeStampField;
    SQLDADOSCODIGOCLIENTE: TIntegerField;
    SQLDADOSCODIGO_ENDERECO_CLIENTE: TIntegerField;
    SQLDADOSCODIGO_VENDEDOR: TIntegerField;
    SQLDADOSPERC_COMISSAO_VERDEDOR: TIntegerField;
    SQLDADOSVALOR_TOTAL: TFloatField;
    SQLDADOSNFE: TStringField;
    SQLDADOSOBSERVACAO: TMemoField;
    CDSDadosCODIGO: TIntegerField;
    CDSDadosDESCRICAO: TStringField;
    CDSDadosNUMERO: TIntegerField;
    CDSDadosDATA_EMISSAO: TSQLTimeStampField;
    CDSDadosDATA_VENCIMENTO: TSQLTimeStampField;
    CDSDadosDATA_ENTREGA: TSQLTimeStampField;
    CDSDadosCODIGOCLIENTE: TIntegerField;
    CDSDadosCODIGO_ENDERECO_CLIENTE: TIntegerField;
    CDSDadosCODIGO_VENDEDOR: TIntegerField;
    CDSDadosPERC_COMISSAO_VERDEDOR: TIntegerField;
    CDSDadosVALOR_TOTAL: TFloatField;
    CDSDadosNFE: TStringField;
    CDSDadosOBSERVACAO: TMemoField;
    SQLDADOSDC_CLIENTE: TStringField;
    SQLDADOSDC_VENDEDOR: TStringField;
    SQLDADOSDC_SITUACAO: TStringField;
    CDSDadosDC_CLIENTE: TStringField;
    CDSDadosDC_VENDEDOR: TStringField;
    CDSDadosDC_SITUACAO: TStringField;
    intgrfldSQLDADOSCODIGO_SITUACAO_PEDIDO: TIntegerField;
    intgrfldSQLDADOSCODIGO_EMPRESA: TIntegerField;
    intgrfldCDSDadosCODIGO_SITUACAO_PEDIDO: TIntegerField;
    intgrfldCDSDadosCODIGO_EMPRESA: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoPedido }

initialization

RegisterClass(TObjectDaoPedido);

end.
