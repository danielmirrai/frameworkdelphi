unit uObjectDaoDirectiveMethod;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoDirectiveMethod = class(TObjectDao)
    CDSDadosID_DIRECTIVE_METHOD: TIntegerField;
    CDSDadosID_DIRECTIVE: TIntegerField;
    CDSDadosID_METHOD: TIntegerField;
    SQLDADOSID_DIRECTIVE_METHOD: TIntegerField;
    SQLDADOSID_DIRECTIVE: TIntegerField;
    SQLDADOSID_METHOD: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoDirectiveMethod }

initialization

RegisterClass(TObjectDaoDirectiveMethod);

end.
