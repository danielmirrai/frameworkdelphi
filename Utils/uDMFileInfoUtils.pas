{***********************************************************}
{                                                           }
{                Developed by Daniel Mirrai                 }
{                                                           }
{                Senior Delphi Programmer                   }
{             E-mail: danielmirrai@gmail.com                }
{                   Skype: danielmirrai                     }
{          Phones: +55 (51) 9413-3725 / 3111-2388           }
{         http://www.linkedin.com/in/danielmirrai           }
{          https://www.facebook.com/danielmirrai            }
{                   www.danielmirrai.com                    }
{***********************************************************}

unit uDMFileInfoUtils;

interface
uses
  Classes, Windows, SysUtils, uDMUtils, Contnrs, uConstantUtils;

const
  Key: array[1..9] of string = ('CompanyName',
    'FileDescription',
    'FileVersion',
    'InternalName',
    'LegalCopyright',
    'OriginalFilename',
    'ProductName',
    'ProductVersion',
    'Comments');

  KeyBr: array[1..9] of string = ('Empresa..........................',
    'Descricao........................',
    'Versao do Arquivo...........',
    'Nome Interno...................',
    'Copyright..........................',
    'Nome Original do Arquivo.',
    'Produto.............................',
    'Versao do Produto............',
    'Comentarios...............:');

type
  TDMFileInfoUtils = class(TObject)
  private
    FCompanyName: string;
    FFileDescription: string;
    FFileVersion: string;
    FInternalName: string;
    FLegalCopyright: string;
    FOriginalFilename: string;
    FProductName: string;
    FProductVersion: string;
    FComments: string;
    FAttribute: string;
    FTypeFile: string;
    FOS: string;
    FFileName: string;
    FNameValidate: string;
    FMD5: string;

    function GetComments: string;
    function GetCompanyName: string;
    function GetFileDescription: string;
    function GetFileVersion: string;
    function GetInternalName: string;
    function GetLegalCopyright: string;
    function GetOriginalFilename: string;
    function GetProductName: string;
    function GetProductVersion: string;
    procedure SetComments(const Value: string);
    procedure SetCompanyName(const Value: string);
    procedure SetFileDescription(const Value: string);
    procedure SetFileVersion(const Value: string);
    procedure SetInternalName(const Value: string);
    procedure SetLegalCopyright(const Value: string);
    procedure SetOriginalFilename(const Value: string);
    procedure SetProductName(const Value: string);
    procedure SetProductVersion(const Value: string);
    procedure SetAttribute(const Value: string);
    procedure SetOS(const Value: string);
    procedure SetTypeFile(const Value: string);
    function GetAttribute: string;
    function GetOS: string;
    function GetTypeFile: string;
    procedure SetFileName(const Value: string);
    function GetFileName: string;
    procedure SetNameValidate(const Value: string);
    function GetNameValidate: string;
    procedure SetMD5(const Value: string);
    function GetMD5: string;
  public
    procedure ShowProperties;
    procedure Clear;
    procedure SetFileInfo(const aFileName: string);
    procedure SetListDescriptionFileInfo(const poTranslate: Pointer; const poBuffer: PChar; var pnLength: Integer);
    function GetFlags(const poFileFlags: DWord): string;
    function GetTargetSO(const poFileOS: DWORD): string;
    function GetTypeArq(const poFileType, poFileSubtype: DWORD): string;
    procedure SetDescriptionInfoFile(const pnIndex: Integer; const psDescription: string);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    property CompanyName: string read GetCompanyName write SetCompanyName;
    property FileDescription: string read GetFileDescription write SetFileDescription;
    property FileVersion: string read GetFileVersion write SetFileVersion;
    property InternalName: string read GetInternalName write SetInternalName;
    property LegalCopyright: string read GetLegalCopyright write SetLegalCopyright;
    property OriginalFilename: string read GetOriginalFilename write SetOriginalFilename;
    property ProductName: string read GetProductName write SetProductName;
    property ProductVersion: string read GetProductVersion write SetProductVersion;
    property Comments: string read GetComments write SetComments;
    property TypeFile: string read GetTypeFile write SetTypeFile;
    property OS: string read GetOS write SetOS;
    property Attribute: string read GetAttribute write SetAttribute;
    property FileName: string read GetFileName write SetFileName;
    property NameValidate: string read GetNameValidate write SetNameValidate;
    property MD5: string read GetMD5 write SetMD5;
  end;

  TDMListFileInfoUtils = class(TObjectList)
  private
    function GetItems(Index: Integer): TDMFileInfoUtils;
    procedure SetItems(Index: Integer; const Value: TDMFileInfoUtils);
  public
    function Add: TDMFileInfoUtils; overload;
    function Add(aList: TDMFileInfoUtils): TDMFileInfoUtils; overload;
    constructor Create; overload;
    destructor Destroy; override;
    property Items[Index: Integer]: TDMFileInfoUtils read GetItems write SetItems;
  end;

implementation

uses uDMUtilsMessage, MD5;

{ TDMFileInfoUtils }

procedure TDMFileInfoUtils.AfterConstruction;
begin
  inherited;
  Clear;
end;

procedure TDMFileInfoUtils.BeforeDestruction;
begin
  inherited;

end;

procedure TDMFileInfoUtils.Clear;
begin
  FCompanyName := sCST_EmptyStr;
  FFileDescription := sCST_EmptyStr;
  FFileVersion := sCST_EmptyStr;
  FInternalName := sCST_EmptyStr;
  FLegalCopyright := sCST_EmptyStr;
  FOriginalFilename := sCST_EmptyStr;
  FProductName := sCST_EmptyStr;
  FProductVersion := sCST_EmptyStr;
  FComments := sCST_EmptyStr;
  FAttribute := sCST_EmptyStr;
  FTypeFile := sCST_EmptyStr;
  FOS := sCST_EmptyStr;
  FFileName := sCST_EmptyStr;
  FNameValidate := sCST_EmptyStr;
  FMD5 := sCST_EmptyStr;
end;

function TDMFileInfoUtils.GetAttribute: string;
begin
  Result := FAttribute;
end;

function TDMFileInfoUtils.GetComments: string;
begin
  Result := FComments;
end;

function TDMFileInfoUtils.GetCompanyName: string;
begin
  Result := FCompanyName;
end;

function TDMFileInfoUtils.GetFileDescription: string;
begin
  Result := FFileDescription;
end;

function TDMFileInfoUtils.GetFileName: string;
begin
  Result := FFileName;
end;

function TDMFileInfoUtils.GetFileVersion: string;
begin
  Result := FFileVersion;
end;

function TDMFileInfoUtils.GetFlags(const poFileFlags: DWord): string;
begin
  Result := sCST_EmptyStr;
  Result := TDMUtils.IIf((poFileFlags = VS_FF_DEBUG), Concat(Result, '*Debug* '), Result);
  Result := TDMUtils.IIf((poFileFlags = VS_FF_SPECIALBUILD), Concat(Result, '*Special Build* '), Result);
  Result := TDMUtils.IIf((poFileFlags = VS_FF_PRIVATEBUILD), Concat(Result, '*Private Build* '), Result);
  Result := TDMUtils.IIf((poFileFlags = VS_FF_PRERELEASE), Concat(Result, '*Pre-Release Build* '), Result);
  Result := TDMUtils.IIf((poFileFlags = VS_FF_PATCHED), Concat(Result, '*Patched* '), Result);
  FAttribute := Result;
end;

function TDMFileInfoUtils.GetInternalName: string;
begin
  Result := FInternalName;
end;

function TDMFileInfoUtils.GetLegalCopyright: string;
begin
  Result := FLegalCopyright;
end;

function TDMFileInfoUtils.GetMD5: string;
begin
  Result := FMD5;
end;

function TDMFileInfoUtils.GetNameValidate: string;
begin
  Result := FNameValidate;
end;

function TDMFileInfoUtils.GetOriginalFilename: string;
begin
  Result := FOriginalFilename;
end;

function TDMFileInfoUtils.GetOS: string;
begin
  Result := FOS;
end;

function TDMFileInfoUtils.GetProductName: string;
begin
  Result := FProductName;
end;

function TDMFileInfoUtils.GetProductVersion: string;
begin
  Result := FProductVersion;
end;

function TDMFileInfoUtils.GetTargetSO(const poFileOS: DWORD): string;
begin
  Result := sCST_EmptyStr;
  case poFileOS of
    VOS_UNKNOWN: Result := Concat(Result, 'Desconhecido');
    VOS_DOS: Result := Concat(Result, 'MS-DOS');
    VOS_OS216: Result := Concat(Result, '16-bit OS/2');
    VOS_OS232: Result := Concat(Result, '32-bit OS/2');
    VOS_NT: Result := Concat(Result, 'Windows NT');
    VOS_NT_WINDOWS32, 4: Result := Concat(Result, 'Win32 API');
    VOS_DOS_WINDOWS16: Result := Concat(Result, '16-bit Windows ', 'sob MS-DOS');
  else
    Result := Concat(Result, 'Fora do Padrão. Código: ', IntToStr(poFileOS));
  end;
end;

function TDMFileInfoUtils.GetTypeArq(const poFileType, poFileSubtype: DWORD): string;
begin
  Result := sCST_EmptyStr;
  case poFileType of
    VFT_UNKNOWN: Result := Concat(Result, 'Desconhecido');
    VFT_APP: Result := Concat(Result, 'Aplicacao');
    VFT_DLL: Result := Concat(Result, 'Dynamic-Link Lib.');
    VFT_DRV:
      begin
        Result := Concat(Result, 'Device driver - Driver ');
        case poFileSubtype of
          VFT2_UNKNOWN: Result := Concat(Result, 'Desconhecido');
          VFT2_DRV_PRINTER: Result := Concat(Result, 'de Impressao');
          VFT2_DRV_KEYBOARD: Result := Concat(Result, 'de Teclado');
          VFT2_DRV_LANGUAGE: Result := Concat(Result, 'de Idioma');
          VFT2_DRV_DISPLAY: Result := Concat(Result, 'de Vídeo');
          VFT2_DRV_MOUSE: Result := Concat(Result, 'de Mouse');
          VFT2_DRV_NETWORK: Result := Concat(Result, 'de Rede');
          VFT2_DRV_SYSTEM: Result := Concat(Result, 'de Sistema');
          VFT2_DRV_INSTALLABLE: Result := Concat(Result, 'Instalavel');
          VFT2_DRV_SOUND: Result := Concat(Result, 'Multimida');
        end;
      end;
    VFT_FONT:
      begin
        Result := Concat(Result, 'Fonte - Fonte ');
        case poFileSubtype of
          VFT2_UNKNOWN: Result := Concat(Result, 'Desconhecida');
          VFT2_FONT_RASTER: Result := Concat(Result, 'Raster');
          VFT2_FONT_VECTOR: Result := Concat(Result, 'Vetorial');
          VFT2_FONT_TRUETYPE: Result := Concat(Result, 'TrueType');
        end;
      end;
    VFT_VXD: Result := Concat(Result, 'Virtual Device');
    VFT_STATIC_LIB: Result := Concat(Result, 'Static-Link Lib.');
  end;
  FTypeFile := Result;
end;

function TDMFileInfoUtils.GetTypeFile: string;
begin
  Result := FTypeFile;
end;

procedure TDMFileInfoUtils.SetAttribute(const Value: string);
begin
  FAttribute := Value;
end;

procedure TDMFileInfoUtils.SetComments(const Value: string);
begin
  FComments := Value;
end;

procedure TDMFileInfoUtils.SetCompanyName(const Value: string);
begin
  FCompanyName := Value;
end;

procedure TDMFileInfoUtils.SetDescriptionInfoFile(const pnIndex: Integer; const psDescription: string);
begin
  case pnIndex of
    1: FCompanyName := psDescription;
    2: FFileDescription := psDescription;
    3: FFileVersion := psDescription;
    4: FInternalName := psDescription;
    5: FLegalCopyright := psDescription;
    6: FOriginalFilename := psDescription;
    7: FProductName := psDescription;
    8: FProductVersion := psDescription;
    9: FComments := psDescription;
  end;
end;

procedure TDMFileInfoUtils.SetFileDescription(const Value: string);
begin
  FFileDescription := Value;
end;

procedure TDMFileInfoUtils.SetFileInfo(const aFileName: string);
var
  vDummy: THandle;
  vBufferSize, vLen: Integer;
  vBuffer: PChar;
  vTranslate: Pointer;
  vFlags: string;
  vTargetOS, vTypeArq: string;
  vFixedFileInfo: Pointer;
begin
  Clear;
  FFileName := aFileName;
  FNameValidate := ExtractFileName(FFileName);
  if not FileExists(aFileName) then
    exit;

  FMD5 := MD5File2(aFileName);
  vBufferSize := GetFileVersionInfoSize(PChar(aFileName), vDummy);
  if vBufferSize <> 0 then
  begin
    GetMem(vBuffer, Succ(vBufferSize));
    try
      if GetFileVersionInfo(PChar(aFileName), nCST_Zero, vBufferSize, vBuffer) then
      begin
        if VerQueryValue(vBuffer, '\VarFileInfo\Translation', vTranslate, UINT(vLen)) then
        begin
          SetListDescriptionFileInfo(vTranslate, vBuffer, vLen);

          if VerQueryValue(vBuffer, PChar(sCST_EmptyStr), vFixedFileInfo, UINT(vLen)) then
            with TVSFixedFileInfo(vFixedFileInfo^) do
            begin
              vFlags := GetFlags(dwFileFlags);

              vTargetOS := GetTargetSO(dwFileOS);
              FOS := vTargetOS;

              vTypeArq := GetTypeArq(dwFileType, dwFileSubtype);
            end;
        end;
      end;
    finally
      FreeMem(vBuffer, Succ(vBufferSize));
    end;
  end;
end;

procedure TDMFileInfoUtils.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure TDMFileInfoUtils.SetFileVersion(const Value: string);
begin
  FFileVersion := Value;
end;

procedure TDMFileInfoUtils.SetInternalName(const Value: string);
begin
  FInternalName := Value;
end;

procedure TDMFileInfoUtils.SetLegalCopyright(const Value: string);
begin
  FLegalCopyright := Value;
end;

procedure TDMFileInfoUtils.SetListDescriptionFileInfo(const poTranslate: Pointer; const poBuffer: PChar; var pnLength: Integer);
var
  nIndex: Integer;
  nStrFileInfo: string;
  oLoCharSet, oHiCharSet: Word;
  oReturn: Pointer;
begin
  oLoCharSet := LoWord(Longint(poTranslate^));
  oHiCharSet := HiWord(Longint(poTranslate^));
  for nIndex := 1 to 9 do
  begin
    nStrFileInfo := Format('\StringFileInfo\0%x0%x\%s', [oLoCharSet, oHiCharSet, Key[nIndex]]);
    if VerQueryValue(poBuffer, PChar(nStrFileInfo), oReturn, UINT(pnLength)) then
      SetDescriptionInfoFile(nIndex, PChar(oReturn));
  end;
end;

procedure TDMFileInfoUtils.SetMD5(const Value: string);
begin
  FMD5 := Value;
end;

procedure TDMFileInfoUtils.SetNameValidate(const Value: string);
begin
  FNameValidate := Value;
end;

procedure TDMFileInfoUtils.SetOriginalFilename(const Value: string);
begin
  FOriginalFilename := Value;
end;

procedure TDMFileInfoUtils.SetOS(const Value: string);
begin
  FOS := Value;
end;

procedure TDMFileInfoUtils.SetProductName(const Value: string);
begin
  FProductName := Value;
end;

procedure TDMFileInfoUtils.SetProductVersion(const Value: string);
begin
  FProductVersion := Value;
end;

procedure TDMFileInfoUtils.SetTypeFile(const Value: string);
begin
  FTypeFile := Value;
end;

procedure TDMFileInfoUtils.ShowProperties;
begin
  TDMUtilsMessage.ShowMessageOk(
    'Empresa: ' + FCompanyName + #13 + #10 +
    'Descricao: ' + FFileDescription + #13 + #10 +
    'Versao do Arquivo: ' + FFileVersion + #13 + #10 +
    'Nome Interno: ' + FInternalName + #13 + #10 +
    'Copyright: ' + FLegalCopyright + #13 + #10 +
    'Nome Original do Arquivo: ' + FOriginalFilename + #13 + #10 +
    'Produto: ' + FProductName + #13 + #10 +
    'Versao do Produto: ' + FProductVersion + #13 + #10 +
    'Comentarios: ' + FComments + #13 + #10 +
    'Atributos: ' + FAttribute + #13 + #10 +
    'Tipo: ' + FTypeFile + #13 + #10 +
    'OS: ' + FOS + #13 + #10 +
    'Diretório: ' + FFileName);
end;

{ TDMListFileInfoUtils }

function TDMListFileInfoUtils.Add(aList: TDMFileInfoUtils): TDMFileInfoUtils;
begin
  inherited Add(aList);
  result := aList;
end;

function TDMListFileInfoUtils.Add: TDMFileInfoUtils;
var
  vNew: TDMFileInfoUtils;
begin
  vNew := TDMFileInfoUtils.Create;
  Result := Add(vNew);
end;

constructor TDMListFileInfoUtils.Create;
begin
  inherited Create;
end;

destructor TDMListFileInfoUtils.Destroy;
begin
  inherited Destroy;
end;

function TDMListFileInfoUtils.GetItems(Index: Integer): TDMFileInfoUtils;
begin
  Result := TDMFileInfoUtils(inherited Items[index]);
end;

procedure TDMListFileInfoUtils.SetItems(Index: Integer;
  const Value: TDMFileInfoUtils);
begin
  inherited Items[Index] := Value;
end;

end.
