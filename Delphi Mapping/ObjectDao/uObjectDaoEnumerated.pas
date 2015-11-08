unit uObjectDaoEnumerated;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoEnumerated = class(TObjectDao)
    CDSDadosID_ENUMERATED: TIntegerField;
    CDSDadosNAME: TStringField;
    SQLDADOSID_ENUMERATED: TIntegerField;
    SQLDADOSNAME: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoEnumerated }

initialization

RegisterClass(TObjectDaoEnumerated);

end.
