unit uObjectDaoObjectOf;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoObjectOf = class(TObjectDao)
    CDSDadosID_OBJECTOF: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosIS_FUNCTION: TIntegerField;
    CDSDadosIS_STATIC: TIntegerField;
    CDSDadosID_TYPE: TIntegerField;
    SQLDADOSID_OBJECTOF: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSIS_FUNCTION: TIntegerField;
    SQLDADOSIS_STATIC: TIntegerField;
    SQLDADOSID_TYPE: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoObjectOf }

initialization

RegisterClass(TObjectDaoObjectOf);

end.
