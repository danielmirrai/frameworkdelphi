unit uObjectActionFolder;

interface

uses
  uObjectAction, uObjectDaoFolder, Classes, Forms, SysUtils, uConstantFolder, System.TypInfo, variants,
  uConstantUtils, uDMUtils, DB, DBClient, uObjectActionFile;

type
  TObjectActionFolder = Class(TObjectAction)
  private
    FCanCreateObjectDrive: Boolean;
  protected
    procedure SetCanCreateObjectDrive(const Value: Boolean);
    function GetCanCreateObjectDrive: Boolean;
  public
    FObjectDaoFolder: TObjectDaoFolder;
    FObjectActionDrive: TObjectAction;
    FObjectActionFile: TObjectActionFile;
    procedure AfterConstruction; override;
    procedure Add; Override;
    procedure Save; Override;
    function GetFolderPathOwner: String;
    procedure UpdateFilePath;
    procedure Load; Override;
    function LocateFolder(const psFilePath: String): Boolean;
    class function GetNameDir(const psFIlePath: String): String;
    procedure AddFolder(const psFilePath: string);
    procedure Import(const psFilePath: string; const pbAddFiles: Boolean = True); reintroduce; Virtual;
    procedure ValidateChange(const psFilePath: string; const pbAutoFix: Boolean; const poLogError: TStringList;
      const pbAddFiles: Boolean = True); reintroduce; Virtual;
    class function GetDirOwner(const psFilePath: String): String;
    procedure BeforeDestruction; override;
    property CanCreateObjectDrive: Boolean read GetCanCreateObjectDrive write SetCanCreateObjectDrive;
  end;

implementation

uses uObjectActionDrive, uFactoryObject;

procedure TObjectActionFolder.Add;
begin
  inherited;
  if CanCreateObjectDrive then
    FObjectDaoFolder.CDSDadosID_DRIVE.AsInteger := TObjectActionDrive(FObjectActionDrive).FObjectDaoDrive.CDSDadosID_DRIVE.AsInteger;
end;

procedure TObjectActionFolder.AddFolder(const psFilePath: string);
var
  sPath, sDirOwner: String;
  nIDOwner: Variant;
begin
  TObjectActionDrive(FObjectActionDrive).AddDrive(psFilePath);

  sDirOwner := GetDirOwner(ExtractFilePath(psFilePath));
  nIDOwner := null;
  if TDMUtils.ExistValue(sDirOwner) then
  begin
    AddFolder(sDirOwner);
    nIDOwner := FObjectDaoFolder.CDSDadosID_FOLDER.AsInteger;
  end;
  sPath := ExtractFilePath(psFilePath);
  if FObjectDaoFolder.CDSDados.Locate(FObjectDaoFolder.CDSDadosFOLDER_PATH.FieldName,
    sPath, []) then
    Edit
  else
    Add;
  FObjectDaoFolder.CDSDadosFOLDER_PATH.AsString := sPath;
  FObjectDaoFolder.CDSDadosID_FOLDER_OWNER.Value := nIDOwner;
  FObjectDaoFolder.CDSDadosNAME.AsString := GetNameDir(psFilePath);
  Save;
end;

procedure TObjectActionFolder.AfterConstruction;
begin
  inherited;
  FObjectDaoFolder := GetObjectDao as TObjectDaoFolder;
  FObjectActionFile := ListObjectActionChildren.Add(TObjectActionFile, Self) as TObjectActionFile;

  CanCreateObjectDrive := False;
  FObjectActionDrive := ObjectActionOwner;
  if not (Assigned(ObjectActionOwner) and (ObjectActionOwner is TObjectActionDrive)) then
  begin
    CanCreateObjectDrive := True;
    FObjectActionDrive := TFactoryObject.CreateComponent(TObjectActionDrive, Self) as TObjectActionDrive;
  end;
end;



procedure TObjectActionFolder.BeforeDestruction;
begin
  if CanCreateObjectDrive then
    TDMutils.DestroyObject(FObjectActionDrive);
  FObjectActionDrive := nil;
  inherited;

end;

function TObjectActionFolder.GetCanCreateObjectDrive: Boolean;
begin
  Result := FCanCreateObjectDrive;
end;


class function TObjectActionFolder.GetDirOwner(const psFilePath: String): String;
var
  nIndexBegin: Integer;
begin
  Result := Trim(psFilePath);
  nIndexBegin := TDMUtils.PostInvertString('\', Result);
  if nIndexBegin = (Length(Result)) then
  begin
    Result := Copy(Result, 1, nIndexBegin - 1);
    nIndexBegin := TDMUtils.PostInvertString('\', Result);
  end;
  if nIndexBegin <= 0 then
  begin
    Result := '';
    Exit;
  end;
  Result := Copy(Result, 1, nIndexBegin - 1);
  if not TDMUtils.ExisteString(Result, '\') then
    Result := '';
end;

function TObjectActionFolder.GetFolderPathOwner: String;
var
  oCDSClone: TClientDataSet;
begin
  Result := TObjectActionDrive(FObjectActionDrive).FObjectDaoDrive.CDSDadosNAME.AsString + '\';
  if TDMUtils.IsEmpty(FObjectDaoFolder.CDSDadosID_FOLDER_OWNER.AsInteger) then
    Exit;

  oCDSClone := TClientDataSet.Create(nil);
  try
    oCDSClone.CloneCursor(FObjectDaoFolder.CDSDados, False, True);
    if oCDSClone.Locate(FObjectDaoFolder.CDSDadosID_FOLDER.FieldName, FObjectDaoFolder.CDSDadosID_FOLDER_OWNER.AsInteger, []) then
      Result := oCDSClone.FieldByName(FObjectDaoFolder.CDSDadosFOLDER_PATH.FieldName).AsString;
  finally
    TDMUtils.DestroyObject(oCDSClone);
  end;
end;

class function TObjectActionFolder.GetNameDir(const psFIlePath: String): String;
var
  sDrive: String;
begin
  Result := ExtractFilePath(psFIlePath);
  Result := Copy(Result, Length(GetDirOwner(Result)), Length(Result));
  sDrive := ExtractFileDrive(Result);
  if TDMUtils.ExistValue(sDrive) then
    Result := Copy(Result, Length(sDrive) + 2, Length(Result));
  Result := StringReplace(Result, '\', '', [rfReplaceAll]);
end;

procedure TObjectActionFolder.Import(const psFilePath: string; const pbAddFiles: Boolean);
var
  oListDir: TStringList;
  nIndex: Integer;
  sFile: String;
  sDirectory: String;
begin
  sDirectory := TDMUtils.FormatDirectory(psFilePath);
  AddFolder(sDirectory);
  FObjectActionFile.Import(sDirectory, False);

  oListDir := TStringList.Create;
  try
    TDMUtils.ListDir(sDirectory, oListDir, []);
    for nIndex := 0 to oListDir.Count - 1 do
    begin
      sFile := Trim(oListDir.Strings[nIndex]);
      AddFolder(sDirectory);
      FObjectActionFile.Import(sDirectory, False);
    end;
  finally
    TDMUtils.DestroyObject(oListDir);
  end;
end;

procedure TObjectActionFolder.Load;
begin
  inherited;
  if CanCreateObjectDrive then
    FObjectActionDrive.Load;
end;

function TObjectActionFolder.LocateFolder(const psFilePath: String): Boolean;
begin
  Result := False;
  if TObjectActionDrive(FObjectActionDrive).LocateDrive(psFilePath) then
    Result := FObjectDaoFolder.CDSDados.Locate(FObjectDaoFolder.CDSDadosFOLDER_PATH.FieldName, ExtractFilePath(psFilePath), [loCaseInsensitive]);
end;

procedure TObjectActionFolder.Save;
begin
  inherited;
end;

procedure TObjectActionFolder.SetCanCreateObjectDrive(const Value: Boolean);
begin
  FCanCreateObjectDrive := Value;
end;

procedure TObjectActionFolder.UpdateFilePath;
begin
  if (FObjectDaoFolder.Editing) then
    FObjectDaoFolder.CDSDadosFOLDER_PATH.AsString := GetFolderPathOwner + FObjectDaoFolder.CDSDadosNAME.AsString;
end;

procedure TObjectActionFolder.ValidateChange(const psFilePath: string; const pbAutoFix: Boolean; const poLogError: TStringList;
  const pbAddFiles: Boolean);
const
  sMSG_PastaExcluido = 'A pasta "%d - %s" foi excluído.';
  sMSG_PastaAdicionado = 'A pasta "%s" foi adicionado.';
  sMSG_ArquivoExcluido = 'O arquivo "%d - %s" foi excluído.';
var
  oListFolder: TStringList;
  nIndexFolder, nIndex: Integer;

  sFilePath, sDirectory: String;
begin
  sDirectory := TDMUtils.FormatDirectory(psFilePath);
  oListFolder := TStringList.Create;
  FObjectActionFile.FObjectDaoFile.SetBackupMasterSource;
  try
    FObjectActionFile.FObjectDaoFile.ConfigureMasterSource(FObjectDao);
    oListFolder.Add(sDirectory);
    TDMUtils.ListDir(sDirectory, oListFolder, []);
    FObjectDao.CDSDados.First;
    while not FObjectDao.CDSDados.Eof do
    begin
      if not TDMUtils.CompareIgnoreCase(Copy(FObjectDaoFolder.CDSDadosFOLDER_PATH.AsString, 1, Length(sDirectory)), sDirectory) then
      begin
        FObjectDao.CDSDados.Next;
        Continue;
      end;
      nIndexFolder := oListFolder.IndexOf(UpperCase(FObjectDaoFolder.CDSDadosFOLDER_PATH.AsString));
      if nIndexFolder = -1 then
      begin
        poLogError.Add(Format(sMSG_PastaExcluido,
          [FObjectDaoFolder.CDSDadosID_FOLDER.AsInteger,
          FObjectDaoFolder.CDSDadosFOLDER_PATH.AsString]));

        FObjectActionFile.FObjectDaoFile.CDSDados.First;
        while not FObjectActionFile.FObjectDaoFile.CDSDados.Eof do
        begin
          poLogError.Add(Format(sMSG_ArquivoExcluido,
              [FObjectactionFile.FObjectDaoFile.CDSDadosID_FILE.AsInteger,
              FObjectactionFile.FObjectDaoFile.CDSDadosFILE_PATH.AsString]));
          FObjectActionFile.FObjectDaoFile.CDSDados.Next;
        end;
        if pbAutoFix then
          Delete
        else
          FObjectDao.CDSDados.Next;

        Continue;
      end;
      oListFolder.Delete(nIndexFolder);
      FObjectActionFile.ValideChangeFile(FObjectDaoFolder.CDSDadosFOLDER_PATH.AsString, pbAutoFix, poLogError);
      FObjectDao.CDSDados.Next;
    end;

    for nIndex := 0 to oListFolder.Count - 1 do
    begin
      sFilePath := Trim(oListFolder.Strings[nIndex]);
      if TDMUtils.IsEmpty(sFilePath) then
        Continue;

      poLogError.Add(Format(sMSG_PastaAdicionado, [sFilePath]));
      if pbAutoFix then
      begin
        AddFolder(sFilePath);
        ValidateChange(sFilePath, True, poLogError);
      end;
    end;
  finally
    FObjectActionFile.FObjectDaoFile.RevertBackupMasterSource;
    TDMUtils.DestroyObject(oListFolder);
  end;
end;

initialization
  RegisterClass(TObjectActionFolder);

end.
