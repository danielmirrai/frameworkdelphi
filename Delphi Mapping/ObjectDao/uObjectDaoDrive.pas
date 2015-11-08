unit uObjectDaoDrive;

interface

uses
  System.SysUtils, System.Classes, uObjectDao, Data.DB, Datasnap.DBClient, Data.FMTBcd, Datasnap.Provider, Data.SqlExpr;

type
  TObjectDaoDrive = class(TObjectDao)
    SQLDADOSID_DRIVE: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_COMPUTER_SO: TIntegerField;
    CDSDadosID_DRIVE: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_COMPUTER_SO: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;
  
implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TObjectDaoDrive }

initialization
  RegisterClass(TObjectDaoDrive);


end.
