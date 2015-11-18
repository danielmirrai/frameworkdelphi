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

unit uDMUtils;

interface

uses
  SysUtils, uConstantUtils, {JclDebug,} DBClient, Windows, Db, Forms,
  Contnrs, Dialogs, DateUtils, XMLDoc, ShellAPI, Controls, Variants,
  Classes, uDMList;

type

  /// <summary>
  /// Class functions global util
  /// </summary>
  TDMUtils = class(TComponent)
  private
    class procedure DeleteLineEmptySimple(poList: TStringList); Overload;
    class procedure DeleteLineEmptySimple(var psText: String); Overload;
    class procedure ExplodeStrSimple(var psText: string;
      const psExplode: string = '|'; const pbExcluirTag: Boolean = true;
      const pbNewLineBefore: Boolean = true;
      const pbNewLineAfter: Boolean = true;
      const pbAllowAddLineEmpty: Boolean = true);
    class procedure ExplodeListStrSimple(var poText: TStringList;
      const psExplode: string = '|'; const pbExcluirTag: Boolean = true;
      const pbNewLineBefore: Boolean = true;
      const pbNewLineAfter: Boolean = true;
      const pbAllowAddLineEmpty: Boolean = true);

  public
    class function GetFileName(const psFilePath: String;
      pbRemoveExt: Boolean = true): String;
    class function ByteToString(const poValue: Array of Byte): String;
    class procedure DestroyObject(var Obj);
    class function Ping(const psIP: String; const pnQtde: Integer): Boolean;
    class function IIf(const pbCondition: Boolean;
      const poReturnTrue, poReturnFalse: Variant): Variant; overload;
    class function IIf(const pbCondition: Boolean; const pnReturnTrue: Integer)
      : Integer; overload;
    class function IIf(const pbCondition: Boolean; const psReturnTrue: string)
      : string; overload;
    class function DeleteFile2(const psFileName: string): Boolean; overload;
    class function FileExists2(const psFileName: string): Boolean;
    class function DeleteFile2(const psFileName: TStringList): Boolean;
      overload;
    class procedure DeleteFileDelphiTemp(const psDirectory: String);
    class procedure CopyDFMForLib(const psDirectoryOrigin,
      psDirectoryDestination: String);

    class function IsEmpty(const psValue: Extended): Boolean; overload;
    class function IsEmpty(const poValue: array of Extended): Boolean; overload;
    class function IsEmpty(const poValue: array of string): Boolean; overload;
    class function IsEmpty(const psValue: string): Boolean; overload;
    class function IsEmpty(const poField: TField): Boolean; overload;
    class function IsEmpty(const poValue: TStringList): Boolean; overload;
    class function IsEmpty(const poDataSet: TDataSet): Boolean; overload;

    class function ExistValue(const pnValue: Extended): Boolean; overload;
    class function ExistValue(const poValue: array of Extended)
      : Boolean; overload;
    class function ExistValue(const poValue: TStringList): Boolean; overload;
    class function ExistValue(const poValue: array of string): Boolean;
      overload;
    class function ExistValue(const psValue: string): Boolean; overload;
    class function ExistValue(const poField: TField): Boolean; overload;
    class function ExistValue(const poDataSet: TDataSet): Boolean; overload;
    class function ValidateCommand(const psValidate, psCommand, psTag: String;
      const psAfterCommand: String = '';
      const psBeforeCommand: String = ''): Boolean;
    class function StrCompare(const psValueFirst, psValueSecond: string)
      : Boolean; overload;
    class function CharInSet(const psCharFInd: Char;
      const poListChar: Array of Char): Boolean;
    class function GetHaveCharStr(const psText: string): Boolean;
    class function ExisteString(const psLocalizar, psTexto: string;
      const pbIgnoreCase: Boolean = true): Boolean;
    class function ExistePalavra(const psLocalizar, psTexto: string;
      const pbIgnoreCase: Boolean = true): Boolean;
    class function PosIgnoreCase(const psLocalizar, psTexto: string;
      const pbIgnoreCase: Boolean = true): Integer;
    class function PosAfterIndex(const psLocalizar, psTexto: string;
      const pnIndexBegin: Integer = 1;
      const pbIgnoreCase: Boolean = true): Integer; Overload;
    class function PosAfterIndex(const psLocalizar: Array of String; const psTexto: string;
      const pnIndexBegin: Integer = 1;
      const pbIgnoreCase: Boolean = true): Integer; Overload;
    class function StrToInt2(const psValue: string): Integer;
    class function StrToFloat2(const psValue: string): Extended;
    class function CardinalToInt(const psValue: Cardinal): Integer;
    class procedure OpenSite(const psURLSite: string);
    class function IntToStr2(const psValue: Integer): string;
    class function FloatToInt2(const psValue: Extended): Integer;

    class function Explode(const psText: string; const psExplode: string = '|';
      const pbExcluirTag: Boolean = true; const pbNewLineBefore: Boolean = true;
      const pbNewLineAfter: Boolean = true;
      const pbAllowAddLineEmpty: Boolean = true): TStringList;

    class procedure ExplodeStr(psText: TStringList;
      const psExplode: string = '|'; const pbExcluirTag: Boolean = true;
      const pbNewLineBefore: Boolean = true;
      const pbNewLineAfter: Boolean = true;
      const pbAllowAddLineEmpty: Boolean = true); Overload;
    class procedure ExplodeStr(var psText: string;
      const psExplode: string = '|'; const pbExcluirTag: Boolean = true;
      const pbNewLineBefore: Boolean = true;
      const pbNewLineAfter: Boolean = true;
      const pbAllowAddLineEmpty: Boolean = true); Overload;

    class procedure ExplodeList(var psText: String;
      const psExplode: Array of string; const pbExcluirTag: Boolean = true;
      const pbNewLineBefore: Boolean = true;
      const pbNewLineAfter: Boolean = true;
      const pbAllowAddLineEmpty: Boolean = False); Overload;
    class procedure ExplodeList(poList: TStringList;
      const psExplode: Array of string; const pbExcluirTag: Boolean = true;
      const pbNewLineBefore: Boolean = true;
      const pbNewLineAfter: Boolean = true;
      const pbAllowAddLineEmpty: Boolean = False); Overload;

    class procedure RemoveComment(poList: TStringList);
    class procedure DeleteLineEmpty(var psText: String); Overload;
    class procedure DeleteLineEmpty(poFile: TStringList); Overload;

    class procedure ExtractBlock(var psText: String;
      const psTagBegin, psTagEnd: String;
      const pbRemoveTag: Boolean = true); overload;
    class procedure ExtractBlock(poList: TStringList;
      const psTagBegin, psTagEnd: String;
      const pbRemoveTag: Boolean = true); overload;

    class procedure RemoveBlock(var psText: string;
      const psTagBegin, psTagEnd: String; const pbRemoveTag: Boolean = true;
      const psIgnoreBefore: String = ''); overload;
    class procedure RemoveBlock(poList: TStringList;
      const psTagBegin, psTagEnd: String; const pbRemoveTag: Boolean = true;
      const psIgnoreBefore: String = ''); overload;
    class procedure RemoveBlock(var poList, poListRemove: TStringList;
      const psTagBegin, psTagEnd: String; const pbRemoveTag: Boolean = true;
      const psIgnoreBefore: String = '';
      const psNewValue: String = ''); overload;
    class function FormatValue(const psFormat: string;
      const psValue: Extended): string;
    class function FormatDateTime2(const pdDate: TDateTime): string; overload;
    class function FormatDateTimeSQL(const pdDate: TDateTime): string;
    class function FormatDateSQL(const pdDate: TDate): string;
    class function FormatDateTime2(const psFormat: string;
      const pdDate: TDateTime): string; overload;
    class function FormatDate2(const pdDate: TDateTime): string;
    class function StrToDateTime2(const pdDate: string): TDateTime; overload;
    class function StrToDateTime2(const psFormat, pdDate: string)
      : TDateTime; overload;
    class function FormatExtended(const psValue: Extended): string;
    class function CaptureFunctionName(const pnLevel: Integer = 0): String;
    class function FormatInteger(const psValue: Integer): string;
    class function SizeFile(const psFileName: string): Integer;
    class procedure CreateDirectory(const psDirectory: string);
    class function FormatDirectory(const psDirectory: string): string;
    class function CreateFile(const psFileName, psText: string): Boolean;

    /// <summary>
    /// Exclui diretório e todos os arquivos e sub diretórios
    /// </summary>
    /// <param name="aRootDir">
    /// Diretório que será excluído
    /// </param>
    class procedure DeleteDir(const psDirectory: string); Overload;
    /// <summary>
    /// Exclui todos os diretórios da lista, arquivos do diretório e sub diretórios
    /// </summary>
    /// <param name="aRootDir">
    /// Diretório que será excluído
    /// </param>
    class procedure DeleteDir(const poRootDir: TStringList); Overload;
    class procedure RemoveDir2(const aRootDir: string);

    /// <summary>
    /// Exclui todos os arquivos do diretório
    /// </summary>
    /// <param name="aRootDir">
    /// Diretório que contém os arquivos
    /// </param>
    class procedure DeleteAllFiles(const psDirectory: string);

    /// <summary>
    /// Lista todos os arquivo e do diretório e dos sub diretórios
    /// </summary>
    /// <param name="psDirectory">
    /// Diretório que contém os arquivos e sub diretórios
    /// </param>
    /// <param name="poListFiles">
    /// Arquivos que foram encontrados
    /// </param>
    /// <param name="poListExtensionAllow">
    /// Filtro de extensões permitidas, se vazio permite todas
    /// </param>
    class procedure ListFileDir(const psDirectory: string;
      poListFiles: TStringList; const poListExtensionAllow: Array of String; const pbRecursive: Boolean = True);
    /// <summary>
    /// Lista todos os sub diretórios podendo filtrar por nome
    /// </summary>
    /// <param name="psDirectory">
    /// Diretório origem que contém os sub diretórios
    /// </param>
    /// <param name="poListFiles">
    /// Diretórios que foram encontrados
    /// </param>
    /// <param name="poListExtensionAllow">
    /// Filtro de nomes de diretórios permitidas, se vazio permite todas
    /// </param>
    class procedure ListDir(const psDirectory: string; poListDir: TStringList;
      const poListNameDirAllow: Array of String);
    class function GetDirFormat(const psDirectory: String): String;
    class function RemoveAccents(const psText: string): string;
    class function RemoveCaracter(const aCaracter: array of string;
      const psText: string): string; overload;
    class function RemoveCaracter(const aCaracter, psText: string)
      : string; overload;
    class function SpecialCharacterSwitching(const psText: string;
      const pbLimExt: Boolean = true): string;
    class function StreamToString(const poStream: TStream): string;
    class function FindWindowByTitle(const psWindowTitle: string): Hwnd;
    class function XMLSaveToFile(const psFileName, psXML: string): Boolean;
    class function FormatSize(const pnSize: Extended): string;
    class function LocateStr(const poLocate: array of string;
      const psText: string): Boolean; Overload;
    class function LocateStr(const psLocate, psText: string): Boolean; Overload;
    class function FormatXMLData2(const psXML: string): string;
    class function GetXML(const psXML: string): TXMLDocument;
    class function RemoveEnter(const psText: string): string;
    class function ExtractWindowsDir: string;
    class function ExtractSystemDir: string;
    class function ExtractTempDir: string;
    class function FormatPath(const psPath: string): string;
    class function ExecuteBat(const psFileName: string;
      const pbHide: Boolean = true): Boolean;
    class function GetDirectoryTemp: string;
    class function GetDirectoryTempApp: string;
    class function ExtractFileNameUrl(const psUrl: string): String;
    class function DataSetToStringFormat(const poDataSet: TDataSet): String;
    class procedure StringFormatToDataSet(const poDataSet: TDataSet;
      const psTexto: String);
    class function InvertString(Const psValue: String): String;
    //Case insensitive
    class function PostInvertString(Const psLocate, psValue: String): Integer;
    //Case sensitive
    class function PosInvert(const psValue, psLocate: String): Integer;
    class procedure FreeAplication;
    class function ExtractDrive(const psPath: string): string;
    class procedure MyException(const poSender: TObject); overload;
    class procedure MyException(const psMessage: string;
      const pbShowError: Boolean = False;
      const psName: String = 'log'); overload;
    class function UpperCaseFirst(const psText: string): string;
    class function CompareIgnoreCase(const psText, psTextCompare
      : string): Boolean;
    class function ReadFile(const psFilePath: string): TStringList;
    class function WriteFile(const psFilePath: string; var poText: TStringList;
      const pbClearFile: Boolean = False): Boolean;
    class function IsInteger(const poValue: Variant): Boolean;
    class function IsFloat(const poValue: Variant): Boolean;
    class procedure FocusSet(poComponent: TWinControl;
      const pbDesabilite: Boolean = False);
    class function NumericAndKey(const psValue, psKey: string): string;

    class function InString(const psValue: String;
      const poList: array of String): Boolean;
    class function VarValidate(const poVariant: Variant): Boolean;
    class function VarToStr2(const poVariant: Variant): String;
    class function VarToInt(const poVariant: Variant): Integer;
    class procedure SetRecno(poDataSet: TDataSet; const pnRecno: Integer);
    class function GetValueList(poList: TStringList;
      const pnIndex: Integer): String;
    class procedure AddIfExistValue(var psVariable: String; const psAdd: string;
      const pbAfterValue: Boolean = true); Overload;
    class procedure AddIfExistValue(const psVariable: TStringList; const psAdd: string); Overload;
    class function StrToBoolean(const psStr: String): Boolean;
    class function BooleanToStr(const pbValor: Boolean): String;
    class procedure AssignStringList(var poListDest: TStringList; const poListOrigem: TStringList; const pbClearOldValue: Boolean);
    class function StringReplace2(const S: string; const OldPattern, NewPattern: array of string;
        Flags: TReplaceFlags): string; overload;
    class procedure DelimiterMaxLengthLine(const poList: TStringList; const poValueDelimiter: array of string; const pnLengthMax: Integer = 200);
  end;

var
  sUserActive: String;

implementation

uses uDMUtilsMessage, uDMCript, uDMException, uObjectActionTimeExecuting,
  uDMThreadUtils, uDMClasses, uFactoryObject;

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

class function TDMUtils.CharInSet(const psCharFInd: Char;
  const poListChar: array of Char): Boolean;
var
  nIndex: Integer;
begin
  Result := False;
  for nIndex := nCST_Zero to Length(poListChar) - nCST_One do
  begin
    if (poListChar[nIndex] = psCharFInd) then
    begin
      Result := true;
      Break;
    end;
  end;
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
      Result := true;
      TDMUtils.DeleteFile2(psFileName);
      poFile.Clear;
      poFile.Text := psText;
      poFile.SaveToFile(psFileName);
    except
      Result := False;
      MyException(sCST_ErrorCreatingFile, False);
    end;
  finally
    TDMUtils.DestroyObject(poFile);
  end;
end;

class procedure TDMUtils.DeleteAllFiles(const psDirectory: string);
var
  vSearchRec: tSearchREC;
  vErc: Integer;
  sDirectory: String;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'DeleteAllFiles');
  try
    try
      sDirectory := GetDirFormat(psDirectory);
      if not DirectoryExists(sDirectory) then
        Exit;

      FindFirst(sDirectory + '\*.*', faAnyFile, vSearchRec);
      vErc := nCST_Zero;
      while vErc = nCST_Zero do
      begin
        if ((vSearchRec.Name <> '.') and (vSearchRec.Name <> '..')) then
        begin
          if (vSearchRec.Attr and faDirectory > nCST_Zero) then
            DeleteAllFiles(sDirectory + vSearchRec.Name)
          else
            TDMUtils.DeleteFile2(sDirectory + vSearchRec.Name);
        end;
        vErc := FindNext(vSearchRec);
        Application.ProcessMessages;
      end;
      SysUtils.FindClose(vSearchRec);
    except
      MyException(sCST_ErroDeletingFile, true);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.DeleteDir(const poRootDir: TStringList);
var
  nIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'DeleteDir');
  try
    for nIndex := 0 to poRootDir.Count - 1 do
    begin
      TDMUtils.DeleteDir(poRootDir.Strings[nIndex]);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.DeleteDir(const psDirectory: string);
var
  vSearchRec: tSearchREC;
  vErc: Integer;
  sDirectory: string;
begin
  try
    sDirectory := GetDirFormat(psDirectory);
    if not DirectoryExists(sDirectory) then
      Exit;
    try
      FindFirst(sDirectory + '\*.*', faAnyFile, vSearchRec);
      vErc := nCST_Zero;
      while vErc = nCST_Zero do
      begin
        if ((vSearchRec.Name <> '.') and (vSearchRec.Name <> '..')) then
        begin
          if (vSearchRec.Attr and faDirectory > nCST_Zero) then
            DeleteDir(sDirectory + vSearchRec.Name)
          else
            TDMUtils.DeleteFile2(sDirectory + vSearchRec.Name);
        end;
        vErc := FindNext(vSearchRec);
        Application.ProcessMessages;
      end;
      SysUtils.FindClose(vSearchRec);
    finally
      RemoveDir2(sDirectory);
    end;
  except
    MyException(sCST_ErroDeletingDirectory, true);
  end;
end;

class function TDMUtils.DeleteFile2(const psFileName: TStringList): Boolean;
var
  vIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'DeleteFile2');
  try
    Result := False;
    if not Assigned(psFileName) then
      Exit;
    Result := true;
    for vIndex := nCST_Zero to psFileName.Count - nCST_One do
    begin
      if not TDMUtils.DeleteFile2(psFileName.Strings[vIndex]) then
        Result := False;
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.DeleteFileDelphiTemp(const psDirectory: String);
var
  poListFiles: TStringList;
begin
  poListFiles := TStringList.Create;
  try
    TDMUtils.ListFileDir(psDirectory, poListFiles, ['dcu', '~pas', '~dfm']);
    TDMUtils.DeleteFile2(poListFiles);
    poListFiles.Clear;
    TDMUtils.ListDir(psDirectory, poListFiles, ['__history']);
    TDMUtils.DeleteDir(poListFiles);
  finally
    TDMUtils.DestroyObject(poListFiles);
  end;
end;

class procedure TDMUtils.DeleteLineEmptySimple(var psText: String);
var
  oFileList: TStringList;
begin
  oFileList := TStringList.Create;
  try
    oFileList.Text := psText;
    TDMUtils.DeleteLineEmptySimple(oFileList);
    psText := oFileList.Text;
  finally
    TDMUtils.DestroyObject(oFileList);
  end;
end;

class procedure TDMUtils.DeleteLineEmpty(poFile: TStringList);
var
  oListThreadExplode: TListThreadFile;
begin
  if poFile.Count < 100 then
  begin
    TDMUtils.DeleteLineEmptySimple(poFile);
    Exit;
  end;
  oListThreadExplode := TListThreadFile.Create;
  try
    oListThreadExplode.FDataFile := poFile;
    oListThreadExplode.FMethodExecutar := TDMUtils.DeleteLineEmptySimple;
    oListThreadExplode.Execute;
  finally
    TDMUtils.DestroyObject(oListThreadExplode);
  end;
end;

class procedure TDMUtils.DeleteLineEmpty(var psText: String);
var
  oFile: TStringList;
begin
  oFile := TStringList.Create;
  try
    oFile.Text := psText;
    TDMUtils.DeleteLineEmpty(oFile);
    psText := oFile.Text;
  finally
    TDMUtils.DestroyObject(oFile);
  end;
end;

class procedure TDMUtils.DeleteLineEmptySimple(poList: TStringList);
var
  nIndex: Integer;
begin
  if not Assigned(poList) then
    Exit;

  for nIndex := poList.Count - nCST_One downto nCST_Zero do
  begin
    if TDMUtils.IsEmpty(poList.Strings[nIndex]) then
      poList.Delete(nIndex);
  end;
end;

class function TDMUtils.DeleteFile2(const psFileName: string): Boolean;
begin
  Result := true;
  try
    if FileExists(Trim(psFileName)) then
      DeleteFile(PChar(Trim(psFileName)));
  except
    Result := False;
    MyException(sCST_ErroDeletingFile, true);
    Exit;
  end;
end;

class function TDMUtils.ExecuteBat(const psFileName: string;
  const pbHide: Boolean = true): Boolean;
const
  nCST_ExecuteSucessful = 32;
begin
  Application.ProcessMessages;
  Result := False;
  try
    if FileExists2(psFileName) then
      Result := ShellExecute(Application.Handle, PChar(sCST_Open),
        PChar(psFileName), PChar(sCST_EmptyStr), PChar(sCST_EmptyStr),
        TDMUtils.IIf(pbHide, SW_HIDE, SW_SHOWNORMAL)) = nCST_ExecuteSucessful;

  except
    TDMUtils.MyException(sCST_ErroExecutingFile);
  end;
  Application.ProcessMessages;
end;

class function TDMUtils.Explode(const psText, psExplode: string;
  const pbExcluirTag: Boolean; const pbNewLineBefore, pbNewLineAfter,
  pbAllowAddLineEmpty: Boolean): TStringList;
var
  sText: String;
begin
  sText := psText;
  TDMUtils.ExplodeStr(sText, psExplode, pbExcluirTag, pbNewLineBefore,
    pbNewLineAfter, pbAllowAddLineEmpty);

  Result := TStringList.Create;
  Result.Text := sText;
end;

class procedure TDMUtils.ExplodeList(var psText: String;
  const psExplode: array of string; const pbExcluirTag, pbNewLineBefore,
  pbNewLineAfter, pbAllowAddLineEmpty: Boolean);
var
  oListThreadExplode: TListThreadExplodeStr;
  // nIDTimeFunction: Integer;
  oDataFile: TStringList;
  nIndex: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'ExplodeStr1');
  try
    if Length(Trim(psText)) < 1000 then
    begin
      for nIndex := 0 to Length(psExplode) - 1 do
      begin
        TDMUtils.ExplodeStrSimple(psText, psExplode[nIndex], pbExcluirTag,
          pbNewLineBefore, pbNewLineAfter, pbAllowAddLineEmpty);
      end;
      Exit;
    end;
    oListThreadExplode := TListThreadExplodeStr.Create;
    oDataFile := TStringList.Create;
    try
      oDataFile.Text := psText;
      oListThreadExplode.FbExcluirTag := pbExcluirTag;
      oListThreadExplode.FDataFile := oDataFile;
      oListThreadExplode.FoMethodExecutarExplodeStr :=
        TDMUtils.ExplodeStrSimple;

      for nIndex := 0 to Length(psExplode) - 1 do
      begin
        oListThreadExplode.AddExplode(psExplode[nIndex]);
      end;

      oListThreadExplode.FbNewLineBefore := pbNewLineBefore;
      oListThreadExplode.FbNewLineAfter := pbNewLineAfter;
      oListThreadExplode.FbAllowAddLineEmpty := pbAllowAddLineEmpty;
      oListThreadExplode.Execute;
      psText := oDataFile.Text;
    finally
      TDMUtils.DestroyObject(oDataFile);
      TDMUtils.DestroyObject(oListThreadExplode);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.ExplodeList(poList: TStringList;
  const psExplode: array of string; const pbExcluirTag, pbNewLineBefore,
  pbNewLineAfter, pbAllowAddLineEmpty: Boolean);
var
  oListThreadExplode: TListThreadExplodeStr;
  // nIDTimeFunction: Integer;
  nIndex: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'ExplodeStr1');
  try
    if poList.Count < 100 then
    begin
      for nIndex := 0 to Length(psExplode) - 1 do
      begin
        TDMUtils.ExplodeListStrSimple(poList, psExplode[nIndex], pbExcluirTag,
          pbNewLineBefore, pbNewLineAfter, pbAllowAddLineEmpty);
      end;
      Exit;
    end;
    oListThreadExplode := TListThreadExplodeStr.Create;
    try
      oListThreadExplode.FbExcluirTag := pbExcluirTag;
      oListThreadExplode.FDataFile := poList;
      oListThreadExplode.FoMethodExecutarExplodeStr :=
        TDMUtils.ExplodeStrSimple;
      for nIndex := 0 to Length(psExplode) - 1 do
      begin
        oListThreadExplode.AddExplode(psExplode[nIndex]);
      end;

      oListThreadExplode.FbNewLineBefore := pbNewLineBefore;
      oListThreadExplode.FbNewLineAfter := pbNewLineAfter;
      oListThreadExplode.FbAllowAddLineEmpty := pbAllowAddLineEmpty;
      oListThreadExplode.Execute;
    finally
      TDMUtils.DestroyObject(oListThreadExplode);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.ExplodeStr(psText: TStringList;
  const psExplode: string; const pbExcluirTag, pbNewLineBefore, pbNewLineAfter,
  pbAllowAddLineEmpty: Boolean);
var
  oListThreadExplode: TListThreadExplodeStr;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'ExplodeStr1');
  try
    if psText.Count < 100 then
    begin
      TDMUtils.ExplodeListStrSimple(psText, psExplode, pbExcluirTag,
        pbNewLineBefore, pbNewLineAfter, pbAllowAddLineEmpty);
      Exit;
    end;
    oListThreadExplode := TListThreadExplodeStr.Create;
    try
      oListThreadExplode.FbExcluirTag := pbExcluirTag;
      oListThreadExplode.FDataFile := psText;
      oListThreadExplode.FoMethodExecutarExplodeStr :=
        TDMUtils.ExplodeStrSimple;
      oListThreadExplode.AddExplode(psExplode);

      oListThreadExplode.FbNewLineBefore := pbNewLineBefore;
      oListThreadExplode.FbNewLineAfter := pbNewLineAfter;
      oListThreadExplode.FbAllowAddLineEmpty := pbAllowAddLineEmpty;
      oListThreadExplode.Execute;
    finally
      TDMUtils.DestroyObject(oListThreadExplode);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.ExplodeStr(var psText: string; const psExplode: string;
  const pbExcluirTag, pbNewLineBefore, pbNewLineAfter, pbAllowAddLineEmpty
  : Boolean);
var
  oListThreadExplode: TListThreadExplodeStr;
  // nIDTimeFunction: Integer;
  oDataFile: TStringList;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'ExplodeStr1');
  try
    if Length(Trim(psText)) < 1000 then
    begin
      TDMUtils.ExplodeStrSimple(psText, psExplode, pbExcluirTag,
        pbNewLineBefore, pbNewLineAfter, pbAllowAddLineEmpty);
      Exit;
    end;
    oListThreadExplode := TListThreadExplodeStr.Create;
    oDataFile := TStringList.Create;
    try
      oDataFile.Text := psText;
      oListThreadExplode.FbExcluirTag := pbExcluirTag;
      oListThreadExplode.FDataFile := oDataFile;
      oListThreadExplode.FoMethodExecutarExplodeStr :=
        TDMUtils.ExplodeStrSimple;
      oListThreadExplode.AddExplode(psExplode);

      oListThreadExplode.FbNewLineBefore := pbNewLineBefore;
      oListThreadExplode.FbNewLineAfter := pbNewLineAfter;
      oListThreadExplode.FbAllowAddLineEmpty := pbAllowAddLineEmpty;
      oListThreadExplode.Execute;
      psText := oDataFile.Text;
    finally
      TDMUtils.DestroyObject(oDataFile);
      TDMUtils.DestroyObject(oListThreadExplode);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.ExplodeListStrSimple(var poText: TStringList;
  const psExplode: string; const pbExcluirTag, pbNewLineBefore, pbNewLineAfter,
  pbAllowAddLineEmpty: Boolean);
var
  sText: string;
begin
  if not Assigned(poText) then
    Exit;
  sText := poText.Text;
  ExplodeStrSimple(sText, psExplode, pbExcluirTag, pbNewLineBefore,
    pbNewLineAfter, pbAllowAddLineEmpty);
  poText.Text := sText;
end;

class procedure TDMUtils.ExplodeStrSimple(var psText: string;
  const psExplode: string; const pbExcluirTag, pbNewLineBefore, pbNewLineAfter,
  pbAllowAddLineEmpty: Boolean);
var
  nIndex: Integer;
  sExplode: string;
  sText: string;
  bFirst: Boolean;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'ExplodeList');
  try
    if ((psText = '') or (psExplode = '')) then
      Exit;

    sText := psText;
    psText := sCST_EmptyStr;

    nIndex := Pos(psExplode, sText);
    bFirst := True;
    while (nIndex <> nCST_Zero) do
    begin
      sExplode := Copy(sText, nCST_One, nIndex - nCST_One);
      sText := Copy(sText, nIndex + Length(psExplode), Length(sText));

      psText := psText + TDMUtils.IIf(not bFirst, #13) + sExplode;
      bFirst := False;

      if (not pbExcluirTag) and
        ((not pbAllowAddLineEmpty) or (pbAllowAddLineEmpty and
        TDMUtils.ExistValue(psExplode))) then
        psText := psText + TDMUtils.IIf(pbNewLineBefore, #13) + psExplode;

      nIndex := Pos(psExplode, sText);
      if (nIndex = nCST_Zero) then
      begin
        if (not TDMUtils.IsEmpty(sText)) then
          psText := psText + TDMUtils.IIf(pbNewLineAfter, #13) + sText;

        sText := sCST_EmptyStr;
      end;
    end;

    if (not TDMUtils.IsEmpty(sText)) or
      (TDMUtils.IsEmpty(psText) and ((not pbAllowAddLineEmpty) or
      (pbAllowAddLineEmpty and TDMUtils.ExistValue(sText)))) then
      psText := sText;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.ExtractBlock(poList: TStringList;
  const psTagBegin, psTagEnd: String; const pbRemoveTag: Boolean);
var
  nIndex, nIndexBegin: Integer;
  sLine: String;
  bBegin: Boolean;
  oListTemp: TStringList;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'ExtractBlock');
  try
    if not Assigned(poList) then
      Exit;

    oListTemp := TStringList.Create;
    try
      bBegin := False;
      for nIndex := nCST_Zero to poList.Count - nCST_One do
      begin
        sLine := poList.Strings[nIndex];
        nIndexBegin := TDMUtils.PosIgnoreCase(psTagBegin, sLine);
        if (not bBegin) and TDMUtils.ExistValue(nIndexBegin) then
        begin
          if pbRemoveTag then
            nIndexBegin := nIndexBegin + Length(psTagBegin);

          sLine := Copy(sLine, nIndexBegin, Length(sLine));
          bBegin := true;
        end;

        if not bBegin then
          Continue;

        nIndexBegin := TDMUtils.PosIgnoreCase(psTagEnd, sLine);
        if TDMUtils.ExistValue(nIndexBegin) then
        begin
          if not pbRemoveTag then
            nIndexBegin := nIndexBegin + Length(psTagEnd)
          else
            nIndexBegin := nIndexBegin - nCST_One;

          sLine := Copy(sLine, nCST_One, nIndexBegin);
          bBegin := true;
        end;

        oListTemp.Add(sLine)
      end;
    finally
      poList.Text := oListTemp.Text;
      TDMUtils.DestroyObject(oListTemp);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.ExtractBlock(var psText: String;
  const psTagBegin, psTagEnd: String; const pbRemoveTag: Boolean);
var
  oList: TStringList;
begin
  oList := TStringList.Create;
  try
    oList.Add(psText);
    ExtractBlock(oList, psTagBegin, psTagEnd, pbRemoveTag);
  finally
    psText := Trim(oList.Text);
    TDMUtils.DestroyObject(oList);
  end;
end;

class function TDMUtils.ExtractDrive(const psPath: string): string;
var
  vIndex: Integer;
begin
  vIndex := Pos(sCST_BeginDrive, psPath);
  Result := sCST_EmptyStr;
  if (vIndex <= nCST_Zero) then
    vIndex := Pos('\\', psPath);
  if (vIndex > nCST_Zero) then
    Result := Copy(psPath, nCST_One, vIndex + nCST_One);
end;

class function TDMUtils.ExtractSystemDir: string;
var
  vBuffer: array [0 .. 144] of Char;
begin
  GetSystemDirectory(vBuffer, 144);
  Result := FormatPath(StrPas(vBuffer));
end;

class function TDMUtils.ExtractTempDir: string;
var
  vBuffer: array [0 .. 144] of Char;
begin
  GetTempPath(144, vBuffer);
  Result := FormatPath(StrPas(vBuffer));
end;

class function TDMUtils.ExtractWindowsDir: string;
var
  vBuffer: array [0 .. 144] of Char;
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
  NextTitle: array [0 .. 260] of Char;
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
  DirSep: Char = {$IFDEF Unix} '/'{$ELSE} '\'{$ENDIF};
var
  P: Integer;
  SC: Char;
  sPath: string;
begin
  sPath := psPath;
  if ord(DirSep) = ord('/') then
    SC := '\'
  else
    SC := '/';

  repeat
    P := Pos(SC, sPath);
    if P > nCST_Zero then
      sPath[P] := DirSep;
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
    0:
      Result := 'B';
    1:
      Result := 'kB';
    2:
      Result := 'MB';
    3:
      Result := 'GB';
    4:
      Result := 'TB';
    5:
      Result := 'PB';
    6:
      Result := 'EB';
    7:
      Result := 'ZB';
    8:
      Result := 'YB'
  else
    Result := 'B';
  end;
  Result := TDMUtils.IntToStr2(TDMUtils.FloatToInt2(sSize)) +
    sCST_Space + Result;
end;

class function TDMUtils.FormatValue(const psFormat: string;
  const psValue: Extended): string;
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

      if (Copy(vDirectory, Length(vDirectory), nCST_One) = sCST_Backslash) then
        vDirectory := Copy(vDirectory, nCST_One, Length(vDirectory) - nCST_One);

      vText.Add('cacls "' + vDirectory + '" /E /G "All":F');

      vDirectory := ExtractFilePath(Application.ExeName);

      if (Copy(vDirectory, Length(vDirectory), nCST_One) = sCST_Backslash) then
        vDirectory := Copy(vDirectory, nCST_One, Length(vDirectory) - nCST_One);
      vText.Add('cacls "' + vDirectory + '" /E /G "Todos":F');
      vText.Add('exit;');
      TDMUtils.CreateFile(vFile, vText.Text);
      TDMUtils.ExecuteBat(vFile);
      Sleep(nCST_two);
      TDMUtils.DeleteFile2(vFile)
    except
      TDMUtils.MyException(sCST_ErrorCreatingFilePermission, False);
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

class function TDMUtils.GetDirectoryTempApp: string;
begin
  Result := FormatDirectory(ExtractFilePath(Application.ExeName)) + 'WinTemp\';
end;

class function TDMUtils.GetDirFormat(const psDirectory: String): String;
begin
  Result := psDirectory;
  if TDMUtils.ExistValue(Result) and (Copy(Result, Length(Result), 1) <> '\')
  then
    Result := Result + '\';
  Result := ExtractFilePath(Result);
  if not(TDMUtils.ExisteString(':\', Result) or TDMUtils.ExisteString('\\',
    Result)) then
  begin
    Result := sCST_EmptyStr;
    Exit;
  end;
end;

class function TDMUtils.GetFileName(const psFilePath: String;
  pbRemoveExt: Boolean): String;
begin
  Result := ExtractFileName(psFilePath);
  if pbRemoveExt then
    Result := Copy(Result, 1, Length(Result) -
      Length(ExtractFileExt(psFilePath)));
end;

class function TDMUtils.GetHaveCharStr(const psText: string): Boolean;
var
  sChar: Char;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'GetHaveCharStr');
  try
    for sChar := 'a' to 'z' do
    begin
      Result := TDMUtils.ExisteString(sChar, psText);
      if Result then
        Break;
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.GetValueList(poList: TStringList;
  const pnIndex: Integer): String;
begin
  Result := sCST_EmptyStr;
  if Assigned(poList) and (poList.Count > pnIndex) and (pnIndex >= 0) then
    Result := poList.Strings[pnIndex];
end;

class function TDMUtils.GetXML(const psXML: string): TXMLDocument;
begin
  Result := TXMLDocument.Create(nil);
  Result.LoadFromXML(psXML);
  Result.Active := true;
end;

class function TDMUtils.FormatExtended(const psValue: Extended): string;
begin
  Result := FormatValue(sCST_FormatExtended, psValue);
end;

class function TDMUtils.FormatDate2(const pdDate: TDateTime): string;
begin
  Result := FormatDateTime(sCST_FormatDate, pdDate);
end;

class function TDMUtils.FormatDateTime2(const psFormat: string;
  const pdDate: TDateTime): string;
begin
  Result := FormatDateTime(psFormat, pdDate);
end;

class function TDMUtils.FormatDirectory(const psDirectory: string): string;
begin
  Result := psDirectory;
  if (Copy(Result, Length(Result), nCST_One) <> '\') then
    Result := Result + '\';
end;

class function TDMUtils.FormatDateTime2(const pdDate: TDateTime): string;
begin
  Result := FormatDateTime2('dd/mm/yyyy hh:mm:ss', pdDate);
end;

class function TDMUtils.IIf(const pbCondition: Boolean;
  const poReturnTrue, poReturnFalse: Variant): Variant;
begin
  Result := poReturnFalse;
  if (pbCondition) then
    Result := poReturnTrue;
end;

class function TDMUtils.IIf(const pbCondition: Boolean;
  const pnReturnTrue: Integer): Integer;
begin
  Result := nCST_Zero;
  if (pbCondition) then
    Result := pnReturnTrue;
end;

class function TDMUtils.IIf(const pbCondition: Boolean;
  const psReturnTrue: string): string;
begin
  Result := sCST_EmptyStr;
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
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'IsEmpty');
  try
    Result := False;
    for vIndex := nCST_Zero to high(poValue) - nCST_One do
    begin
      Result := IsEmpty(poValue[vIndex]);

      if (Result) then
        Break;
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.IsEmpty(const poValue: array of string): Boolean;
var
  vIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'IsEmpty');
  try
    Result := False;
    for vIndex := nCST_Zero to high(poValue) do
    begin
      Result := IsEmpty(poValue[vIndex]);

      if (Result) then
        Break;
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.IsEmpty(const psValue: string): Boolean;
begin
  Result := (Trim(psValue) = sCST_EmptyStr);
end;

class function TDMUtils.IsFloat(const poValue: Variant): Boolean;
var
  nValue: Extended;
  sValue: string;
begin
  sValue := Trim(VarToStr2(poValue));
  Result := TextToFloat(PChar(sValue), nValue, fvExtended);
end;

class function TDMUtils.IsInteger(const poValue: Variant): Boolean;
var
  nError: Integer;
  nValue: Integer;
  sValue: string;
begin
  sValue := Trim(VarToStr2(poValue));
  Val(sValue, nValue, nError);
  Result := (nError = nCST_Zero);
  if nValue = 0 then
    Exit;
end;

class procedure TDMUtils.ListDir(const psDirectory: string;
  poListDir: TStringList; const poListNameDirAllow: array of String);
var
  oSearchRec: tSearchREC;
  nIndex, nErc: Integer;
  bAllowAdd: Boolean;
  sDirectory, sName: string;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'ListDir');
  try
    try
      sDirectory := GetDirFormat(psDirectory);

      if not DirectoryExists(sDirectory) then
        Exit;

      FindFirst(sDirectory + '\*.*', faAnyFile, oSearchRec);
      nErc := nCST_Zero;
      while nErc = nCST_Zero do
      begin
        if ((oSearchRec.Name <> '.') and (oSearchRec.Name <> '..')) then
        begin
          if (oSearchRec.Attr and faDirectory > nCST_Zero) then
          begin
            bAllowAdd := true;
            sName := oSearchRec.Name;
            for nIndex := 0 to Length(poListNameDirAllow) - 1 do
            begin
              bAllowAdd := TDMUtils.CompareIgnoreCase(sName,
                poListNameDirAllow[nIndex]);
              if bAllowAdd then
                Break;
            end;

            if bAllowAdd then
              poListDir.Add(sDirectory + oSearchRec.Name + '\');

            ListDir(sDirectory + oSearchRec.Name + '\', poListDir,
              poListNameDirAllow);
          end;
        end;
        nErc := FindNext(oSearchRec);
        Application.ProcessMessages;
      end;
      SysUtils.FindClose(oSearchRec);
    except
      MyException(sCST_ErroDeletingFile, true);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.ListFileDir(const psDirectory: string;
  poListFiles: TStringList; const poListExtensionAllow: Array of String; const pbRecursive: Boolean);
var
  oSearchRec: tSearchREC;
  nIndex, nErc: Integer;
  bAllowAdd: Boolean;
  sDirectory, sExtension: string;
begin
  try
    sDirectory := psDirectory;
    if Copy(sDirectory, Length(sDirectory), 1) <> '\' then
      sDirectory := sDirectory + '\';

    if not DirectoryExists(sDirectory) then
      Exit;

    FindFirst(sDirectory + '\*.*', faAnyFile, oSearchRec);
    nErc := nCST_Zero;
    while nErc = nCST_Zero do
    begin
      if ((oSearchRec.Name <> '.') and (oSearchRec.Name <> '..')) then
      begin
        if (oSearchRec.Attr and faDirectory > nCST_Zero) then
        begin
          if pbRecursive then
            ListFileDir(sDirectory + oSearchRec.Name, poListFiles,
            poListExtensionAllow);
        end
        else
        begin
          bAllowAdd := true;
          sExtension := ExtractFileExt(oSearchRec.Name);
          sExtension := Copy(sExtension, 2, Length(sExtension));
          for nIndex := 0 to Length(poListExtensionAllow) - 1 do
          begin
            bAllowAdd := TDMUtils.CompareIgnoreCase(sExtension,
              poListExtensionAllow[nIndex]);
            if bAllowAdd then
              Break;
          end;
          if bAllowAdd then
            poListFiles.Add(sDirectory + oSearchRec.Name);
        end;
      end;
      nErc := FindNext(oSearchRec);
      Application.ProcessMessages;
    end;
    SysUtils.FindClose(oSearchRec);
  except
    MyException(sCST_ErroDeletingFile, true);
  end;
end;

class function TDMUtils.LocateStr(const psLocate, psText: string): Boolean;
begin
  Result := (Pos(UpperCase(psLocate), UpperCase(psText)) > nCST_Zero);
end;

class procedure TDMUtils.MyException(const poSender: TObject);
begin
  TDMUtils.MyException(sCST_ErrorIn + poSender.ClassName, False);
end;

class function TDMUtils.ReadFile(const psFilePath: string): TStringList;
var
  oTextFile: TextFile;
  sLine: string;
begin
  Result := TStringList.Create;
  try
    Result.Clear;
    if not FileExists2(psFilePath) then
      Exit;
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
  except
    TDMUtils.MyException(sCST_ErroWritingFile, False);
    TDMUtils.DestroyObject(Result);
    Exit;
  end;
end;

class function TDMUtils.RemoveAccents(const psText: string): string;
var
  nIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'RemoveAccents');
  try
    Result := psText;
    for nIndex := nCST_Zero to Length(Result) - nCST_One do
    begin
      if Pos(Result[nIndex], cComAcento) <> nCST_Zero then
        Result[nIndex] := cSemAcento[Pos(Result[nIndex], cComAcento)];
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.RemoveBlock(var poList, poListRemove: TStringList;
  const psTagBegin, psTagEnd: String; const pbRemoveTag: Boolean;
  const psIgnoreBefore, psNewValue: String);
var
  nIndex, nIndexAfter, nIndexBegin: Integer;
  sLine: String;
  bBegin: Boolean;
  oListTemp: TStringList;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'RemoveBlock');
  try
    if not(Assigned(poList) and Assigned(poListRemove)) then
      Exit;

    oListTemp := TStringList.Create;
    try
      bBegin := False;
      for nIndex := nCST_Zero to poList.Count - nCST_One do
      begin
        sLine := poList.Strings[nIndex];
        if not bBegin then
          oListTemp.Add(sLine)
        else
          oListTemp.Add(sCST_EmptyStr);

        nIndexBegin := TDMUtils.PosIgnoreCase(psTagBegin, sLine);
        nIndexAfter := TDMUtils.PosIgnoreCase(psIgnoreBefore, sLine);
        if (nIndexAfter < nIndexBegin) and TDMUtils.ExistValue(nIndexAfter) then
          nIndexBegin := nCST_Zero;

        if (not bBegin) and TDMUtils.ExistValue(nIndexBegin) then
        begin
          oListTemp.Strings[nIndex] :=
            (Copy(sLine, nCST_One, nIndexBegin - nCST_One));
          if pbRemoveTag then
            nIndexBegin := nIndexBegin + Length(psTagBegin)
          else
            nIndexBegin := nIndexBegin;

          sLine := Copy(sLine, nIndexBegin, Length(sLine));
          bBegin := true;

          if TDMUtils.IsEmpty(psTagEnd) then
          begin
            bBegin := False;
            if TDMUtils.ExistValue(sLine) then
              poListRemove.Add(sLine);
            sLine := sCST_EmptyStr;
          end;
        end;

        if not bBegin then
          Continue;

        nIndexBegin := TDMUtils.PosIgnoreCase(psTagEnd, sLine);
        if TDMUtils.ExistValue(nIndexBegin) then
        begin
          if pbRemoveTag then
            nIndexBegin := nIndexBegin + Length(psTagEnd);

          poListRemove.Add(Copy(sLine, nCST_One, nIndexBegin - nCST_One));
          sLine := Copy(sLine, nIndexBegin, Length(sLine));
          bBegin := False;
        end;

        if not bBegin then
          oListTemp.Strings[nIndex] :=
            Trim(oListTemp.Strings[nIndex] + ' ' + sLine);
      end;
    finally
      poList.Text := oListTemp.Text;
      TDMUtils.DestroyObject(oListTemp);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.RemoveBlock(var psText: string;
  const psTagBegin, psTagEnd: String; const pbRemoveTag: Boolean;
  const psIgnoreBefore: String);
var
  oList: TStringList;
begin
  oList := TStringList.Create;
  try
    oList.Add(psText);
    RemoveBlock(oList, psTagBegin, psTagEnd, pbRemoveTag, psIgnoreBefore);
  finally
    psText := Trim(oList.Text);
    TDMUtils.DestroyObject(oList);
  end;
end;

class procedure TDMUtils.RemoveBlock(poList: TStringList;
  const psTagBegin, psTagEnd: String; const pbRemoveTag: Boolean;
  const psIgnoreBefore: String);
var
  nIndex, nIndexAfter, nIndexBegin: Integer;
  sLine: String;
  bBegin: Boolean;
  oListTemp: TStringList;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'RemoveBlock');
  try
    if not Assigned(poList) then
      Exit;

    oListTemp := TStringList.Create;
    try
      bBegin := False;
      for nIndex := nCST_Zero to poList.Count - nCST_One do
      begin
        sLine := poList.Strings[nIndex];
        if not bBegin then
          oListTemp.Add(sLine)
        else
          oListTemp.Add(sCST_EmptyStr);

        nIndexBegin := TDMUtils.PosIgnoreCase(psTagBegin, sLine);
        nIndexAfter := TDMUtils.PosIgnoreCase(psIgnoreBefore, sLine);
        if (nIndexAfter < nIndexBegin) and TDMUtils.ExistValue(nIndexAfter) then
          nIndexBegin := nCST_Zero;

        if (not bBegin) and TDMUtils.ExistValue(nIndexBegin) then
        begin
          oListTemp.Strings[nIndex] :=
            (Copy(sLine, nCST_One, nIndexBegin - nCST_One));
          if pbRemoveTag then
            nIndexBegin := nIndexBegin + Length(psTagBegin)
          else
            nIndexBegin := nIndexBegin;

          sLine := Copy(sLine, nIndexBegin, Length(sLine));
          bBegin := true;

          if TDMUtils.IsEmpty(psTagEnd) then
          begin
            bBegin := False;
            sLine := sCST_EmptyStr;
          end;
        end;

        if not bBegin then
          Continue;

        nIndexBegin := TDMUtils.PosIgnoreCase(psTagEnd, sLine);
        if TDMUtils.ExistValue(nIndexBegin) then
        begin
          if pbRemoveTag then
            nIndexBegin := nIndexBegin + Length(psTagEnd);

          sLine := Copy(sLine, nIndexBegin, Length(sLine));
          bBegin := False;
        end;

        if not bBegin then
          oListTemp.Strings[nIndex] :=
            Trim(oListTemp.Strings[nIndex] + ' ' + sLine);
      end;
    finally
      poList.Text := oListTemp.Text;
      TDMUtils.DestroyObject(oListTemp);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.RemoveCaracter(const aCaracter, psText: string): string;
var
  vList: TStringList;
  vIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'RemoveCaracter');
  try
    vList := TDMUtils.Explode(aCaracter);
    Result := psText;
    try
      for vIndex := nCST_Zero to vList.Count - nCST_One do
      begin
        Result := StringReplace(Result, vList.Strings[vIndex], sCST_EmptyStr,
          [rfReplaceAll]);
      end;
    finally
      TDMUtils.DestroyObject(vList);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.RemoveComment(poList: TStringList);
begin
  TDMUtils.RemoveBlock(poList, '{', '}', true, '//');
  TDMUtils.RemoveBlock(poList, '//', '', true);
  TDMUtils.RemoveBlock(poList, '''', '''', true);
end;

class procedure TDMUtils.RemoveDir2(const aRootDir: string);
begin
  if DirectoryExists(aRootDir) then
    RemoveDir(aRootDir);
end;

class function TDMUtils.RemoveCaracter(const aCaracter: array of string;
  const psText: string): string;
var
  vIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'RemoveCaracter');
  try
    Result := psText;
    for vIndex := nCST_Zero to high(aCaracter) do
    begin
      Result := StringReplace(Result, aCaracter[vIndex], sCST_EmptyStr,
        [rfReplaceAll]);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.RemoveEnter(const psText: string): string;
begin
  Result := Trim(TDMUtils.RemoveCaracter([#13, #10, #$D#$A], Trim(psText)));
end;

class procedure TDMUtils.SetRecno(poDataSet: TDataSet;
  const pnRecno: Integer);
begin
  if (pnRecno > 0) and TDMUtils.ExistValue(poDataSet) and
    (poDataSet.RecordCount >= pnRecno) then
    poDataSet.RecNo := pnRecno;
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
        Result := nCST_Zero;
        MyException(sCST_ErrorGettingFileSize, true);
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
    Result := nCST_Zero;
  end;
end;

class function TDMUtils.StrToBoolean(const psStr: String): Boolean;
const
  sCST_Sim_Char = 'S';
  sCST_True_Char = 'T';
  sCST_True_Integer = '1';
  sCST_True = 'True';
begin
  Result := TDMUtils.InString(Trim(psStr), [sCST_True_Integer, sCST_Sim,
    sCST_Sim_Char, sCST_True_Char, sCST_True]);
end;

class function TDMUtils.StrToDateTime2(const psFormat, pdDate: string)
  : TDateTime;
var
  vYear, vMonth, vDay, vHour, vMinute, vSecond, vMiliSecond: Integer;
  sFormat: string;
  sDate: string;

  function LocateDate(const aStr: string): Integer;
  var
    vIndex: Integer;
  begin
    Result := nCST_Zero;
    vIndex := Pos(aStr, UpperCase(sFormat));
    if (vIndex > nCST_Zero) then
    begin
      Result := TDMUtils.StrToInt2(Copy(sDate, vIndex, Length(aStr)));
      sFormat := Copy(sFormat, nCST_One, vIndex - nCST_One) +
        Copy(sFormat, vIndex + Length(aStr), Length(sFormat));
      sDate := Copy(sDate, nCST_One, vIndex - nCST_One) +
        Copy(sDate, vIndex + Length(aStr), Length(sDate));
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
  Result := EncodeDateTime(vYear, vMonth, vDay, vHour, vMinute, vSecond,
    vMiliSecond);
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

class function TDMUtils.WriteFile(const psFilePath: string;
  var poText: TStringList; const pbClearFile: Boolean): Boolean;
var
  vArq: TextFile;
  vIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'WriteFile');
  try
    try
      Result := true;
      TDMUtils.CreateDirectory(psFilePath);
      try
        AssignFile(vArq, psFilePath);
        if FileExists(psFilePath) and (not pbClearFile) then
          Append(vArq)
        else
          ReWrite(vArq);

        for vIndex := nCST_Zero to poText.Count - nCST_One do
        begin
          WriteLn(vArq, poText[vIndex]);
        end;
      except
        TDMUtils.MyException(sCST_ErrorWritingDataToFile);
        Result := False;
        Exit;
      end;
    finally
      CloseFile(vArq);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
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
      vDoc.Active := true;
      vDoc.SaveToFile(psFileName);
    except
      Result := False;
      MyException('Erro ao salva arquivo!', true);
      Exit;
    end;
  finally
    TDMUtils.DestroyObject(vDoc);
  end;
end;

class function TDMUtils.SpecialCharacterSwitching(const psText: string;
  const pbLimExt: Boolean): string;
var
  vIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'SpecialCharacterSwitching');
  try
    Result := psText;
    for vIndex := nCST_One to 38 do
    begin
      Result := StringReplace(Result, cCaracterEspeciais[vIndex],
        cCaracterTroca[vIndex], [rfReplaceAll]);
    end;

    if not(pbLimExt) then
      Exit;
    for vIndex := nCST_One to 30 do
    begin
      Result := StringReplace(Result, cCaracterExtra[vIndex], sCST_EmptyStr,
        [rfReplaceAll]);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.IsEmpty(const psValue: Extended): Boolean;
begin
  Result := (psValue = nCST_Zero);
end;

class procedure TDMUtils.MyException(const psMessage: string;
  const pbShowError: Boolean = False; const psName: String = 'log');
var
  vArq: TextFile;
  sMessage, sFileName, sException: string;
begin
  try
    sFileName := ExtractFilePath(Application.ExeName) + psName + '.txt';
    AssignFile(vArq, sFileName);
    if FileExists(sFileName) then
      Append(vArq)
    else
    begin
      ReWrite(vArq);
      WriteLn(vArq, sCST_TitleLog); // TDMCript.Encrypts(
    end;

    sMessage := psMessage;
    sException := TDMException.GetMessageException;
    if TDMUtils.ExistValue(sException) then
      sMessage := sMessage + sCST_Space + sCST_MessageError + sException;

    if TDMUtils.ExistValue(sUserActive) then
      sMessage := sMessage + ' Username Active: ' + sUserActive;
    WriteLn(vArq, TDMUtils.FormatDateTime2(now) + sCST_TraceSpaces + sMessage);

    CloseFile(vArq);

    if pbShowError then
      TDMUtilsMessage.ShowMessageError(sMessage);
  except
    Exit;
  end;
end;

class procedure TDMUtils.FocusSet(poComponent: TWinControl;
  const pbDesabilite: Boolean = False);
begin
  try
    if (poComponent.Visible and poComponent.Enabled and poComponent.CanFocus and
      poComponent.Showing) then
      poComponent.SetFocus;

    if pbDesabilite then
      poComponent.Enabled := False;
  except
    TDMUtils.MyException('Error set focus');
  end;
end;

class function TDMUtils.StreamToString(const poStream: TStream): string;
var
  ms: TMemoryStream;
begin
  Result := sCST_EmptyStr;
  ms := TMemoryStream.Create;
  try
    ms.LoadFromStream(poStream);
    SetString(Result, PChar(ms.memory), ms.Size);
  finally
    TDMUtils.DestroyObject(ms);
  end;
  Result := Trim(Result);
end;

class function TDMUtils.NumericAndKey(const psValue, psKey: string): string;
var
  nIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'NumericAndKey');
  try
    Result := psValue;
    for nIndex := nCST_Zero to Length(Result) - nCST_One do
    begin
      if not((Result[nIndex] = psKey) or IsInteger(Result[nIndex])) then
        Result[nIndex] := ' ';
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
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
    ShellExecute(Application.Handle, 'open', PChar(psURLSite), nil,
      nil, sw_show);
end;

class function TDMUtils.StrCompare(const psValueFirst, psValueSecond
  : string): Boolean;
begin
  Result := UpperCase(Trim(psValueFirst)) = UpperCase(Trim(psValueSecond));
end;

class function TDMUtils.LocateStr(const poLocate: array of string;
  const psText: string): Boolean;
var
  nIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'LocateStr');
  try
    Result := False;
    for nIndex := nCST_Zero to Length(poLocate) - nCST_One do
    begin
      if LocateStr(poLocate[nIndex], psText) then
      begin
        Result := true;
        Break;
      end;
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
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

class function TDMUtils.InString(const psValue: String;
  const poList: array of String): Boolean;
var
  nIndex: Integer;
begin
  Result := False;
  for nIndex := nCST_Zero to Length(poList) - nCST_One do
  begin
    if StrCompare(poList[nIndex], psValue) then
    begin
      Result := true;
      Break;
    end;
  end;
end;

class function TDMUtils.CompareIgnoreCase(const psText, psTextCompare
  : string): Boolean;
begin
  Result := (Trim(UpperCase(psText)) = Trim(UpperCase(psTextCompare)));
end;

class procedure TDMUtils.CopyDFMForLib(const psDirectoryOrigin,
  psDirectoryDestination: String);
var
  poListFiles: TStringList;
  nIndex: Integer;
  sFile: String;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'CopyDFMForLib');
  try
    if not(DirectoryExists(psDirectoryOrigin) and
      DirectoryExists(psDirectoryDestination)) then
      Exit;

    poListFiles := TStringList.Create;
    try
      TDMUtils.ListFileDir(psDirectoryOrigin, poListFiles, ['dfm']);
      for nIndex := 0 to poListFiles.Count - 1 do
      begin
        sFile := poListFiles.Strings[nIndex];
        if (TDMUtils.FileExists2(sFile) and not TDMUtils.CompareIgnoreCase
          (ExtractFilePath(sFile), ExtractFilePath(psDirectoryDestination)))
        then
          CopyFile(PChar(poListFiles.Strings[nIndex]),
            PChar(ExtractFilePath(psDirectoryDestination) +
            ExtractFileName(sFile)), False);
      end;
    finally
      TDMUtils.DestroyObject(poListFiles);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.UpperCaseFirst(const psText: string): string;
begin
  Result := UpperCase(Copy(psText, nCST_One, nCST_One)) + Copy(psText, nCST_two,
    Length(psText));
end;

class function TDMUtils.VarValidate(const poVariant: Variant): Boolean;
begin
  Result := not(VarIsNull(poVariant) and VarIsEmpty(poVariant));
end;

class function TDMUtils.VarToStr2(const poVariant: Variant): String;
begin
  Result := sCST_EmptyStr;
  if VarValidate(poVariant) then
    Result := VarToStr(poVariant);
end;

class function TDMUtils.VarToInt(const poVariant: Variant): Integer;
begin
  Result := StrToInt2(VarToStr2(poVariant));
end;

class function TDMUtils.FormatDateTimeSQL(const pdDate: TDateTime): string;
const
  sCST_FormatDateTimeSQL = 'YYYY/MM/DD HH:MM:SS.ZZZZ';
begin
  Result := QuotedStr(FormatDateTime2(sCST_FormatDateTimeSQL, pdDate));
end;

class function TDMUtils.FormatDateSQL(const pdDate: TDate): string;
begin
  Result := FormatDateTimeSQL(pdDate);
end;

class function TDMUtils.CaptureFunctionName(const pnLevel: Integer): String;
begin {
    var
    StackList : TJclStackInfoList;
    SL : TStringList;
    begin
    StackList := JclCreateStackList(false,0,Caller(0,false));
    SL := TStringList.Create;
    StackList.AddToStrings(SL,true,true,true,true);
    ShowMessage(SL.Text);
    TDMUtils.DestroyObject(SL)
    TDMUtils.DestroyObject(Stacklist) }
end;

class procedure TDMUtils.AddIfExistValue(var psVariable: String;
  const psAdd: string; const pbAfterValue: Boolean = true);
begin
  if TDMUtils.ExistValue(psVariable) then
  begin
    if pbAfterValue then
      psVariable := psVariable + psAdd
    else
      psVariable := psAdd + psVariable;
  end;
end;

class procedure TDMUtils.AssignStringList(var poListDest: TStringList; const poListOrigem: TStringList; const pbClearOldValue: Boolean);
begin
  if (not Assigned(poListOrigem)) then
  begin
    TDMUtils.DestroyObject(poListDest);
    Exit;
  end
  else
  if (not Assigned(poListDest)) then
    poListDest := TStringList.Create;

  poListDest.Text := TDMUtils.IIf((not pbClearOldValue) and TDMUtils.ExistValue(poListDest.Text), poListDest.Text + #13) + poListOrigem.Text;
end;

class function TDMUtils.BooleanToStr(const pbValor: Boolean): String;
begin
  Result := 'F';
  if pbValor then
    Result := 'T';
end;

class function TDMUtils.ByteToString(const poValue: Array of Byte): String;
var
  i: Integer;
  S: String;
  Letra: Char;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'ByteToString');
  try
    S := '';
    for i := Length(poValue) - 1 Downto 0 do
    begin
      Letra := Chr(poValue[i] + 48);
      S := Letra + S;
    end;

    Result := S;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.Ping(const psIP: String; const pnQtde: Integer)
  : Boolean;
var
  oFile: TStringList;
  sFilePath: String;
  nIndex: Integer;
  // nIDTimeFunction: Integer;
const
  nCST_ExecuteSucessful = 32;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'Ping');
  try
    oFile := TStringList.Create;
    try
      for nIndex := 0 to pnQtde - 1 do
      begin
        oFile.Add('ping ' + psIP + ' -t');
      end;
      oFile.Add('exit');
      sFilePath := ExtractFilePath(Application.ExeName) + 'test.bat';
      TDMUtils.WriteFile(sFilePath, oFile, true);
      Result := ShellExecute(Application.Handle, 'open', PChar(sFilePath), nil,
        nil, SW_HIDE) = nCST_ExecuteSucessful;
      TDMUtils.DeleteFile2(sFilePath)
    finally
      TDMUtils.DestroyObject(oFile);
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.ExtractFileNameUrl(const psUrl: string): String;
var
  nIndexBegin: Integer;
begin
  nIndexBegin := TDMUtils.PosInvert(psUrl, '/');
  Result := '';
  if TDMUtils.ExistValue(nIndexBegin) then
    Result := Copy(psUrl, nIndexBegin + 1, Length(psUrl));
end;

class function TDMUtils.InvertString(const psValue: String): String;
var
  nIndex: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'InvertString');
  try
    Result := '';
    for nIndex := Length(psValue) downto 1 do
    begin
      Result := Result + psValue[nIndex];
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.PosAfterIndex(const psLocalizar, psTexto: string;
  const pnIndexBegin: Integer; const pbIgnoreCase: Boolean): Integer;
begin
  if pbIgnoreCase then
    Result := Pos(UpperCase(psLocalizar),
      UpperCase(Copy(psTexto, pnIndexBegin, Length(psTexto))))
  else
    Result := Pos(psLocalizar, Copy(psTexto, pnIndexBegin, Length(psTexto)));
  if (Result > 0) then
    Result := Result + pnIndexBegin;
end;

class function TDMUtils.PosIgnoreCase(const psLocalizar, psTexto: string;
  const pbIgnoreCase: Boolean): Integer;
begin
  if pbIgnoreCase then
    Result := Pos(UpperCase(psLocalizar), UpperCase(psTexto))
  else
    Result := Pos(psLocalizar, psTexto);
end;

class function TDMUtils.PosInvert(const psValue, psLocate: String): Integer;
var
  sValue: String;
begin
  sValue := TDMUtils.InvertString(psValue);
  Result := Pos(psLocate, sValue);
  Result := Length(psValue) - Result;
end;

class function TDMUtils.PostInvertString(const psLocate,
  psValue: String): Integer;
var
  sCommand: String;
begin
  sCommand := TDMUtils.InvertString(psValue);
  Result := TDMUtils.PosIgnoreCase(psLocate, sCommand);
  if TDMUtils.ExistValue(Result) then
    Result := Length(psValue) - Result + 1;
end;

class function TDMUtils.DataSetToStringFormat(const poDataSet
  : TDataSet): String;
var
  nIndexFields: Integer;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self, 'DataSetToStringFormat');
  try
    Result := '';
    if not(Assigned(poDataSet) and poDataSet.Active) then
      Exit;

    poDataSet.DisableControls;
    try
      poDataSet.First;
      while not poDataSet.eof do
      begin
        for nIndexFields := 0 to poDataSet.Fields.Count - 1 do
        begin
          Result := Result + poDataSet.Fields[nIndexFields].AsString + '|';
        end;
        Result := Result + ']';
        poDataSet.Next;
      end;
    finally
      poDataSet.EnableControls;
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class procedure TDMUtils.StringFormatToDataSet(const poDataSet: TDataSet;
  const psTexto: String);
var
  nIndexFields, nIndexLines: Integer;
  oListaLines, oListaValues: TStringList;
  // nIDTimeFunction: Integer;
begin
  // nIDTimeFunction := FObjectActionTimeExecuting.BeginExecuting(Self,'StringFormatToDataSet');
  try
    if not Assigned(poDataSet) then
      Exit;

    if (not poDataSet.Active) then
      poDataSet.open;
    poDataSet.DisableControls;
    try
      oListaLines := TDMUtils.Explode(psTexto, ']');
      for nIndexLines := 0 to oListaLines.Count - 1 do
      begin
        poDataSet.Insert;
        oListaValues := TDMUtils.Explode(psTexto, '|');
        for nIndexFields := 0 to oListaValues.Count - 1 do
        begin
          if poDataSet.Fields.Count > nIndexFields then
            poDataSet.Fields[nIndexFields].AsString := oListaValues.Strings
              [nIndexFields];
        end;
        poDataSet.Post;
      end;
    finally
      poDataSet.EnableControls;
    end;
  finally
    // FObjectActionTimeExecuting.EndExecuting(nIDTimeFunction);
  end;
end;

class function TDMUtils.ValidateCommand(const psValidate, psCommand, psTag,
  psAfterCommand, psBeforeCommand: String): Boolean;
var
  sNew2, sValidate, sNew, sCommand: String;
  nIndex: Integer;
begin
  sCommand := psCommand;
  sValidate := psValidate;
  Result := TDMUtils.CompareIgnoreCase(sValidate, sCommand);
  if Result then
    Exit;

  nIndex := TDMUtils.PosIgnoreCase(psTag, sCommand);
  while TDMUtils.ExistValue(nIndex) do
  begin
    sNew := Copy(sCommand, 1, nIndex - 1) + psBeforeCommand;
    sCommand := psAfterCommand + Copy(sCommand, nIndex + Length(psTag),
      Length(sCommand));
    sNew2 := Copy(sValidate, 1, nIndex + Length(psBeforeCommand) - 1);
    sValidate := Copy(sValidate, nIndex + Length(psBeforeCommand),
      Length(sValidate));

    if not TDMUtils.CompareIgnoreCase(sNew, sNew2) then
      Exit;

    Result := TDMUtils.CompareIgnoreCase(sValidate, sCommand);
    if Result then
      Exit;

    nIndex := TDMUtils.PosIgnoreCase(sCommand, sValidate);
    sValidate := Copy(sValidate, nIndex, Length(sValidate));
    Result := TDMUtils.CompareIgnoreCase(sValidate, sCommand);
    if Result then
      Exit;
    nIndex := TDMUtils.PosIgnoreCase(psTag, sCommand);
  end;
end;

class function TDMUtils.IsEmpty(const poField: TField): Boolean;
begin
  Result := Assigned(poField) and Assigned(poField.DataSet) and
    TDMUtils.IsEmpty(poField.AsString);
end;

class function TDMUtils.IsEmpty(const poDataSet: TDataSet): Boolean;
begin
  Result := not(Assigned(poDataSet) and poDataSet.Active and
    ((poDataSet.RecordCount > nCST_Zero) or (poDataSet.State in [dsInsert,
    dsEdit])));
end;

class function TDMUtils.IsEmpty(const poValue: TStringList): Boolean;
begin
  Result := not(Assigned(poValue) and TDMUtils.ExistValue(poValue.Text))
end;

class function TDMUtils.ExistValue(const poField: TField): Boolean;
begin
  Result := TDMUtils.IsEmpty(poField);
end;

class function TDMUtils.ExistePalavra(const psLocalizar, psTexto: string;
  const pbIgnoreCase: Boolean): Boolean;
begin
  Result := TDMUtils.ExisteString(sCST_Space + psLocalizar + sCST_Space,
    sCST_Space + psTexto + sCST_Space);
end;

class function TDMUtils.ExisteString(const psLocalizar, psTexto: string;
  const pbIgnoreCase: Boolean): Boolean;
begin
  Result := TDMUtils.ExistValue(TDMUtils.PosIgnoreCase(psLocalizar, psTexto));
end;

class function TDMUtils.ExistValue(const poDataSet: TDataSet): Boolean;
begin
  Result := not TDMUtils.IsEmpty(poDataSet);
end;

class function TDMUtils.ExistValue(const poValue: TStringList): Boolean;
begin
  Result := not TDMUtils.IsEmpty(poValue);
end;

class function TDMUtils.StringReplace2(const S: string; const OldPattern,
  NewPattern: array of string; Flags: TReplaceFlags): string;
var
  i: Integer;
begin
  for i := 0 to Length(OldPattern) - 1 do
  begin
    Result := stringReplace(S, OldPattern[i], NewPattern[i], Flags);
  end;
end;

class procedure TDMUtils.AddIfExistValue(const psVariable: TStringList;
  const psAdd: string);
begin
  if Assigned(psVariable) and ExistValue(psAdd) then
    psVariable.Add(psAdd);
end;

class procedure TDMUtils.DelimiterMaxLengthLine(const poList: TStringList; const poValueDelimiter: array of string; const pnLengthMax: Integer);
var
  nColunasVoltar, nIndexFinal, i, nLengthCurrent, nNewIndex: Integer;
  sText: String;
begin
  if not Assigned(poList) then
    Exit;

  for i := poList.Count -1 downto 0 do
  begin
    sText := poList.Strings[i];
    nLengthCurrent := Length(sText);
    if (nLengthCurrent <= pnLengthMax) then
      Continue;

    nNewIndex :=  i;
    while TDMUtils.ExistValue(sText) do
    begin
      nColunasVoltar := trunc((pnLengthMax / 10));
      nIndexFinal := TDMUtils.PosAfterIndex(poValueDelimiter, sText, pnLengthMax - nColunasVoltar);
      if (nIndexFinal > 0) then
      begin
        if (nNewIndex <> i) then
          poList.Insert(nNewIndex, Copy(sText, 1, nIndexFinal - 1))
        else
          poList.Strings[nNewIndex] := Copy(sText, 1, nIndexFinal - 1);

        sText := Copy(sText, nIndexFinal, Length(sText));
        inc(nNewIndex);
      end
      else
      begin
        if (nNewIndex <> i) then
        begin
          poList.Insert(nNewIndex, Copy(sText, 1, Length(sText)));
          nNewIndex := i;
        end;

        sText := EmptyStr;
      end;
    end;
  end;
end;

class function TDMUtils.PosAfterIndex(const psLocalizar: array of String;
  const psTexto: string; const pnIndexBegin: Integer;
  const pbIgnoreCase: Boolean): Integer;
var
  i, IndexAtual: Integer;
begin
  Result := 0;
  for i := 0 to Length(psLocalizar) -1 do
  begin
    IndexAtual := PosAfterIndex(psLocalizar[i], psTexto, pnIndexBegin, pbIgnoreCase);
    if ((Result = 0) or ((IndexAtual > 0) and (IndexAtual < Result))) then
      Result := IndexAtual;
  end;
end;

initialization

DMClasses.RegisterClass(TDMUtils);

end.