unit uObjectDaoTypeExpression;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoTypeExpression = class(TObjectDao)
    CDSDadosID_TYPE_EXPRESSION: TIntegerField;
    CDSDadosID_TYPE: TIntegerField;
    CDSDadosDATA: TStringField;
    SQLDADOSID_TYPE_EXPRESSION: TIntegerField;
    SQLDADOSID_TYPE: TIntegerField;
    SQLDADOSDATA: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses uObjectDaoApplication;

{$R *.dfm}
{ TObjectDaoTypeExpression }

initialization

RegisterClass(TObjectDaoTypeExpression);

end.
