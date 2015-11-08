unit uFrameworkRegister;

interface

uses Windows, Classes, SysUtils, uFrameLookupModel;
procedure Register;
implementation

procedure Register;
begin
  RegisterComponents('FrameLookupDM',[TFrameLookupModel]);
end;
end.
