unit uObjectDaoInterface;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoInterface = class(TObjectDao)
    CDSDadosID_TYPE: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_OWNER: TIntegerField;
    CDSDadosID_INTERFACE: TIntegerField;
    SQLDADOSID_INTERFACE: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_TYPE: TIntegerField;
    SQLDADOSID_OWNER: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoInterface }

initialization

RegisterClass(TObjectDaoInterface);

end.
