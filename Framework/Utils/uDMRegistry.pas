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

unit uDMRegistry;

interface

uses
  Classes, SysUtils, Windows, Registry, Variants, uConstantUtils;

type
  TDMRegistry = class(TRegistry)

  private
    FKey: string;
    FFilename: string;
    FKeyIsOpen: Boolean;
    FActiveCript: Boolean;
  protected
    procedure SetKey(const Value: string);
    procedure SetFilename(const Value: string);
    procedure SetActiveCript(const Value: Boolean);
    function GetActiveCript: Boolean;
  public
    procedure Add(const pnValue: Boolean); overload;
    procedure Add(const psFileName: string; const pbValue: Boolean); overload;
    procedure Add(const pnValue: Double); overload;
    procedure Add(const psFileName: string; const pnValue: Double); overload;
    procedure Add(const psValue: string); overload;
    procedure Add(const psFileName: string; const psValue: string); overload;
    function GetKeyValue: string; overload;
    function GetTypeKeyValue: TRegDataType;
    function GetKeyValue(const psFileName: string; const psDefault: string = '')
      : string; overload;
    function GetValueExist: Boolean; overload;
    function GetValueExist(const psFileName: string): Boolean; overload;
    function GetKeyBinaryValue: Integer; overload;
    function GetKeyBinaryValue(const psFileName: string;
      const psDefault: Integer = nCST_Zero): Integer; overload;
    function SaveKey: Boolean; overload;
    function SaveKey(const psKey, psFileName: string): Boolean; overload;
    function OpenKey2(const pbCanCreate: Boolean = true): Boolean; overload;
    function OpenKey2(const psKey: string; pbCanCreate: Boolean = true)
      : Boolean; overload;
    function OpenKeyReadOnly2: Boolean; overload;
    function OpenKeyReadOnly2(const psKey: string): Boolean; overload;
    function KeyExists2: Boolean;
    procedure CloseKey2;
    function CreateKey(const psKey: string): Boolean; overload;
    function CreateKey: Boolean; overload;
    property Key: string read FKey write SetKey;
    property Filename: string read FFilename write SetFilename;
    procedure AfterConstruction; override;
    class procedure DeleteRegistry(const psKey: string);
    class procedure SaveRegistry(const psKey, psField, psValue: string);
    class function GetValueRegistry(const psKey, psField, psValueDefault
      : string): String; overload;
    procedure BeforeDestruction; override;
    property ActiveCript: Boolean read GetActiveCript write SetActiveCript;
  end;

implementation

uses uDMUtils, uDMCript;

{ TDMRegistry }

procedure TDMRegistry.AfterConstruction;
begin
  inherited;
  FKey := '';
  FFilename := '';
  RootKey := HKEY_CURRENT_USER;
  FKeyIsOpen := False;
  FActiveCript := False;
end;

function TDMRegistry.SaveKey: Boolean;
begin
  Result := SaveKey(FKey, FFilename);
end;

function TDMRegistry.SaveKey(const psKey, psFileName: string): Boolean;
begin
  Result := inherited SaveKey(psKey, psFileName);
end;

procedure TDMRegistry.SetActiveCript(const Value: Boolean);
begin
  FActiveCript := Value;
end;

procedure TDMRegistry.SetFilename(const Value: string);
begin
  FFilename := Value;
end;

procedure TDMRegistry.SetKey(const Value: string);
begin
  FKey := Value;
end;

function TDMRegistry.CreateKey: Boolean;
begin
  Result := False;
  if not KeyExists2 then
    Result := inherited CreateKey(FKey);
end;

procedure TDMRegistry.Add(const psValue: string);
var
  oRegDataType: TRegDataType;
  oValue : Array of Byte;
  nValueLenght, nIndex: Integer;
  sValue: String;
begin
  sValue := psValue;
  if ActiveCript then
    sValue := TDMCript.Encrypts(sValue);

  oRegDataType := GetTypeKeyValue;
  case oRegDataType of
    rdString: WriteString(FFilename, sValue);
    rdExpandString: WriteString(FFilename, sValue);
    rdInteger: WriteInteger(FFilename, TDMUtils.StrToInt2(sValue));
    rdBinary:
    begin
      nValueLenght := Length(psValue);
      if nValueLenght <= 0 then
        Exit;
      SetLength(oValue, nValueLenght);
      for nIndex := 1 to Length(psValue) do
      begin
        oValue[nIndex] := byte(psValue[nIndex]);
      end;

      WriteBinaryData(FFilename, PByte(oValue), nValueLenght);
    end;
  end;
end;

procedure TDMRegistry.Add(const psFileName: string; const psValue: string);
begin
  FFilename := psFileName;
  Add(psValue);
end;

function TDMRegistry.OpenKey2(const pbCanCreate: Boolean): Boolean;
begin
  CloseKey2;
  Result := OpenKey(FKey, pbCanCreate);
  FKeyIsOpen := Result;
end;

function TDMRegistry.OpenKey2(const psKey: string;
  pbCanCreate: Boolean): Boolean;
begin
  FKey := psKey;
  Result := OpenKey2(pbCanCreate);
end;

procedure TDMRegistry.CloseKey2;
begin
  if FKeyIsOpen then
    CloseKey;
end;

function TDMRegistry.GetKeyValue(const psFileName: string;
  const psDefault: string = ''): string;
begin
  FFilename := psFileName;
  Result := GetKeyValue;

  if not GetValueExist(FFilename) then
  begin
    OpenKey2;
    Add(psDefault);
  end;

  if TDMUtils.IsEmpty(Result) then
    Result := psDefault;
end;

function TDMRegistry.GetTypeKeyValue: TRegDataType;
var
  Info: TRegDataInfo;
begin
  Result := rdUnknown;
  if GetDataInfo(Filename, Info) then
    Result := Info.RegData;
end;

function TDMRegistry.GetKeyValue: string;
var
  oRegDataType: TRegDataType;
  oValue : Array of Byte;
  nValueLenght : Integer;
begin
  Result := sCST_EmptyStr;
  if not GetValueExist(FFilename) then
    Exit;

  oRegDataType := GetTypeKeyValue;
  case oRegDataType of
    rdString: Result := ReadString(FFilename);
    rdExpandString: Result := ReadString(FFilename);
    rdInteger: Result := IntToStr(ReadInteger(FFilename));
    rdBinary:
    begin
      nValueLenght := GetDataSize(FFilename);
      if nValueLenght <= 0 then
        Exit;

      SetLength(oValue, nValueLenght);
      Result := IntToStr(ReadBinaryData(FFilename, PByte(oValue), nValueLenght));
    end;
  end;
  if ActiveCript then
    Result := TDMCript.Decrypt(Result);
end;

function TDMRegistry.KeyExists2: Boolean;
begin
  Result := KeyExists(FKey);
end;

class procedure TDMRegistry.SaveRegistry(const psKey, psField, psValue: string);
var
  oDMRegistry: TDMRegistry;
begin
  oDMRegistry := TDMRegistry.Create;
  try
    oDMRegistry.Key := psKey;
    if oDMRegistry.OpenKey2 then
      oDMRegistry.Add(psField, psValue);
  finally
    TDMUtils.DestroyObject(oDMRegistry);
  end;
end;

function TDMRegistry.CreateKey(const psKey: string): Boolean;
begin
  FKey := psKey;
  Result := CreateKey;
end;

class procedure TDMRegistry.DeleteRegistry(const psKey: string);
var
  oDMRegistry: TDMRegistry;
begin
  oDMRegistry := TDMRegistry.Create;
  try
    oDMRegistry.Key := psKey;
    if oDMRegistry.KeyExists2 then
      oDMRegistry.DeleteKey(psKey);
  finally
    TDMUtils.DestroyObject(oDMRegistry);
  end;
end;

procedure TDMRegistry.Add(const pnValue: Double);
begin
  Add(FloatToStr(pnValue));
end;

procedure TDMRegistry.Add(const psFileName: string; const pnValue: Double);
begin
  FFilename := psFileName;
  Add(pnValue);
end;

procedure TDMRegistry.Add(const pnValue: Boolean);
begin
  Add(BoolToStr(pnValue));
end;

procedure TDMRegistry.Add(const psFileName: string; const pbValue: Boolean);
begin
  FFilename := psFileName;
  Add(pbValue);
end;

function TDMRegistry.GetActiveCript: Boolean;
begin
  Result := FActiveCript;
end;

function TDMRegistry.GetKeyBinaryValue(const psFileName: string;
  const psDefault: Integer = nCST_Zero): Integer;
begin
  FFilename := psFileName;
  Result := GetKeyBinaryValue;
  if TDMUtils.IsEmpty(Result) then
    Result := psDefault;
end;

function TDMRegistry.GetKeyBinaryValue: Integer;
begin
  try
    Result := StrToInt(GetKeyValue);
  except
    Result := nCST_Zero;
  end;
end;

function TDMRegistry.GetValueExist: Boolean;
begin
  Result := ValueExists(FFilename);
end;

function TDMRegistry.GetValueExist(const psFileName: string): Boolean;
begin
  FFilename := psFileName;
  Result := GetValueExist;
end;

procedure TDMRegistry.BeforeDestruction;
begin
  CloseKey2;
  inherited;
end;

function TDMRegistry.OpenKeyReadOnly2: Boolean;
begin
  CloseKey2;
  Result := inherited OpenKeyReadOnly(FKey);
  FKeyIsOpen := Result;
end;

function TDMRegistry.OpenKeyReadOnly2(const psKey: string): Boolean;
begin
  FKey := psKey;
  Result := OpenKeyReadOnly2;
end;

class function TDMRegistry.GetValueRegistry(const psKey, psField,
  psValueDefault: string): String;
var
  oDMRegistry: TDMRegistry;
begin
  oDMRegistry := TDMRegistry.Create;
  try
    oDMRegistry.Key := psKey;
    Result := psValueDefault;

    if oDMRegistry.KeyExists2 and oDMRegistry.OpenKeyReadOnly2 then
      Result := oDMRegistry.GetKeyValue(psField, psValueDefault)
    else if oDMRegistry.OpenKey2 then
      oDMRegistry.Add(psField, psValueDefault);
  finally
    TDMUtils.DestroyObject(oDMRegistry);
  end;
end;

end.
