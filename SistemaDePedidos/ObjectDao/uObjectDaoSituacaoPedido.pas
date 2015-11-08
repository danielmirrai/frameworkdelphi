unit uObjectDaoSituacaoPedido;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, uObjectDaoAplicacaoPedidos, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoSituacaoPedido = class(TObjectDao)
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoSituacaoPedido }

initialization

RegisterClass(TObjectDaoSituacaoPedido);

end.
