library HookExplorer;

uses Windows, MagicApiHook;

var

 MainCreateProcessInternalW: function(P1:DWORD; lpApplicationName:PWideChar; lpCommandLine:PWideChar; lpProcessAttributes,lpThreadAttributes:PSecurityAttributes; bInheritHandles:BOOL; dwCreationFlags:DWORD; lpEnvironment:Pointer; lpCurrentDirectory:PWideChar; const lpStartupInfo:TStartupInfo; var lpProcessInformation:TProcessInformation; P2:DWORD):BOOL; stdcall;

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
 S1,S2: string;
begin
 S1:=GetModule(WideToStr(lpApplicationName));
 S2:=GetModule(WideToStr(lpCommandLine));
 if (Pos('CALC.EXE',UpCaseStr(S1))<>0) or (Pos('CALC.EXE',UpCaseStr(S2))<>0) then begin
  MessageBox(0,'Try to Run Calc.exe by Explorer?!','MagicHookEngine',MB_ICONINFORMATION);
 end;
 Result:=MainCreateProcessInternalW(P1,lpApplicationName,lpCommandLine,lpProcessAttributes,lpThreadAttributes,bInheritHandles,dwCreationFlags,lpEnvironment,lpCurrentDirectory,lpStartupInfo,lpProcessInformation,P2);
end;
(******************************************************************************)
procedure DLLEntryPoint(dwReason:DWORD);
begin
 case dwReason of
   DLL_PROCESS_ATTACH: begin
     ApiHook('kernel32.dll','CreateProcessInternalW',nil,@HookCreateProcessInternalW,@MainCreateProcessInternalW);
   end;
   DLL_PROCESS_DETACH: begin
     ApiUnHook('kernel32.dll','CreateProcessInternalW',nil,@HookCreateProcessInternalW,@MainCreateProcessInternalW);
   end;
 end;
end;
(******************************************************************************)
begin
 DllProc:=@DLLEntryPoint;
 DLLEntryPoint(DLL_PROCESS_ATTACH);
end.

