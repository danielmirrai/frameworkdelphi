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
unit uObjectActionComment;

interface

uses
  uObjectAction, uDMList, uObjectDaoComment, Classes, Forms, SysUtils,
  uConstantTrack,
  uDMThreadUtils, TypInfo, uConstantCommand, uConstantComment,
  uConstantUtils, uDMUtils;

type

  /// <summary>
  /// Comentário do arquivo
  /// </summary>
  TObjectActionComment = Class(TObjectAction)
  private
    FDataFile: TStringList;
    procedure SetDataFile(const Value: TStringList);
    procedure RemoveBlock(const ptTypeComment: TTypeComment;
      const pbSetCommandInFile: Boolean = False);
    function AddComment(const psMessage: string;
      const ptTypeComment: TTypeComment): String;
    function GetTagType(const ptTypeComment: TTypeComment;
      var psTagBegin, psTagEnd, psIgnoreBefore: String): string;
    function GetFormatID(const ptTypeComment: TTypeComment): String; virtual;
  public
    FObjectDaoComment: TObjectDaoComment;

    /// <summary>
    /// Localiza o comando na base de dados
    /// </summary>
    function LocateRegistry(const psCommand: string;
      const pnID: Integer): Boolean;
    procedure AfterConstruction; override;

    /// <summary>
    /// Formatar o arquivo deixando cada comando em uma linha separada
    /// </summary>
    procedure FormatAllCommands;

    /// <summary>
    /// Importa os comandos do arquivo para o App e modifica os comandos no
    /// arquivo para o ID do comando.
    /// </summary>
    procedure Import; override;
    procedure BeforeDestruction; override;

    /// <summary>
    /// Unit que será mapeada
    /// </summary>
    property DataFile: TStringList read FDataFile write SetDataFile;
  end;

implementation

uses uObjectActionTimeExecuting;

function TObjectActionComment.AddComment(const psMessage: string;
  const ptTypeComment: TTypeComment): String;
begin
  Result := sCST_EmptyStr;
  if TDMUtils.IsEmpty(psMessage) then
    Exit;

  Add;
  FObjectDaoComment.CDSDadosDATA.AsString := psMessage;
  FObjectDaoComment.CDSDadosID_TYPE_COMMENT.AsInteger := Integer(ptTypeComment);
  Save;
  Result := Format(GetFormatID(ptTypeComment),
    [FObjectDaoComment.CDSDadosID.AsInteger]);
end;

procedure TObjectActionComment.AfterConstruction;
begin
  inherited;
  FObjectDaoComment := GetObjectDao as TObjectDaoComment;
  FDataFile := nil;
end;

procedure TObjectActionComment.BeforeDestruction;
begin
  FDataFile := nil;
  inherited;
end;

procedure TObjectActionComment.FormatAllCommands;
begin
  TDMUtils.ExplodeList(FDataFile, [' ', '$', '{', '}', 'DMSymbol',
    sCST_OtherValueStr], False);
end;

function TObjectActionComment.GetFormatID(const ptTypeComment
  : TTypeComment): String;
const
  sCST_IdComment = '|ID_Comment_%d|';
  sCST_IdDirective = '|ID_Comment_%d|';
  sCST_IdString = '|ID_String_%d|';
begin
  Result := sCST_IdComment;
  case ptTypeComment of
    tcDirective:
      Result := sCST_IdDirective;
    tcBlockCurlyBrackets, tcBlockParentheses, tcLine:
      Result := sCST_IdComment;
    tcText:
      Result := sCST_IdString;
  end;
end;

function TObjectActionComment.GetTagType(const ptTypeComment: TTypeComment;
  var psTagBegin, psTagEnd, psIgnoreBefore: String): string;
begin
  psIgnoreBefore := '';
  psTagBegin := '';
  psTagEnd := '';
  case ptTypeComment of
    tcDirective:
      begin
        psTagBegin := '{$';
        psTagEnd := '}';
        psIgnoreBefore := '//';
      end;
    tcBlockCurlyBrackets:
      begin
        psTagBegin := '{';
        psTagEnd := '}';
        psIgnoreBefore := '//';
      end;
    tcBlockParentheses:
      begin
        psTagBegin := '(*';
        psTagEnd := '*)';
        psIgnoreBefore := '//';
      end;
    tcLine:
      begin
        psTagBegin := '//';
      end;
    tcText:
      begin
        psTagBegin := '''';
        psTagEnd := '''';
      end;
  end;
end;

procedure TObjectActionComment.Import;
var
  nIndex: Integer;
begin
  if not Assigned(FDataFile) then
    Exit;

  for nIndex := nCST_Zero to Ord(High(TTypeComment)) do
  begin
    RemoveBlock(TTypeComment(nIndex));
  end;
end;

function TObjectActionComment.LocateRegistry(const psCommand: string;
  const pnID: Integer): Boolean;
var
  nIndex: Integer;
begin
  Result := False;
  for nIndex := nCST_Zero to Ord(High(TTypeComment)) do
  begin
    if TDMUtils.ExisteString(psCommand, GetFormatID(TTypeComment(nIndex))) then
    begin
      Result := FObjectDaoComment.CDSDados.Locate
        (FObjectDaoComment.CDSDadosID.FieldName, pnID, []);
      Break;
    end;
  end;
end;

procedure TObjectActionComment.RemoveBlock(const ptTypeComment: TTypeComment;
  const pbSetCommandInFile: Boolean);
var
  nIndex, nIndexAfter, nIndexBegin, nIndexEnd: Integer;
  sCommand, sTagBegin, sTagEnd, sIgnoreBefore, sLine: String;
  bBegin: Boolean;
  oListRemove, oListTemp: TStringList;

  procedure CalculeIndex;
  begin
    nIndexBegin := TDMUtils.PosIgnoreCase(sTagBegin, sLine);
    nIndexAfter := TDMUtils.PosIgnoreCase(sIgnoreBefore, sLine);
    nIndexEnd := TDMUtils.PosIgnoreCase(sTagEnd, sLine);
    if (nIndexAfter < nIndexBegin) and TDMUtils.ExistValue(nIndexAfter) then
      nIndexBegin := nCST_Zero;
  end;

begin
  if not(Assigned(FDataFile)) then
    Exit;

  GetTagType(ptTypeComment, sTagBegin, sTagEnd, sIgnoreBefore);
  if TDMUtils.IsEmpty(sTagBegin) and TDMUtils.IsEmpty(sTagEnd) and
    TDMUtils.IsEmpty(sIgnoreBefore) then
    Exit;

  oListRemove := TStringList.Create;
  oListTemp := TStringList.Create;
  try
    bBegin := False;
    for nIndex := nCST_Zero to FDataFile.Count - nCST_One do
    begin
      sLine := FDataFile.Strings[nIndex];
      if not bBegin then
        oListTemp.Add(sLine)
      else
        oListTemp.Add(sCST_EmptyStr);

      CalculeIndex;
      while TDMUtils.ExistValue(nIndexBegin) or
        TDMUtils.ExistValue(nIndexEnd) do
      begin
        if (not bBegin) and TDMUtils.ExistValue(nIndexBegin) then
        begin
          oListTemp.Strings[nIndex] :=
            (Copy(sLine, nCST_One, nIndexBegin - nCST_One));
          nIndexBegin := nIndexBegin + Length(sTagBegin);
          sLine := Copy(sLine, nIndexBegin, Length(sLine));
          bBegin := True;

          if TDMUtils.IsEmpty(sTagEnd) then
          begin
            bBegin := False;
            sCommand := AddComment(sLine, ptTypeComment);
            if pbSetCommandInFile then
              oListTemp.Strings[nIndex] := oListTemp.Strings[nIndex] + ' '
                + sCommand;
            sLine := sCST_EmptyStr;
          end;
        end;

        if not bBegin then
        begin
          sLine := sCST_EmptyStr;
          CalculeIndex;
          Continue;
        end;

        CalculeIndex;
        if TDMUtils.ExistValue(nIndexEnd) then
        begin
          sCommand := AddComment(Trim(Copy(sLine, nCST_One, nIndexEnd - 1)),
            ptTypeComment);
          if pbSetCommandInFile then
            oListTemp.Strings[nIndex] :=
              Trim(oListTemp.Strings[nIndex] + ' ' + sCommand);

          sLine := Copy(sLine, nIndexEnd + Length(sTagEnd), Length(sLine));
          bBegin := False;
        end;

        if not bBegin then
          oListTemp.Strings[nIndex] :=
            Trim(oListTemp.Strings[nIndex] + ' ' + sLine);
        sLine := oListTemp.Strings[nIndex];
        CalculeIndex;
      end;
    end;
  finally
    FDataFile.Text := oListTemp.Text;
    TDMUtils.DestroyObject(oListTemp);
    TDMUtils.DestroyObject(oListRemove);
  end;
end;

procedure TObjectActionComment.SetDataFile(const Value: TStringList);
begin
  FDataFile := Value;
end;

initialization

RegisterClass(TObjectActionComment);

end.
