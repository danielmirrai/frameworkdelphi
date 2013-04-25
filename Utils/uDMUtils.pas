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

unit uDMUtils;

interface
uses
  SysUtils, Classes, Forms, Windows, DateUtils, XMLDoc, ShellAPI, Controls, Variants, uConstantUtils;

type
  TDMUtils = class
  private
  public
    class procedure DestroyObject(var Obj); overload;
    class function IIf(const pbCondition: Boolean; const poReturnTrue, poReturnFalse: Variant): Variant; overload;
    class function IIf(const pbCondition: Boolean; const pnReturnTrue: Integer): Integer; overload;
    class function IIf(const pbCondition: Boolean; const psReturnTrue: string): string; overload;
    class function DeleteFile2(const psFileName: string): Boolean; overload;
    class function FileExists2(const psFileName: string): Boolean;
    class function DeleteFile2(const psFileName: TStringList): Boolean; overload;

    class function IsEmpty(const psValue: Extended): Boolean; overload;
    class function IsEmpty(const poValue: array of Extended): Boolean; overload;
    class function IsEmpty(const poValue: array of string): Boolean; overload;
    class function IsEmpty(const psValue: string): Boolean; overload;

    class function ExistValue(const pnValue: Extended): Boolean; overload;
    class function ExistValue(const poValue: array of Extended): Boolean; overload;
    class function ExistValue(const poValue: array of string): Boolean; overload;
    class function ExistValue(const psValue: string): Boolean; overload;

    class function StrCompare(const psValueFirst, psValueSecond: string): Boolean; overload;

    class procedure StrInitialization(poValue: array of string);
    class procedure IntInitialization(poValue: array of Integer);
    class procedure BooleanInitialization(poValue: array of Boolean);
    class procedure ObjectInitialization(poValue: array of TObject);

    class function StrToInt2(const psValue: string): Integer;
    class function StrToFloat2(const psValue: string): Extended;
    class function CardinalToInt(const psValue: Cardinal): Integer;
    class procedure OpenSite(const psURLSite: string);
    class function IntToStr2(const psValue: Integer): string;
    class function FloatToInt2(const psValue: Extended): Integer;
    class function Explode(const psText: string; const psExplode: string = '|'): TStringList;

    class function FormatValue(const psFormat: string; const psValue: Extended): string;
    class function FormatDateTime2(const pdDate: TDateTime): string; overload;
    class function FormatDateTime2(const psFormat: string; const pdDate: TDateTime): string; overload;
    class function FormatDate2(const pdDate: TDateTime): string;
    class function StrToDateTime2(const pdDate: string): TDateTime; overload;
    class function StrToDateTime2(const psFormat, pdDate: string): TDateTime; overload;
    class function FormpoTextended(const psValue: Extended): string;
    class function FormatInteger(const psValue: Integer): string;
    class function SizeFile(const psFileName: string): Integer;
    class procedure CreateDirectory(const psDirectory: string);
    class function FormatDirectory(const psDirectory: string): string;
    class function CreateFile(const psFileName, psText: string): Boolean;
    class procedure DeleteDir(const aRootDir: string);
    class procedure RemoveDir2(const aRootDir: string);
    class procedure DeleteAllFiles(const aRootDir: string);
    class procedure ListFileDir(const psDirectory: string; poListFiles: TStringList);
    class function RemoveAccents(const psText: string): string;
    class function RemoveCaracter(const aCaracter: array of string; const psText: string): string; overload;
    class function RemoveCaracter(const aCaracter, psText: string): string; overload;
    class function SpecialCharacterSwitching(const psText: string; const pbLimExt: boolean = True): string;
    class function StreamToString(const poStream: TStream): string;
    class function FindWindowByTitle(const psWindowTitle: string): Hwnd;
    class function XMLSaveToFile(const psFileName, psXML: string): Boolean;
    class function FormatSize(const pnSize: Extended): string;
    class function LocateStr(const poLocate: array of string; const psText: string): Boolean; Overload;
    class function LocateStr(const psLocate, psText: string): Boolean; Overload;
    class function FormatXMLData2(const psXML: string): string;
    class function GetXML(const psXML: string): TXMLDocument;
    class function RemoveEnter(const psText: string): string;
    class function ExtractWindowsDir: string;
    class function ExtractSystemDir: string;
    class function ExtractTempDir: string;
    class function FormatPath(const psPath: string): string;
    class function ExecuteBat(const psFileName: string): Boolean;
    class function GetDirectoryTemp: string;
    class procedure FreeAplication;
    class function ExtractDrive(const psPath: string): string;
    class procedure MyException(var poSender: TObject); overload;
    class procedure MyException(const psMessage: string; const pbShowError: Boolean = False); overload;
    class function GetMessageException: String;
    class function UpperCaseFirst(const psText: string): string;
    class function CompareIgnoreCase(const psText, psTextCompare: string): Boolean;
    class function ReadFile(const psFilePath: string): TStringList;
    class function WriteFile(const psFilePath: string; var poText: TStringList): Boolean;
    class function IsInteger(const poValue: Variant): Boolean;
    class function IsFloat(const poValue: variant): Boolean;
    class procedure FocusSet(poComponent: TWinControl; const pbDesabilite: Boolean = False);
    class function NumericAndKey(const psValue, psKey: string): string;

    class function ValidateEmail(const psEmail: string): Boolean;
    class function InString(const psValue: String; const poList: array of String): Boolean;
  end;
implementation

uses uDMUtilsMessage, uDMCript;

{ TDMUtils }

class procedure TDMUtils.DestroyObject(var Obj);
begin
  if Assigned(TObject(Obj)) then
    FreeAndNil(Obj);
end;

class function TDMUtils.CardinalToInt(const psValue: Cardinal): Integer;
begin
  Result := TDMUtils.StrToInt2(TDMUtils.IntToStr2(psValue));
end;

class procedure TDMUtils.CreateDirectory(const psDirectory: string);
var
  sDirectory: string;
begin
  sDirectory := ExtractFilePath(psDirectory);

  if (not DirectoryExists(sDirectory)) then
    ForceDirectories(sDirectory);
end;

class function TDMUtils.CreateFile(const psFileName, psText: string): Boolean;
const
  sCST_ErrorCreatingFile = 'Error creating file.';
var
  poFile: TStringList;
begin
  poFile := TStringList.Create;
  try
    try
      Result := True;
      TDMUtils.DeleteFile2(psFileName);
      poFile.Clear;
      poFile.Text := psText;
      poFile.SaveToFile(psFileName);
    except
      on E: Exception do
      begin
        Result := False;
        MyException(sCST_ErrorCreatingFile, False);
      end;
    end;
  finally
    TDMUtils.DestroyObject(poFile);
  end;
end;

class procedure TDMUtils.DeleteAllFiles(const aRootDir: string);
var
  vSearchRec: tSearchREC;
  vErc: Integer;
begin
  try
    if DirectoryExists(aRootDir) then
    begin
      FindFirst(aRootDir + '\*.*', faAnyFile, vSearchRec);
      vErc := nCST_Zero;
      while vErc = nCST_Zero do
      begin
        if ((vSearchRec.Name <> '.') and (vSearchRec.Name <> '..')) then
        begin
          if (vSearchRec.Attr and faDirectory > nCST_Zero) then
            DeleteAllFiles(aRootDir + vSearchRec.Name)
          else
            TDMUtils.DeleteFile2(aRootDir + vSearchRec.Name);
        end;
        vErc := FindNext(vSearchRec);
        Application.ProcessMessages;
      end;
      SysUtils.FindClose(vSearchRec);
    end;
  except
    on E: Exception do
      MyException('Erro ao excluír arquivos', True);
  end;
end;

class procedure TDMUtils.DeleteDir(const aRootDir: string);
var
  vSearchRec: tSearchREC;
  vErc: Integer;
begin
  try
    if DirectoryExists(aRootDir) then
    begin
      try
        FindFirst(aRootDir + '\*.*', faAnyFile, vSearchRec);
        vErc := nCST_Zero;
        while vErc = nCST_Zero do
        begin
          if ((vSearchRec.Name <> '.') and (vSearchRec.Name <> '..')) then
          begin
            if (vSearchRec.Attr and faDirectory > nCST_Zero) then
              DeleteDir(aRootDir + vSearchRec.Name)
            else
              TDMUtils.DeleteFile2(aRootDir + vSearchRec.Name);
          end;
          vErc := FindNext(vSearchRec);
          Application.ProcessMessages;
        end;
        SysUtils.FindClose(vSearchRec);
      finally
        RemoveDir2(aRootDir);
      end;
    end;
  except
    on E: Exception do
      MyException('Erro ao excluír diretório.', True);
  end;
end;

class function TDMUtils.DeleteFile2(const psFileName: TStringList): Boolean;
var
  vIndex: Integer;
begin
  Result := False;
  if Assigned(psFileName) then
  begin
    Result := True;
    for vIndex := nCST_Zero to psFileName.Count - nCST_One do
    begin
      if not TDMUtils.DeleteFile2(psFileName.Strings[vIndex]) then
        Result := False;
    end;
  end;
end;

class function TDMUtils.DeleteFile2(const psFileName: string): Boolean;
begin
  try
    Result := True;
    if FileExists(Trim(psFileName)) then
      DeleteFile(PChar(Trim(psFileName)));
  except
    on E: Exception do
    begin
      Result := False;
      MyException('Erro ao excluír o arquivo!', True);
      exit;
    end;
  end;
end;

class function TDMUtils.ExecuteBat(const psFileName: string): Boolean;
const
  sCST_ErroExecutingFile = 'Error executing file!';
  nCST_ExecuteSucessful = 32;
  sCST_Open = 'open';
begin
  try
    Result := False;
    if FileExists2(psFileName) then
      Result := ShellExecute(Application.Handle, sCST_Open, PChar(psFileName), PChar(EmptyStr), PChar(EmptyStr), SW_hide) = nCST_ExecuteSucessful;
  except
    on E: Exception do
    begin
      TDMUtils.MyException(sCST_ErroExecutingFile);
    end;
  end;
end;

class function TDMUtils.Explode(const psText, psExplode: string): TStringList;
var
  nIndex: Integer;
  sExplode: string;
  sText: string;
begin
  sText := psText;
  Result := TStringList.Create;
  Result.Clear;
  nIndex := Pos(psExplode, sText);
  while (nIndex <> nCST_Zero) do
  begin
    sExplode := Copy(sText, 1, nIndex - 1);
    sText := Copy(sText, nIndex + 1, Length(sText));
    Result.Add(sExplode);
    nIndex := Pos(psExplode, sText);
    if (nIndex = nCST_Zero) then
    begin
      if (not TDMUtils.IsEmpty(sText)) then
        Result.Add(sText);

      sText := EmptyStr;
    end;
  end;

  if (not TDMUtils.IsEmpty(SText)) or (Result.Count = nCST_Zero) then
    Result.Add(sText);
end;

class function TDMUtils.ExtractDrive(const psPath: string): string;
var
  vIndex: Integer;
begin
  vIndex := Pos(sCST_BeginDrive, psPath);
  Result := EmptyStr;
  if (vIndex > nCST_Zero) then
    Result := Copy(psPath, 1, vIndex + 1);
end;

class function TDMUtils.ExtractSystemDir: string;
var
  vBuffer: array[0..144] of Char;
begin
  GetSystemDirectory(vBuffer, 144);
  Result := FormatPath(StrPas(vBuffer));
end;

class function TDMUtils.ExtractTempDir: string;
var
  vBuffer: array[0..144] of Char;
begin
  GetTempPath(144, vBuffer);
  Result := FormatPath(StrPas(vBuffer));
end;

class function TDMUtils.ExtractWindowsDir: string;
var
  vBuffer: array[0..144] of Char;
begin
  GetWindowsDirectory(vBuffer, 144);
  Result := FormatPath(StrPas(vBuffer));
end;

class function TDMUtils.FileExists2(const psFileName: string): Boolean;
begin
  Result := (not TDMUtils.IsEmpty(psFileName)) and FileExists(psFileName);
end;

class function TDMUtils.FindWindowByTitle(const psWindowTitle: string): Hwnd;
var
  NextHandle: Hwnd;
  NextTitle: array[0..260] of char;
begin
  NextHandle := GetWindow(Application.Handle, GW_HWNDFIRST);
  while NextHandle > nCST_Zero do
  begin
    GetWindowText(NextHandle, NextTitle, 255);
    if Pos(psWindowTitle, StrPas(NextTitle)) <> nCST_Zero then
    begin
      Result := NextHandle;
      Exit;
    end
    else
      NextHandle := GetWindow(NextHandle, GW_HWNDNEXT);
  end;
  Result := nCST_Zero;
end;

class function TDMUtils.FloatToInt2(const psValue: Extended): Integer;
begin
  Result := Round(psValue);
end;

class function TDMUtils.FormatInteger(const psValue: Integer): string;
begin
  Result := FormatValue('###,##0', psValue);
end;

class function TDMUtils.FormatPath(const psPath: string): string;
const
  DirSep: char = {$IFDEF Unix} '/'{$ELSE} '\'{$ENDIF};
var
  P: integer;
  SC: char;
  sPath: string;
begin
  sPath := psPath;
  if ord(DirSep) = ord('/') then
    SC := '\'
  else
    SC := '/';

  repeat
    P := Pos(SC, sPath);
    if P > nCST_Zero then sPath[P] := DirSep;
  until P = nCST_Zero;

  Result := sPath;
end;

class function TDMUtils.FormatSize(const pnSize: Extended): string;
var
  vQtde: Integer;
  sSize: Extended;
begin
  vQtde := nCST_Zero;
  sSize := pnSize;
  while (sSize / nCST_ExplodeBits) >= nCST_One do
  begin
    Inc(vQtde);
    sSize := TDMUtils.FloatToInt2(sSize / nCST_ExplodeBits);
  end;
  case vQtde of
    0: Result := 'B';
    1: Result := 'kB';
    2: Result := 'MB';
    3: Result := 'GB';
    4: Result := 'TB';
    5: Result := 'PB';
    6: Result := 'EB';
    7: Result := 'ZB';
    8: Result := 'YB'
  else
    Result := 'B';
  end;
  Result := TDMUtils.IntToStr2(TDMUtils.FloatToInt2(sSize)) + ' ' + Result;
end;

class function TDMUtils.FormatValue(const psFormat: string; const psValue: Extended): string;
begin
  Result := FormatFloat(psFormat, psValue);
end;

class function TDMUtils.FormatXMLData2(const psXML: string): string;
var
  sXML: string;
begin
  sXML := psXML;
  sXML := SpecialCharacterSwitching(sXML, true);
  sXML := RemoveAccents(sXML);
  Result := FormatXMLData(sXML);
end;

class procedure TDMUtils.FreeAplication;
var
  vFile, vDirectory: string;
  vText: TStringList;
begin
  vText := nil;
  try
    try
      vFile := ExtractDrive(ExtractFilePath(Application.ExeName)) + 'free.bat';
      vText := TStringList.Create;
      vText.Clear;
      vText.Add('Echo off');
      vDirectory := GetDirectoryTemp;

      if (Copy(vDirectory, Length(vDirectory), 1) = '\') then
        vDirectory := Copy(vDirectory, 1, Length(vDirectory) - 1);

      vText.Add('cacls "' + vDirectory + '" /E /G "Todos":F');

      vDirectory := ExtractFilePath(Application.ExeName);

      if (Copy(vDirectory, Length(vDirectory), 1) = '\') then
        vDirectory := Copy(vDirectory, 1, Length(vDirectory) - 1);
      vText.Add('cacls "' + vDirectory + '" /E /G "Todos":F');
      vText.Add('exit;');
      TDMUtils.CreateFile(vFile, vText.Text);
      TDMUtils.ExecuteBat(vFile);
      Sleep(nCST_two);
      TDMUtils.DeleteFile2(vFile)
    except
      TDMUtils.MyException('Erro ao criar arquivo de permissão!', False);
    end;
  finally
    TDMUtils.DestroyObject(vText);
  end;
end;

class function TDMUtils.GetDirectoryTemp: string;
var
  vDirectory: string;
begin
  vDirectory := TDMUtils.ExtractWindowsDir;
  if TDMUtils.IsEmpty(vDirectory) then
    vDirectory := ExtractFilePath(Application.ExeName);

  Result := FormatDirectory(vDirectory) + 'WinTemp\';
end;

class function TDMUtils.GetXML(const psXML: string): TXMLDocument;
begin
  Result := TXMLDocument.Create(nil);
  Result.LoadFromXML(psXML);
  Result.Active := True;
end;

class function TDMUtils.FormpoTextended(const psValue: Extended): string;
begin
  Result := FormatValue('###,##0.00', psValue);
end;

class function TDMUtils.FormatDate2(const pdDate: TDateTime): string;
begin
  Result := FormatDateTime('dd/mm/yyyy', pdDate);
end;

class function TDMUtils.FormatDateTime2(const psFormat: string; const pdDate: TDateTime): string;
begin
  Result := FormatDateTime(psFormat, pdDate);
end;

class function TDMUtils.FormatDirectory(const psDirectory: string): string;
begin
  Result := psDirectory;
  if (Copy(Result, Length(Result), 1) <> '\') then
    Result := Result + '\';
end;

class function TDMUtils.FormatDateTime2(const pdDate: TDateTime): string;
begin
  Result := FormatDateTime2('dd/mm/yyyy hh:mm:ss', pdDate);
end;

class function TDMUtils.iIf(const pbCondition: Boolean; const poReturnTrue, poReturnFalse: Variant): Variant;
begin                     
  Result := poReturnFalse;
  if (pbCondition) then
    Result := poReturnTrue;
end;

class function TDMUtils.IIf(const pbCondition: Boolean; const pnReturnTrue: Integer): Integer;
begin
  Result := nCST_Zero;
  if (pbCondition) then
    Result := pnReturnTrue;
end;

class function TDMUtils.IIf(const pbCondition: Boolean; const psReturnTrue: string): string;
begin
  Result := EmptyStr;
  if (pbCondition) then
    Result := psReturnTrue;
end;

class function TDMUtils.IntToStr2(const psValue: Integer): string;
begin
  Result := IntToStr(psValue);
end;

class function TDMUtils.IsEmpty(const poValue: array of Extended): Boolean;
var
  vIndex: Integer;
begin
  Result := False;
  for vIndex := nCST_Zero to high(poValue) do
  begin
    Result := IsEmpty(poValue[vIndex]);

    if (Result) then
      Abort;
  end;
end;

class function TDMUtils.IsEmpty(const poValue: array of string): Boolean;
var
  vIndex: Integer;
begin
  Result := False;
  for vIndex := nCST_Zero to high(poValue) do
  begin
    Result := IsEmpty(poValue[vIndex]);

    if (Result) then
      Abort;
  end;
end;

class function TDMUtils.IsEmpty(const psValue: string): Boolean;
begin
  Result := (Trim(psValue) = EmptyStr);
end;

class function TDMUtils.IsFloat(const poValue: variant): Boolean;
var
  sDecimal, sValue: string;
  nIndex: Integer;
begin
  sValue := Trim(VarToStr(poValue));
  nIndex := Pos(',', sValue);
  if (Length(sValue) > nIndex) then
  begin
    sDecimal := Copy(sValue, 1, nIndex - 1);
    Result := IsInteger(sDecimal);
    if Result then
    begin
      sDecimal := Copy(sValue, nIndex + 1, Length(sValue));
      Result := IsInteger(sDecimal);
    end;
  end
  else
    Result := IsInteger(sValue);
end;

class function TDMUtils.IsInteger(const poValue: Variant): Boolean;
var
  vTemp, vErrorPos: Integer;
begin
  Result := False;
  Val(poValue, vTemp, vErrorPos);
  if vErrorPos = nCST_Zero then
    Result := (vTemp - round(vTemp)) = nCST_Zero;
end;

class procedure TDMUtils.ListFileDir(const psDirectory: string; poListFiles: TStringList);
var
  vSearchRec: tSearchREC;
  vErc: Integer;
begin
  try
    if DirectoryExists(psDirectory) then
    begin
      try
        FindFirst(psDirectory + '\*.*', faAnyFile, vSearchRec);
        vErc := nCST_Zero;
        while vErc = nCST_Zero do
        begin
          if ((vSearchRec.Name <> '.') and (vSearchRec.Name <> '..')) then
          begin
            if (vSearchRec.Attr and faDirectory > nCST_Zero) then
              ListFileDir(vSearchRec.Name, poListFiles)
            else
              poListFiles.Add(psDirectory + vSearchRec.Name);
          end;
          vErc := FindNext(vSearchRec);
          Application.ProcessMessages;
        end;
        SysUtils.FindClose(vSearchRec);
      finally
      end;
    end;
  except
    on E: Exception do
      MyException('Erro ao excluír arquivos', True);
  end;
end;

class function TDMUtils.LocateStr(const psLocate, psText: string): Boolean;
begin
  Result := (Pos(UpperCase(psLocate), UpperCase(psText)) > nCST_Zero);
end;

class procedure TDMUtils.MyException(var poSender: TObject);
begin
  TDMUtils.MyException('Error in '+poSender.ClassName, True);
end;

class function TDMUtils.ReadFile(const psFilePath: string): TStringList;
var
  oTextFile: TextFile;
  sLine: string;
const
  sCST_ErroWritingFile = 'Error writing file read!';
begin
  Result := TStringList.Create;
  try
    Result.Clear;
    if FileExists2(psFilePath) then
    begin
      try
        AssignFile(oTextFile, psFilePath);
        Reset(oTextFile);
        while not eof(oTextFile) do
        begin
          Readln(oTextFile, sLine);
          Result.Add(sLine);

        end;
      finally
        CloseFile(oTextFile);
      end;
    end;
  except
    on E: Exception do
    begin
      TDMUtils.MyException(sCST_ErroWritingFile, False);
      TDMUtils.DestroyObject(Result);
      exit;
    end;
  end;
end;

class function TDMUtils.RemoveAccents(const psText: string): string;
var
  nIndex: Integer;
begin 
  Result := psText;
  for nIndex := nCST_One to Length(Result) do
  begin
    if Pos(Result[nIndex], cComAcento) <> nCST_Zero then
    begin
      Result[nIndex] := cSemAcento[Pos(Result[nIndex], cComAcento)];
    end;
  end;
end;

class function TDMUtils.RemoveCaracter(const aCaracter, psText: string): string;
var
  vList: TStringList;
  vIndex: Integer;
begin
  vList := TDMUtils.Explode(aCaracter);
  Result := psText;
  try
    for vIndex := nCST_Zero to vList.Count - nCST_One do
      Result := StringReplace(Result, vList.Strings[vIndex], EmptyStr, [rfReplaceAll]);
  finally
    TDMUtils.DestroyObject(vList);
  end;
end;

class procedure TDMUtils.RemoveDir2(const aRootDir: string);
begin
  if DirectoryExists(aRootDir) then
    RemoveDir(aRootDir);
end;

class function TDMUtils.RemoveCaracter(const aCaracter: array of string; const psText: string): string;
var
  vIndex: Integer;
begin
  Result := psText;
  for vIndex := nCST_Zero to high(aCaracter) do
    Result := StringReplace(Result, aCaracter[vIndex], EmptyStr, [rfReplaceAll]);
end;

class function TDMUtils.RemoveEnter(const psText: string): string;
begin
  Result := Trim(TDMUtils.RemoveCaracter([#13, #10, #$D#$A], Trim(psText)));
end;

class function TDMUtils.SizeFile(const psFileName: string): Integer;
var
  vFileStream: TFileStream;
begin
  Result := nCST_Zero;
  vFileStream := nil;
  if FileExists(psFileName) then
  begin
    try
      try
        vFileStream := TFileStream.Create(psFileName, fmShareDenyNone);
        Result := vFileStream.Size;
      except
        on E: Exception do
        begin
          Result := nCST_Zero;
          MyException('Erro ao obter tamanho do arquivo!', True);
        end;
      end;
    finally
      DestroyObject(vFileStream);
    end;
  end;
end;

class function TDMUtils.StrToDateTime2(const pdDate: string): TDateTime;
begin
  try
    Result := StrToDateTime(pdDate);
  except
    on E: Exception do
    begin
      Result := nCST_Zero;
    end;
  end;
end;

class function TDMUtils.StrToDateTime2(const psFormat, pdDate: string): TDateTime;
var
  vYear, vMonth, vDay, vHour, vMinute, vSecond, vMiliSecond: Integer;
  sFormat: string;
  sDate: string;

  function LocateDate(const aStr: string): Integer;
  var
    vIndex: Integer;
  begin
    Result := nCST_Zero;
    vIndex := Pos(aStr, UpperCase(psFormat));
    if (vIndex > nCST_Zero) then
    begin
      Result := TDMUtils.StrToInt2(Copy(sDate, vIndex, length(aStr)));
      sFormat := Copy(sFormat, 1, vIndex - 1) + Copy(sFormat, vIndex + length(aStr), length(sFormat));
      sDate := Copy(sDate, 1, vIndex - 1) + Copy(sDate, vIndex + length(aStr), length(sDate));
    end;
  end;
begin
  sFormat := psFormat;
  sDate := pdDate;
  vYear := LocateDate('YYYY');
  vMonth := LocateDate('MM');
  vDay := LocateDate('DD');
  vHour := LocateDate('HH');
  vMinute := LocateDate('MM');
  vSecond := LocateDate('SS');
  vMiliSecond := LocateDate('SSS');
  Result := EncodeDateTime(vYear, vMonth, vDay, vHour, vMinute, vSecond, vMiliSecond);
end;

class function TDMUtils.StrToInt2(const psValue: string): Integer;
begin
  Result := nCST_Zero;
  try
    if ((not IsEmpty(psValue)) and IsInteger(psValue)) then
      Result := StrToInt(Trim(psValue));
  except
    Result := nCST_Zero;
  end;
end;

class function TDMUtils.WriteFile(const psFilePath: string; var poText: TStringList): Boolean;
var
  vArq: TextFile;
  vIndex: Integer;
begin
  try
    Result := True;
    try
      AssignFile(vArq, psFilePath);
      if FileExists(psFilePath) then
        Append(vArq)
      else
      begin
        ReWrite(vArq);
      end;
      for vIndex := nCST_Zero to poText.Count - nCST_One do
        WriteLn(vArq, poText[vIndex]);
    except
      on E: Exception do
      begin
        TDMUtils.MyException('Erro ao gravar dados no arquivo');
        Result := False;
        exit;
      end;
    end;
  finally
    CloseFile(vArq);
  end;
end;

class function TDMUtils.XMLSaveToFile(const psFileName, psXML: string): Boolean;
var
  vDoc: TXMLDocument;
begin
  Result := False;
  vDoc := nil;
  try
    try
      TDMUtils.DeleteFile2(psFileName);
      vDoc := TXMLDocument.Create(nil);
      vDoc.XML.Text := psXML;
      vDoc.Active := True;
      vDoc.SaveToFile(psFileName);
    except
      on E: Exception do
      begin
        Result := False;
        MyException('Erro ao salva arquivo!', True);
        exit;
      end;
    end;
  finally
    TDMUtils.DestroyObject(vDoc);
  end;
end;

class function TDMUtils.SpecialCharacterSwitching(const psText: string; const pbLimExt: boolean): string;
var
  vIndex: Integer;
begin
  Result := psText;
  for vIndex := nCST_One to 38 do
    Result := StringReplace(Result, cCaracterEspeciais[vIndex], cCaracterTroca[vIndex], [rfreplaceall]);

  if (pbLimExt) then
    for vIndex := nCST_One to 30 do
      Result := StringReplace(Result, cCaracterExtra[vIndex], EmptyStr, [rfreplaceall]);
end;

class function TDMUtils.IsEmpty(const psValue: Extended): Boolean;
begin
  Result := (psValue = nCST_Zero);
end;

class procedure TDMUtils.MyException(const psMessage: string; const pbShowError: Boolean = False);
var
  vArq: TextFile;
  sMessage, sFileName, sException: string;
begin
  try
    sFileName := ExtractFilePath(Application.ExeName) + sCST_NameLog;
    AssignFile(vArq, sFileName);
    if FileExists(sFileName) then
      Append(vArq)
    else
    begin
      ReWrite(vArq);
      WriteLn(vArq, TDMCript.Encrypts(sCST_TitleLog));
    end;

    sException := GetMessageException;
    if TDMUtils.ExistValue(sException) then
      sMessage := sMessage + sCST_Space + sCST_MessageError + sException;

    WriteLn(vArq, TDMUtils.FormatDateTime2(Now) + sCST_TraceSpaces + sMessage);

    CloseFile(vArq);

    if pbShowError then
      TDMUtilsMessage.ShowMessageError(sMessage);
  except
    exit;
  end;
end;

class procedure TDMUtils.FocusSet(poComponent: TWinControl; const pbDesabilite: Boolean = False);
begin
  if (poComponent.Visible and poComponent.Enabled and poComponent.CanFocus and poComponent.Showing) then
    poComponent.SetFocus;

  if pbDesabilite then
    poComponent.Enabled := False;
end;

class function TDMUtils.StreamToString(const poStream: TStream): string;
var
  ms: TMemoryStream;
begin
  Result := EmptyStr;
  ms := TMemoryStream.Create;
  try
    ms.LoadFromStream(poStream);
    SetString(Result, PChar(ms.memory), ms.Size);
  finally
    ms.Free;
  end;
  Result := Trim(Result);
end;

class function TDMUtils.NumericAndKey(const psValue, psKey: string): string;
var
  nIndex: Integer;
begin
  Result := psValue;
  for nIndex := nCST_Zero to Length(Result) do
  begin
    if not ((Result[nIndex] = psKey) or IsInteger(Result[nIndex])) then
      Result[nIndex] := ' ';
  end;
end;

class function TDMUtils.StrToFloat2(const psValue: string): Extended;
begin
  Result := nCST_Zero;
  try
    if ((not IsEmpty(psValue)) and IsFloat(psValue)) then
      Result := StrToFloat(Trim(psValue));
  except
    Result := nCST_Zero;
  end;
end;

class procedure TDMUtils.OpenSite(const psURLSite: string);
begin
  if not IsEmpty(psURLSite) then
    shellexecute(Application.Handle, 'open', PChar(psURLSite), nil, nil, sw_show);
end;

class procedure TDMUtils.StrInitialization(poValue: array of string);
var
  nIndex: Integer;
begin
  for nIndex := nCST_Zero to high(poValue) do
  begin
    poValue[nIndex] := EmptyStr;
  end;
end;

class procedure TDMUtils.IntInitialization(poValue: array of Integer);
var
  nIndex: Integer;
begin
  for nIndex := nCST_Zero to high(poValue) do
  begin
    poValue[nIndex] := nCST_Zero;
  end;
end;

class procedure TDMUtils.BooleanInitialization(poValue: array of Boolean);
var
  nIndex: Integer;
begin
  for nIndex := nCST_Zero to high(poValue) do
  begin
    poValue[nIndex] := False;
  end;
end;

class procedure TDMUtils.ObjectInitialization(poValue: array of TObject);
var
  nIndex: Integer;
begin
  for nIndex := nCST_Zero to high(poValue) do
  begin
    poValue[nIndex] := nil;
  end;
end;

class function TDMUtils.ValidateEmail(const psEmail: string): Boolean;
const
  // Caracteres válidos
  ATOM_CHARS = [#33..#255] - ['(', ')', '<', '>', '@', ',', ';', ':',
                              '\', '/', '"', '.', '[', ']', #127];

  // Caracteres válidos em uma cadeia
  QUOTED_STRING_CHARS = [#0..#255] - ['"', #13, '\'];

  // Caracteres válidos em um subdominio
  LETTERS = ['A'..'Z', 'a'..'z'];
  LETTERS_DIGITS = ['0'..'9', 'A'..'Z', 'a'..'z'];
  SUBDOMAIN_CHARS = ['-', '0'..'9', 'A'..'Z', 'a'..'z'];

type
  States = (STATE_BEGIN, STATE_ATOM, STATE_QTEXT, STATE_QCHAR,
    STATE_QUOTE, STATE_LOCAL_PERIOD, STATE_EXPECTING_SUBDOMAIN,
    STATE_SUBDOMAIN, STATE_HYPHEN);
var
  State: States;
  i, n, iSubdomains: integer;
  c: char;
begin
  State := STATE_BEGIN;
  n := Length(psEmail);
  i := 1;
  iSubdomains := 1;
  while (i <= n) do
  begin
    c := psEmail[i];
    case State of
      STATE_BEGIN:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_ATOM:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else if not (c in atom_chars) then
          break;
      STATE_QTEXT:
        if c = '\' then
          State := STATE_QCHAR
        else if c = '"' then
          State := STATE_QUOTE
        else if not (c in quoted_string_chars) then
          break;
      STATE_QCHAR:
        State := STATE_QTEXT;
      STATE_QUOTE:
        if c = '@' then
          State := STATE_EXPECTING_SUBDOMAIN
        else if c = '.' then
          State := STATE_LOCAL_PERIOD
        else
          break;
      STATE_LOCAL_PERIOD:
        if c in atom_chars then
          State := STATE_ATOM
        else if c = '"' then
          State := STATE_QTEXT
        else
          break;
      STATE_EXPECTING_SUBDOMAIN:
        if c in letters then
          State := STATE_SUBDOMAIN
        else
          break;
      STATE_SUBDOMAIN:
        if c = '.' then
        begin
          Inc(iSubdomains);
          State := STATE_EXPECTING_SUBDOMAIN
        end
        else if c = '-' then
          State := STATE_HYPHEN
        else if not (c in letters_digits) then
          break;
      STATE_HYPHEN:
        if c in letters_digits then
          State := STATE_SUBDOMAIN
        else if c <> '-' then
          break;
    end;
    Inc(i);
  end;

  if i <= n then
    Result := False
  else
    Result := (State = STATE_SUBDOMAIN) and (iSubdomains >= nCST_two);

  if psEmail = EmptyStr then
    Result := true;
end;

class function TDMUtils.StrCompare(const psValueFirst, psValueSecond: string): Boolean;
begin
  Result := UpperCase(Trim(psValueFirst)) = UpperCase(Trim(psValueSecond));
end;

class function TDMUtils.LocateStr(const poLocate: array of string; const psText: string): Boolean;
var
  nIndex: Integer;
begin
  Result := False;
  for nIndex := nCST_Zero to Length(poLocate) - nCST_One do
  begin
    if LocateStr(poLocate[nIndex], psText) then
      result := True;
  end;
end;

class function TDMUtils.ExistValue(const poValue: array of Extended): Boolean;
begin
  Result := not IsEmpty(poValue);
end;

class function TDMUtils.ExistValue(const pnValue: Extended): Boolean;
begin
  Result := not IsEmpty(pnValue);
end;

class function TDMUtils.ExistValue(const psValue: string): Boolean;
begin
  Result := not IsEmpty(psValue);
end;

class function TDMUtils.ExistValue(const poValue: array of string): Boolean;
begin
  Result := not IsEmpty(poValue);
end;

class function TDMUtils.InString(const psValue: String; const poList: array of String): Boolean;
var
  nIndex: Integer;
begin
  Result := False;
  for nIndex := nCST_Zero to Length(poList) - nCST_One do
  begin
    if StrCompare(poList[nIndex], psValue) then
      Result := True;
  end;
end;

class function TDMUtils.GetMessageException: String;
begin
  Result := EmptyStr;
  if ExceptObject is Exception then
    Result := Exception(ExceptObject).Message
end;

class function TDMUtils.CompareIgnoreCase(const psText, psTextCompare: string): Boolean;
begin
  Result := (Trim(UpperCase(psText)) = Trim(UpperCase(psTextCompare)));
end;

class function TDMUtils.UpperCaseFirst(const psText: string): string;
begin
  Result := upperCase(Copy(psText, nCST_One, nCST_One)) + Copy(psText, nCST_two, length(psText));
end;

end.
