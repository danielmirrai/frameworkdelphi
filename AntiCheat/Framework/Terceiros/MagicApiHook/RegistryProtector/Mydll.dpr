library MyDll;

uses Windows, MagicApiHook;

var
 DllName: string='MyDll.dll';
 DllPath: array[0..255] of Char;

 MainCreateProcessInternalW: function(P1:DWORD; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes,lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation; P2:DWORD):BOOL; stdcall;
 MainCreateProcessAsUserA: function(hToken:THandle; lpApplicationName:PAnsiChar; lpCommandLine:PAnsiChar; lpProcessAttributes:PSecurityAttributes; lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PAnsiChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation):BOOL; stdcall;
 MainCreateProcessAsUserW: function(hToken:THandle; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes:PSecurityAttributes; lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation):BOOL; stdcall;
 MainRegSetValueExA: function(hKey:HKEY; lpValueName:PAnsiChar; Reserved:DWORD; dwType:DWORD; lpData:Pointer; cbData:DWORD):Longint; stdcall;
 MainRegSetValueExW: function(hKey:HKEY; lpValueName:PWideChar; Reserved:DWORD; dwType:DWORD; lpData:Pointer; cbData:DWORD):Longint; stdcall;

(******************************************************************************)
function HookCreateProcessInternalW(P1:DWORD; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes,lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation; P2:DWORD):BOOL; stdcall;
var
 CrSuspend,Debuged: Boolean;
begin
 Debuged:=((dwCreationFlags and DEBUG_PROCESS)=DEBUG_PROCESS) or
          ((dwCreationFlags and DEBUG_ONLY_THIS_PROCESS)=DEBUG_ONLY_THIS_PROCESS);
 if (P1=0) and (P2=0) and (not Debuged) then begin
  CrSuspend:=((dwCreationFlags and CREATE_SUSPENDED)=CREATE_SUSPENDED);
  dwCreationFlags:=dwCreationFlags or CREATE_SUSPENDED;
  Result:=MainCreateProcessInternalW(P1,lpApplicationName,lpCommandLine,lpProcessAttributes,lpThreadAttributes,bInheritHandles,dwCreationFlags,lpEnvironment,lpCurrentDirectory,lpStartupInfo,lpProcessInformation,P2);
  InjectDll(DllPath,lpProcessInformation.dwProcessId);
  if not CrSuspend then ResumeThread(lpProcessInformation.hThread);
 end
 else Result:=MainCreateProcessInternalW(P1,lpApplicationName,lpCommandLine,lpProcessAttributes,lpThreadAttributes,bInheritHandles,dwCreationFlags,lpEnvironment,lpCurrentDirectory,lpStartupInfo,lpProcessInformation,P2);
end;
(******************************************************************************)
function HookCreateProcessAsUserA(hToken:THandle; lpApplicationName:PAnsiChar; lpCommandLine:PAnsiChar; lpProcessAttributes:PSecurityAttributes; lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PAnsiChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation):BOOL; stdcall;
var 
 CrSuspend: Boolean;
begin
 CrSuspend:=((dwCreationFlags and CREATE_SUSPENDED)=CREATE_SUSPENDED);
 dwCreationFlags:=dwCreationFlags or CREATE_SUSPENDED;
 Result:=MainCreateProcessAsUserA(hToken,lpApplicationName,lpCommandLine,lpProcessAttributes,lpThreadAttributes,bInheritHandles,dwCreationFlags,lpEnvironment,lpCurrentDirectory,lpStartupInfo,lpProcessInformation);
 InjectDll(DllPath,lpProcessInformation.dwProcessId);
 if not CrSuspend then ResumeThread(lpProcessInformation.hThread);
end;
(******************************************************************************)
function HookCreateProcessAsUserW(hToken:THandle; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes:PSecurityAttributes; lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation):BOOL; stdcall;
var 
 CrSuspend: Boolean;
begin
 CrSuspend:=((dwCreationFlags and CREATE_SUSPENDED)=CREATE_SUSPENDED);
 dwCreationFlags:=dwCreationFlags or CREATE_SUSPENDED;
 Result:=MainCreateProcessAsUserW(hToken,lpApplicationName,lpCommandLine,lpProcessAttributes,lpThreadAttributes,bInheritHandles,dwCreationFlags,lpEnvironment,lpCurrentDirectory,lpStartupInfo,lpProcessInformation);
 InjectDll(DllPath,lpProcessInformation.dwProcessId);
 if not CrSuspend then ResumeThread(lpProcessInformation.hThread);
end;
(******************************************************************************)
function HookRegSetValueExA(hKey: HKEY; lpValueName: PAnsiChar; Reserved: DWORD; dwType: DWORD; lpData: Pointer; cbData: DWORD): Longint; stdcall;
var S:string;
begin
 S:=string(lpValueName);
 if (StrCmp(S,'DisableTaskMgr') or StrCmp(S,'DisableRegistryTools') or
     StrCmp(S,'DisableCMD')) and (DWORD(lpData^)>=1) then DWORD(lpData^):=0;
 Result:=MainRegSetValueExA(hKey,lpValueName,Reserved,dwType,lpData,cbData);
end;
(******************************************************************************)
function HookRegSetValueExW(hKey: HKEY; lpValueName: PWideChar; Reserved: DWORD; dwType: DWORD; lpData: Pointer; cbData: DWORD): Longint; stdcall;
var S:string;
begin
 S:=WideToStr(lpValueName);
 if (StrCmp(S,'DisableTaskMgr') or StrCmp(S,'DisableRegistryTools') or
     StrCmp(S,'DisableCMD')) and (DWORD(lpData^)>=1) then DWORD(lpData^):=0;
 Result:=MainRegSetValueExW(hKey,lpValueName,Reserved,dwType,lpData,cbData);
end;
(******************************************************************************)
procedure DLLEntryPoint(dwReason:DWORD);
begin
 case dwReason of
   DLL_PROCESS_ATTACH: begin
     ApiHook('kernel32.dll','CreateProcessInternalW',nil,@HookCreateProcessInternalW,@MainCreateProcessInternalW);
     ApiHook('advapi32.dll','CreateProcessAsUserA',nil,@HookCreateProcessAsUserA,@MainCreateProcessAsUserA);
     ApiHook('advapi32.dll','CreateProcessAsUserW',nil,@HookCreateProcessAsUserW,@MainCreateProcessAsUserW);
     ApiHook('advapi32.dll','RegSetValueExA',nil,@HookRegSetValueExA,@MainRegSetValueExA);
     ApiHook('advapi32.dll','RegSetValueExW',nil,@HookRegSetValueExW,@MainRegSetValueExW);
     GetModuleFileName(GetModuleHandle(Pchar(DllName)),DllPath,SizeOf(DllPath));
   end;
   DLL_PROCESS_DETACH: begin
     ApiUnHook('kernel32.dll','CreateProcessInternalW',nil,@HookCreateProcessInternalW,@MainCreateProcessInternalW);
     ApiUnHook('advapi32.dll','CreateProcessAsUserA',nil,@HookCreateProcessAsUserA,@MainCreateProcessAsUserA);
     ApiUnHook('advapi32.dll','CreateProcessAsUserW',nil,@HookCreateProcessAsUserW,@MainCreateProcessAsUserW);
     ApiUnHook('advapi32.dll','RegSetValueExA',nil,@HookRegSetValueExA,@MainRegSetValueExA);
     ApiUnHook('advapi32.dll','RegSetValueExW',nil,@HookRegSetValueExW,@MainRegSetValueExW);
   end;
 end;
end;
(******************************************************************************)
begin
 DllProc:=@DLLEntryPoint;
 DLLEntryPoint(DLL_PROCESS_ATTACH);
end.

