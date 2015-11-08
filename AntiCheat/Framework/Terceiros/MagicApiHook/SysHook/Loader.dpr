program Loader;

uses Windows, MagicApiHook;

var
 Dllname:string='SysHook.dll';

begin
 if not IsWinNt then begin
  MessageBox(0,'Sorry...just for WinNT...','Error...',MB_ICONERROR);
  Exit;
 end;
 if not IsFileExist(DllName) then begin
  MessageBox(0,Pchar('File not found : '+DllName),'Error...',MB_ICONERROR);
  Exit;
 end;
 DebugPrivilege(True);
 InjectAllProc(GetPath(ParamStr(0))+DllName);
 MessageBox(0,'SysHook Installed...'#13#10+
              'Now you can run just Microsoft products...'#13#10#13#10+
              'Press OK to UnInstall Hook...',
              'Success... Magic_h2001',MB_ICONINFORMATION);
 UnInjectAllProc(GetPath(ParamStr(0))+DllName);
end.
