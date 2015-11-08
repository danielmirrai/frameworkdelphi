library ProtectProcess;

uses Windows, MagicApiHook;

var
 DllName: string='ProtectProcess.dll';
 DllPath: array[0..255] of Char;
 F: THandle;
 PID,Cnt: DWORD;

 MainZwTerminateProcess: function(hProcess: THandle; uExitCode: UINT): BOOL; stdcall;
 MainCreateProcessInternalW: function(P1:DWORD; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes,lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation; P2:DWORD):BOOL; stdcall;
 MainOpenProcess: function(dwDesiredAccess: DWORD; bInheritHandle: BOOL; dwProcessId: DWORD): THandle; stdcall;
 MainCreateProcessAsUserA: function(hToken:THandle; lpApplicationName:PAnsiChar; lpCommandLine:PAnsiChar; lpProcessAttributes:PSecurityAttributes; lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PAnsiChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation):BOOL; stdcall;
 MainCreateProcessAsUserW: function(hToken:THandle; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes:PSecurityAttributes; lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation):BOOL; stdcall;

(******************************************************************************)
function HookOpenProcess(dwDesiredAccess: DWORD; bInheritHandle: BOOL; dwProcessId: DWORD): THandle; stdcall;
begin
 if dwProcessId=PID then begin
  Result:=0;
  SetLastError(ERROR_ACCESS_DENIED);
 end
 else Result:=MainOpenProcess(dwDesiredAccess,bInheritHandle,dwProcessId);
end;
(******************************************************************************)
function HookZwTerminateProcess(hProcess: THandle; uExitCode: UINT): BOOL; stdcall;
begin
 if PHandleToPID(hProcess)=PID then begin
  Result:=False;
  SetLastError(ERROR_ACCESS_DENIED);
 end
 else Result:=MainZwTerminateProcess(hProcess,uExitCode);
end;
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
procedure DLLEntryPoint(dwReason:DWORD);
begin
 case dwReason of
   DLL_PROCESS_ATTACH: begin
     ApiHook('ntdll.dll','ZwTerminateProcess',nil,@HookZwTerminateProcess,@MainZwTerminateProcess);
     ApiHook('kernel32.dll','CreateProcessInternalW',nil,@HookCreateProcessInternalW,@MainCreateProcessInternalW);
     ApiHook('kernel32.dll','OpenProcess',nil,@HookOpenProcess,@MainOpenProcess);
     ApiHook('advapi32.dll','CreateProcessAsUserA',nil,@HookCreateProcessAsUserA,@MainCreateProcessAsUserA);
     ApiHook('advapi32.dll','CreateProcessAsUserW',nil,@HookCreateProcessAsUserW,@MainCreateProcessAsUserW);
     GetModuleFileName(GetModuleHandle(Pchar(DllName)),DllPath,SizeOf(DllPath));
     PID:=$FFFFFFFF;
     F:=CreateFileA(Pchar(GetPath(DllPath)+'PID.dat'),GENERIC_READ,FILE_SHARE_READ or
                    FILE_SHARE_WRITE,nil,OPEN_EXISTING,0,0);
     if F<>INVALID_HANDLE_VALUE then begin
      ReadFile(F,PID,SizeOf(PID),Cnt,nil);
      CloseHandle(F);
     end;
   end;
   DLL_PROCESS_DETACH: begin
     ApiUnHook('ntdll.dll','ZwTerminateProcess',nil,@HookZwTerminateProcess,@MainZwTerminateProcess);
     ApiUnHook('kernel32.dll','CreateProcessInternalW',nil,@HookCreateProcessInternalW,@MainCreateProcessInternalW);
     ApiUnHook('kernel32.dll','OpenProcess',nil,@HookOpenProcess,@MainOpenProcess);
     ApiUnHook('advapi32.dll','CreateProcessAsUserA',nil,@HookCreateProcessAsUserA,@MainCreateProcessAsUserA);
     ApiUnHook('advapi32.dll','CreateProcessAsUserW',nil,@HookCreateProcessAsUserW,@MainCreateProcessAsUserW);
   end;
 end;
end;
(******************************************************************************)
begin
 DllProc:=@DLLEntryPoint;
 DLLEntryPoint(DLL_PROCESS_ATTACH);
end.

