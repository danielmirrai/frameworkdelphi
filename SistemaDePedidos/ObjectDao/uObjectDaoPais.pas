unit uObjectDaoPais;

interface

uses
  SysUtils, Classes, uObjectDaoAplicacaoPedidos, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoPais = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    SQLDADOSNOME: TStringField;
    SQLDADOSDDI: TSmallintField;
    SQLDADOSSIGLA: TStringField;
    CDSDadosCODIGO: TIntegerField;
    CDSDadosNOME: TStringField;
    CDSDadosDDI: TSmallintField;
    CDSDadosSIGLA: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoPais }

initialization

RegisterClass(TObjectDaoPais);

end.
