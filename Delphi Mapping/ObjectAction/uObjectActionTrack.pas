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
unit uObjectActionTrack;

interface

uses
  uObjectActionCustom, Classes, Forms, SysUtils, uConstantTrack, DB,
  Variants, uDMList, uObjectActionWordDelphi, uObjectActionCommand,
  uObjectActionUses, uObjectActionUnit, uObjectActionMethod, uObjectAction,
  uObjectActionStructureDelphi, MD5,
  uObjectActionVariable, uObjectActionConst, uFormViewUses,
  uObjectActionComment, uObjectActionOperator, uObjectActionData,
  uObjectActionDirective;

type
  /// <summary>
  /// Constrole ação de mapeamento do delphi
  /// </summary>
  /// <example>
  /// unit uObjectActionUnit;
  /// </example>
  TObjectActionTrack = class(TObjectActionCustom)
  private
    FDataFile: TStringList;
  protected
    FObjectActionComment: TObjectActionComment;
    FListActionCommand: TListActionCommand;
    /// <summary>
    /// Extrair todos os dados estruturais da unit - Exemplo Class com métodos
    /// </summary>
    /// <summary>
    /// Converte o Id do banco para o comando real
    /// </summary>
    function DeKeyToDate(const poList: TStringList): TStringList;

    procedure SetDataFile(const Value: TStringList);
    procedure AddUnit(poObjectActionUnit: TObjectActionUnit; const psFilePath: string);
    procedure SetMD5Unit(poObjectActionUnit: TObjectActionUnit);
    function UnitEqualsOldProcess(const psFilePath: string): Boolean; virtual;
  public
    FObjectActionUnit: TObjectActionUnit;
    property DataFile: TStringList read FDataFile write SetDataFile;
    procedure CreateStructure(const aDirectory: string);
    procedure AfterConstruction; override;
    procedure Load(const pbLoadAllChildren: Boolean = True); Override;
    procedure BeforeDestruction; override;
    /// <summary>
    /// Lê o arquivo e Efetua a quebra de linha e importa comentário
    /// </summary>
    function LoadFile(const psFileName: string): Boolean;

    procedure FormatAllCommands;
    /// <summary>
    /// Cadastra no banco os dados do arquivo
    /// </summary>
    procedure ImportUnit;
    /// <summary>
    /// Identifica a estrutura do arquivo e cadastra
    /// </summary>
    procedure ProcessUnit(const psFilePath: String);

    /// <summary>
    /// Banco de dados para Arquivo
    /// </summary>
    procedure ExportUnit(const psFilePath: string);
  end;

implementation

uses uDMUtils, uFactoryObject, uConstantUtils, uConstantCommand,
  uConstantClass, uObjectDaoCommand, uConstantComment,
  uObjectActionTimeExecuting;

{ TObjectActionTrack }

procedure TObjectActionTrack.AfterConstruction;
begin
  inherited;
  FDataFile := nil;
  FObjectActionUnit := TFactoryObject.CreateComponent(TObjectActionUnit)
    as TObjectActionUnit;
  FListActionCommand := TListActionCommand.Create(Self);
  FListActionCommand.Add(TObjectActionOperator);
  FListActionCommand.Add(TObjectActionWordDelphi);
  FListActionCommand.Add(TObjectActionDirective);
  FListActionCommand.Add(TObjectActionData);
  // FListActionCommand.Add(TObjectActionCompilerDirectives);

  FObjectActionComment := TFactoryObject.CreateComponent(TObjectActionComment,
    Self) as TObjectActionComment;

end;

procedure TObjectActionTrack.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FDataFile);
  TDMUtils.DestroyObject(FObjectActionUnit);
  TDMUtils.DestroyObject(FListActionCommand);
  inherited;
end;

procedure TObjectActionTrack.SetDataFile(const Value: TStringList);
begin
  FDataFile := Value;
  if Assigned(FObjectActionComment) then
    FObjectActionComment.DataFile := FDataFile;

  if Assigned(FListActionCommand) then
    FListActionCommand.DataFile := FDataFile;
end;

procedure TObjectActionTrack.SetMD5Unit(poObjectActionUnit: TObjectActionUnit);
begin
  poObjectActionUnit.Edit;
  poObjectActionUnit.FObjectDaoUnit.CDSDadosMD5.AsString := MD5File2(poObjectActionUnit.FObjectDaoUnit.CDSDadosFILEPATH.FieldName);
  poObjectActionUnit.Save;
  poObjectActionUnit.ApplyDB;
end;

function TObjectActionTrack.UnitEqualsOldProcess(const psFilePath: string): Boolean;
begin
  Result := FObjectActionUnit.FObjectDaoUnit.CDSDados.Locate
    (FObjectActionUnit.FObjectDaoUnit.CDSDadosMD5.FieldName,
    MD5File2(psFilePath), []);
end;

procedure TObjectActionTrack.CreateStructure(const aDirectory: string);
var
  sDirectory: string;
begin
  sDirectory := TDMUtils.FormatDirectory(aDirectory);
  TDMUtils.CreateDirectory(sDirectory + 'Constant\');
  TDMUtils.CreateDirectory(sDirectory + 'Forms\');
  TDMUtils.CreateDirectory(sDirectory + 'Forms\Add\');
  TDMUtils.CreateDirectory(sDirectory + 'Forms\Model\');
  TDMUtils.CreateDirectory(sDirectory + 'Forms\View\');
  TDMUtils.CreateDirectory(sDirectory + 'Image\');
  TDMUtils.CreateDirectory(sDirectory + 'Interface\');
  TDMUtils.CreateDirectory(sDirectory + 'ObjectAction\');
  TDMUtils.CreateDirectory(sDirectory + 'ObjectDao\');
  TDMUtils.CreateDirectory(sDirectory + 'Utils\');
end;

function TObjectActionTrack.DeKeyToDate(const poList: TStringList): TStringList;
var
  nIndexCommand, nIndex, nID: Integer;
  sKey: String;
  oObjectActionCommand: TObjectActionCommand;
begin
  Result := TStringList.Create;
  if not Assigned(poList) then
    Exit;

  for nIndex := 0 to poList.Count - 1 do
  begin
    sKey := poList.Strings[nIndex];
    Result.Add(sCST_EmptyStr);
    TItemCommand.ExplodeCommandAndID(sKey, nID);
    oObjectActionCommand := nil;
    if FObjectActionComment.LocateRegistry(sKey, nID) then
    begin
      Result.Strings[nIndex] := FObjectActionComment.FObjectDaoComment.
        CDSDadosDATA.AsString;
      if (TTypeComment(FObjectActionComment.FObjectDaoComment.
        CDSDadosID_TYPE_COMMENT.AsInteger) = tcText) then
        Result.Strings[nIndex] := QuotedStr(Result.Strings[nIndex]);

      Continue;
    end;

    for nIndexCommand := 0 to FListActionCommand.Count - 1 do
    begin
      if FListActionCommand.Items[nIndexCommand].LocateRegistry(sKey, nID) then
      begin
        oObjectActionCommand := FListActionCommand.Items[nIndexCommand];
        Break;
      end;
    end;

    if not Assigned(oObjectActionCommand) then
      Continue;

    Result.Strings[nIndex] := oObjectActionCommand.FObjectDaoCommand.
      CDSDadosCOMMAND.AsString;
    if TDMUtils.IsEmpty(Result.Strings[nIndex]) then
      Result.Strings[nIndex] := oObjectActionCommand.FObjectDaoCommand.
        CDSDadosSPECIFIC_NOT_COMMAND.AsString;
  end;
end;

procedure TObjectActionTrack.ExportUnit(const psFilePath: string);
var
  nIndexStructure: Integer;
  oItem: TObjectAction;
  oListDateLocate: TListStructureDelphi;
  oObjectActionUnit: TObjectActionUnit;
begin
  oListDateLocate := TListStructureDelphi.Create(Self);
  try
    TDMUtils.DestroyObject(FDataFile);
    DataFile := TStringList.Create;
    oListDateLocate.DataFile := FDataFile;
    oListDateLocate.DeKeyToDate := DeKeyToDate;
    oObjectActionUnit := oListDateLocate.Add(TObjectActionUnit)
      as TObjectActionUnit;
    oObjectActionUnit.ObjectCanProcessStructure := true;
    if not oObjectActionUnit.FObjectDaoUnit.CDSDados.Locate(oObjectActionUnit.FObjectDaoUnit.CDSDadosFILEPATH.FieldName,
      psFilePath, [loCaseInsensitive]) then
      Exit;

    // Processa a unit
    for nIndexStructure := nCST_Zero to oListDateLocate.Count - nCST_One do
    begin
      oItem := oListDateLocate.Items[nIndexStructure];

      if Assigned(oItem) and (oItem is TObjectActionStructureDelphi) then
        TObjectActionStructureDelphi(oItem).ExportDBtoFile(TObjectActionStructureDelphi(oItem).DataFile, true);
    end;

    SetMD5Unit(oObjectActionUnit);
  finally
    TDMUtils.DestroyObject(oListDateLocate);
  end;
end;

procedure TObjectActionTrack.FormatAllCommands;
var
  nIndex: Integer;
  oItem: TObjectActionCommand;
begin
  FObjectActionComment.Import;
  FObjectActionComment.FormatAllCommands;

  for nIndex := nCST_Zero to FListActionCommand.Count - 1 do
  begin
    oItem := FListActionCommand.Items[nIndex];
    if not Assigned(oItem) then
      Continue;

    oItem.FormatAllCommands;
  end;

  TDMUtils.DeleteLineEmpty(FDataFile);
end;

procedure TObjectActionTrack.ImportUnit;
var
  oItem: TObjectActionCommand;
  nIndex: Integer;
begin
  for nIndex := nCST_Zero to FListActionCommand.Count - 1 do
  begin
    oItem := FListActionCommand.Items[nIndex];
    if not Assigned(oItem) then
      Continue;

    oItem.Import;
  end;
end;

procedure TObjectActionTrack.ProcessUnit(const psFilePath: String);
var
  nIndexActive, nIndexStructure, nIndex: Integer;
  oItem: TObjectAction;
  oListDateLocate: TListStructureDelphi;
  oObjectActionUnit: TObjectActionUnit;
begin
  oListDateLocate := TListStructureDelphi.Create(Self);
  try
    oListDateLocate.DataFile := FDataFile;
    oListDateLocate.DeKeyToDate := DeKeyToDate;
    oObjectActionUnit := oListDateLocate.Add(TObjectActionUnit)
      as TObjectActionUnit;
    oObjectActionUnit.ObjectCanProcessStructure := true;
    AddUnit(oObjectActionUnit, psFilePath);

    // Processa a unit
    nIndexActive := -1;
    for nIndex := nCST_Zero to FDataFile.Count - nCST_One do
    begin
      if (nIndex < nIndexActive) then
        Continue;

      nIndexActive := nIndex;

      for nIndexStructure := nCST_Zero to oListDateLocate.Count - nCST_One do
      begin
        oItem := oListDateLocate.Items[nIndexStructure];

        if Assigned(oItem) and (oItem is TObjectActionStructureDelphi) then
          TObjectActionStructureDelphi(oItem)
            .ImportFileToDB(nIndexActive, true);
      end;
    end;

    SetMD5Unit(oObjectActionUnit);
  finally
    TDMUtils.DestroyObject(oListDateLocate);
  end;
end;

procedure TObjectActionTrack.AddUnit(poObjectActionUnit: TObjectActionUnit; const psFilePath: string);
begin
  if poObjectActionUnit.FObjectDaoUnit.CDSDados.Locate(poObjectActionUnit.FObjectDaoUnit.CDSDadosFILEPATH.FieldName,
    psFilePath, [loCaseInsensitive]) then
    poObjectActionUnit.FObjectDaoUnit.CDSDados.Delete;

  poObjectActionUnit.FindAddOrEdit
    ([poObjectActionUnit.FObjectDaoUnit.CDSDadosFILEPATH.FieldName],
    [psFilePath], true);
  poObjectActionUnit.ApplyDB;
end;

procedure TObjectActionTrack.Load(const pbLoadAllChildren: Boolean = True);
begin
  FObjectActionUnit.Load(pbLoadAllChildren);
  FObjectActionComment.Load(pbLoadAllChildren);
  if pbLoadAllChildren then
    FListActionCommand.Load;
end;

function TObjectActionTrack.LoadFile(const psFileName: string): Boolean;
begin
  Result := true;
  { if UnitEqualsOldProcess then
    begin
    Result := False;
    Exit;
    end; }
  FObjectActionComment.Clear;
  TDMUtils.DestroyObject(FDataFile);
  DataFile := TDMUtils.ReadFile(psFileName);
end;

initialization

RegisterClass(TObjectActionTrack);

end.
