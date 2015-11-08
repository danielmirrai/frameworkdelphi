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
unit uObjectActionCommand;

interface

uses
  uObjectAction, uObjectDaoCommand, Classes, Forms, SysUtils, uConstantCommand,
  TypInfo, uDMList, uObjectDao,
  uConstantUtils, uDMUtils, uObjectActionCustom, Contnrs, DB,
  uDMThreadUtils, uFactoryObject;

type
  TAddCommand = function(const psCommand: String; const pbIsNotCommand: Boolean)
    : string of Object;

  /// <summary>
  ///
  /// <font style="BACKGROUND-COLOR: #ffffe0">Definição do comando Delphi que será importado e mapeado</font>
  /// </summary>
  TItemCommand = class(TObjectActionCustom)
  private
    FCommand: string;

  protected
    class function GetItemCommandFormated(const psCommand: string): String;
    function IsLineNotValidate(const psLine: String): Boolean;

  public
    procedure Assign(Source: TPersistent;
      const pbClearOldValue: Boolean); Override;
    destructor Destroy; Override;

    /// <summary>
    /// Retorna o comando formatado
    /// </summary>
    function GetCommand: string; virtual;

    /// <summary>
    /// Retorna comando que deve ser diferente
    /// </summary>
    function GetNotSpecificCommand: string; virtual;

    /// <summary>
    /// Verifica se comando é diferente
    /// </summary>
    class function NotIsCommandEquals(const pbValidateEquals: Boolean;
      const psLineValidate, psCommand: string): Boolean;

    class function IsCommandAnyValue(const psLineValidate: string): Boolean;

    /// <summary>
    /// Comando possui string
    /// </summary>
    function IsStringOperator: Boolean;
    procedure AfterConstruction; override;

    /// <summary>
    /// Separa o ID e comando
    /// </summary>
    class procedure ExplodeCommandAndID(var psCommand: string;
      var pnID: Integer);
  end;

  TClassCommand = class of TItemCommand;

  TListCommand = Class(TLisTObjectActionCustom)
  private
  protected
    function GetItems(Index: Integer): TItemCommand; reintroduce; virtual;
    procedure SetItems(Index: Integer; const Value: TItemCommand); reintroduce; virtual;
  public
    constructor Create(AOwner: TComponent); Override;


    destructor Destroy; Override;

    /// <summary>
    /// Carrega a lista de todos os comandos
    /// </summary>
    procedure ImportAll; virtual;

    /// <summary>
    /// Adiciona novo comando
    /// </summary>
    /// <param name="poClassCommand">
    /// Classe do comando que será adicionada
    /// </param>
    function Add(poClassCommand: TClassCommand): TItemCommand; overload;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
    property Items[Index: Integer]: TItemCommand read GetItems write SetItems;

  end;

  TObjectActionCommand = Class(TObjectAction)
  private
    FDataFile: TStringList;
    procedure SetDataFile(const Value: TStringList);
  protected
    function GetFormatID: String; virtual;
    procedure AddAllCommand; Virtual;
    function GetListCommand: TListCommand; virtual;
  public
    FObjectDaoCommand: TObjectDaoCommand;

    procedure Assign(Source: TPersistent;
      const pbClearOldValue: Boolean); Override;
    function GetIDType: Integer; virtual;
    procedure Add; Override;
    /// <summary>
    /// Localiza o comando no arquivo e importa para o app. Modifica o comando no arquivo para o ID do comando no app.
    /// </summary>
    /// <param name="poFile">
    /// Arquivo Origem
    /// </param>
    /// <param name="poDataCommand">
    /// Comando a ser localizado
    /// </param>
    /// <param name="poAddCommand">
    /// Configuração do comando
    /// </param>
    /// <param name="pbValidateEquals">
    /// Comando deve ser igual
    /// </param>
    procedure LocateAndSetFileCommand;

    /// <summary>
    /// Localiza o registro do comando pelo o ID
    /// </summary>
    function LocateRegistry(const psCommand: string; const pnID: Integer)
      : Boolean; Virtual;

    /// <summary>
    /// Quebra a linha a cada comando
    /// </summary>
    /// <example>
    /// <para>
    /// =
    /// </para>
    /// <para>
    /// class
    /// </para>
    /// <para>
    /// (
    /// </para>
    /// </example>
    procedure FormatAllCommands; virtual;

    constructor Create(poOwner: TComponent;
      poObjectDao: TObjectDao = nil); Override;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    /// <summary>
    /// Adiciona um comando
    /// </summary>
    procedure AddCommand(poCommand: TItemCommand); Virtual;
    procedure Save; Override;

    /// <summary>
    /// Importa os comandos cadastrados no arquivo para o DB
    /// </summary>
    /// <remarks>
    /// Modifica os comandos no arquivo para o ID cadastrado
    /// </remarks>
    procedure Import; Override;

    /// <summary>
    /// Retorna a Tag ID do comando caso não existe cadastra
    /// </summary>
    /// <param name="poListValue">
    /// <font style="BACKGROUND-COLOR: #ffffe0">Valor do arquivo a ser cadastrado</font>
    /// </param>
    /// <param name="psCommand">
    /// Comando
    /// </param>
    /// <param name="pbIsNotCommand">
    /// <font style="BACKGROUND-COLOR: #ffffe0">Validar diferente</font>
    /// </param>
    function GetIdentFormat(const psCommand: String;
      const pbIsNotCommand: Boolean): String; Virtual;

    /// <summary>
    /// Arquivo que será mapeado
    /// </summary>
    property DataFile: TStringList read FDataFile write SetDataFile;
  end;

  TClassObjectActionCommand = class of TObjectActionCommand;

  TListActionCommand = Class(TListObjectAction)
  private
    FDataFile: TStringList;
    procedure SetDataFile(const Value: TStringList);
  protected
    function GetItems(Index: Integer): TObjectActionCommand; reintroduce;
    procedure SetItems(Index: Integer; const Value: TObjectActionCommand);
      reintroduce;
  public
    /// <summary>
    /// Adiciona nova ação do comando
    /// </summary>
    /// <param name="poClassCommand">
    /// Class ação do comando que será adicionada
    /// </param>
    function Add(poClassObjectActionCommand: TClassObjectActionCommand)
      : TObjectActionCommand; overload;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Items[Index: Integer]: TObjectActionCommand read GetItems
      write SetItems;

    /// <summary>
    /// Arquivo que será mapeado
    /// </summary>
    property DataFile: TStringList read FDataFile write SetDataFile;
  end;

implementation

uses uDMException, uObjectActionTimeExecuting;

procedure TObjectActionCommand.Add;
begin
  inherited;
  FObjectDaoCommand.CDSDadosID_TYPE_COMMAND.AsInteger := GetIDType;
end;

procedure TObjectActionCommand.AddAllCommand;
var
  nIndex: Integer;
  FListCommand: TListCommand;
begin
  FListCommand := GetListCommand;
  try
    for nIndex := nCST_Zero to FListCommand.Count - nCST_One do
    begin
      AddCommand(FListCommand.Items[nIndex]);
    end;
  finally
    TDMUtils.DestroyObject(FListCommand);
  end;
end;

procedure TObjectActionCommand.AddCommand(poCommand: TItemCommand);
begin
  if not Assigned(poCommand) then
    Exit;

  FindAddOrEdit([FObjectDaoCommand.CDSDadosCOMMAND.FieldName,
    FObjectDaoCommand.CDSDadosSPECIFIC_NOT_COMMAND.FieldName],
    [poCommand.GetCommand, poCommand.GetNotSpecificCommand], True, False);
end;

procedure TObjectActionCommand.AfterConstruction;
begin
  inherited;
  FDataFile := nil;

  Load;
  FObjectDaoCommand.Filter(FObjectDaoCommand.CDSDadosID_TYPE_COMMAND,
    IntToStr(GetIDType));
  if TDMUtils.IsEmpty(FObjectDaoCommand.CDSDados) then
    AddAllCommand;
end;

procedure TObjectActionCommand.Assign(Source: TPersistent;
  const pbClearOldValue: Boolean);
var
  oObjectAction: TObjectActionCommand;
begin
  inherited;
  if not(Assigned(Source) and (Source is TObjectActionCommand)) then
    Exit;

  oObjectAction := TObjectActionCommand(Source);
  FDataFile := oObjectAction.FDataFile;
end;

procedure TObjectActionCommand.BeforeDestruction;
begin
  FDataFile := nil;
  inherited;
end;

constructor TObjectActionCommand.Create(poOwner: TComponent;
  poObjectDao: TObjectDao);
begin
  inherited;
  FDataFile := nil;

  FObjectDaoCommand := GetObjectDao as TObjectDaoCommand;

end;

procedure TObjectActionCommand.FormatAllCommands;
var
  sCommand, sNotSpecificCommand: String;
  oListCommand: Array of string;
begin
  SetLength(oListCommand, 0);
  FObjectDaoCommand.CDSDados.First;
  while not FObjectDaoCommand.CDSDados.Eof do
  begin
    sCommand := FObjectDaoCommand.CDSDadosCOMMAND.AsString;
    sNotSpecificCommand :=
      FObjectDaoCommand.CDSDadosSPECIFIC_NOT_COMMAND.AsString;
    if TDMUtils.GetHaveCharStr(sCommand) then
      sCommand := sCST_Space + sCommand + sCST_Space;

    if TDMUtils.GetHaveCharStr(sNotSpecificCommand) then
      sNotSpecificCommand := sCST_Space + sNotSpecificCommand + sCST_Space;

    if TDMUtils.ExistValue(sCommand) then
    begin
      SetLength(oListCommand, Length(oListCommand) + 1);
      oListCommand[Length(oListCommand) - 1] := sCommand;
    end;

    if TDMUtils.ExistValue(sNotSpecificCommand) then
    begin
      SetLength(oListCommand, Length(oListCommand) + 1);
      oListCommand[Length(oListCommand) - 1] := sNotSpecificCommand;
    end;
    FObjectDaoCommand.CDSDados.Next;
  end;
  TDMUtils.ExplodeList(FDataFile, oListCommand, False);
end;

function TObjectActionCommand.GetFormatID: String;
begin
  Result := '|ID_' + GetIdentClass + '_%d|';
end;

function TObjectActionCommand.GetIdentFormat(const psCommand: String;
  const pbIsNotCommand: Boolean): String;
var
  oField: TField;
begin
  if not(TDMUtils.ExistValue(psCommand)) then
    raise eDataError.Create(sMSG_DataError);

  if pbIsNotCommand then
    oField := FObjectDaoCommand.CDSDadosSPECIFIC_NOT_COMMAND
  else
    oField := FObjectDaoCommand.CDSDadosCOMMAND;

  if not FObjectDao.CDSDados.Locate(oField.FieldName, Trim(psCommand),
    [loCaseInsensitive]) then
  begin
    Add;
    oField.AsString := Trim(psCommand);
    Save;
  end;
  Result := Format(GetFormatID,
    [FObjectDaoCommand.CDSDadosID_COMMAND.AsInteger]);
end;

function TObjectActionCommand.GetIDType: Integer;
begin
  Result := 1;
end;

function TObjectActionCommand.GetListCommand: TListCommand;
begin
  Result := TListCommand.Create(Self);
end;

procedure TObjectActionCommand.Import;
begin
  FObjectDaoCommand.CDSDados.First;
  while not FObjectDaoCommand.CDSDados.Eof do
  begin
    LocateAndSetFileCommand;
    FObjectDaoCommand.CDSDados.Next;
  end;
end;

function TObjectActionCommand.LocateRegistry(const psCommand: string;
  const pnID: Integer): Boolean;
begin
  Result := False;
  if TDMUtils.ExisteString(psCommand, GetFormatID) then
    Result := FObjectDaoCommand.CDSDados.Locate
      (FObjectDaoCommand.CDSDadosID_COMMAND.FieldName, pnID, []);
end;

procedure TObjectActionCommand.Save;
begin
  // Captura o comando para uma lista formatado
  FObjectDaoCommand.CDSDadosCOMMAND_FORMATTED.AsString :=
    TItemCommand.GetItemCommandFormated
    (FObjectDaoCommand.CDSDadosCOMMAND.AsString);
  FObjectDaoCommand.CDSDadosSPECIFIC_NOT_COMMAND_FORMATTED.AsString :=
    TItemCommand.GetItemCommandFormated
    (FObjectDaoCommand.CDSDadosSPECIFIC_NOT_COMMAND.AsString);
  inherited;
end;

procedure TObjectActionCommand.SetDataFile(const Value: TStringList);
begin
  FDataFile := Value;
end;

{ TItemCommand }

procedure TItemCommand.AfterConstruction;
begin
  inherited;
  FCommand := sCST_EmptyStr;
end;

class function TItemCommand.GetItemCommandFormated(const psCommand
  : string): String;
begin
  Result := psCommand;
  TDMUtils.ExplodeList(Result, [' ', '{', '$', '}'], False);
  TDMUtils.DeleteLineEmpty(Result);
end;

procedure TItemCommand.Assign(Source: TPersistent;
  const pbClearOldValue: Boolean);
var
  oObjectAction: TItemCommand;
begin
  inherited;
  if not(Assigned(Source) and (Source is TItemCommand)) then
    Exit;

  oObjectAction := TItemCommand(Source);
  FCommand := oObjectAction.FCommand;
end;

destructor TItemCommand.Destroy;
begin
  inherited;
end;

class procedure TItemCommand.ExplodeCommandAndID(var psCommand: string;
  var pnID: Integer);
var
  nIndexNumber: Integer;
  sID: string;
begin
  pnID := 0;
  nIndexNumber := TDMUtils.PostInvertString('_', psCommand);
  if TDMUtils.IsEmpty(nIndexNumber) then
    Exit;

  sID := Copy(psCommand, nIndexNumber + 1, Length(psCommand));
  pnID := TDMUtils.StrToInt2(Copy(sID, 1, Length(sID) - 1));
  psCommand := Copy(psCommand, 1, nIndexNumber);
end;

class function TItemCommand.NotIsCommandEquals(const pbValidateEquals: Boolean;
  const psLineValidate, psCommand: string): Boolean;
begin
  if IsCommandAnyValue(psCommand) then
  begin
    Result := not pbValidateEquals;
    Exit;
  end;

  Result := (pbValidateEquals and (not TDMUtils.ValidateCommand(psLineValidate,
    psCommand, sCST_OtherValue)) and
    (not TDMUtils.ValidateCommand(psLineValidate, psCommand, sCST_OtherValueStr)
    )) or ((not pbValidateEquals) and (TDMUtils.ValidateCommand(psLineValidate,
    psCommand, sCST_OtherValue) or TDMUtils.ValidateCommand(psLineValidate,
    psCommand, sCST_OtherValueStr)));
end;

function TItemCommand.GetCommand: string;
begin
  Result := FCommand;
  if TDMUtils.ExistValue(Result) then
    Exit;

  Result := Copy(Self.ClassName, Length(Self.ClassParent.ClassName) + nCST_One,
    Length(Self.ClassName));
  Result := StringReplace(Result, '_', ' ', [rfReplaceAll]);
end;

function TItemCommand.GetNotSpecificCommand: string;
begin
  Result := sCST_EmptyStr;
end;

class function TItemCommand.IsCommandAnyValue(const psLineValidate
  : string): Boolean;
begin
  Result := TDMUtils.CompareIgnoreCase(psLineValidate, sCST_OtherValue) or
    TDMUtils.CompareIgnoreCase(psLineValidate, sCST_OtherValueStr)
end;

function TItemCommand.IsLineNotValidate(const psLine: String): Boolean;
begin
  Result := TDMUtils.CompareIgnoreCase(psLine, sCST_OtherValueStr) or
    TDMUtils.CompareIgnoreCase(psLine, sCST_OtherValue);
end;

function TItemCommand.IsStringOperator: Boolean;
begin
  Result := TDMUtils.GetHaveCharStr(GetCommand);
end;

procedure TObjectActionCommand.LocateAndSetFileCommand;
var
  nIndexNextEqualsCommand, nIndex: Integer;
  sNewLine, sLine, sDataCommand, sDataNotCommand: String;
  bExisteValueCommand, bExisteValueNotCommand: Boolean;
begin
  if not(Assigned(FDataFile)) then
    Exit;

  sDataCommand := Trim(FObjectDaoCommand.CDSDadosCOMMAND_FORMATTED.AsString);
  sDataNotCommand :=
    Trim(FObjectDaoCommand.CDSDadosSPECIFIC_NOT_COMMAND_FORMATTED.AsString);

  bExisteValueCommand := TDMUtils.ExistValue(sDataCommand);
  bExisteValueNotCommand := TDMUtils.ExistValue(sDataNotCommand);

  if not(bExisteValueCommand or bExisteValueNotCommand) then
    Exit;

  for nIndex := nCST_Zero to FDataFile.Count - 1 do
  begin
    sLine := FDataFile.Strings[nIndex];

    if TDMUtils.ExisteString('|ID_', sLine) then
      Continue;

    if bExisteValueCommand and (not TItemCommand.NotIsCommandEquals(True, sLine,
      sDataCommand)) then
      FDataFile.Strings[nIndex] := GetIdentFormat(sLine, False)
    else if bExisteValueNotCommand and
      (not TItemCommand.NotIsCommandEquals(False, sLine, sDataNotCommand)) then
      FDataFile.Strings[nIndex] := GetIdentFormat(sLine, True)
    else
      Continue;

    // Localiza todos os proximos comando iguais ao identificado
    sNewLine := FDataFile.Strings[nIndex];
    nIndexNextEqualsCommand := FDataFile.IndexOf(sLine);
    while (nIndexNextEqualsCommand > nCST_Zero) do
    begin
      FDataFile.Strings[nIndexNextEqualsCommand] := sNewLine;
      nIndexNextEqualsCommand := FDataFile.IndexOf(sLine);
    end;
  end;
end;

{ TListCommand }

function TListCommand.Add(poClassCommand: TClassCommand): TItemCommand;
begin
  Result := TFactoryObject.CreateComponent(poClassCommand) as TItemCommand;
  inherited Add(Result);
end;

procedure TListCommand.AfterConstruction;
begin
  inherited;

end;

procedure TListCommand.BeforeDestruction;
begin
  inherited;

end;

constructor TListCommand.Create(AOwner: TComponent);
begin
  inherited;
  ImportAll;
end;

destructor TListCommand.Destroy;
begin
  inherited;
end;

function TListCommand.GetItems(Index: Integer): TItemCommand;
begin
   Result := TItemCommand(inherited Items[index]);
end;

procedure TListCommand.ImportAll;
begin

end;

procedure TListCommand.SetItems(Index: Integer; const Value: TItemCommand);
begin
  inherited Items[Index] := Value;
end;

{ TListActionCommand }

function TListActionCommand.Add(poClassObjectActionCommand
  : TClassObjectActionCommand): TObjectActionCommand;
begin
  Result := TFactoryObject.CreateComponent(poClassObjectActionCommand)
    as TObjectActionCommand;
  Result.DataFile := DataFile;
  inherited Add(Result);
end;

procedure TListActionCommand.AfterConstruction;
begin
  inherited;
  FDataFile := nil;
end;

procedure TListActionCommand.BeforeDestruction;
begin
  FDataFile := nil;
  inherited;
end;

function TListActionCommand.GetItems(Index: Integer): TObjectActionCommand;
begin
  Result := TObjectActionCommand(inherited Items[index]);
end;

procedure TListActionCommand.SetDataFile(const Value: TStringList);
var
  nIndex: Integer;
  oItem: TObjectActionCommand;
begin
  FDataFile := Value;

  for nIndex := 0 to Self.Count - 1 do
  begin
    oItem := Items[nIndex];
    if Assigned(oItem) then
      oItem.DataFile := FDataFile;
  end;
end;

procedure TListActionCommand.SetItems(Index: Integer;
  const Value: TObjectActionCommand);
begin
  inherited Items[Index] := Value;
end;

initialization

RegisterClass(TObjectActionCommand);
RegisterClass(TItemCommand);

end.
