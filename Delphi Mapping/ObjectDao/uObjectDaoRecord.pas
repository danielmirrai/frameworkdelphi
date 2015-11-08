unit uObjectDaoRecord;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoRecord = class(TObjectDao)
    CDSDadosID_RECORD: TIntegerField;
    CDSDadosNAME: TIntegerField;
    CDSDadosID_TYPE: TIntegerField;
    SQLDADOSID_RECORD: TIntegerField;
    SQLDADOSNAME: TIntegerField;
    SQLDADOSID_TYPE: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}
{ TObjectDaoRecord }

initialization

RegisterClass(TObjectDaoRecord);

end.
