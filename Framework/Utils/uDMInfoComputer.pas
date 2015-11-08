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

unit uDMInfoComputer;

interface

uses
  NB30, SysUtils, Windows, Variants, uConstantUtils,
  Forms, Registry, Classes,
  IdBaseComponent, IdIPWatch;
Const
   NERR_Success = 0;

function NetApiBufferAllocate(ByteCount: DWORD; var Buffer: Pointer): DWORD;
                                           stdcall; external 'netapi32.dll';
function NetGetDCName(servername: LPCWSTR; domainname: LPCWSTR;
  bufptr: Pointer): DWORD; stdcall; external 'netapi32.dll';
function NetApiBufferFree (Buffer: Pointer): DWORD ; stdcall;
                                     external 'netapi32.dll';
Function NetWkstaGetInfo
        (ServerName : LPWSTR;
         Level      : DWORD;
         BufPtr     : Pointer) : Longint; Stdcall;
                external 'netapi32.dll' Name 'NetWkstaGetInfo';

function NetUserEnum(servername: LPCWSTR; level: DWORD; filter: DWORD;
  var bufptr: Pointer; prefmaxlen: DWORD; var entriesread: DWORD;
  var totalentries: DWORD; resume_handle: PDWORD): DWORD; stdcall;
                                          external 'netapi32.dll';

type
  WKSTA_INFO_100   = Record
      wki100_platform_id  : DWORD;
      wki100_computername : LPWSTR;
      wki100_langroup     : LPWSTR;
      wki100_ver_major    : DWORD;
      wki100_ver_minor    : DWORD;
                            End;

   LPWKSTA_INFO_100 = ^WKSTA_INFO_100;

  _USER_INFO_0  = record
    usri0_name: LPWSTR;
  end;
  TUserInfo0 = _USER_INFO_0;

  TDMInfoComputer = class
  private
    class function GetFamilyWindowsSO: string;
    class function GetFamilyNTSO: string;
    class function DecodeProductKey(const HexSrc: array of Byte): string;
  public
    class function GetAdapterInfo(aLana: AnsiChar): string;
    class function GetAdress_MAC: string;
    class function GetAdress_IP: string;
      class function GetAdress_IP_Rede: string;
    class function GetName_Processor(aID_Processor
      : Integer = nCST_Zero): string;
    class function GetName_VideoCard(aID: Integer = nCST_Zero): string;
    class function GetCpuSpeed: string;
    class function GetMotherboard: string;
    class function GetID_Motherboard: Integer;
    class function GetMemory_RAM_Format: string;
    class function GetMemory_RAM: Real;
    class function GetMemory_RAM_MB: Integer;
    class function GetSO: string;
    class function GetPCName: string;
    class function GetPCUser: string;
    class function GetUserIsAdmin: Boolean;
    class function GetSerialDisk(Disk: string): string;
    class function GetResolution: string;
    class function GetSerialMotherboard: string;
    class function GetBiosInfo: string;
    class function GetWindowsKey: string;
    class function GetUsers(const psServer: string): TStringList;
  end;

implementation

uses uDMUtils, uDMHTTP;

{ TObjectActionInfoCompute }
// Function GetHDDSerialN(DriveIndex:Byte;var pHDDSerialOut:PChar):Boolean;stdcall;external 'HCAudio.dll'; //--6

class function TDMInfoComputer.GetAdapterInfo(aLana: AnsiChar): string;
var
  vAdapter: TAdapterStatus;
  vNCB: TNCB;
begin
  FillChar(vNCB, SizeOf(vNCB), nCST_Zero);
  vNCB.ncb_command := Char(NCBRESET);
  vNCB.ncb_lana_num := aLana;
  if Netbios(@vNCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'mac não encontrado';
    Exit;
  end;

  FillChar(vNCB, SizeOf(vNCB), nCST_Zero);
  vNCB.ncb_command := Char(NCBASTAT);
  vNCB.ncb_lana_num := aLana;
  vNCB.ncb_callname := '*';
  FillChar(vAdapter, SizeOf(vAdapter), nCST_Zero);
  vNCB.ncb_buffer := @vAdapter;
  vNCB.ncb_length := SizeOf(vAdapter);
  if Netbios(@vNCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'mac não encontrado';
    Exit;
  end;
  Result := IntToHex(Byte(vAdapter.adapter_address[0]), 2) +
    IntToHex(Byte(vAdapter.adapter_address[1]), 2) +
    IntToHex(Byte(vAdapter.adapter_address[2]), 2) +
    IntToHex(Byte(vAdapter.adapter_address[3]), 2) +
    IntToHex(Byte(vAdapter.adapter_address[4]), 2) +
    IntToHex(Byte(vAdapter.adapter_address[5]), 2);
end;

class function TDMInfoComputer.GetAdress_IP: string;
var
  vIdIPWatch: TIdIPWatch;
begin
  vIdIPWatch := nil;
  try
    vIdIPWatch := TIdIPWatch.Create(nil);
    vIdIPWatch.HistoryEnabled := False;
    Result := vIdIPWatch.LocalIP;
  finally
    TDMUtils.DestroyObject(vIdIPWatch);
  end;
end;

class function TDMInfoComputer.GetAdress_IP_Rede: string;
var
  vIdIPWatch: TIdIPWatch;
begin
  vIdIPWatch := nil;
  try
    vIdIPWatch := TIdIPWatch.Create(nil);
    vIdIPWatch.HistoryEnabled := False;
    Result := vIdIPWatch.CurrentIP;
  finally
    TDMUtils.DestroyObject(vIdIPWatch);
  end;
end;

class function TDMInfoComputer.GetAdress_MAC: string;
var
  vAdapterList: TLanaEnum;
  vNCB: TNCB;
begin
  Result := sCST_EmptyStr;
  FillChar(vNCB, SizeOf(vNCB), nCST_Zero);
  vNCB.ncb_command := Char(NCBENUM);
  vNCB.ncb_buffer := @vAdapterList;
  vNCB.ncb_length := SizeOf(vAdapterList);
  Netbios(@vNCB);
  if Byte(vAdapterList.length) > 0 then
    Result := GetAdapterInfo(vAdapterList.lana[0]);
end;

class function TDMInfoComputer.GetCpuSpeed: string;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\Hardware\Description\System\CentralProcessor\0', False)
    then
    begin
      Result := IntToStr(Reg.ReadInteger('~MHz')) + ' MHz';
      Reg.CloseKey;
    end;
  finally
    TDMUtils.DestroyObject(Reg);
  end;
end;

class function TDMInfoComputer.GetFamilyNTSO: string;
begin
  Result := 'Windows 7';
  if Win32MajorVersion <= 4 then
    Result := 'NT'
  else if Win32MajorVersion = 5 then
    case Win32MinorVersion of
      0:
        Result := '2000';
      1:
        Result := 'XP';
      2:
        Result := 'Server 2003';
    end
  else if (Win32MajorVersion = 6) and (Win32MinorVersion = nCST_Zero) then
    Result := 'Vista';
end;

class function TDMInfoComputer.GetFamilyWindowsSO: string;
begin
  Result := '9x version (unknown)';
  if Win32MajorVersion <> 4 then
    Exit;

  case Win32MinorVersion of
    0:
      Result := TDMUtils.IIf((length(Win32CSDVersion) > nCST_Zero) and
        TDMUtils.CharInSet(Win32CSDVersion[1], ['B', 'C']), '95 OSR2', '95');
    10:
      Result := TDMUtils.IIf((length(Win32CSDVersion) > nCST_Zero) and
        (Win32CSDVersion[1] = 'A'), '98 SE', '98');
    90:
      Result := 'ME';
  end;
end;

class function TDMInfoComputer.GetID_Motherboard: Integer;
begin
  Result := nCST_Zero;
end;

class function TDMInfoComputer.GetMemory_RAM: Real;
var
  vMemoryStatus: TMemoryStatus;
begin
  GlobalMemoryStatus(vMemoryStatus);
  Result := vMemoryStatus.dwTotalPhys;
end;

class function TDMInfoComputer.GetMemory_RAM_Format: string;
begin
  Result := TDMUtils.FormatSize(GetMemory_RAM);
end;

class function TDMInfoComputer.GetMemory_RAM_MB: Integer;
var
  vMemory: Real;
begin
  vMemory := GetMemory_RAM;
  Result := TDMUtils.FloatToInt2((vMemory / 1024) / 1024);
end;

class function TDMInfoComputer.GetPCName: string;
var
  PC: pwidechar;
  Tam: Cardinal;
begin
  Result := '';
  Tam := 255;
  Getmem(PC, Tam);
  GetComputerNameW(PC, Tam);
  Result := PC;
  FreeMem(PC);
end;

class function TDMInfoComputer.GetName_VideoCard
  (aID: Integer = nCST_Zero): string;
var
  vRegistry: TRegistry;
  vDevice: string;
begin
  Result := sCST_EmptyStr;
  vRegistry := TRegistry.Create(KEY_READ); // ACESSO APENAS LEITURA
  vRegistry.RootKey := HKEY_LOCAL_MACHINE;
  if not vRegistry.OpenKeyReadOnly('\HARDWARE\DEVICEMAP\VIDEO\') then
    Exit;

  vDevice := vRegistry.ReadString('\Device\Video' + IntToStr(aID));
  vDevice := Copy(vDevice, 18, length(vDevice) - 17);
  if vRegistry.OpenKeyReadOnly(vDevice) then
    Result := vRegistry.ReadString('Device Description');
end;

class function TDMInfoComputer.GetName_Processor(aID_Processor
  : Integer = nCST_Zero): string;
var
  Reg: TRegistry;
begin
  Result := sCST_EmptyStr;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\Hardware\Description\System\CentralProcessor\' +
      TDMUtils.IntToStr2(aID_Processor), False) then
      Result := Reg.ReadString('Identifier');
  finally
    TDMUtils.DestroyObject(Reg);
  end;
end;

class function TDMInfoComputer.GetPCUser: string;
var
  User: pwidechar;
  Tam: Cardinal;
begin
  Result := '';
  Tam := 255;
  Getmem(User, Tam);
  GetUserNameW(User, Tam);
  Result := User;
  FreeMem(User);
end;

class function TDMInfoComputer.GetMotherboard: string;
begin
  Result := sCST_EmptyStr;
end;

class function TDMInfoComputer.GetResolution: string;
var
  vWidth, vHeigth: string;
begin
  vWidth := IntToStr(screen.Width);
  vHeigth := IntToStr(screen.Height);
  Result := vWidth + ' x ' + vHeigth;
end;

class function TDMInfoComputer.GetSerialDisk(Disk: string): string;
{
  var
  s: pwidechar; }
begin
  Result := sCST_EmptyStr;
  // GetHDDSerialN(0,s);
  // Result := s;
end;

class function TDMInfoComputer.GetSerialMotherboard: string;
var
  a, b, c, d: LongWord;
begin
  asm
    push EAX
    push EBX
    push ECX
    push EDX

    mov eax, 1
    db $0F, $A2
    mov a, EAX
    mov b, EBX
    mov c, ECX
    mov d, EDX

    pop EDX
    pop ECX
    pop EBX
    pop EAX

    {
    mov eax, 1
    db $0F, $A2
    mov a, EAX
    mov b, EBX
    mov c, ECX
    mov d, EDX
     }
  end;
  Result := IntToHex(a, 8) + '-' + IntToHex(b, 8) + '-' + IntToHex(c, 8) + '-' +
    IntToHex(d, 8);

  { var
    a, b, c, d: LongWord;
    begin
    asm
    push EAX
    push EBX
    push ECX
    push EDX

    mov eax, 1
    db $0F, $A2
    mov a, EAX
    mov b, EBX
    mov c, ECX
    mov d, EDX

    pop EDX
    pop ECX
    pop EBX
    pop EAX

    end;
    result := inttohex(a, 8) + '-' +
    inttohex(b, 8) + '-' +
    inttohex(c, 8) + '-' +
    inttohex(d, 8);
  }
end;

class function TDMInfoComputer.GetSO: string;
var
  vPlatformId: string;
begin
  Result := vPlatformId;
  case Win32Platform of
    VER_PLATFORM_WIN32_WINDOWS:
      Result := GetFamilyWindowsSO;
    VER_PLATFORM_WIN32_NT:
      Result := GetFamilyNTSO;
  end;
end;

class function TDMInfoComputer.GetUserIsAdmin: Boolean;
const
   SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0, 0, 0, 0, 0, 5)) ;
   SECURITY_BUILTIN_DOMAIN_RID = $00000020;
   DOMAIN_ALIAS_RID_ADMINS = $00000220;
var
   hAccessToken: THandle;
   ptgGroups: PTokenGroups;
   dwInfoBufferSize: DWORD;
   psidAdministrators: PSID;
   nIndex: Integer;
   bSuccess: BOOL;
begin
  Result := False;

  bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True, hAccessToken) ;
  if not bSuccess then
  begin
    if GetLastError = ERROR_NO_TOKEN then
      bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, hAccessToken) ;
  end;

  if not bSuccess then
    Exit;
  GetMem(ptgGroups, 1024) ;
  try
    bSuccess := GetTokenInformation(hAccessToken, TokenGroups, ptgGroups, 1024, dwInfoBufferSize) ;
    CloseHandle(hAccessToken);

    if not bSuccess then
      Exit;

    AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2, SECURITY_BUILTIN_DOMAIN_RID, DOMAIN_ALIAS_RID_ADMINS, 0, 0, 0, 0, 0, 0, psidAdministrators) ;
    try
      for nIndex := 0 to ptgGroups.GroupCount - 1 do
      begin
        if EqualSid(psidAdministrators, ptgGroups.Groups[nIndex].Sid) then
        begin
          Result := True;
          Break;
        end;
      end;
    finally
      FreeSid(psidAdministrators);
    end;
  finally
    FreeMem(ptgGroups);
  end;
end;

class function TDMInfoComputer.GetUsers(const psServer: string): TStringList;
type
  TUserInfoArr = array[0..(MaxInt - 4) div SizeOf(TUserInfo0)] of TUserInfo0;
var
  UserInfo: Pointer;
  EntriesRead, TotalEntries, ResumeHandle: DWORD;
  Res: DWORD;
  i: Integer;
  FServer : WideString;
begin
  Result := TStringList.Create;
  FServer :=  psServer;
  ResumeHandle := 0;
  repeat
    Res := NetUserEnum(PWideChar(FServer), 0, 0, UserInfo,
                       64 * SizeOf(TUserInfo0),
                       EntriesRead, TotalEntries, @ResumeHandle);
    if (Res = NERR_SUCCESS) or (Res = ERROR_MORE_DATA) then
    begin
      for i := 0 to EntriesRead - 1 do
        Result.Add(TUserInfoArr(UserInfo^)[i].usri0_name);
      NetApiBufferFree(UserInfo);
    end;
  until Res <> ERROR_MORE_DATA;
end;

class function TDMInfoComputer.GetBiosInfo: string;
begin
  Result := sCST_EmptyStr; // GetRegInfoWinNT;
end;

class function TDMInfoComputer.GetWindowsKey: string;
var
  Reg: TRegistry;
  binarySize: Integer;
  HexBuf: array of Byte;
  PN, PID: string;
begin
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if not(Reg.OpenKeyReadOnly('\SOFTWARE\Microsoft\Windows NT\CurrentVersion')
      and (Reg.GetDataType('DigitalProductId') = rdBinary)) then
      Exit;

    PN := (Reg.ReadString('ProductName'));
    PID := (Reg.ReadString('ProductID'));
    binarySize := Reg.GetDataSize('DigitalProductId');
    SetLength(HexBuf, binarySize);
    if binarySize > 0 then
      Reg.ReadBinaryData('DigitalProductId', HexBuf[0], binarySize);
  finally
    FreeAndNil(Reg);
  end;

  Result := DecodeProductKey(HexBuf);
end;

class function TDMInfoComputer.DecodeProductKey(const HexSrc
  : array of Byte): string;
const
  StartOffset: Integer = $34; { //Offset 34 = Array[52] }
  EndOffset: Integer = $34 + 15; { //Offset 34 + 15(Bytes) = Array[64] }
  Digits: array [0 .. 23] of Char = ('B', 'C', 'D', 'F', 'G', 'H', 'J', 'K',
    'M', 'P', 'Q', 'R', 'T', 'V', 'W', 'X', 'Y', '2', '3', '4', '6', '7',
    '8', '9');
  dLen: Integer = 29; { //Length of Decoded Product Key }
  sLen: Integer = 15;
  { //Length of Encoded Product Key in Bytes (An total of 30 in chars) }
var
  HexDigitalPID: array of Cardinal;
  Des: array of Char;
  I, N: Integer;
  HN, Value: Cardinal;
begin
  SetLength(HexDigitalPID, dLen);
  for I := StartOffset to EndOffset do
  begin
    HexDigitalPID[I - StartOffset] := HexSrc[I];
  end;

  SetLength(Des, dLen + 1);

  for I := dLen - 1 downto 0 do
  begin
    if (((I + 1) mod 6) = 0) then
      Des[I] := '-'
    else
    begin
      HN := 0;
      for N := sLen - 1 downto 0 do
      begin
        Value := (HN shl 8) or HexDigitalPID[N];
        HexDigitalPID[N] := Value div 24;
        HN := Value mod 24;
      end;
      Des[I] := Digits[HN];
    end;
  end;
  Des[dLen] := Chr(0);

  for I := 0 to length(Des) do
  begin
    Result := Result + Des[I];
  end;
end;

end.
