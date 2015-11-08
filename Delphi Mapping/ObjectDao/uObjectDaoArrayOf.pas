unit uObjectDaoArrayOf;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoArrayOf = class(TObjectDao)
    CDSDadosID_ARRAY_OF: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_CLASS: TIntegerField;
    CDSDadosID_TYPE: TIntegerField;
    SQLDADOSID_ARRAY_OF: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_CLASS: TIntegerField;
    SQLDADOSID_TYPE: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoArrayOf }

initialization

RegisterClass(TObjectDaoArrayOf);

end.
