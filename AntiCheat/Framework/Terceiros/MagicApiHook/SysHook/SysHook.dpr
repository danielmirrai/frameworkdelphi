library SysHook;

uses Windows, MagicApiHook;

var
 DllName: string='SysHook.dll';
 DllPath: array[0..255] of Char;

 MainCreateProcessInternalW: function(P1:DWORD; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes,lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation; P2:DWORD):BOOL; stdcall;
 MainCreateProcessAsUserA: function(hToken:THandle; lpApplicationName:PAnsiChar; lpCommandLine:PAnsiChar; lpProcessAttributes:PSecurityAttributes; lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PAnsiChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation):BOOL; stdcall;
 MainCreateProcessAsUserW: function(hToken:THandle; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes:PSecurityAttributes; lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation):BOOL; stdcall;

(******************************************************************************)
function GetModule(S:string):string;
begin
 Result:=S;
 if S='' then Exit;
 if S[1]='"' then begin
  Delete(S,1,1);
  if S='' then Exit;
  Result:=Copy(S,1,Pos('"',S)-1);
 end
 else if Pos(' ',S)<>0 then Result:=Copy(S,1,Pos(' ',S)-1);
end;
(******************************************************************************)
function HookCreateProcessInternalW(P1:DWORD; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes,lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation; P2:DWORD):BOOL; stdcall;
var
 CrSuspend,Debuged: Boolean;
 S1,S2: string;
begin
 Debuged:=((dwCreationFlags and DEBUG_PROCESS)=DEBUG_PROCESS) or
          ((dwCreationFlags and DEBUG_ONLY_THIS_PROCESS)=DEBUG_ONLY_THIS_PROCESS);
 if (P1=0) and (P2=0) and (not Debuged) then begin
  S1:=GetModule(WideToStr(lpApplicationName));
  S2:=GetModule(WideToStr(lpCommandLine));
  if (S1<>'') and (Pos('Microsoft',GetFileInfo(S1,'CompanyName'))=0) then begin
    Result:=False;
    SetLastError(ERROR_ACCESS_DENIED);
    Exit;
  end;
  if (S2<>'') and (Pos('Microsoft',GetFileInfo(S2,'CompanyName'))=0) then begin
    Result:=False;
    SetLastError(ERROR_ACCESS_DENIED);
    Exit;
  end;
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
 S1,S2: string;
begin
 S1:=GetModule(string(lpApplicationName));
 S2:=GetModule(string(lpCommandLine));
 if (S1<>'') and (Pos('Microsoft',GetFileInfo(S1,'CompanyName'))=0) then begin
   Result:=False;
   SetLastError(ERROR_ACCESS_DENIED);
   Exit;
 end;
 if (S2<>'') and (Pos('Microsoft',GetFileInfo(S2,'CompanyName'))=0) then begin
   Result:=False;
   SetLastError(ERROR_ACCESS_DENIED);
   Exit;
 end;
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
 S1,S2: string;
begin
 S1:=GetModule(WideToStr(lpApplicationName));
 S2:=GetModule(WideToStr(lpCommandLine));
 if (S1<>'') and (Pos('Microsoft',GetFileInfo(S1,'CompanyName'))=0) then begin
   Result:=False;
   SetLastError(ERROR_ACCESS_DENIED);
   Exit;
 end;
 if (S2<>'') and (Pos('Microsoft',GetFileInfo(S2,'CompanyName'))=0) then begin
   Result:=False;
   SetLastError(ERROR_ACCESS_DENIED);
   Exit;
 end;
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
     ApiHook('kernel32.dll','CreateProcessInternalW',nil,@HookCreateProcessInternalW,@MainCreateProcessInternalW);
     ApiHook('advapi32.dll','CreateProcessAsUserA',nil,@HookCreateProcessAsUserA,@MainCreateProcessAsUserA);
     ApiHook('advapi32.dll','CreateProcessAsUserW',nil,@HookCreateProcessAsUserW,@MainCreateProcessAsUserW);
     GetModuleFileName(GetModuleHandle(Pchar(DllName)),DllPath,SizeOf(DllPath));
   end;
   DLL_PROCESS_DETACH: begin
     ApiUnHook('kernel32.dll','CreateProcessInternalW',nil,@HookCreateProcessInternalW,@MainCreateProcessInternalW);
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

