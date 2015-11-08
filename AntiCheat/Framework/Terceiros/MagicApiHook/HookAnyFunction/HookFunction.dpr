program HookFunction;

uses Windows, MagicApiHook;

// With this sample you can learn Hooking none Api functions (any functions)
// Magic_h2001

var
 MainMyError: function(S: string):Integer;

(******************************************************************************)
function MyError(S: string):Integer;
begin
 Result:=MessageBox(0,Pchar(S),'Error!',MB_ICONERROR);
end;
(******************************************************************************)
function HookMyError(S: string):Integer;
begin
 Result:=MainMyError('My Error function Hooked!');
end;
(******************************************************************************)
begin
 MyError('Error String');
 ApiHook(nil,nil,@MyError,@HookMyError,@MainMyError);
 MyError('Error String');
 ApiUnHook(nil,nil,@MyError,@HookMyError,@MainMyError);
 MyError('Error String');
end.
