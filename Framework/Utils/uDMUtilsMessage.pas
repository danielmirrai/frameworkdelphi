{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Senior Delphi Programmer }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Phones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ www.danielmirrai.com }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }

unit uDMUtilsMessage;

interface

uses
  Forms, uConstantUtils, Windows;

type
  TDMUtilsMessage = class
  private

  public
    class procedure ShowMessageOk(const psMessage: string);
    class procedure ShowMessageError(const psMessage: string);
    class procedure ShowMessageAlert(const psMessage: string);
  end;

implementation

{ TDMUtilsMessage }

class procedure TDMUtilsMessage.ShowMessageAlert(const psMessage: string);
begin
  Application.MessageBox(PChar(psMessage),
    PChar(sCST_NameProject + sCST_TraceSpaces + sCST_Alert),
    mb_ok + MB_ICONWARNING);
end;

class procedure TDMUtilsMessage.ShowMessageError(const psMessage: string);
begin
  Application.MessageBox(PChar(psMessage),
    PChar(sCST_NameProject + sCST_TraceSpaces + sCST_Error),
    mb_ok + MB_ICONERROR);
end;

class procedure TDMUtilsMessage.ShowMessageOk(const psMessage: string);
begin
  Application.MessageBox(PChar(psMessage),
    PChar(sCST_NameProject + sCST_TraceSpaces + sCST_Information),
    mb_ok + MB_ICONINFORMATION);
end;

end.
