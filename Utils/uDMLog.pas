{***********************************************************}
{                                                           }
{                Developed by Daniel Mirrai                 }
{                                                           }
{                Senior Delphi Programmer                   }
{             E-mail: danielmirrai@gmail.com                }
{                   Skype: danielmirrai                     }
{          Phones: +55 (51) 9413-3725 / 3111-2388           }
{         http://www.linkedin.com/in/danielmirrai           }
{          https://www.facebook.com/danielmirrai            }
{                   www.danielmirrai.com                    }
{***********************************************************}

unit uDMLog;

interface

type
  TDMLog = class
  public
    class function GetMessageError(aIDMessage: Integer): string;
    class procedure DMAssert(aIDMessage: Integer); overload;
    class procedure DMAssert(aCondition: Boolean; aIDMessage: Integer); overload;
    class procedure DMAssert(aCondition: Boolean; aMessage: string); overload;
    class procedure DMAssert(aMessage: string); overload;
  end;

implementation

{ TDMLog }

class procedure TDMLog.DMAssert(aCondition: Boolean; aMessage: string);
begin
  Assert(aCondition, aMessage);
end;

class procedure TDMLog.DMAssert(aMessage: string);
begin
  TDMLog.DMAssert(True, aMessage);
end;

class function TDMLog.GetMessageError(aIDMessage: Integer): string;
begin
  case aIDMessage of
    1: Result := 'Erro gravar';
  end;
end;

class procedure TDMLog.DMAssert(aIDMessage: Integer);
begin
  TDMLog.DMAssert(True, aIDMessage);
end;

class procedure TDMLog.DMAssert(aCondition: Boolean; aIDMessage: Integer);
begin
  Assert(aCondition, TDMLog.GetMessageError(aIDMessage));
end;

end.
