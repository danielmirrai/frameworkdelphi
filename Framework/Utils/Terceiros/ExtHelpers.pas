{By WebDelphi.ru}
unit ExtHelpers;

interface

uses System.SysUtils, System.Classes, RegularExpressions, Character,Math, DateUtils, Winapi.Windows;

type
  TInt32Helper = record helper for integer
  public
    function Equals(Value: integer):boolean;
    function ToString:string;
    function ToBoolean: boolean;
    function ToHex(Digits:integer): string;
    function Init(Value: double):integer;overload;
    function Init(Value: double; ToCeil:boolean):integer;overload;
    function Parse(const Value: string):integer;overload;
    function Parse(const Value: string; Pos: integer):integer;overload;
  end;

  TCharHelper = record helper for char
    function IsControl: boolean;
    function IsDigit: boolean;
    function IsHighSurrogate: boolean;
    function IsLetter: boolean;
    function IsLetterOrDigit: boolean;
    function IsLower: boolean;
    function IsLowSurrogate: boolean;
    function IsNumber: boolean;
    function IsPunctuation: boolean;
    function IsSeparator: boolean;
    function IsSurrogate: boolean;
    function IsSymbol: boolean;
    function IsUpper : boolean;
    function IsWhiteSpace: boolean;
    function ToLower: Char;
    function ToUpper: Char;
    function NumericValue: Double;
    function UnicodeCategory(C: Char): TUnicodeCategory;
    function Replicate(Count: integer):string;
  end;

  TDateTimeHelper = record helper for TDateTime
  private
    function MatchIndex(const DTString: string):integer;
    function ISODateTimeToDateTime(const ISODateTime: string):TDateTime;
    function SQLiteDateTimeToDateTime(const SQLiteDateTime: string):TDateTime;
  public
    function SetFromString(const ADateTimeStr: string):TDateTime;overload;
    function SetFromString(const ADateTimeStr:string; AFormat: TFormatSettings):TDateTime;overload;
    function SystemToUTC: TDateTime;
    function UTCToSystem: TDateTime;
    function ToString: string;overload;
    function ToString(AFormat: string): string;overload;
  end;

implementation

const
  cIntRegEx = '(\+?|-?)\d+';
  DateTimeRegEx: array [0..10] of string = (//2012-03-13
                                           '\d{4}\-\d{2}\-\d{2}$',
                                           //2012-03-13T15:58Z
                                           '\d{4}\-\d{2}\-\d{2}\S{1}\d{2}:\d{2}\S{1}$',
                                           //20120313T1558Z
                                           '\d{8}\S{1}\d{4}\S{1}$',
                                           //2012-03-13T00:00:00.000+07:00
                                           '\d{4}\-\d{2}\-\d{2}\S{1}\d{2}:\d{2}:\d{2}\.\d{3}(\+{1}|\-{1})\d{2}:\d{2}$',
                                           //20120417T100000
                                           '\d{8}\S{1}\d{6}$',
                                           //YYYY-MM-DD HH:MM
                                           '\d{4}\-\d{2}\-\d{2}\s{1}\d{2}:\d{2}$',
                                           //YYYY-MM-DD HH:MM:SS
                                           '\d{4}\-\d{2}\-\d{2}\s{1}\d{2}:\d{2}:\d{2}$',
                                           //YYYY-MM-DD HH:MM:SS.SSS
                                           '\d{4}\-\d{2}\-\d{2}\s{1}\d{2}:\d{2}:\d{2}\.\d{3}$',
                                           //YYYY-MM-DDTHH:MM
                                           '\d{4}\-\d{2}\-\d{2}\S{1}\d{2}:\d{2}$',
                                           //YYYY-MM-DDTHH:MM:SS
                                           '\d{4}\-\d{2}\-\d{2}\S{1}\d{2}:\d{2}:\d{2}$',
                                           //YYYY-MM-DDTHH:MM:SS.SSS
                                           '\d{4}\-\d{2}\-\d{2}\S{1}\d{2}:\d{2}:\d{2}\.\d{3}$'
                                           );

{ TInt32Helper }

function TInt32Helper.Equals(Value: integer): boolean;
begin
  Result:=Self = Value;
end;

function TInt32Helper.Parse(const Value: string):integer;
begin
  self.Parse(Value,1);
  Result:=self;
end;

function TInt32Helper.Init(Value: double):integer;
begin
  self:=Round(Value);
  Result:=self;
end;

function TInt32Helper.Init(Value: double; ToCeil: boolean):integer;
begin
  if ToCeil then
    self:=Ceil(Value)
  else
    self:=Floor(Value);
  Result:=self;
end;

function TInt32Helper.Parse(const Value: string; Pos: integer):integer;
var R:TRegEx;
    M: TMatchCollection;
begin
  R:=TRegEx.Create(cIntRegEx);
  if R.IsMatch(Value)then
    begin
      M:=R.Matches(Value);
      if M.Count>=Pos then
         self:=StrToIntDef(M.Item[pos-1].Value,-1);
    end
  else
    self:=-1;
  Result:=self;
end;

function TInt32Helper.ToBoolean: boolean;
begin
  Result:=self<0;
end;

function TInt32Helper.ToHex(Digits:integer): string;
begin
  Result:=IntToHex(self,Digits);
end;

function TInt32Helper.ToString: string;
begin
  Result:=IntToStr(Self)
end;

{ TCharHelper }

function TCharHelper.Replicate(Count: integer): string;
begin
  Result:=StringOfChar(self,Count)
end;

function TCharHelper.IsControl: boolean;
begin
  Result:=TCharacter.IsControl(self)
end;

function TCharHelper.IsDigit: boolean;
begin
  Result:=TCharacter.IsDigit(self);
end;

function TCharHelper.IsHighSurrogate: boolean;
begin
  Result:=TCharacter.IsHighSurrogate(self);
end;

function TCharHelper.IsLetter: boolean;
begin
  Result:=TCharacter.IsLetter(self);
end;

function TCharHelper.IsLetterOrDigit: boolean;
begin
  Result:=TCharacter.IsLetterOrDigit(self);
end;

function TCharHelper.IsLower: boolean;
begin
  Result:=TCharacter.IsLower(self);
end;

function TCharHelper.IsLowSurrogate: boolean;
begin
  Result:=TCharacter.IsLowSurrogate(self);
end;

function TCharHelper.IsNumber: boolean;
begin
  Result:=TCharacter.IsNumber(self);
end;

function TCharHelper.IsPunctuation: boolean;
begin
  Result:=TCharacter.IsPunctuation(self);
end;

function TCharHelper.IsSeparator: boolean;
begin
  Result:=TCharacter.IsSeparator(self);
end;

function TCharHelper.IsSurrogate: boolean;
begin
  Result:=TCharacter.IsSurrogate(self);
end;

function TCharHelper.IsSymbol: boolean;
begin
  Result:=TCharacter.IsSymbol(self);
end;

function TCharHelper.IsUpper: boolean;
begin
  Result:=TCharacter.IsUpper(self);
end;

function TCharHelper.IsWhiteSpace: boolean;
begin
  Result:=TCharacter.IsWhiteSpace(self);
end;

function TCharHelper.NumericValue: Double;
begin
  Result:=TCharacter.GetNumericValue(self)
end;

function TCharHelper.ToLower: Char;
begin
  Result:=TCharacter.ToLower(self)
end;

function TCharHelper.ToUpper: Char;
begin
  Result:=TCharacter.ToUpper(self)
end;

function TCharHelper.UnicodeCategory(C: Char): TUnicodeCategory;
begin
  Result:=TCharacter.GetUnicodeCategory(self)
end;

{ TDateTimeHelper }

function TDateTimeHelper.ISODateTimeToDateTime(
  const ISODateTime: string): TDateTime;
var
  I, Len: Integer;
  DD, MM, YY: Word;
  HH, MN, SS, ZZ: Word;
  HH1, MN1: Integer;
  TimeOffsetSign: Char;
begin
  Len := Length(ISODateTime);
  YY := StrToIntDef(copy(ISODateTime, 1, 4), 0);
  I := 5;
  if (I <= Len) and (ISODateTime[I] = '-') then
    inc(I);
  MM := StrToIntDef(copy(ISODateTime, I, 2), 0);
  inc(I, 2);
  if (I <= Len) and (ISODateTime[I] = '-') then
    inc(I);
  DD := StrToIntDef(copy(ISODateTime, I, 2), 0);
  inc(I, 2);
  HH := 0;
  MN := 0;
  SS := 0;
  ZZ := 0;
  if (I <= Len) and (ISODateTime[I] = 'T') then
  begin
    inc(I);
    HH := StrToIntDef(copy(ISODateTime, I, 2), 0);
    inc(I, 2);
    if (I <= Len) and CharInSet(ISODateTime[I], [':', '0' .. '5']) then
    begin
      if ISODateTime[I] = ':' then
        inc(I);
      MN := StrToIntDef(copy(ISODateTime, I, 2), 0);
      inc(I, 2);
      if (I <= Len) and CharInSet(ISODateTime[I], [':', '0' .. '5']) then
      begin
        if ISODateTime[I] = ':' then
          inc(I);
        SS := StrToIntDef(copy(ISODateTime, I, 2), 0);
        inc(I, 2);
        if (I <= Len) and (ISODateTime[I] = '.') then
        begin
          inc(I);
          ZZ := StrToIntDef(copy(ISODateTime, I, 3), 0);
          inc(I, 3);
        end;
      end;
    end;
  end;

  Result := EncodeDateTime(YY, MM, DD, HH, MN, SS, ZZ);

  if (I <= Len) and CharInSet(ISODateTime[I], ['Z', '+', '-']) then
  begin
    if ISODateTime[I] <> 'Z' then
    begin
      TimeOffsetSign := ISODateTime[I];
      inc(I);
      HH1 := StrToIntDef(copy(ISODateTime, I, 2), 0);
      inc(I, 2);
      if (I <= Len) and CharInSet(ISODateTime[I], [':', '0' .. '5']) then
      begin
        if ISODateTime[I] = ':' then
          inc(I);
        MN1 := StrToIntDef(copy(ISODateTime, I, 2), 0);
      end
      else
        MN1 := 0;
      if TimeOffsetSign = '+' then
      begin
        HH1 := -HH1;
        MN1 := -MN1;
      end;
      Result := IncHour(Result, HH1);
      Result := IncMinute(Result, MN1);
    end;
  end
  else Result := Result;
end;

function TDateTimeHelper.MatchIndex(const DTString: string): integer;
var
  I: Integer;
begin
  if DTString.IsEmpty then
    begin
      Result:=-1;
      Exit;
    end;
  for I := Low(DateTimeRegEx) to High(DateTimeRegEx) do
    begin
      if TRegEx.IsMatch(DTString,DateTimeRegEx[i]) then
        begin
          Result:=i;
          Exit;
        end;
    end;
end;

function TDateTimeHelper.SetFromString(const ADateTimeStr: string):TDateTime;
begin
  case MatchIndex(ADateTimeStr) of
    0..4:Self:=ISODateTimeToDateTime(ADateTimeStr);
    5..10:self:=SQLiteDateTimeToDateTime(ADateTimeStr);
    else
      self:=0;
  end;
  Result:=self;
end;

function TDateTimeHelper.SetFromString(const ADateTimeStr: string;
  AFormat: TFormatSettings): TDateTime;
begin
  Self:=StrToDateTimeDef(ADateTimeStr, 0, AFormat);
  Result:=self;
end;

function TDateTimeHelper.SQLiteDateTimeToDateTime(
  const SQLiteDateTime: string): TDateTime;
//YYYY-MM-DD HH:MM
//YYYY-MM-DD HH:MM:SS
//YYYY-MM-DD HH:MM:SS.SSS
//YYYY-MM-DDTHH:MM
//YYYY-MM-DDTHH:MM:SS
//YYYY-MM-DDTHH:MM:SS.SSS
var FormatSet: TFormatSettings;
    DTString: string;
begin
  DTString:=SQLiteDateTime.Replace('T',' ',[rfIgnoreCase]);
  FormatSet.DateSeparator:='-';
  FormatSet.TimeSeparator:=':';
  FormatSet.ShortDateFormat:='YYYY-MM-DD';
  case Length(DTString) of
    16:FormatSet.ShortTimeFormat:='HH:MM';
    19:FormatSet.ShortTimeFormat:='HH:MM:SS';
    23:FormatSet.ShortTimeFormat:='HH:MM:SS.ZZZ';
  end;
  Result:=StrToDateTime(DTString, FormatSet);
end;

function TzSpecificLocalTimeToSystemTime(lpTimeZoneInformation: PTimeZoneInformation; var lpLocalTime, lpUniversalTime: TSystemTime): BOOL; stdcall;
  external kernel32 name 'TzSpecificLocalTimeToSystemTime';
{$EXTERNALSYM TzSpecificLocalTimeToSystemTime}

function TDateTimeHelper.SystemToUTC: TDateTime;
var
  TimeZoneInf: _TIME_ZONE_INFORMATION;
  SysTime, LocalTime: TSystemTime;
begin
  if GetTimeZoneInformation(TimeZoneInf) < $FFFFFFFF then
  begin
    DatetimetoSystemTime(Self, SysTime);
    if TzSpecificLocalTimeToSystemTime(@TimeZoneInf, SysTime, LocalTime) then
      Result := SystemTimeToDateTime(LocalTime)
    else
      Result := self;
  end
  else
    Result := self;
end;

function TDateTimeHelper.ToString: string;
begin
  Result:=DateTimeToStr(self)
end;

function TDateTimeHelper.ToString(AFormat: string): string;
begin
  Result:=FormatDateTime(AFormat,self)
end;

function TDateTimeHelper.UTCToSystem: TDateTime;
var
  TimeZoneInf: _TIME_ZONE_INFORMATION;
  UTCTime, LocalTime: TSystemTime;
begin
  if GetTimeZoneInformation(TimeZoneInf) < $FFFFFFFF then
  begin
    DatetimetoSystemTime(Self, UTCTime);
    if SystemTimeToTzSpecificLocalTime(@TimeZoneInf, UTCTime, LocalTime) then
    begin
      Result := SystemTimeToDateTime(LocalTime);
    end
    else
      Result := Self;
  end
  else
    Result := Self;
end;

end.
