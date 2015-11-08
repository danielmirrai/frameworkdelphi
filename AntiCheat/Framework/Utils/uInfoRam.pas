unit uInfoRam;

interface
uses
  Windows;
type
  TWinVersion = (wvUnknown, wv95, wv98, wv98SE, wvNT,
    wvME, wv2000, wvXP, wvVista, wv2003, wv7);

  TMemoryStatusEx = record
    dwLength: DWORD;
    dwMemoryLoad: DWORD;
    ullTotalPhys: Int64;
    ullAvailPhys: Int64;
    ullTotalPageFile: Int64;
    ullAvailPageFile: Int64;
    ullTotalVirtual: Int64;
    ullAvailVirtual: Int64;
    ullAvailExtendedVirtual: Int64;
  end;

  function GetWinVersion: TWinVersion;
  function GetTotalRAM: Int64;
  function GetGlobalMemoryRecord: TMemoryStatusEx;
implementation

function GetWinVersion: TWinVersion;
var
  osVerInfo: TOSVersionInfo;
  majorVersion, minorVersion: Integer;
begin
  Result := wvUnknown;
  osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  if GetVersionEx(osVerInfo) then
  begin
    minorVersion := osVerInfo.dwMinorVersion;
    majorVersion := osVerInfo.dwMajorVersion;
    case osVerInfo.dwPlatformId of
      VER_PLATFORM_WIN32_NT:
      begin
        if majorVersion <= 4 then
          Result := wvNT
        else if (majorVersion = 5) and (minorVersion = 0) then
          Result := wv2000
        else if (majorVersion = 5) and (minorVersion = 1) then
          Result := wvXP
        else if (majorVersion = 5) and (minorVersion = 2) then
          Result := wv2003
        else if (majorVersion = 6) then
          Result := wvVista
        else if (majorVersion = 7) then
          Result := wv7;
      end;
      VER_PLATFORM_WIN32_WINDOWS:
      begin
        if (majorVersion = 4) and (minorVersion = 0) then
          Result := wv95
        else if (majorVersion = 4) and (minorVersion = 10) then
        begin
          if osVerInfo.szCSDVersion[1] = 'A' then
            Result := wv98SE
          else
            Result := wv98;
        end
        else if (majorVersion = 4) and (minorVersion = 90) then
          Result := wvME
        else
          Result := wvUnknown;
      end;
    end;
  end;
end;

function GetGlobalMemoryRecord: TMemoryStatusEx;
type
  TGlobalMemoryStatusEx = procedure(var lpBuffer: TMemoryStatusEx); stdcall;
var
  ms : TMemoryStatus;
  h : THandle;
  gms : TGlobalMemoryStatusEx;
begin
  Result.dwLength := SizeOf(Result);
  if GetWinVersion in [wvUnknown, wv95, wv98, wv98SE, wvNT, wvME] then
  begin
    ms.dwLength := SizeOf(ms);
    GlobalMemoryStatus(ms);
    Result.dwMemoryLoad := ms.dwMemoryLoad;
    Result.ullTotalPhys := ms.dwTotalPhys;
    Result.ullAvailPhys := ms.dwAvailPhys;
    Result.ullTotalPageFile := ms.dwTotalPageFile;
    Result.ullAvailPageFile := ms.dwAvailPageFile;
    Result.ullTotalVirtual := ms.dwTotalVirtual;
    Result.ullAvailVirtual := ms.dwAvailVirtual;
  end
  else
  begin
    h := LoadLibrary(kernel32);
    try
      if h <> 0 then
      begin
        @gms := GetProcAddress(h, 'GlobalMemoryStatusEx');
        if @gms <> nil then
          gms(Result);
      end;
    finally
      FreeLibrary(h);
    end;
  end;
end;

function GetTotalRAM: Int64;
begin
  Result := GetGlobalMemoryRecord.ullTotalPhys;
end;
end.
