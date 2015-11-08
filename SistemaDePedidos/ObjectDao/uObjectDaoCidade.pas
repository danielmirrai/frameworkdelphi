unit uObjectDaoCidade;

interface

uses
  SysUtils, uObjectDaoAplicacaoPedidos, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoCidade = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    SQLDADOSNOME: TStringField;
    SQLDADOSCODIGO_ESTADO: TIntegerField;
    intgrfldCDSDadosCODIGO: TIntegerField;
    strngfldCDSDadosNOME: TStringField;
    intgrfldCDSDadosCODIGO_ESTADO: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

uses uObjectDaoCustom;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoCidade }

{ TObjectDaoCidade }

initialization

RegisterClass(TObjectDaoCidade);

end.
