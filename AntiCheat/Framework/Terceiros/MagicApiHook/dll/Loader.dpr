program Loader;

uses
  Windows,
  MagicApiHook in '..\MagicApiHook.pas';

var
 Dllname:string='ProcessHide.dll';
 sName: String;

begin
 DebugPrivilege(True);
 sName := GetPath(ParamStr(0))+DllName;
 InjectAllProc(GetPath(ParamStr(0))+DllName);
 MessageBox(0,'Aperte OK para acabar ' , '' , mb_ok);
 UnInjectAllProc(GetPath(ParamStr(0))+DllName);
end.
