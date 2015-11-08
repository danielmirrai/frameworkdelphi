unit uObjectDaoVisibilityClass;

interface

uses
  SysUtils, uObjectDao, DB, DBClient, Classes, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoVisibilityClass = class(TObjectDao)
    CDSDadosID_VISIBILITY_CLASS: TIntegerField;
    CDSDadosID_CLASS: TIntegerField;
    CDSDadosID_VISIBILITY: TIntegerField;
    SQLDADOSID_VISIBILITY_CLASS: TIntegerField;
    SQLDADOSID_CLASS: TIntegerField;
    SQLDADOSID_VISIBILITY: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses uObjectDaoApplication;

{$R *.dfm}
{ TObjectDaoVisibilityClass }

initialization

RegisterClass(TObjectDaoVisibilityClass);

end.
