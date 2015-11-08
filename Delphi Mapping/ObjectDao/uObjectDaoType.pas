unit uObjectDaoType;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoType = class(TObjectDao)
    CDSDadosID_TYPE: TIntegerField;
    CDSDadosID_VISIBILITY_UNIT: TIntegerField;
    SQLDADOSID_TYPE: TIntegerField;
    SQLDADOSID_VISIBILITY_UNIT: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses uObjectDaoApplication;

{$R *.dfm}

procedure TObjectDaoType.DataModuleCreate(Sender: TObject);
begin
  inherited;
end;

{ TObjectDaoType }

initialization

RegisterClass(TObjectDaoType);

end.
