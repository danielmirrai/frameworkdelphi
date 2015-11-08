{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Senior Delphi Programmer }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Phones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ www.danielmirrai.com }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }
unit uDMValidateProcess;

interface

uses
  uDMFileInfoUtils, SysUtils, classes;

type
  TDMValidateProcess = class
  private
    FDMListFileInfoUtils: TDMListFileInfoUtils;
  protected
    class function LocateItem(aName, aValue: string): Boolean;
  public
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    function GetNameProcess(aFileInfoUtils: TDMFileInfoUtils;
      var pbFoundProcessValidate: Boolean): string;
    class function ProcessEquals(const poFileInfoUtils, poCompareFileInfoUtils
      : TDMFileInfoUtils): Boolean;

  end;

implementation

uses uDMUtils;

{ TDMValidateProcess }

procedure TDMValidateProcess.AfterConstruction;
begin
  inherited;
  FDMListFileInfoUtils := TDMListFileInfoUtils.Create;
end;

procedure TDMValidateProcess.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FDMListFileInfoUtils);
  inherited;
end;

function TDMValidateProcess.GetNameProcess(aFileInfoUtils: TDMFileInfoUtils;
  var pbFoundProcessValidate: Boolean): string;
var
  vIndex: Integer;
  vFileInfoUtils: TDMFileInfoUtils;
begin
  pbFoundProcessValidate := False;
  if not(Assigned(FDMListFileInfoUtils) and
    not TDMUtils.IsEmpty(aFileInfoUtils.NameValidate)) then
    Exit;

  Result := aFileInfoUtils.NameValidate;
  for vIndex := 0 to FDMListFileInfoUtils.Count - 1 do
  begin
    vFileInfoUtils := FDMListFileInfoUtils.Items[vIndex];
    if not ProcessEquals(aFileInfoUtils, vFileInfoUtils) then
      Continue;
    Result := vFileInfoUtils.NameValidate;
    pbFoundProcessValidate := True;
    if TDMUtils.ExistValue(vFileInfoUtils.CompanyName) then
      aFileInfoUtils.CompanyName := vFileInfoUtils.CompanyName;
    if TDMUtils.ExistValue(vFileInfoUtils.FileDescription) then
      aFileInfoUtils.FileDescription := vFileInfoUtils.FileDescription;
    if TDMUtils.ExistValue(vFileInfoUtils.FileVersion) then
      aFileInfoUtils.FileVersion := vFileInfoUtils.FileVersion;
    if TDMUtils.ExistValue(vFileInfoUtils.InternalName) then
      aFileInfoUtils.InternalName := vFileInfoUtils.InternalName;
    if TDMUtils.ExistValue(vFileInfoUtils.LegalCopyright) then
      aFileInfoUtils.LegalCopyright := vFileInfoUtils.LegalCopyright;
    if TDMUtils.ExistValue(vFileInfoUtils.OriginalFilename) then
      aFileInfoUtils.OriginalFilename := vFileInfoUtils.OriginalFilename;
    if TDMUtils.ExistValue(vFileInfoUtils.ProductName) then
      aFileInfoUtils.ProductName := vFileInfoUtils.ProductName;
    if TDMUtils.ExistValue(vFileInfoUtils.ProductVersion) then
      aFileInfoUtils.ProductVersion := vFileInfoUtils.ProductVersion;
    if TDMUtils.ExistValue(vFileInfoUtils.Comments) then
      aFileInfoUtils.Comments := vFileInfoUtils.Comments;
    if TDMUtils.ExistValue(vFileInfoUtils.Attribute) then
      aFileInfoUtils.Attribute := vFileInfoUtils.Attribute;
    if TDMUtils.ExistValue(vFileInfoUtils.OS) then
      aFileInfoUtils.OS := vFileInfoUtils.OS;
    if TDMUtils.ExistValue(vFileInfoUtils.TypeFile) then
      aFileInfoUtils.TypeFile := vFileInfoUtils.TypeFile;
    if TDMUtils.ExistValue(vFileInfoUtils.FileName) then
      aFileInfoUtils.FileName := vFileInfoUtils.FileName;
    if TDMUtils.ExistValue(vFileInfoUtils.NameValidate) then
      aFileInfoUtils.NameValidate := vFileInfoUtils.NameValidate;
    if TDMUtils.ExistValue(vFileInfoUtils.MD5) then
      aFileInfoUtils.MD5 := vFileInfoUtils.MD5;
    Break;
  end;
end;

class function TDMValidateProcess.LocateItem(aName, aValue: string): Boolean;
var
  vList: TStringList;
  vIndex2: Integer;
begin
  Result := False;
  try
    vList := TDMUtils.Explode(aValue, '!');
    for vIndex2 := 0 to vList.Count - 1 do
    begin
      Result := (not(TDMUtils.IsEmpty(aName) or TDMUtils.IsEmpty(aValue))) and
        (pos(UpperCase(Trim(vList.Strings[vIndex2])),
        UpperCase(Trim(aName))) > 0);
      if Result then
        Exit;
    end;
  finally
    TDMUtils.DestroyObject(vList);
  end;
end;

class function TDMValidateProcess.ProcessEquals(const poFileInfoUtils,
  poCompareFileInfoUtils: TDMFileInfoUtils): Boolean;
begin
  Result := False;
  if not(Assigned(poFileInfoUtils) and Assigned(poCompareFileInfoUtils) and
    not TDMUtils.IsEmpty(poFileInfoUtils.NameValidate)) then
    Exit;

  if (TDMUtils.CompareIgnoreCase(poFileInfoUtils.NameValidate, poCompareFileInfoUtils.NameValidate, True) or
    TDMUtils.CompareIgnoreCase(poFileInfoUtils.NameValidate, poCompareFileInfoUtils.FileName, True) or
    TDMUtils.CompareIgnoreCase(poFileInfoUtils.FileName, poCompareFileInfoUtils.FileName, True) or
    LocateItem(poFileInfoUtils.MD5, poCompareFileInfoUtils.MD5) or
    LocateItem(poFileInfoUtils.CompanyName, poCompareFileInfoUtils.CompanyName) or
    LocateItem(poFileInfoUtils.FileDescription, poCompareFileInfoUtils.FileDescription) or
    LocateItem(poFileInfoUtils.InternalName, poCompareFileInfoUtils.InternalName) or
    LocateItem(poFileInfoUtils.LegalCopyright, poCompareFileInfoUtils.LegalCopyright) or
    LocateItem(poFileInfoUtils.OriginalFilename, poCompareFileInfoUtils.OriginalFilename) or
    LocateItem(poFileInfoUtils.ProductName, poCompareFileInfoUtils.ProductName) or
    LocateItem(poFileInfoUtils.FileName, poCompareFileInfoUtils.FileName) or
    LocateItem(ExtractFilePath(poFileInfoUtils.FileName), ExtractFilePath(poCompareFileInfoUtils.FileName)) or
    LocateItem(ExtractFileName(poFileInfoUtils.FileName), ExtractFileName(poCompareFileInfoUtils.FileName)) or
    LocateItem(poFileInfoUtils.NameValidate, poCompareFileInfoUtils.NameValidate)) then
    Result := True;
end;

end.
