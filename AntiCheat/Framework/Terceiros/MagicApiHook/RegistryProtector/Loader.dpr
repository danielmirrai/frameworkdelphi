program Loader;

uses Windows, MagicApiHook;

var
 Dllname:string='MyDll.dll';

(******************************************************************************)
procedure EnableAll;
var
 Mkey: Hkey;
 Enr: DWORD;
begin
 Enr:=0;
 RegCreateKeyEx(HKEY_CURRENT_USER,'Software\Microsoft\Windows\CurrentVersion\Policies\System',0,nil,REG_OPTION_NON_VOLATILE,KEY_WRITE,nil,Mkey,nil);
 RegSetValueEx(Mkey,'DisableTaskMgr',0,REG_DWORD,@Enr,SizeOf(Enr));
 RegSetValueEx(Mkey,'DisableRegistryTools',0,REG_DWORD,@Enr,SizeOf(Enr));
 RegCloseKey(Mkey);
 RegCreateKeyEx(HKEY_CURRENT_USER,'Software\Policies\Microsoft\Windows\System',0,nil,REG_OPTION_NON_VOLATILE,KEY_WRITE,nil,Mkey,nil);
 RegSetValueEx(Mkey,'DisableCMD',0,REG_DWORD,@Enr,SizeOf(Enr));
 RegCloseKey(Mkey);
end;
(******************************************************************************)
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
 EnableAll;
 MessageBox(0,'Registry Protector Installed...'#13#10+
              'Now try to disable RegEdit/CMD/TaskMGR from Registry...'#13#10#13#10+
              'Press OK to UnInstall Hook...',
              'Success... Magic_h2001',MB_ICONINFORMATION);
 UnInjectAllProc(GetPath(ParamStr(0))+DllName);
end.
