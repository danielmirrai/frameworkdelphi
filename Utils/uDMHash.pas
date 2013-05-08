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

unit uDMHash;

interface
uses
  uConstantUtils;
  
type
  TDMHash = class
  private
    FText: string;
  public
    procedure Add(aFieldValue: string); overload;
    procedure Add(aFieldValue: Integer); overload;
    function GetHash: string;
    procedure AfterConstruction; override;

  end;
implementation

uses uDMUtils, MD5;

{ TDMHash }

procedure TDMHash.Add(aFieldValue: string);
begin
  if not TDMUtils.IsEmpty(FText) then
    FText := FText + '!';

  FText := FText + aFieldValue;
end;

procedure TDMHash.Add(aFieldValue: Integer);
begin
  Add(TDMUtils.IntToStr2(aFieldValue));
end;

procedure TDMHash.AfterConstruction;
begin
  inherited;
  FText := sCST_EmptyStr;
end;

function TDMHash.GetHash: string;
begin
  Result := MD5DigestToStr(MD5String(FText));
end;

end.
