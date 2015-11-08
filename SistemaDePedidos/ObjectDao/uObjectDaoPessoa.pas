unit uObjectDaoPessoa;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, uObjectDaoAplicacaoPedidos, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoPessoa = class(TObjectDao)
    SQLDADOSCODIGO: TIntegerField;
    SQLDADOSNOME: TStringField;
    SQLDADOSRAZAO_SOCIAL: TStringField;
    SQLDADOSCPF: TStringField;
    SQLDADOSCNPJ: TStringField;
    SQLDADOSTELEFONE: TStringField;
    SQLDADOSEMAIL: TStringField;
    SQLDADOSFL_ATIVO: TSmallintField;
    CDSDadosCODIGO: TIntegerField;
    CDSDadosNOME: TStringField;
    CDSDadosRAZAO_SOCIAL: TStringField;
    CDSDadosCPF: TStringField;
    CDSDadosCNPJ: TStringField;
    CDSDadosTELEFONE: TStringField;
    CDSDadosEMAIL: TStringField;
    CDSDadosFL_ATIVO: TSmallintField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoPessoa }

initialization

RegisterClass(TObjectDaoPessoa);

end.
