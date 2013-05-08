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
unit uDMCript;

interface
uses Sysutils, Forms, uConstantUtils;
const
  cKey = 'keyWorkYUQajda342342423423423423K3LAKDJSL9RTIKJ';

type
  TDMCript = class
  private
    class procedure SetCrypt(var psSrc, Dest, Key: string; const KeyLen: Integer);
    class procedure SetDescrypt(var psSrc, Dest, Key: string; const KeyLen: Integer);
  public
    class function Decrypt(aText: string): string;
    class function Encrypts(aText: string): string;
    class function Crypt(Action, Src: string): string;
  end;
implementation

uses uDMUtils;

{ TDMCript }

class function TDMCript.Decrypt(aText: string): string;
begin
  Result := Crypt('D', aText);
end;

class function TDMCript.Encrypts(aText: string): string;
begin
  result := TDMCript.Crypt('C', aText);
end;

class procedure TDMCript.SetCrypt(var psSrc, Dest, Key: string; const KeyLen: Integer);
var
  KeyPos: Integer;
  OffSet: Integer;
  SrcPos: Integer;
  SrcAsc: Integer;
  Range: Integer;
begin
  KeyPos := nCST_Zero;
  Range := 256;
  Randomize;
  OffSet := Random(Range);
  Dest := Format('%1.2x', [OffSet]);
  for SrcPos := 1 to Length(psSrc) do
  begin
    Application.ProcessMessages;
    SrcAsc := (Ord(psSrc[SrcPos]) + OffSet) mod 255;
    if KeyPos < KeyLen then
      KeyPos := KeyPos + 1
    else
      KeyPos := nCST_One;
    SrcAsc := SrcAsc xor Ord(Key[KeyPos]);
    Dest := Dest + Format('%1.2x', [SrcAsc]);
    OffSet := SrcAsc;
  end;
end;

class procedure TDMCript.SetDescrypt(var psSrc, Dest, Key: string; const KeyLen: Integer);
var
  KeyPos: Integer;
  OffSet: Integer;
  SrcPos: Integer;
  SrcAsc: Integer;
  TmpSrcAsc: Integer;
begin
  KeyPos := nCST_Zero;
  OffSet := TDMUtils.Strtoint2('$' + copy(psSrc, nCST_One, 2));
  SrcPos := 3;
  repeat
    SrcAsc := TDMUtils.Strtoint2('$' + copy(psSrc, SrcPos, 2));
    if (KeyPos < KeyLen) then
      KeyPos := KeyPos + 1
    else
      KeyPos := nCST_One;
    TmpSrcAsc := SrcAsc xor Ord(Key[KeyPos]);
    if TmpSrcAsc <= OffSet then
      TmpSrcAsc := 255 + TmpSrcAsc - OffSet
    else
      TmpSrcAsc := TmpSrcAsc - OffSet;
    Dest := Dest + Chr(TmpSrcAsc);
    OffSet := SrcAsc;
    SrcPos := SrcPos + nCST_Two;
  until (SrcPos >= Length(psSrc));
end;

class function TDMCript.Crypt(Action, Src: string): string;
label
  Fim;
var
  KeyLen: Integer;
  Dest, Key: string;
begin
  if (Src = sCST_EmptyStr) then
  begin
    Result := sCST_EmptyStr;
    goto Fim;
  end;
  Key := cKey;
  Dest := sCST_EmptyStr;
  KeyLen := Length(Key);
  if (Action = UpperCase('C')) then
    SetCrypt(Src, Dest, Key, KeyLen)
  else
    if (Action = UpperCase('D')) then
      SetDescrypt(Src, Dest, Key, KeyLen);
  Result := Dest;
  Fim:
end;

end.
