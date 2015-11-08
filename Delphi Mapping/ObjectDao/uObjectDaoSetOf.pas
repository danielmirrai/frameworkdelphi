unit uObjectDaoSetOf;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoSetOf = class(TObjectDao)
    CDSDadosID_SET_OF: TIntegerField;
    CDSDadosID_TYPE: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_VALUE_TYPE: TIntegerField;
    SQLDADOSID_SET_OF: TIntegerField;
    SQLDADOSID_TYPE: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSVALUE_SETOF: TStringField;
    SQLDADOSID_VALUE_TYPE: TIntegerField;
    CDSDadosVALUE_SETOF: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoSetOf }

initialization

RegisterClass(TObjectDaoSetOf);

end.
