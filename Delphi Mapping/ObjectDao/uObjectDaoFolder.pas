unit uObjectDaoFolder;

interface

uses
  System.SysUtils, System.Classes, uObjectDao, Data.DB, Datasnap.DBClient, Data.FMTBcd, Datasnap.Provider, Data.SqlExpr;

type
  TObjectDaoFolder = class(TObjectDao)
    SQLDADOSID_FOLDER: TIntegerField;
    SQLDADOSFOLDER_PATH: TStringField;
    SQLDADOSID_FOLDER_OWNER: TIntegerField;
    CDSDadosID_FOLDER: TIntegerField;
    CDSDadosFOLDER_PATH: TStringField;
    CDSDadosID_FOLDER_OWNER: TIntegerField;
    SQLDADOSNAME: TStringField;
    SQLDADOSID_DRIVE: TIntegerField;
    CDSDadosNAME: TStringField;
    CDSDadosID_DRIVE: TIntegerField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;
  
implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TObjectDaoFolder }

initialization
  RegisterClass(TObjectDaoFolder);


end.
