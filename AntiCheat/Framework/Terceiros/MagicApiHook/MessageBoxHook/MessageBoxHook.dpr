program MessageBoxHook;

uses Windows, MagicApiHook;

var
 MainMessageBoxA: function(hWnd:HWND; lpText,lpCaption:PAnsiChar; uType:UINT):Integer; stdcall;

(******************************************************************************)
function HookMessageBoxA(hWnd:HWND; lpText,lpCaption:PAnsiChar; uType:UINT):Integer; stdcall;
begin
 Result:=MainMessageBoxA(hWnd,'Hooked MessageBox',lpCaption,uType);
end;
(******************************************************************************)
begin
 MessageBox(0,'Message1','Message',MB_ICONINFORMATION);
 ApiHook('user32.dll','MessageBoxA',nil,@HookMessageBoxA,@MainMessageBoxA);
 MessageBox(0,'Message1','Message',MB_ICONINFORMATION);
 MainMessageBoxA(0,'Message1','Message',MB_ICONINFORMATION);
 ApiUnHook('user32.dll','MessageBoxA',nil,@HookMessageBoxA,@MainMessageBoxA);
 MessageBox(0,'Message1','Message',MB_ICONINFORMATION);
end.
