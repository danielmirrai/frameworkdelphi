{***********************************************************}
{                                                           }
{                Developed by Daniel Mirrai                 }
{                                                           }
{                Senior Delphi Programmer                   }
{               E-mail: danielmirrai@gmail.com              }
{                   Skype: danielmirrai                     }
{          Phones: +55 (51) 9413-3725 / 3111-2388           }
{         http://www.linkedin.com/in/danielmirrai           }
{          https://www.facebook.com/danielmirrai            }
{                   www.danielmirrai.com                    }
{***********************************************************}

unit uDMUtilsVariant;

interface
uses
  SysUtils, Variants;

type
  TDMUtilsVariant = class
  public
    class function VariantToStr(poValue: Variant): string;
    class function VariantToInt(poValue: Variant): Integer;
    class function FormatValue(poValue: Variant): string;
  end;
implementation

uses uDMUtils;

{ TDMUtilsVariant }

class function TDMUtilsVariant.FormatValue(poValue: Variant): string;
begin
  if (VarIsNull(poValue) or VarIsEmpty(poValue)) then
    Result := ''
  else
  begin
    case TVarData(poValue).VType of
      varSmallInt,
        varInteger: Result := FormatFloat('###,##0', poValue);
      varSingle,
        varDouble,
        varCurrency: Result := FormatFloat('###,##0.00', poValue);
      varDate: Result := FormatDateTime('DD/MM/YYYY', poValue);
      varBoolean:
        begin
          if poValue then
            Result := '0'
          else
            Result := '1';
        end;
      varString: Result := poValue;
    else
      Result := poValue;
    end;
  end;
end;

class function TDMUtilsVariant.VariantToInt(poValue: Variant): Integer;
begin
  if (VarIsNull(poValue) or VarIsEmpty(poValue)) then
    Result := 0
  else
  begin
    case TVarData(poValue).VType of
      varSmallInt,
        varInteger: Result := poValue;
      varSingle,
        varDouble,
        varCurrency: Result := TDMUtils.FloatToInt2(poValue);
      varDate: Result := poValue;
      varBoolean:
        begin
          if poValue then
            Result := 0
          else
            Result := 1;
        end;
      varString: Result := TDMUtils.Strtoint2(poValue);
    else
      Result := poValue;
    end;
  end;
end;

class function TDMUtilsVariant.VariantToStr(poValue: Variant): string;
begin
  if (VarIsNull(poValue) or VarIsEmpty(poValue)) then
    Result := ''
  else
  begin
    case TVarData(poValue).VType of
      varSmallInt,
        varInteger: Result := IntToStr(poValue);
      varSingle,
        varDouble,
        varCurrency: Result := FloatToStr(poValue);
      varDate: Result := FormatDateTime('dd/mm/yyyy', poValue);
      varBoolean:
        begin
          if poValue then
            Result := 'T'
          else
            Result := 'F';
        end;
      varString: Result := poValue;
    else
      Result := poValue;
    end;
  end;
end;

end.
