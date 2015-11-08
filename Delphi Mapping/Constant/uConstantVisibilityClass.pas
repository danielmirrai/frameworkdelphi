unit uConstantVisibilityClass;

interface

uses
  SysUtils, TypInfo, uConstantTrack, uConstantUtils;

type
  TpVisibleClass = (tvSTRICT_PROTECTED, tvSTRICT_PRIVATE, tvPRIVATE,
    tvPROTECTED, tvPUBLIC, tvPUBLISHED);

  /// <summary>
  /// Constante da classe delphi
  /// </summary>
  TConstantVisibilityClass = class
  public
    class function GetDescVisible(ptVisibleClass: TpVisibleClass): string;
  end;

implementation

{ TConstantVisibilityClass }

class function TConstantVisibilityClass.GetDescVisible(ptVisibleClass
  : TpVisibleClass): string;
begin
  Result := GetEnumName(TypeInfo(TpVisibleClass), Integer(ptVisibleClass));
  Result := Copy(Result, 3, Length(Result));
  Result := StringReplace(Result, '_', sCST_Space, [rfReplaceAll]);
end;

end.
