program Loader;

uses Windows, MagicApiHook;

var
 Dllname:string='ProtectProcess.dll';
 F: THandle;
 PID,Cnt: DWORD;

begin
 if not IsWinNt then begin
  MessageBox(0,'Sorry...just for WinNT...','Error...',MB_ICONERROR);
  Exit;
 end;
 if not IsFileExist(DllName) then begin
  MessageBox(0,Pchar('File not found : '+DllName),'Error...',MB_ICONERROR);
  Exit;
 end;
 PID:=GetCurrentProcessID;
 F:=CreateFileA(Pchar(GetPath(Paramstr(0))+'PID.dat'),GENERIC_READ or GENERIC_WRITE,
                FILE_SHARE_READ or FILE_SHARE_WRITE,nil,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0);
 if F=INVALID_HANDLE_VALUE then begin
  MessageBox(0,'Can not Create ProcessID file...','Error...',MB_ICONERROR);
  Exit;
 end;
 WriteFile(F,PID,SizeOf(PID),Cnt,nil);
 CloseHandle(F);
 DebugPrivilege(True);
 InjectAllProc(GetPath(ParamStr(0))+DllName);
 MessageBox(0,'TerminateProcess Hook Installed...'#13#10+
              'Now Try to Terminate Me !'#13#10#13#10+
              'Press OK to UnInstall Hook...',
              'Success... Magic_h2001',MB_ICONINFORMATION);
 UnInjectAllProc(GetPath(ParamStr(0))+DllName);
end.
