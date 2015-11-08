unit uConstantMethod;

interface

uses TypInfo, uConstantUtils;

type
  TpTypeMethodo = (tmCLASS_FUNCTION, tmCLASS_PROCEDURE, tmFUNCTION, tmPROCEDURE,
    tmCONSTRUCTOR, tmDESTRUCTOR, tmPROPERTY);

  TConstantMethod = class
  public
    class function GetDescTypeMethod(ptTypeMethodo: TpTypeMethodo): string;
  end;

implementation

uses SysUtils;

{ TConstantMethod }

class function TConstantMethod.GetDescTypeMethod(ptTypeMethodo
  : TpTypeMethodo): string;
begin
  Result := GetEnumName(TypeInfo(TpTypeMethodo), Integer(ptTypeMethodo));
  Result := Copy(Result, 3, Length(Result));
  Result := StringReplace(Result, '_', sCST_Space, [rfReplaceAll]);
end;

end.
