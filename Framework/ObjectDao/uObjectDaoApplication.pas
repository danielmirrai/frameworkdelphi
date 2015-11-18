{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Programador Delphi Sênior }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Fones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }
unit uObjectDaoApplication;

interface

uses
  uDMClasses, DBXpress, DB, SqlExpr, Classes, ImgList, Controls, MidasLib;

type
  TObjectDaoApplication = class(TDataModule)
    Img1: TImageList;
    Img2: TImageList;
    FBConnection: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function ExtractFilePathConfig: string; virtual;
    procedure ExportConfigurationDB;
    procedure ImportConfigurationDB;
  public
    { Public declarations }
  end;

var
  ObjectDaoApplication: TObjectDaoApplication;

implementation

uses
  IniFiles, SysUtils, uDMUtils, Forms;

const
  sCST_DriverName = 'DriverName';
  sCST_Database = 'Database';
  sCST_Password = 'Password';
  sCST_User_Name = 'User_Name';
  sCST_ConexaoDB = 'ConexãoDB';

{$R *.dfm}

procedure TObjectDaoApplication.DataModuleCreate(Sender: TObject);
begin
  inherited;
  ImportConfigurationDB;
end;

procedure TObjectDaoApplication.ImportConfigurationDB;
var
  oIniFileConfig: TIniFile;
  sFilePathConfig: string;
begin
  sFilePathConfig := ExtractFilePathConfig;
  if not FileExists(sFilePathConfig) then
  begin
    ExportConfigurationDB;
    raise Exception.Create('Os dados de conexão não foram configurados.' + #13 + sFilePathConfig);
  end;
  oIniFileConfig := TIniFile.Create(sFilePathConfig);
  try
    try
      FBConnection.Close;
      FBConnection.Params.Clear;
      FBConnection.Params.Add(sCST_Database + '=' + oIniFileConfig.ReadString(sCST_ConexaoDB, sCST_Database, ''));

      FBConnection.Params.Add('RoleName=RoleName');
      FBConnection.Params.Add(sCST_User_Name + '=' + oIniFileConfig.ReadString(sCST_ConexaoDB, sCST_User_Name, ''));
      FBConnection.Params.Add(sCST_Password + '=' + oIniFileConfig.ReadString(sCST_ConexaoDB, sCST_Password, ''));

      FBConnection.Params.Add(sCST_DriverName + '=' + oIniFileConfig.ReadString(sCST_ConexaoDB, sCST_DriverName, ''));

      FBConnection.Params.Add('ServerCharSet=');
      FBConnection.Params.Add('SQLDialect=1');
      FBConnection.Params.Add('ErrorResourceFile=');
      FBConnection.Params.Add('LocaleCode=0000');
      FBConnection.Params.Add('BlobSize=-1');
      FBConnection.Params.Add('CommitRetain=False');
      FBConnection.Params.Add('WaitOnLocks=True');
      FBConnection.Params.Add('Interbase TransIsolation=ReadCommited');
      FBConnection.Params.Add('Trim Char=False');
      FBConnection.ParamsLoaded := False;
      FBConnection.Connected := True;
    except
      on e: Exception do
        TDMUtils.MyException('Não foi possível conectar com a base!', True);
    end;
  finally
    FreeAndNil(oIniFileConfig);
  end;
end;

function TObjectDaoApplication.ExtractFilePathConfig: string;
begin
  Result := ExtractFilePath(Application.ExeName) + 'ConfigDB.ini';
end;

procedure TObjectDaoApplication.ExportConfigurationDB;
var
  oIniFileConfig: TIniFile;
  ValorLinha: TStringList;
  i: Integer;
begin
  ValorLinha := nil;
  oIniFileConfig := TIniFile.Create(ExtractFilePathConfig);
  try
    try
      ValorLinha := TStringList.Create;
      for i := 0 to FBConnection.Params.Count - 1 do
      begin
        ValorLinha.Text := FBConnection.Params.Strings[i];
        TDMUtils.ExplodeStr(ValorLinha, '=');
        oIniFileConfig.WriteString(sCST_ConexaoDB, TDMUtils.GetValueList(ValorLinha, 0), TDMUtils.GetValueList(ValorLinha, 1));
      end;
    except
      on e: Exception do
        TDMUtils.MyException('Não foi possível conectar com a base!', True);
    end;
  finally
    FreeAndNil(oIniFileConfig);
    FreeAndNil(ValorLinha);
  end;
end;

initialization
  DMClasses.RegisterClass(TObjectDaoApplication);

end.
