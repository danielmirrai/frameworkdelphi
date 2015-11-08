unit uObjectDaoClassOf;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoClassOf = class(TObjectDao)
    CDSDadosID_CLASS_OF: TIntegerField;
    CDSDadosID_TYPE: TIntegerField;
    CDSDadosNAME: TStringField;
    SQLDADOSID_CLASS_OF: TIntegerField;
    SQLDADOSID_TYPE: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_CLASS: TStringField;
    CDSDadosID_CLASS: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoClassOf }

initialization

RegisterClass(TObjectDaoClassOf);

end.
