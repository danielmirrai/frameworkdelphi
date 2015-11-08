unit uObjectActionDrive;

interface

uses
  uObjectAction, uObjectDaoDrive, Classes, Forms, SysUtils, uConstantDrive, System.TypInfo,
  uConstantUtils, uDMUtils, uObjectActionFolder, DB, DBClient, uObjectDao;

type
  TObjectActionDrive = Class(TObjectAction)
  public
    FObjectDaoDrive: TObjectDaoDrive;
    FObjectActionFolder: TObjectActionFolder;
    procedure AfterConstruction; override;
    function LocateDrive(const psFilePath: String): Boolean;
    procedure AddDrive(const psFilePath: String);
    procedure Import(const psFilePath: String; const pbAddFolder: Boolean = True); reintroduce;
    procedure ValidateChange(const psFilePath: String; const pbAutoFix: Boolean; const poLogError: TStringList;
      const pbValidateFolder: Boolean = True); reintroduce;
  end;
  
implementation

uses uObjectActionFile, uObjectActionComputerSO;

procedure TObjectActionDrive.AddDrive(const psFilePath: String);
begin
  FindAddOrEdit([FObjectDaoDrive.CDSDadosNAME.FieldName], [ExtractFileDrive(psFilePath)], True);
end;

procedure TObjectActionDrive.AfterConstruction;
begin
  inherited;
  FObjectDaoDrive := GetObjectDao as TObjectDaoDrive;
  FObjectActionFolder := ListObjectActionChildren.Add(TObjectActionFolder, Self) as TObjectActionFolder;
end;

procedure TObjectActionDrive.Import(const psFilePath: String; const pbAddFolder: Boolean);
var
  sDirectory: String;
begin
  sDirectory := TDMUtils.FormatDirectory(psFilePath);
  AddDrive(sDirectory);
  if pbAddFolder then
    FObjectActionFolder.Import(sDirectory);
end;

function TObjectActionDrive.LocateDrive(const psFilePath: String): Boolean;
begin
  Result := FObjectDaoDrive.CDSDados.Locate(FObjectDaoDrive.CDSDadosNAME.FieldName, ExtractFileDrive(psFilePath), [loCaseInsensitive]);
end;

procedure TObjectActionDrive.ValidateChange(const psFilePath: String;
  const pbAutoFix: Boolean; const poLogError: TStringList; const pbValidateFolder: Boolean);
const
  sMSG_DriveExcluido = 'O arquivo "%d - %s" foi excluído.';
var
  sDirectory: String;
begin
  sDirectory := TDMUtils.FormatDirectory(psFilePath);
  if not Assigned(poLogError) then
    Exit;

  if not FObjectDaoDrive.CDSDados.Locate(FObjectDaoDrive.CDSDadosNAME.FieldName, ExtractFileDrive(sDirectory), [loCaseInsensitive]) then
  begin
    poLogError.Add(Format(sMSG_DriveExcluido, [ExtractFileDrive(sDirectory)]));
    if pbAutoFix then
      AddDrive(sDirectory);
  end;

  if pbValidateFolder then
    FObjectActionFolder.ValidateChange(sDirectory, pbAutoFix, poLogError);
end;

initialization
  RegisterClass(TObjectActionDrive);

end.
