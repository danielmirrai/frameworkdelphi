unit uObjectDaoEndereco;

interface

uses
  SysUtils, Classes, uObjectDaoAplicacaoPedidos, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoEndereco = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    intgrfldSQLDADOSCODIGO_PESSOA: TIntegerField;
    SQLDADOSTIPO_ENDERECO: TSmallintField;
    strngfldSQLDADOSCEP: TStringField;
    intgrfldSQLDADOSCODIGO_CIDADE: TIntegerField;
    strngfldSQLDADOSBAIRRO: TStringField;
    strngfldSQLDADOSRUA: TStringField;
    intgrfldSQLDADOSNUMERO: TIntegerField;
    intgrfldSQLDADOSNUMERO_BLOCO: TIntegerField;
    intgrfldSQLDADOSNUMERO_APARTAMENTO: TIntegerField;
    strngfldSQLDADOSOBSERVACAO: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoEndereco }

initialization

RegisterClass(TObjectDaoEndereco);

end.
