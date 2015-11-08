unit uObjectDaoTimeExecuting;

interface

uses
  SysUtils, Classes, uObjectDao, DB, DBClient,
  uDMUtils, FMTBcd, Dialogs,
  Provider, SqlExpr;

type
  TObjectDaoTimeExecuting = class(TObjectDao)
    CDSDadosID_TIME_EXECUTING: TIntegerField;
    CDSDadosID_UNIT: TStringField;
    CDSDadosID_CLASS: TStringField;
    CDSDadosID_FUNCTION: TStringField;
    CDSDadosID_NIVEL: TIntegerField;
    CDSDadosID_OWNER: TIntegerField;
    CDSDadosTIME_EXECUTING: TTimeField;
    SQLDADOSID_TIME_EXECUTING: TIntegerField;
    SQLDADOSID_UNIT: TStringField;
    SQLDADOSID_CLASS: TStringField;
    SQLDADOSID_FUNCTION: TStringField;
    SQLDADOSTIME_EXECUTING: TTimeField;
    SQLDADOSID_NIVEL: TIntegerField;
    SQLDADOSDATE_BEGIN: TSQLTimeStampField;
    SQLDADOSDATE_END: TSQLTimeStampField;
    SQLDADOSID_OWNER: TIntegerField;
    CDSDadosDATE_BEGIN: TSQLTimeStampField;
    CDSDadosDATE_END: TSQLTimeStampField;
    procedure DataModuleCreate(Sender: TObject);
    procedure CDSDadosCalcFields(DataSet: TDataSet);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses uObjectDaoApplication;

{$R *.dfm}

procedure TObjectDaoTimeExecuting.DataModuleCreate(Sender: TObject);
begin
  inherited;
end;

{ TObjectDaoTimeExecuting }

procedure TObjectDaoTimeExecuting.CDSDadosCalcFields(DataSet: TDataSet);
begin
  inherited;
  if TDMUtils.IsEmpty(CDSDadosDATE_END.AsDateTime) then
    CDSDadosTIME_EXECUTING.AsDateTime := Now - CDSDadosDATE_BEGIN.AsDateTime
  else
    CDSDadosTIME_EXECUTING.AsDateTime := CDSDadosDATE_END.AsDateTime -
      CDSDadosDATE_BEGIN.AsDateTime;
end;

initialization

RegisterClass(TObjectDaoTimeExecuting);

end.
