unit uObjectDaoVisibilityUnit;

interface

uses
  SysUtils, uObjectDaoApplication, Classes, uObjectDao, DB, DBClient, FMTBcd,
  Provider, SqlExpr;

type
  TObjectDaoVisibilityUnit = class(TObjectDao)
    CDSDadosID_VISIBILITY_UNIT: TIntegerField;
    CDSDadosID_UNIT: TIntegerField;
    SQLDADOSID_VISIBILITY_UNIT: TIntegerField;
    SQLDADOSID_UNIT: TIntegerField;
    SQLDADOSIS_PUBLIC: TStringField;
    CDSDadosIS_PUBLIC: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses uObjectDaoUnit;

{$R *.dfm}
{ TObjectDaoVisibilityUnit }

initialization

RegisterClass(TObjectDaoVisibilityUnit);

end.
