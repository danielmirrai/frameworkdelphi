program Loader;

uses Windows, MagicApiHook;

var
 Dllname:string='HookExplorer.dll';

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
 if InjectDll(GetPath(ParamStr(0))+DllName,GetExplorerPID) then
   MessageBox(0,'Hook Explorer Installed...'#13#10+
                'Now try to run Calc.exe'#13#10#13#10+
                'Press OK to UnInstall Hook...','Success... Magic_h2001',MB_ICONINFORMATION)
 else
   MessageBox(0,'Hook Error...'#13#10'Maybe uses Antivirus or Firewall',
              'Error... Magic_h2001',MB_ICONERROR);
 UnInjectDll(GetPath(ParamStr(0))+DllName,GetExplorerPID);
end.
