unit uObjectDaoTipoPessoa;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, uObjectDaoAplicacaoPedidos, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoTipoPessoa = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    SQLDADOSCODIGO_TIPO: TIntegerField;
    SQLDADOSCODIGO_PESSOA: TIntegerField;
    CDSDadosCODIGO: TIntegerField;
    CDSDadosCODIGO_TIPO: TIntegerField;
    CDSDadosCODIGO_PESSOA: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoTipoPessoa }

initialization

RegisterClass(TObjectDaoTipoPessoa);

end.
