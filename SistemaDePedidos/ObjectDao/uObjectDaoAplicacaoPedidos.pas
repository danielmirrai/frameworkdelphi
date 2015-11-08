unit uObjectDaoAplicacaoPedidos;

interface

uses
  SysUtils, Classes, uObjectDao, uObjectDaoApplication, DB, DBClient, FMTBcd, Provider, SqlExpr,
  DBXpress, ImgList, Controls;

type
  TObjectDaoAplicacaoPedidos = class(TObjectDaoApplication)
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoAplicacaoPedidos }

initialization

RegisterClass(TObjectDaoAplicacaoPedidos);

end.
