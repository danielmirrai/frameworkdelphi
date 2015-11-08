unit uDMThreadUtils;

interface

uses
  SysUtils, uConstantUtils, {JclDebug,} DBClient, Windows, Db, Forms,
  uDMUtils, Contnrs, Dialogs, DateUtils, XMLDoc, ShellAPI, Controls, Variants,
  Classes, uDMList, Math;

type
  TThreadFile = class;
  TProcedureFile = procedure(var psFile: string) of object;
  TProcedureFileExplode = procedure(var poList: String;
    const psExplode: Array of string; const pbExcluirTag: Boolean = true;
    const pbNewLineBefore: Boolean = true; const pbNewLineAfter: Boolean = true;
    const pbAllowAddLineEmpty: Boolean = False) of Object;

  TProcedureFileExplodeStr = procedure(var psText: String;
    const psExplode: string; const pbExcluirTag, pbNewLineBefore,
    pbNewLineAfter, pbAllowAddLineEmpty: Boolean) of Object;

  TListThreadFile = Class(TObjectList)
  private
    function GetItem(Index: Integer): TThreadFile;
    procedure SetItem(Index: Integer; const Value: TThreadFile);
  protected
    function GetNewThread: TThreadFile; virtual;
    procedure ExecuteMethod(var psText: string); virtual;
  public
    FDataFile: TStringList;
    FMethodExecutar: TProcedureFile;
    procedure Execute; virtual;
    constructor Create; Virtual;
    function Add(const pnIndexLineBegin, pnCountLineExecute: Integer)
      : TThreadFile; reintroduce;
    property Item[Index: Integer]: TThreadFile read GetItem write SetItem;
  end;

  TListThreadExplode = Class(TListThreadFile)
  protected
    procedure ExecuteMethod(var psText: string); Override;
  public
    FbExcluirTag: Boolean;
    FoExplode: TListString;
    FbNewLineBefore, FbNewLineAfter, FbAllowAddLineEmpty: Boolean;
    FoMethodExecutarExplode: TProcedureFileExplode;

    constructor Create; Override;
    procedure AddExplode(const psValue: String);
  end;

  TListThreadExplodeStr = Class(TListThreadExplode)
  protected
    procedure ExecuteMethod(var psText: string); Override;
  public
    FoMethodExecutarExplodeStr: TProcedureFileExplodeStr;
    constructor Create; Override;
  end;

  TDMThread = class(TThread)
  public
    function Terminou: Boolean;
  end;

  TThreadFile = class(TDMThread)
  public
    FText: String;
    FoFileOrigem: TStringList;
    FnIndexLineBegin, FnCountLineExecute: Integer;
    FOwner: TListThreadFile;
    procedure AfterConstruction; override;
    procedure Execute; Override;
  end;

implementation

{ TThreadExplode }

{ TListThreadExplode }

procedure TListThreadExplode.AddExplode(const psValue: String);
begin
  SetLength(FoExplode, Length(FoExplode) + 1);
  FoExplode[Length(FoExplode) - 1] := psValue;
end;

constructor TListThreadExplode.Create;
begin
  inherited;
  SetLength(FoExplode, 0);
  FbExcluirTag := true;
  FoMethodExecutarExplode := nil;
  FbNewLineBefore := true;
  FbNewLineAfter := true;
  FbAllowAddLineEmpty := False;
end;

procedure TListThreadExplode.ExecuteMethod(var psText: string);
begin
  if Assigned(FoMethodExecutarExplode) then
    FoMethodExecutarExplode(psText, FoExplode, FbExcluirTag, FbNewLineBefore,
      FbNewLineAfter, FbAllowAddLineEmpty);
end;

{ TDMThread }

function TDMThread.Terminou: Boolean;
begin
  Result := Terminated;
end;

{ TThreadFile }

procedure TThreadFile.AfterConstruction;
begin
  inherited;
  FOwner := nil;
  FText := sCST_EmptyStr;
  FoFileOrigem := nil;
  FnIndexLineBegin := nCST_Zero;
  FnCountLineExecute := nCST_Zero;
  FreeOnTerminate := False;
end;

procedure TThreadFile.Execute;
var
  nCount, nIndexLine, nIndex: Integer;
begin
  FText := sCST_EmptyStr;
  nCount := FoFileOrigem.Count;
  for nIndex := 0 to FnCountLineExecute - 1 do
  begin
    nIndexLine := nIndex + (FnIndexLineBegin * FnCountLineExecute);
    if (nIndexLine >= nCount) then
      Break;
    FText := FText + #13 + FoFileOrigem.Strings[nIndexLine];
  end;

  FOwner.ExecuteMethod(FText);
  Terminate;
end;

{ TListThreadFile }

function TListThreadFile.Add(const pnIndexLineBegin, pnCountLineExecute
  : Integer): TThreadFile;
begin
  Result := TThreadFile.Create(true);
  Result.FoFileOrigem := FDataFile;
  Result.FOwner := Self;
  Result.FnIndexLineBegin := pnIndexLineBegin;
  Result.FnCountLineExecute := pnCountLineExecute;
  inherited Add(Result);
end;

constructor TListThreadFile.Create;
begin
  inherited;
  FDataFile := nil;
  FMethodExecutar := nil;
end;

procedure TListThreadFile.Execute;
var
  oThreadFile: TThreadFile;
  nIndex, nCountLinesInThread, nCountThread: Integer;
  sText: string;
begin
  sText := FDataFile.text;
  if Length(Trim(sText)) < 0 then
    Exit;

  try
    nCountThread := 30;
    nCountLinesInThread := Math.Ceil(FDataFile.Count / nCountThread);
    if (nCountLinesInThread < 50) then
    begin
      nCountLinesInThread := 50;
      nCountThread := Math.Ceil(FDataFile.Count / nCountLinesInThread);
    end;

    if (FDataFile.Count <= nCountLinesInThread) then
    begin
      ExecuteMethod(sText);
      Exit;
    end;

    sText := sCST_EmptyStr;
    for nIndex := 0 to nCountThread - 1 do
    begin
      oThreadFile := Self.Add(nIndex, nCountLinesInThread);
      oThreadFile.Execute;
    end;

    sText := sCST_EmptyStr;
    for nIndex := 0 to Self.Count - 1 do
    begin
      oThreadFile := Self.Item[nIndex];
      if not Assigned(oThreadFile) then
        Continue;

      while not oThreadFile.Terminou do
      begin
        Application.ProcessMessages;
      end;
      sText := Trim(sText) + #13 + Trim(oThreadFile.FText);
    end;
  finally
    FDataFile.text := Trim(sText);
  end;
end;

procedure TListThreadFile.ExecuteMethod(var psText: string);
begin
  if Assigned(FMethodExecutar) then
    FMethodExecutar(psText);
end;

function TListThreadFile.GetItem(Index: Integer): TThreadFile;
begin
  Result := TThreadFile(inherited GetItem(Index));
end;

function TListThreadFile.GetNewThread: TThreadFile;
begin
  Result := TThreadFile.Create(true);
end;

procedure TListThreadFile.SetItem(Index: Integer; const Value: TThreadFile);
begin
  inherited SetItem(Index, Value);
end;

{ TListThreadExplodeStr }

constructor TListThreadExplodeStr.Create;
begin
  inherited;

end;

procedure TListThreadExplodeStr.ExecuteMethod(var psText: string);
var
  nIndex: Integer;
begin
  if not Assigned(FoMethodExecutarExplodeStr) then
    Exit;

  for nIndex := 0 to Length(FoExplode) - 1 do
  begin
    FoMethodExecutarExplodeStr(psText, FoExplode[nIndex], FbExcluirTag,
      FbNewLineBefore, FbNewLineAfter, FbAllowAddLineEmpty);
  end;
end;

end.
