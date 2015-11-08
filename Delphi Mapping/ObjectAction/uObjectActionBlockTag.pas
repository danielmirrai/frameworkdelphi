unit uObjectActionBlockTag;

interface

uses uDMUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  uObjectActionBlockTagInDB, uDMList, uObjectActionCommand, uConstantUtils, DB,
  Controls, Forms, Dialogs, StdCtrls, uObjectActionCustom, uObjectAction,
  Contnrs;

type
  TConfigBlockTag = class;

  /// <summary>
  /// Item que será mapeado
  /// </summary>
  /// <example>
  /// Unit uDMUtils;
  /// </example>
  TConfigItemTag = class(TObjectActionCustom)
  private
    FTagIgnoreData: TValueTag;
    FSubBlock: TConfigBlockTag;
    FTagData: TValueTag;
    FCanExportForFile: Boolean;
  protected
    function GetCanExportForFile: Boolean; virtual;
    function GetSubBlock: TConfigBlockTag; virtual;
    procedure SetCanExportForFile(const Value: Boolean); virtual;
    function GetNewSubBlock: TConfigBlockTag; virtual;
    function GetTagData: TValueTag; virtual;
    function GetTagIgnoreData: TValueTag; virtual;
    procedure SetTagIgnoreData(const Value: TValueTag); virtual;
    procedure SetSubBlock(const Value: TConfigBlockTag); virtual;
    procedure SetTagData(const Value: TValueTag); virtual;
    function GetNewTagData: TValueTag; virtual;
    function GetNewTagIgnoreData: TValueTag; virtual;
  public

    procedure Assign(Source: TPersistent;
      const pbClearOldValue: Boolean); Override;

    /// <summary>
    /// Limpa os valores já encontrados no item
    /// </summary>
    procedure ClearTextFound; virtual;
    procedure NewBackupTextFound(const pbClearOldValue
      : Boolean = True); virtual;
    procedure RevertBackupTextFound(const pbClearOldValue
      : Boolean = False); virtual;

    destructor Destroy; override;
    procedure Clear; Override;

    procedure Configure(const psTagBegin, psTagData, psTagIgnoreData,
      psTagEnd: TRecordParamValueSearch; const pnIDCategory: Integer = -1;
      const pbCanProcessAllValues: Boolean = False); overload; Virtual;
    procedure Configure(const psTagBegin, psTagData, psTagIgnoreData,
      psTagEnd: String; const pnIDCategory: Integer = -1;
      const pbCanProcessAllValues: Boolean = False); overload; Virtual;
    procedure Configure(const psTagBegin: string;
      psTagData: TRecordParamValueSearch; psTagIgnoreData, psTagEnd: String;
      const pnIDCategory: Integer = -1;
      const pbCanProcessAllValues: Boolean = False); overload; Virtual;

    class procedure AddTag(var poTagData: TValueTag; const psText: String);
      Overload; Virtual;
    class procedure AddTag(var poTagData: TValueTag;
      const poRecordParamValueSearch: TRecordParamValueSearch);
      Overload; Virtual;

    procedure ConverteKeyFound(poDeKeyToDate: TMethodKeyToDate); virtual;
    procedure AfterConstruction; override;
    property SubBlock: TConfigBlockTag read GetSubBlock write SetSubBlock;
    property CanExportForFile: Boolean read GetCanExportForFile write SetCanExportForFile;
     /// <summary>
    /// Tag que é o conteúdo a ser catpurado
    /// </summary>
    property TagData: TValueTag read GetTagData write SetTagData;
    /// <summary>
    /// Tag que é ignora ao capturar o conteúdo
    /// </summary>
    property TagIgnoreData: TValueTag read GetTagIgnoreData
      write SetTagIgnoreData;
  end;

  TListConfigItemTag = class(TListObjectActionCustom)
  protected
    function GetItems(Index: Integer): TConfigItemTag; Reintroduce; Virtual;
    procedure SetItems(Index: Integer; const Value: TConfigItemTag);
      Reintroduce; Virtual;
    function GetNewConfigItemTag: TConfigItemTag; Virtual;
  public
    /// <summary>
    /// Limpa os valores já encontrados nos itens
    /// </summary>
    procedure ClearTextFound; virtual;
    procedure ConverteKeyFound(poDeKeyToDate: TMethodKeyToDate); virtual;
    procedure NewBackupTextFound(const pbClearOldValue
      : Boolean = True); Virtual;
    procedure RevertBackupTextFound(const pbClearOldValue
      : Boolean = False); Virtual;
    /// <summary>
    /// Adiciona uma lista de valores possíveis
    /// </summary>
    function Add(const psTagData: String;
      paBeforeData, paAfterData: Array of string;
      const psTagIgnoreData: String = ''; const pnIDCategory: Integer = -1)
      : TConfigItemTag; Overload; Virtual;
    function Add(const poTagData: TRecordParamValueSearch;
      paBeforeData, paAfterData: Array of TRecordParamValueSearch;
      const psTagIgnoreData: String = ''; const pnIDCategory: Integer = -1)
      : TConfigItemTag; Overload; Virtual;
    function Add(const psTagBegin, psTagData: String;
      psTagIgnoreData: String = ''; const psTagEnd: String = '';
      const pnIDCategory: Integer = -1;
      const pbCanProcessAllValues: Boolean = False): TConfigItemTag;
      Overload; Virtual;
    function Add(const poTagBegin: TRecordParamValueSearch;
      const psTagData: String; psTagIgnoreData: String = '';
      const psTagEnd: String = ''; const pnIDCategory: Integer = -1;
      const pbCanProcessAllValues: Boolean = False): TConfigItemTag;
      Overload; Virtual;
    function Add(const psTagBegin: String; poTagData: TRecordParamValueSearch;
      psTagIgnoreData: String = ''; const psTagEnd: String = '';
      const pnIDCategory: Integer = -1;
      const pbCanProcessAllValues: Boolean = False): TConfigItemTag;
      Overload; Virtual;
    function Add(const poTagBegin, poTagData: TRecordParamValueSearch;
      poTagIgnoreData: TRecordParamValueSearch = nil;
      const poTagEnd: TRecordParamValueSearch = nil;
      const pnIDCategory: Integer = -1;
      const pbCanProcessAllValues: Boolean = False): TConfigItemTag;
      Overload; Virtual;
    function Add(const poTagBegin, poTagData: TRecordParamValueSearch;
      psTagIgnoreData: String = ''; const psTagEnd: String = '';
      const pnIDCategory: Integer = -1;
      const pbCanProcessAllValues: Boolean = False): TConfigItemTag;
      Overload; Virtual;
    function Add(const psTagBegin: String; poTagData: TField;
      psTagIgnoreData: String = ''; const psTagEnd: String = '';
      const pnIDCategory: Integer = -1;
      const pbCanProcessAllValues: Boolean = False): TConfigItemTag;
      Overload; Virtual;
    function Add(const psTagData: String; const pnIDCategory: Integer = -1)
      : TConfigItemTag; Overload;

    property Items[Index: Integer]: TConfigItemTag read GetItems write SetItems;
  end;

  TOnProcessingInternalData = procedure(const pbProcessing: Boolean;
    poConfigBlockTag: TConfigBlockTag) of object;

  /// <summary>
  /// Bloco que será mapeado
  /// </summary>
  /// <example>
  /// <para>
  /// Unit
  /// </para>
  /// <para>
  /// End.
  /// </para>
  /// </example>
  TConfigBlockTag = class(TObjectActionCustom)
  private
    FCanProcessAllValues: Boolean;
    FProcessingInternalData: Boolean;
    FCountLocate: Integer;
    FProcessing: Boolean;
    FSucessfullBlock: Boolean;
    FIDCategory: Integer;
    FTagEndBlock: TValueTag;
    FTagBeginBlock: TValueTag;
    FListObjectActionReference: TListObjectAction;
    FOnProcessingInternalData: TOnProcessingInternalData;
    FCanExportForFile: Boolean;
  protected
    function GetCanExportForFile: Boolean; Virtual;
    procedure SetCanExportForFile(const Value: Boolean); Virtual;
    procedure SetListObjectActionReference(const Value
      : TListObjectAction); Virtual;
    function GetNewListObjectAction: TListObjectActionCustom; Override;
    function GetListObjectActionReference: TListObjectAction; Virtual;
    function GetCanProcessAllValues: Boolean; Virtual;
    function GetCountLocate: Integer; Virtual;
    function GetIDCategory: Integer; Virtual;
    function GetOnProcessingInternalData: TOnProcessingInternalData; Virtual;
    function GetProcessing: Boolean; Virtual;
    function GetProcessingInternalData: Boolean; Virtual;
    function GetSucessfullBlock: Boolean; Virtual;
    function GetTagBeginBlock: TValueTag; Virtual;
    procedure SetOnProcessingInternalData(const Value
      : TOnProcessingInternalData); virtual;
    function GetListObjectActionChildren: TListConfigItemTag; reintroduce;
    procedure SetListObjectActionChildren(const Value: TListConfigItemTag);
      reintroduce;
    procedure SetCanProcessAllValues(const Value: Boolean); Virtual;
    procedure SetProcessingInternalData(const Value: Boolean); Virtual;
    procedure SetCountLocate(const Value: Integer); Virtual;
    procedure SetProcessing(const Value: Boolean); Virtual;
    procedure SetSucessfullBlock(const Value: Boolean); Virtual;
    procedure SetIDCategory(const Value: Integer); Virtual;
    procedure SetTagBeginBlock(const Value: TValueTag); Virtual;
    procedure SetTagEndBlock(const Value: TValueTag); Virtual;
    function GetNewTagBeginBlock: TValueTag; virtual;
    function GetNewTagEndBlock: TValueTag; virtual;
    function GetNewListObjectActionReference: TListObjectAction; virtual;
  public
    procedure Assign(Source: TPersistent;
      const pbClearOldValue: Boolean); Override;
    procedure Clear; Override;

    /// <summary>
    /// Limpa os valores já encontrados no bloco
    /// </summary>
    procedure ClearTextFound;
    procedure NewBackupTextFound(const pbClearOldValue: Boolean = True);
    procedure RevertBackupTextFound(const pbClearOldValue: Boolean = False);

    procedure Configure(poListObjectActionReference: TListObjectAction;
      const psTagBeginBlock, psTagEndBlock: String;
      const pbCanProcessAllValues: Boolean = False;
      const pnIDCategory: Integer = -1); overload;

    procedure Configure(poListObjectActionReference: TListObjectAction;
      const psTagBeginBlock, psTagEndBlock: TRecordParamValueSearch;
      const pbCanProcessAllValues: Boolean = False;
      const pnIDCategory: Integer = -1); overload;

    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure ConverteKeyFound(poDeKeyToDate: TMethodKeyToDate); virtual;

    property OnProcessingInternalData: TOnProcessingInternalData
      read GetOnProcessingInternalData write SetOnProcessingInternalData;
    /// <summary>
    /// Tag inicial anterior ao conteúdo
    /// </summary>
    property TagBeginBlock: TValueTag read GetTagBeginBlock
      write SetTagBeginBlock;

    /// <summary>
    /// Conteúdo da tag
    /// </summary>
    property ListObjectActionChildren: TListConfigItemTag
      read GetListObjectActionChildren write SetListObjectActionChildren;
    /// <summary>
    /// Tag finaliza o bloco
    /// </summary>
    property TagEndBlock: TValueTag read FTagEndBlock write SetTagEndBlock;
    property ListObjectActionReference: TListObjectAction
      read GetListObjectActionReference write SetListObjectActionReference;

    property CanProcessAllValues: Boolean read GetCanProcessAllValues
      write SetCanProcessAllValues;

    /// <summary>
    /// Está processando o bloco do item do comando - Exemplo unit uDMUtils; até end.
    /// </summary>
    property ProcessingInternalData: Boolean read GetProcessingInternalData
      write SetProcessingInternalData;

    /// <summary>
    /// Quantidade de vezes que capturou e gravou a estrutura no Id
    /// </summary>
    property CountLocate: Integer read GetCountLocate write SetCountLocate;

    /// <summary>
    /// Está processando o item do comando - Exemplo unit uDMUtils;
    /// </summary>
    property Processing: Boolean read GetProcessing write SetProcessing;

    property SucessfullBlock: Boolean read GetSucessfullBlock
      write SetSucessfullBlock;
    property IDCategory: Integer read GetIDCategory write SetIDCategory;
    property CanExportForFile: Boolean read GetCanExportForFile write SetCanExportForFile;
  end;

  TListConfigBlockTag = class(TListObjectActionCustom)
  private
    FListObjectActionReference: TListObjectAction;
  protected
    procedure SetListObjectActionReference(const Value
      : TListObjectAction); virtual;
    function GetListObjectActionReference: TListObjectAction; virtual;
    procedure OnProcessingInternalData(const pbProcessing: Boolean;
      poConfigBlockTag: TConfigBlockTag); virtual;
    function GetItems(Index: Integer): TConfigBlockTag; reintroduce;
    procedure SetItems(Index: Integer; const Value: TConfigBlockTag);
      reintroduce;
    function GetNewConfigBlockTag: TConfigBlockTag;
  public
    function Add(const psTagBeginBlock, psTagEndBlock: String;
      const pbCanProcessAllValues: Boolean = False;
      const pnIDCategory: Integer = -1): TConfigBlockTag; Overload;

    function Add(const psTagBeginBlock, psTagEndBlock: TRecordParamValueSearch;
      const pbCanProcessAllValues: Boolean = False;
      const pnIDCategory: Integer = -1): TConfigBlockTag; Overload;
    function Add(const psTagBeginBlock: TRecordParamValueSearch;
      const psTagEndBlock: String; const pbCanProcessAllValues: Boolean = False;
      const pnIDCategory: Integer = -1): TConfigBlockTag; Overload;

    function Add(const poConfigBlockTagOrigem: TConfigBlockTag)
      : TConfigBlockTag; Overload;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    property Items[Index: Integer]: TConfigBlockTag read GetItems
      write SetItems;
    property ListObjectActionReference: TListObjectAction
      read GetListObjectActionReference write SetListObjectActionReference;
  end;

implementation

{ TConfigItemTag }

uses uObjectActionStructure, uFactoryObject;

class procedure TConfigItemTag.AddTag(var poTagData: TValueTag;
  const psText: String);
begin
  if Assigned(poTagData) then
    poTagData.ValueSearch.AddValue(psText);
end;

class procedure TConfigItemTag.AddTag(var poTagData: TValueTag;
  const poRecordParamValueSearch: TRecordParamValueSearch);
begin
  if Assigned(poTagData) and Assigned(poRecordParamValueSearch) then
    poTagData.ValueSearch.AddValue(poRecordParamValueSearch);
end;

procedure TConfigItemTag.AfterConstruction;
begin
  TagIgnoreData := GetNewTagIgnoreData;
  TagData := GetNewTagData;
  SubBlock := nil;
  FCanExportForFile := True;
  inherited;
end;

function TConfigItemTag.GetCanExportForFile: Boolean;
begin
  Result := FCanExportForFile;
end;

function TConfigItemTag.GetNewSubBlock: TConfigBlockTag;
begin
  Result := TConfigBlockTag.Create(Self);
end;

function TConfigItemTag.GetNewTagData: TValueTag;
begin
  Result := TValueTag.Create(Self);
end;

function TConfigItemTag.GetNewTagIgnoreData: TValueTag;
begin
  Result := TValueTag.Create(Self);
end;

function TConfigItemTag.GetSubBlock: TConfigBlockTag;
begin
  Result := FSubBlock;
end;

procedure TConfigItemTag.Assign(Source: TPersistent;
  const pbClearOldValue: Boolean);
var
  oConfigItemTag: TConfigItemTag;
begin
  inherited;
  if not(Assigned(Source) and (Source is TConfigItemTag)) then
    Exit;

  oConfigItemTag := TConfigItemTag(Source);
  if Assigned(oConfigItemTag.SubBlock) then
  begin
    if not Assigned(Self.SubBlock) then
      SubBlock := GetNewSubBlock;
    Self.SubBlock.Assign(oConfigItemTag.SubBlock, pbClearOldValue);
  end
  else
    TDMUtils.DestroyObject(FSubBlock);
  FCanExportForFile := oConfigItemTag.CanExportForFile;
  FTagData.Assign(oConfigItemTag.TagData, pbClearOldValue);
  FTagIgnoreData.Assign(oConfigItemTag.TagIgnoreData, pbClearOldValue);
end;

procedure TConfigItemTag.Clear;
begin
  inherited;
  ClearTextFound;
end;

procedure TConfigItemTag.ClearTextFound;
begin
  TagData.ValueFound.Clear;
  TagIgnoreData.ValueFound.Clear;
  if Assigned(SubBlock) then
    SubBlock.ClearTextFound;
end;

procedure TConfigItemTag.Configure(const psTagBegin, psTagData, psTagIgnoreData,
  psTagEnd: TRecordParamValueSearch; const pnIDCategory: Integer;
  const pbCanProcessAllValues: Boolean);
var
  nIDCategory: Integer;
begin
  if TDMUtils.ExistValue(psTagBegin.TagSearch) or
    TDMUtils.ExistValue(psTagEnd.TagSearch) or (pnIDCategory > -1) then
  begin
    nIDCategory := pnIDCategory;
    if (pnIDCategory > -1) and Assigned(Owner) and (Owner is TConfigBlockTag)
    then
      nIDCategory := TConfigBlockTag(Owner).IDCategory;
    TDMUtils.DestroyObject(FSubBlock);
    SubBlock := GetNewSubBlock;
    SubBlock.Configure(nil, psTagBegin, psTagEnd, pbCanProcessAllValues,
      nIDCategory);

    SubBlock.ListObjectActionChildren.Add(nil, psTagData, psTagIgnoreData, nil,
      -1, pbCanProcessAllValues);
    Exit;
  end;

  AddTag(FTagData, psTagData);
  AddTag(FTagIgnoreData, psTagIgnoreData);
end;

procedure TConfigItemTag.Configure(const psTagBegin: string;
  psTagData: TRecordParamValueSearch; psTagIgnoreData, psTagEnd: String;
  const pnIDCategory: Integer; const pbCanProcessAllValues: Boolean);
var
  nIDCategory: Integer;
begin
  if TDMUtils.ExistValue(psTagBegin) or TDMUtils.ExistValue(psTagEnd) or
    (pnIDCategory > -1) then
  begin
    nIDCategory := pnIDCategory;
    if TDMUtils.IsEmpty(pnIDCategory) and Assigned(Owner) and
      (Owner is TConfigBlockTag) then
      nIDCategory := TConfigBlockTag(Owner).IDCategory;

    TDMUtils.DestroyObject(FSubBlock);
    SubBlock := GetNewSubBlock;
    SubBlock.Configure(nil, psTagBegin, psTagEnd, pbCanProcessAllValues,
      nIDCategory);

    SubBlock.ListObjectActionChildren.Add(sCST_EmptyStr, psTagData,
      psTagIgnoreData, sCST_EmptyStr, -1, pbCanProcessAllValues);
    Exit;
  end;

  AddTag(FTagData, psTagData);
  AddTag(FTagIgnoreData, psTagIgnoreData);
end;

procedure TConfigItemTag.ConverteKeyFound(poDeKeyToDate: TMethodKeyToDate);
begin
  TagIgnoreData.ValueFound.ConverteKeyFound(poDeKeyToDate);
  TagData.ValueFound.ConverteKeyFound(poDeKeyToDate);
  if Assigned(SubBlock) then
    SubBlock.ConverteKeyFound(poDeKeyToDate);
end;

procedure TConfigItemTag.Configure(const psTagBegin, psTagData, psTagIgnoreData,
  psTagEnd: String; const pnIDCategory: Integer;
  const pbCanProcessAllValues: Boolean);
var
  nIDCategory: Integer;
begin
  if TDMUtils.ExistValue(psTagBegin) or TDMUtils.ExistValue(psTagEnd) or
    (pnIDCategory > -1) then
  begin
    nIDCategory := pnIDCategory;
    if TDMUtils.IsEmpty(pnIDCategory) and Assigned(Owner) and
      (Owner is TConfigBlockTag) then
      nIDCategory := TConfigBlockTag(Owner).IDCategory;

    TDMUtils.DestroyObject(FSubBlock);
    SubBlock := GetNewSubBlock;
    SubBlock.Configure(nil, psTagBegin, psTagEnd, pbCanProcessAllValues,
      nIDCategory);

    SubBlock.ListObjectActionChildren.Add(sCST_EmptyStr, psTagData,
      psTagIgnoreData, sCST_EmptyStr, -1, pbCanProcessAllValues);
    Exit;
  end;

  AddTag(FTagData, psTagData);
  AddTag(FTagIgnoreData, psTagIgnoreData);
end;

destructor TConfigItemTag.Destroy;
begin
  TDMUtils.DestroyObject(FTagIgnoreData);
  TDMUtils.DestroyObject(FTagData);
  TDMUtils.DestroyObject(FSubBlock);
  inherited;
end;

function TConfigItemTag.GetTagData: TValueTag;
begin
  Result := FTagData;
end;

function TConfigItemTag.GetTagIgnoreData: TValueTag;
begin
  Result := FTagIgnoreData;
end;

procedure TConfigItemTag.NewBackupTextFound(const pbClearOldValue: Boolean);
begin
  TagData.NewBackup(pbClearOldValue);
  TagIgnoreData.NewBackup(pbClearOldValue);
  if Assigned(SubBlock) then
    SubBlock.NewBackupTextFound(pbClearOldValue);
end;

procedure TConfigItemTag.RevertBackupTextFound(const pbClearOldValue: Boolean);
begin
  TagData.RevertBackup(pbClearOldValue);
  TagIgnoreData.RevertBackup(pbClearOldValue);
  if Assigned(SubBlock) then
    SubBlock.RevertBackupTextFound(pbClearOldValue);
end;

procedure TConfigItemTag.SetCanExportForFile(const Value: Boolean);
begin
  FCanExportForFile := Value;
  if assigned(FSubBlock) then
    FSubBlock.CanExportForFile := FCanExportForFile;
end;

procedure TConfigItemTag.SetSubBlock(const Value: TConfigBlockTag);
begin
  FSubBlock := Value;
end;

procedure TConfigItemTag.SetTagData(const Value: TValueTag);
begin
  FTagData := Value;
end;

procedure TConfigItemTag.SetTagIgnoreData(const Value: TValueTag);
begin
  FTagIgnoreData := Value;
end;

{ TConfigBlockTag }

procedure TConfigBlockTag.AfterConstruction;
begin
  FIDCategory := -1;
  FCanExportForFile := True;
  FCanProcessAllValues := False;
  FTagBeginBlock := GetNewTagBeginBlock;
  FTagEndBlock := GetNewTagEndBlock;
  FListObjectActionReference := GetNewListObjectActionReference;
  inherited;
end;

procedure TConfigBlockTag.Assign(Source: TPersistent;
  const pbClearOldValue: Boolean);
var
  oConfigBlockTag: TConfigBlockTag;
begin
  inherited;
  if not(Assigned(Source) and (Source is TConfigBlockTag)) then
    Exit;

  oConfigBlockTag := TConfigBlockTag(Source);
  Self.FCanExportForFile := oConfigBlockTag.CanExportForFile;
  Self.FCanProcessAllValues := oConfigBlockTag.FCanProcessAllValues;
  Self.FProcessingInternalData := oConfigBlockTag.FProcessingInternalData;
  Self.FCountLocate := oConfigBlockTag.FCountLocate;
  Self.FProcessing := oConfigBlockTag.FProcessing;
  Self.FSucessfullBlock := oConfigBlockTag.FSucessfullBlock;
  Self.FIDCategory := oConfigBlockTag.FIDCategory;
  Self.FOnProcessingInternalData := oConfigBlockTag.FOnProcessingInternalData;
  Self.ListObjectActionReference.Assign
    (oConfigBlockTag.ListObjectActionReference, pbClearOldValue);
  Self.FTagBeginBlock.Assign(oConfigBlockTag.FTagBeginBlock, pbClearOldValue);
  Self.FTagEndBlock.Assign(oConfigBlockTag.FTagEndBlock, pbClearOldValue);
end;

procedure TConfigBlockTag.Clear;
begin
  inherited;
  FSucessfullBlock := False;
  FProcessingInternalData := False;
  FCountLocate := nCST_Zero;
  FProcessing := False;
  ClearTextFound;
end;

procedure TConfigBlockTag.ClearTextFound;
begin
  TagBeginBlock.ValueFound.Clear;
  TagEndBlock.ValueFound.Clear;
  ListObjectActionChildren.ClearTextFound;
end;

procedure TConfigBlockTag.Configure(poListObjectActionReference
  : TListObjectAction; const psTagBeginBlock, psTagEndBlock: String;
  const pbCanProcessAllValues: Boolean; const pnIDCategory: Integer);
begin
  ListObjectActionReference.Assign(poListObjectActionReference);
  IDCategory := pnIDCategory;
  FCanProcessAllValues := pbCanProcessAllValues;
  TConfigItemTag.AddTag(FTagBeginBlock, psTagBeginBlock);
  TConfigItemTag.AddTag(FTagEndBlock, psTagEndBlock);
end;

procedure TConfigBlockTag.ConverteKeyFound(poDeKeyToDate: TMethodKeyToDate);
begin
  TagBeginBlock.ValueFound.ConverteKeyFound(poDeKeyToDate);
  TagEndBlock.ValueFound.ConverteKeyFound(poDeKeyToDate);
  ListObjectActionChildren.ConverteKeyFound(poDeKeyToDate);
end;

procedure TConfigBlockTag.Configure(poListObjectActionReference
  : TListObjectAction; const psTagBeginBlock, psTagEndBlock
  : TRecordParamValueSearch; const pbCanProcessAllValues: Boolean;
  const pnIDCategory: Integer);
begin
  ListObjectActionReference.Assign(poListObjectActionReference);
  IDCategory := pnIDCategory;
  FCanProcessAllValues := pbCanProcessAllValues;
  TConfigItemTag.AddTag(FTagBeginBlock, psTagBeginBlock);
  TConfigItemTag.AddTag(FTagEndBlock, psTagEndBlock);
end;

destructor TConfigBlockTag.Destroy;
begin
  TDMUtils.DestroyObject(FTagBeginBlock);
  TDMUtils.DestroyObject(FTagEndBlock);
  TDMUtils.DestroyObject(FListObjectActionReference);
  inherited;
end;

function TConfigBlockTag.GetCanExportForFile: Boolean;
begin
  Result := FCanExportForFile;
end;

function TConfigBlockTag.GetCanProcessAllValues: Boolean;
begin
  Result := FCanProcessAllValues;
end;

function TConfigBlockTag.GetCountLocate: Integer;
begin
  Result := FCountLocate;
end;

function TConfigBlockTag.GetIDCategory: Integer;
begin
  Result := FIDCategory;
end;

function TConfigBlockTag.GetListObjectActionChildren: TListConfigItemTag;
begin
  Result := inherited ListObjectActionChildren as TListConfigItemTag;
end;

function TConfigBlockTag.GetListObjectActionReference: TListObjectAction;
begin
  Result := FListObjectActionReference;
end;

function TConfigBlockTag.GetNewListObjectAction: TListObjectActionCustom;
begin
  Result := TListConfigItemTag.Create(Self);
end;

function TConfigBlockTag.GetNewListObjectActionReference: TListObjectAction;
begin
  Result := TListObjectAction.Create(Self);
end;

function TConfigBlockTag.GetNewTagBeginBlock: TValueTag;
begin
  Result := TFactoryObject.CreateComponent(TValueTag, Self) as TValueTag;
end;

function TConfigBlockTag.GetNewTagEndBlock: TValueTag;
begin
  Result := TFactoryObject.CreateComponent(TValueTag, Self) as TValueTag;
end;

function TConfigBlockTag.GetOnProcessingInternalData: TOnProcessingInternalData;
begin
  Result := FOnProcessingInternalData;
end;

function TConfigBlockTag.GetProcessing: Boolean;
begin
  Result := FProcessing;
end;

function TConfigBlockTag.GetProcessingInternalData: Boolean;
begin
  Result := FProcessingInternalData;
end;

function TConfigBlockTag.GetSucessfullBlock: Boolean;
begin
  Result := FSucessfullBlock;
end;

function TConfigBlockTag.GetTagBeginBlock: TValueTag;
begin
  Result := FTagBeginBlock;
end;

procedure TConfigBlockTag.NewBackupTextFound(const pbClearOldValue: Boolean);
begin
  TagBeginBlock.NewBackup(pbClearOldValue);
  TagEndBlock.NewBackup(pbClearOldValue);
  ListObjectActionChildren.NewBackupTextFound;
end;

procedure TConfigBlockTag.RevertBackupTextFound(const pbClearOldValue: Boolean);
begin
  TagBeginBlock.RevertBackup(pbClearOldValue);
  TagEndBlock.RevertBackup(pbClearOldValue);
  ListObjectActionChildren.RevertBackupTextFound;
end;

procedure TConfigBlockTag.SetCanExportForFile(const Value: Boolean);
var
  nIndex: Integer;
begin
  FCanExportForFile := Value;
  for nIndex := 0 to ListObjectActionChildren.Count - 1 do
  begin
    if assigned(ListObjectActionChildren.Items[nIndex]) then
      ListObjectActionChildren.Items[nIndex].CanExportForFile := FCanExportForFile;
  end;
end;

procedure TConfigBlockTag.SetCanProcessAllValues(const Value: Boolean);
var
  nIndex: Integer;
  oConfigItemTag: TConfigItemTag;
begin
  FCanProcessAllValues := Value;

  for nIndex := 0 to ListObjectActionChildren.Count - 1 do
  begin
    oConfigItemTag := ListObjectActionChildren.Items[nIndex];
    if (Assigned(oConfigItemTag) and Assigned(oConfigItemTag.SubBlock)) then
      oConfigItemTag.SubBlock.CanProcessAllValues := FCanProcessAllValues;
  end;
end;

procedure TConfigBlockTag.SetCountLocate(const Value: Integer);
begin
  FCountLocate := Value;
end;

procedure TConfigBlockTag.SetIDCategory(const Value: Integer);
begin
  FIDCategory := Value;
  if (FIDCategory < -1) then
    FIDCategory := -1;
end;

procedure TConfigBlockTag.SetListObjectActionChildren
  (const Value: TListConfigItemTag);
begin
  inherited ListObjectActionChildren := Value;
end;

procedure TConfigBlockTag.SetListObjectActionReference
  (const Value: TListObjectAction);
begin
  FListObjectActionReference := Value;
end;

procedure TConfigBlockTag.SetOnProcessingInternalData
  (const Value: TOnProcessingInternalData);
begin
  FOnProcessingInternalData := Value;
end;

procedure TConfigBlockTag.SetProcessing(const Value: Boolean);
begin
  FProcessing := Value;
end;

procedure TConfigBlockTag.SetProcessingInternalData(const Value: Boolean);
var
  nIndex: Integer;
  oConfigItemTag: TConfigItemTag;
begin
  FProcessingInternalData := Value;
  try
    if FProcessingInternalData then
    begin
      Inc(FCountLocate);
      Exit;
    end;

    for nIndex := nCST_Zero to ListObjectActionChildren.Count - nCST_One do
    begin
      oConfigItemTag := ListObjectActionChildren.Items[nIndex];
      if not(Assigned(oConfigItemTag) and Assigned(oConfigItemTag.SubBlock))
      then
        Continue;

      oConfigItemTag.SubBlock.ProcessingInternalData := FProcessingInternalData;
      oConfigItemTag.SubBlock.Processing := FProcessingInternalData;
    end;
  finally
    if Assigned(OnProcessingInternalData) then
      OnProcessingInternalData(FProcessingInternalData, Self);
  end;
end;

procedure TConfigBlockTag.SetSucessfullBlock(const Value: Boolean);
begin
  FSucessfullBlock := Value;
end;

procedure TConfigBlockTag.SetTagBeginBlock(const Value: TValueTag);
begin
  FTagBeginBlock := Value;
end;

procedure TConfigBlockTag.SetTagEndBlock(const Value: TValueTag);
begin
  FTagEndBlock := Value;
end;

{ TListConfigItemTag }

function TListConfigItemTag.Add(const psTagBegin, psTagData: String;
  psTagIgnoreData: String; const psTagEnd: String; const pnIDCategory: Integer;
  const pbCanProcessAllValues: Boolean): TConfigItemTag;
begin
  Result := GetNewConfigItemTag;
  Result.Configure(psTagBegin, psTagData, psTagIgnoreData, psTagEnd,
    pnIDCategory, pbCanProcessAllValues);

  inherited Add(Result);
end;

function TListConfigItemTag.Add(const psTagData: String;
  const pnIDCategory: Integer): TConfigItemTag;
begin
  Result := Add(sCST_EmptyStr, psTagData, sCST_EmptyStr, sCST_EmptyStr,
    pnIDCategory, False);
end;

function TListConfigItemTag.Add(const poTagBegin: TRecordParamValueSearch;
  const psTagData: String; psTagIgnoreData: String; const psTagEnd: String;
  const pnIDCategory: Integer; const pbCanProcessAllValues: Boolean)
  : TConfigItemTag;
var
  oTagData, oTagIgnoreData, oTagEnd: TRecordParamValueSearch;
begin
  oTagData := nil;
  if TDMUtils.ExistValue(psTagData) then
    oTagData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
      as TRecordParamValueSearch;

  oTagIgnoreData := nil;
  if TDMUtils.ExistValue(psTagIgnoreData) then
    oTagIgnoreData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
      as TRecordParamValueSearch;

  oTagEnd := nil;
  if TDMUtils.ExistValue(psTagEnd) then
    oTagEnd := TFactoryObject.CreateComponent(TRecordParamValueSearch)
      as TRecordParamValueSearch;
  try
    if TDMUtils.ExistValue(psTagData) then
      oTagData.TagSearch := psTagData;

    if TDMUtils.ExistValue(psTagIgnoreData) then
      oTagIgnoreData.TagSearch := psTagIgnoreData;

    if TDMUtils.ExistValue(psTagEnd) then
      oTagEnd.TagSearch := psTagEnd;

    Result := GetNewConfigItemTag;
    Result.Configure(poTagBegin, oTagData, oTagIgnoreData, oTagEnd,
      pnIDCategory, pbCanProcessAllValues);

    inherited Add(Result);
  finally
    TDMUtils.DestroyObject(oTagData);
    TDMUtils.DestroyObject(oTagIgnoreData);
    TDMUtils.DestroyObject(oTagEnd);
  end;
end;

function TListConfigItemTag.Add(const poTagData: TRecordParamValueSearch;
  paBeforeData, paAfterData: array of TRecordParamValueSearch;
  const psTagIgnoreData: String; const pnIDCategory: Integer): TConfigItemTag;
var
  nIndexBefore, nIndexAfter: Integer;
  oTagIgnoreData, oOldLine, oLine: TRecordParamValueSearch;

  procedure AddTag(poValue: TRecordParamValueSearch);
  begin
    if TDMUtils.IsEmpty(oLine.FieldDBName) and TDMUtils.IsEmpty(oLine.TagSearch)
    then
      Exit;
    if TDMUtils.ExistValue(oLine.FieldDBName) then
      oLine.FieldDBName := oLine.FieldDBName + ',';
    oLine.FieldDBName := oLine.FieldDBName + poValue.FieldDBName;

    if TDMUtils.ExistValue(oLine.TagSearch) then
      oLine.TagSearch := oLine.TagSearch + ',';
    oLine.TagSearch := oLine.TagSearch + poValue.TagSearch;

    if TDMUtils.ExistValue(oLine.FixedValue) then
      oLine.FixedValue := oLine.FixedValue + ',';
    oLine.FixedValue := oLine.FixedValue + poValue.FixedValue;
  end;

begin
  Result := nil;
  oTagIgnoreData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    oTagIgnoreData.TagSearch := psTagIgnoreData;
    for nIndexBefore := 0 to Length(paBeforeData) - 1 do
    begin
      oLine.Clear;
      AddTag(paBeforeData[nIndexBefore]);
      AddTag(poTagData);
      oOldLine := oLine;

      for nIndexAfter := 0 to Length(paAfterData) - 1 do
      begin
        oLine := oOldLine;
        AddTag(paAfterData[nIndexAfter]);
        Result := Add(nil, oLine, oTagIgnoreData, nil, pnIDCategory, False);

      end;
      if TDMUtils.IsEmpty(Length(paAfterData)) then
        Result := Add(nil, oLine, oTagIgnoreData, nil, pnIDCategory, False);
    end;
  finally
    TDMUtils.DestroyObject(oTagIgnoreData);
  end;
end;

function TListConfigItemTag.Add(const poTagBegin,
  poTagData: TRecordParamValueSearch; psTagIgnoreData: String;
  const psTagEnd: String; const pnIDCategory: Integer;
  const pbCanProcessAllValues: Boolean): TConfigItemTag;
var
  oTagIgnoreData, oTagEnd: TRecordParamValueSearch;
begin
  oTagIgnoreData := nil;
  if TDMUtils.ExistValue(psTagIgnoreData) then
    oTagIgnoreData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
      as TRecordParamValueSearch;

  oTagEnd := nil;
  if TDMUtils.ExistValue(psTagEnd) then
    oTagEnd := TFactoryObject.CreateComponent(TRecordParamValueSearch)
      as TRecordParamValueSearch;
  try
    if TDMUtils.ExistValue(psTagIgnoreData) then
      oTagIgnoreData.TagSearch := psTagIgnoreData;

    if TDMUtils.ExistValue(psTagEnd) then
      oTagEnd.TagSearch := psTagEnd;

    Result := GetNewConfigItemTag;
    Result.Configure(poTagBegin, poTagData, oTagIgnoreData, oTagEnd,
      pnIDCategory, pbCanProcessAllValues);

    inherited Add(Result);
  finally
    TDMUtils.DestroyObject(oTagEnd);
    TDMUtils.DestroyObject(oTagIgnoreData);
  end;
end;

function TListConfigItemTag.Add(const psTagBegin: String; poTagData: TField;
  psTagIgnoreData: String; const psTagEnd: String; const pnIDCategory: Integer;
  const pbCanProcessAllValues: Boolean): TConfigItemTag;
var
  oData: TRecordParamValueSearch;
begin
  oData := TFactoryObject.CreateComponent(TRecordParamValueSearch)
    as TRecordParamValueSearch;
  try
    if Assigned(poTagData) then
      oData.FieldDBName := poTagData.FieldName;

    Result := Add(psTagBegin, oData, psTagIgnoreData, psTagEnd, pnIDCategory,
      pbCanProcessAllValues);
  finally
    TDMUtils.DestroyObject(oData);
  end;
end;

function TListConfigItemTag.Add(const psTagBegin: String;
  poTagData: TRecordParamValueSearch; psTagIgnoreData: String;
  const psTagEnd: String; const pnIDCategory: Integer;
  const pbCanProcessAllValues: Boolean): TConfigItemTag;
begin
  Result := GetNewConfigItemTag;
  Result.Configure(psTagBegin, poTagData, psTagIgnoreData, psTagEnd,
    pnIDCategory, pbCanProcessAllValues);
  inherited Add(Result);
end;

function TListConfigItemTag.Add(const poTagBegin,
  poTagData: TRecordParamValueSearch; poTagIgnoreData: TRecordParamValueSearch;
  const poTagEnd: TRecordParamValueSearch; const pnIDCategory: Integer;
  const pbCanProcessAllValues: Boolean): TConfigItemTag;
begin
  Result := GetNewConfigItemTag;
  Result.Configure(poTagBegin, poTagData, poTagIgnoreData, poTagEnd,
    pnIDCategory, pbCanProcessAllValues);
  inherited Add(Result);
end;

function TListConfigItemTag.Add(const psTagData: String;
  paBeforeData, paAfterData: array of string; const psTagIgnoreData: String;
  const pnIDCategory: Integer): TConfigItemTag;
var
  nIndexBefore, nIndexAfter: Integer;
  sLineAdd, sAddAfter, sAddBefore, sLine: String;
begin
  Result := nil;
  for nIndexBefore := 0 to Length(paBeforeData) - 1 do
  begin
    sAddBefore := paBeforeData[nIndexBefore];
    sLine := psTagData;
    if TDMUtils.ExistValue(sAddBefore) then
    begin
      TDMUtils.AddIfExistValue(sLine, ',', False);
      sLine := sAddBefore + sLine;
    end;

    for nIndexAfter := 0 to Length(paAfterData) - 1 do
    begin
      sAddAfter := paAfterData[nIndexAfter];
      sLineAdd := sLine;
      if TDMUtils.ExistValue(sAddAfter) then
      begin
        TDMUtils.AddIfExistValue(sLine, ',');
        sLineAdd := sLine + sAddAfter;
      end;
      Result := Add(sCST_EmptyStr, sLineAdd, psTagIgnoreData, sCST_EmptyStr,
        pnIDCategory, False);
    end;
    if TDMUtils.IsEmpty(Length(paAfterData)) then
      Result := Add(sCST_EmptyStr, sLine, psTagIgnoreData, sCST_EmptyStr,
        pnIDCategory, False);
  end;
end;

procedure TListConfigItemTag.ClearTextFound;
var
  nIndex: Integer;
begin
  for nIndex := 0 to Count - 1 do
  begin
    if Assigned(Items[nIndex]) then
      Items[nIndex].ClearTextFound;
  end;
end;

procedure TListConfigItemTag.ConverteKeyFound(poDeKeyToDate: TMethodKeyToDate);
var
  nIndex: Integer;
begin
  for nIndex := 0 to Count - 1 do
  begin
    if Assigned(Items[nIndex]) then
      Items[nIndex].ConverteKeyFound(poDeKeyToDate);
  end;
end;

function TListConfigItemTag.GetItems(Index: Integer): TConfigItemTag;
begin
  Result := TConfigItemTag(inherited Items[index]);
end;

function TListConfigItemTag.GetNewConfigItemTag: TConfigItemTag;
begin
  Result := TConfigItemTag.Create(FOwner);
end;

procedure TListConfigItemTag.NewBackupTextFound(const pbClearOldValue: Boolean);
var
  nIndex: Integer;
begin
  for nIndex := 0 to Count - 1 do
  begin
    if Assigned(Items[nIndex]) then
      Items[nIndex].NewBackupTextFound(pbClearOldValue);
  end;
end;

procedure TListConfigItemTag.RevertBackupTextFound(const pbClearOldValue
  : Boolean);
var
  nIndex: Integer;
begin
  for nIndex := 0 to Count - 1 do
  begin
    if Assigned(Items[nIndex]) then
      Items[nIndex].RevertBackupTextFound(pbClearOldValue);
  end;
end;

procedure TListConfigItemTag.SetItems(Index: Integer;
  const Value: TConfigItemTag);
begin
  inherited Items[Index] := Value;
end;

{ TListConfigBlockTag }

function TListConfigBlockTag.Add(const psTagBeginBlock, psTagEndBlock: String;
  const pbCanProcessAllValues: Boolean; const pnIDCategory: Integer)
  : TConfigBlockTag;
begin
  Result := GetNewConfigBlockTag;
  Result.Configure(FListObjectActionReference, psTagBeginBlock, psTagEndBlock,
    pbCanProcessAllValues, pnIDCategory);
  Result.OnProcessingInternalData := OnProcessingInternalData;
  inherited Add(Result);
end;

function TListConfigBlockTag.Add(const poConfigBlockTagOrigem: TConfigBlockTag)
  : TConfigBlockTag;
begin
  Result := nil;
  if not Assigned(poConfigBlockTagOrigem) then
    Exit;

  Result := TFactoryObject.CloneComponent(poConfigBlockTagOrigem, FOwner)
    as TConfigBlockTag;
  inherited Add(Result);
end;

function TListConfigBlockTag.Add(const psTagBeginBlock, psTagEndBlock
  : TRecordParamValueSearch; const pbCanProcessAllValues: Boolean;
  const pnIDCategory: Integer): TConfigBlockTag;
begin
  Result := GetNewConfigBlockTag;
  Result.Configure(ListObjectActionReference, psTagBeginBlock, psTagEndBlock,
    pbCanProcessAllValues, pnIDCategory);
  Result.OnProcessingInternalData := OnProcessingInternalData;
  inherited Add(Result);
end;

function TListConfigBlockTag.Add(const psTagBeginBlock: TRecordParamValueSearch;
  const psTagEndBlock: String; const pbCanProcessAllValues: Boolean;
  const pnIDCategory: Integer): TConfigBlockTag;
var
  oTagEnd: TRecordParamValueSearch;
begin
  oTagEnd := nil;
  if TDMUtils.ExistValue(psTagEndBlock) then
    oTagEnd := TFactoryObject.CreateComponent(TRecordParamValueSearch)
      as TRecordParamValueSearch;
  try
    if TDMUtils.ExistValue(psTagEndBlock) then
      oTagEnd.TagSearch := psTagEndBlock;
    Result := GetNewConfigBlockTag;
    Result.Configure(ListObjectActionReference, psTagBeginBlock, oTagEnd,
      pbCanProcessAllValues, pnIDCategory);
    Result.OnProcessingInternalData := OnProcessingInternalData;
    inherited Add(Result);
  finally
    TDMUtils.DestroyObject(oTagEnd);
  end;
end;

procedure TListConfigBlockTag.AfterConstruction;
begin
  inherited;
  FListObjectActionReference := nil;
end;

procedure TListConfigBlockTag.BeforeDestruction;
begin
  FListObjectActionReference := nil;
  inherited;
end;

function TListConfigBlockTag.GetItems(Index: Integer): TConfigBlockTag;
begin
  Result := TConfigBlockTag(inherited Items[index]);
end;

function TListConfigBlockTag.GetListObjectActionReference: TListObjectAction;
begin
  Result := FListObjectActionReference;
end;

function TListConfigBlockTag.GetNewConfigBlockTag: TConfigBlockTag;
begin
  Result := TConfigBlockTag.Create(FOwner);
end;

procedure TListConfigBlockTag.OnProcessingInternalData(const pbProcessing
  : Boolean; poConfigBlockTag: TConfigBlockTag);
var
  nIndex: Integer;
  oConfigBlockTag: TConfigBlockTag;
begin
  if not(pbProcessing and Assigned(poConfigBlockTag)) then
    Exit;

  for nIndex := nCST_Zero to Self.Count - nCST_One do
  begin
    oConfigBlockTag := Self.Items[nIndex];
    if not(Assigned(oConfigBlockTag) and (oConfigBlockTag <> poConfigBlockTag))
    then
      Continue;

    oConfigBlockTag.ProcessingInternalData := False;
  end;
end;

procedure TListConfigBlockTag.SetItems(Index: Integer;
  const Value: TConfigBlockTag);
begin
  inherited Items[Index] := Value;
end;

procedure TListConfigBlockTag.SetListObjectActionReference
  (const Value: TListObjectAction);
begin
  FListObjectActionReference := Value;
end;

initialization

begin
  RegisterClass(TConfigBlockTag);
  RegisterClass(TConfigItemTag);
end;

end.
