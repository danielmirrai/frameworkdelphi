unit uObjectDaoExistingType;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoExistingType = class(TObjectDao)
    CDSDadosID_Existing_Type: TIntegerField;
    CDSDadosNAME: TStringField;
    SQLDADOSID_EXISTING_TYPE: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_OWNER: TStringField;
    SQLDADOSID_TYPE: TIntegerField;
    CDSDadosID_OWNER: TStringField;
    CDSDadosID_TYPE: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TObjectDaoExistingType.DataModuleCreate(Sender: TObject);
begin
  inherited;
end;

{ TObjectDaoExistingType }

initialization

RegisterClass(TObjectDaoExistingType);

end.
