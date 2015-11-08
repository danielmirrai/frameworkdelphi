
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
unit uObjectActionStructure;

interface

uses uDMUtils, Windows, Messages, SysUtils, Variants, Graphics, uFactoryObject,
  uDMList, uObjectActionCommand, uObjectActionBlockTag, Classes,
  Controls, Forms, Dialogs, StdCtrls, uObjectActionCustom, uObjectAction,
  Contnrs, uObjectActionBlockTagInDB, DB, uDMUtilsDao;

type
  TObjectActionStructure = class;
  TFieldNameAddOfListTag = Array of string;
  TValueAddOfListTag = Array of Variant;
  TListFieldNameAddOfListTag = array of TFieldNameAddOfListTag;
  TListValueAddOfListTag = array of TValueAddOfListTag;

  TClassItemStructureData = class of TObjectActionStructure;
  TListItemClass = array of TObjectActionStructure;

  TValueApplyDB = class
  public
    FoListFieldNameAddOfListTagBegin, FoListFieldNameAddOfListTagData,
    FoListFieldNameAddOfListTagEnd: TListFieldNameAddOfListTag;
    FoListValueAddOfListTagBegin, FoListValueAddOfListTagData,
    FoListValueAddOfListTagEnd: TListValueAddOfListTag;
    constructor Create;
  end;

  /// <summary>
  /// Definição de dados que será mapeado
  /// </summary>
  TObjectActionStructure = class(TObjectAction)
  private
    FDataFile: TStringList;
    FDeKeyToDate: TMethodKeyToDate;
    FListConfigBlockTag: TListConfigBlockTag;

    FObjectCanProcessStructure: Boolean;
    FListConfigBlockTagInValue: TListConfigBlockTag;

  protected
    FIDListActive, FIDActiveItemTag: Integer;
    oListBlockPendent: array of array of TConfigBlockTag;

    procedure SetValueConvertedToFile(poTagValue: TValueTag; var poDataFileTemp: TStringList); Virtual;
    procedure SetValueExporterToFile(poListLineOrigem, poListLineDest: TStringList); Virtual;
    function GetDataFile: TStringList; Virtual;
    function GetDeKeyToDate: TMethodKeyToDate; Virtual;
    function GetListConfigBlockTag: TListConfigBlockTag; Virtual;
    function GetListConfigBlockTagInValue: TListConfigBlockTag; Virtual;
    function GetObjectCanProcessStructure: Boolean; Virtual;
    procedure SetDataFile(const Value: TStringList); Virtual;
    procedure SetDeKeyToDate(const Value: TMethodKeyToDate); Virtual;
    procedure SetListConfigBlockTag(const Value: TListConfigBlockTag); Virtual;
    procedure SetListConfigBlockTagInValue(const Value
      : TListConfigBlockTag); Virtual;
    procedure SetObjectCanProcessStructure(const Value: Boolean); Virtual;
    procedure SetObjectChildCanProcessStructor
      (poChildren: TObjectActionStructure;
      const pbCanProcess: Boolean); Virtual;

    function GetNewBlockConfigTag: TConfigBlockTag; Virtual;
    function ProcessList(poList: TValueTag; var pnLineActive: Integer;
      poListIgnore: TValueTag = nil; const pbFirstProcess: Boolean = False;
      poListEnd: TValueTag = nil): Boolean; Virtual;
    /// <summary>
    /// processa bloco de dados
    /// </summary>
    procedure DefineBlock(poConfigBlockTag: TConfigBlockTag;
      var pnLineActive: Integer; const pbCanSave: Boolean = True); Virtual;
    function DefineItem(poListConfigItemTag: TListConfigItemTag;
      poTagEndBlock: TValueTag; var pnLineActive: Integer;
      const pbProcessAllValues: Boolean): Boolean; Virtual;
    procedure SaveTextAllChildren(poConfigBlockTag: TConfigBlockTag; poValueApplyDB: TValueApplyDB); Virtual;



    /// <summary>
    /// Salva na base o valor encontrado do item
    /// Exemplo: Unit Teste;
    /// Salva o valor teste
    /// </summary>
    function SaveValueFoundItem(poConfigBlockTag: TConfigBlockTag;
      poConfigItemTag: TConfigItemTag; poValueApplyDB: TValueApplyDB): Boolean; Virtual;
    procedure ConfigureBlockMapping; Virtual; abstract;
    function GetNewListObjectAction: TListObjectActionCustom; Override;
    class procedure Copy(poFieldNameOrigem: TFieldNameAddOfListTag;
      poValueOrigem: TValueAddOfListTag; var poFieldNameDest: TFieldNameAddOfListTag; var poValueDest: TValueAddOfListTag); Virtual;

    function GetValueOfData(const poTag: TValueTag;
      var poListFieldNameAddOfListTag: TListFieldNameAddOfListTag;
      var poListValueAddOfListTag: TListValueAddOfListTag): Boolean; Virtual;
    function SetValueOfData(poTag: TValueTag; var poDataFileTemp: TStringList): Boolean; Virtual;
    procedure ImportFileToDBSaveAllChildren(oConfigBlockTag: TConfigBlockTag;
      var pnLineActive: Integer); Virtual;
    procedure ExportDBToFileAllChildren(poConfigBlockTag
      : TConfigBlockTag; var poListLineOrigem: TStringList); Virtual;
    procedure DefineExportBlock(poConfigBlockTag: TConfigBlockTag;
      const pbCanSaveFile: Boolean; var poListLineDest: TStringList); Virtual;
    function SaveText(pbCanSave: Boolean; poConfigBlockTag: TConfigBlockTag;
      const pbIsSubBlock: Boolean; poValueApplyDB: TValueApplyDB): Boolean; Virtual;

    procedure AddData(const poListData, poTagBeginBlock, poTagEndBlock
      : TValueTag; const pnIDCategory: Integer; poValueApplyDB: TValueApplyDB); Virtual;
    procedure SaveDataInDB(poValueApplyDB: TValueApplyDB);

    function GetNewListConfigBlock: TListConfigBlockTag; virtual;
  public
    /// <summary>
    /// Inicializa objetos
    /// </summary>
    procedure Clear; Override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Assign(Source: TPersistent;
      const pbClearOldValue: Boolean); Override;
    /// <summary>
    /// Captura e grava os dados referênte ao item
    /// </summary>
    procedure ImportFileToDB(var pnLineActive: Integer;
      const pbCanSave: Boolean = True); Virtual;

    procedure ExportDBtoFile(poListLineOrigem: TStringList; const pbCanSaveFile: Boolean = False); Virtual;

    /// <summary>
    /// Chama o método que converte os id dos valores encontrados para string
    /// Exemplo: |ID_Operator_7| para ;
    /// </summary>
    property DeKeyToDate: TMethodKeyToDate read GetDeKeyToDate
      write SetDeKeyToDate;

    property DataFile: TStringList read GetDataFile write SetDataFile;

    property ListConfigBlockTag: TListConfigBlockTag read GetListConfigBlockTag
      write SetListConfigBlockTag;

    property ListConfigBlockTagInValue: TListConfigBlockTag
      read GetListConfigBlockTagInValue write SetListConfigBlockTagInValue;

    property ObjectCanProcessStructure: Boolean
      read GetObjectCanProcessStructure write SetObjectCanProcessStructure;
  end;

  /// <summary>
  /// Lista de comandos para o mapeamentos dos valores do arquivo
  /// </summary>
  TListStructureData = class(TListObjectAction)
  private
    FDeKeyToDate: TMethodKeyToDate;
    FDataFile: TStringList;
  protected
    procedure SetDataFile(const Value: TStringList); Virtual;
    procedure SetDeKeyToDate(const Value: TMethodKeyToDate); Virtual;
    function GetDataFile: TStringList; Virtual;
    function GetDeKeyToDate: TMethodKeyToDate; Virtual;
  public
    procedure Assign(Source: TObject;
      const pbClearOldValue: Boolean = True); Override;
    function Add(poListClass: TClassItemStructureData)
      : TObjectActionStructure; Virtual;
    /// <summary>
    /// Adiciona todas as estruturas
    /// </summary>
    procedure ImportAll; virtual;
    procedure AfterConstruction; override;
    destructor Destroy; Override;
    property DataFile: TStringList read GetDataFile write SetDataFile;
    /// <summary>
    /// Chama o método que converte os id dos valores encontrados para string
    /// Exemplo: |ID_Operator_7| para ;
    /// </summary>
    property DeKeyToDate: TMethodKeyToDate read GetDeKeyToDate
      write SetDeKeyToDate;
  end;

implementation

{ TObjectActionStructure }

uses uConstantUtils, uDMException, uConstantCommand;

procedure TObjectActionStructure.AddData(const poListData, poTagBeginBlock,
  poTagEndBlock: TValueTag; const pnIDCategory: Integer; poValueApplyDB: TValueApplyDB);
begin
  if not(Assigned(DeKeyToDate) and Assigned(poTagBeginBlock) and
    Assigned(poTagEndBlock)) then
    Exit;

  GetValueOfData(poTagBeginBlock, poValueApplyDB.FoListFieldNameAddOfListTagBegin,
    poValueApplyDB.FoListValueAddOfListTagBegin);
  GetValueOfData(poTagEndBlock, poValueApplyDB.FoListFieldNameAddOfListTagEnd,
    poValueApplyDB.FoListValueAddOfListTagEnd);
  GetValueOfData(poListData, poValueApplyDB.FoListFieldNameAddOfListTagData,
    poValueApplyDB.FoListValueAddOfListTagData);

  SaveDataInDB(poValueApplyDB);
end;

function TObjectActionStructure.GetDataFile: TStringList;
begin
  Result := FDataFile;
end;

function TObjectActionStructure.GetDeKeyToDate: TMethodKeyToDate;
begin
  Result := FDeKeyToDate;
end;

function TObjectActionStructure.GetListConfigBlockTag: TListConfigBlockTag;
begin
  Result := FListConfigBlockTag;
end;

function TObjectActionStructure.GetListConfigBlockTagInValue
  : TListConfigBlockTag;
begin
  Result := FListConfigBlockTagInValue;
end;

function TObjectActionStructure.GetNewBlockConfigTag: TConfigBlockTag;
var
  nIndexBlockPendent: Integer;
begin
  Result := nil;
  if (Length(oListBlockPendent) < FIDListActive) then
    Exit;

  for nIndexBlockPendent := nCST_Zero to Length
    (oListBlockPendent[FIDListActive - 1]) - nCST_One do
  begin
    Result := oListBlockPendent[FIDListActive - 1][nIndexBlockPendent];
    oListBlockPendent[FIDListActive - 1][nIndexBlockPendent] := nil;
    if Assigned(Result) then
      Break;
  end;
  if not Assigned(Result) then
    Result := FListConfigBlockTagInValue.Add
      (FListConfigBlockTag.Items[FIDListActive - 1]);
end;

function TObjectActionStructure.GetNewListConfigBlock: TListConfigBlockTag;
begin
  Result := TListConfigBlockTag.Create(Self);
end;

function TObjectActionStructure.GetNewListObjectAction: TListObjectActionCustom;
begin
  Result := TListStructureData.Create(Self);
end;

function TObjectActionStructure.GetObjectCanProcessStructure: Boolean;
begin
  Result := FObjectCanProcessStructure;
end;

function TObjectActionStructure.GetValueOfData(const poTag: TValueTag;
  var poListFieldNameAddOfListTag: TListFieldNameAddOfListTag;
  var poListValueAddOfListTag: TListValueAddOfListTag): Boolean;
var
  nIndexValueSearch, nIndexValue, nIndex: Integer;
  oField: TField;
  sValueSearch, sValue: String;
  oListValue: TStringList;
  bIsEmpty: Boolean;
begin
  Result := False;
  // Percore a lista de valores encontrados
  if not Assigned(poTag) then
    Exit;

  poTag.ValueFound.ConverteKeyFound(DeKeyToDate);
  SetLength(poListFieldNameAddOfListTag, nCST_Zero);
  SetLength(poListValueAddOfListTag, nCST_Zero);

  SetLength(poListFieldNameAddOfListTag, poTag.ValueFound.ValueConverted.Count);
  SetLength(poListValueAddOfListTag, poTag.ValueFound.ValueConverted.Count);
  try
    for nIndex := nCST_Zero to poTag.ValueFound.ValueConverted.Count - nCST_One do
    begin
      if not Assigned(poTag.ValueFound.ValueConverted.Items[nIndex]) then
        Continue;

      oListValue := poTag.ValueFound.ValueConverted.Items[nIndex];
      SetLength(poListFieldNameAddOfListTag[nIndex], nCST_Zero);
      SetLength(poListValueAddOfListTag[nIndex], nCST_Zero);
      for nIndexValue := nCST_Zero to oListValue.Count - nCST_One do
      begin
        sValue := Trim(oListValue.Strings[nIndexValue]);

        nIndexValueSearch := nIndexValue;
        if (poTag.ValueSearch.TagSearch.Count <= nIndexValueSearch) then
          nIndexValueSearch := poTag.ValueSearch.TagSearch.Count - 1;

        sValueSearch := poTag.ValueSearch.TagSearch.Strings[nIndexValueSearch];
        oField := nil;
        if (poTag.ValueSearch.FieldDBName.Count > nIndexValue) and TDMUtils.ExistValue(poTag.ValueSearch.FieldDBName.Strings[nIndexValue]) then
          oField := FObjectDao.CDSDados.FindField
            (poTag.ValueSearch.FieldDBName.Strings[nIndexValue])
        else
        if TDMutils.CompareIgnoreCase(sValueSearch, sCST_OtherValue) then
        begin
          poListValueAddOfListTag[nIndex][Length(poListValueAddOfListTag[nIndex]) - 1] := poListValueAddOfListTag[nIndex][Length(poListValueAddOfListTag[nIndex]) - 1] + sValue;
        end;

        if not Assigned(oField) then
          Continue;

        if (poTag.ValueSearch.FixedValue.Count > nIndexValue) and
          TDMUtils.ExistValue(poTag.ValueSearch.FixedValue.Strings[nIndexValue]) then
          sValue := poTag.ValueSearch.FixedValue.Strings[nIndexValue];

        if oField.Required then
        begin
          bIsEmpty := False;
          case TDMUtilsDao.GetTypeFieldSimple(oField) of
            ftInteger, ftFloat:
              bIsEmpty := TDMUtils.IsEmpty(TDMUtils.StrToFloat2(sValue));
            ftString:
              bIsEmpty := TDMUtils.IsEmpty(sValue);
            ftBoolean:
              bIsEmpty := False;
          end;

          if bIsEmpty then
            Continue;
        end;

        Result := true;

        if not(pfInKey in oField.ProviderFlags) then
        begin
          SetLength(poListFieldNameAddOfListTag[nIndex], Length(poListFieldNameAddOfListTag[nIndex]) + 1);
          SetLength(poListValueAddOfListTag[nIndex], Length(poListValueAddOfListTag[nIndex]) + 1);

          poListFieldNameAddOfListTag[nIndex][Length(poListFieldNameAddOfListTag[nIndex]) - 1] := oField.FieldName;
          poListValueAddOfListTag[nIndex][Length(poListValueAddOfListTag[nIndex]) - 1] := sValue;
        end;
      end;

      if not Result then
        Break;
    end;
  finally
    if not Result then
    begin
      SetLength(poListFieldNameAddOfListTag, nCST_Zero);
      SetLength(poListValueAddOfListTag, nCST_Zero);
    end;
  end;
end;

procedure TObjectActionStructure.AfterConstruction;
begin
  SetLength(oListBlockPendent, 0);
  ListConfigBlockTag := GetNewListConfigBlock;
  ListConfigBlockTag.ListObjectActionReference := ListObjectActionChildren;

  FListConfigBlockTagInValue := GetNewListConfigBlock;
  FListConfigBlockTagInValue.ListObjectActionReference :=
    ListObjectActionChildren;
  FObjectCanProcessStructure := False;
  inherited;
  Clear;
end;

procedure TObjectActionStructure.Assign(Source: TPersistent;
  const pbClearOldValue: Boolean);
var
  oValueTag: TObjectActionStructure;
begin
  inherited;
  if not(Assigned(Source) and (Source is TObjectActionStructure)) then
    Exit;
  oValueTag := TObjectActionStructure(Source);
  FDataFile := oValueTag.FDataFile;
  FDeKeyToDate := oValueTag.FDeKeyToDate;
  FIDListActive := oValueTag.FIDListActive;
  FIDActiveItemTag := oValueTag.FIDActiveItemTag;
  FObjectCanProcessStructure := oValueTag.FObjectCanProcessStructure;
  FListConfigBlockTagInValue.Clear;
  FListConfigBlockTag.Assign(oValueTag.FListConfigBlockTag, pbClearOldValue);
  SetLength(oListBlockPendent, nCST_Zero);
end;

procedure TObjectActionStructure.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FListConfigBlockTag);
  TDMUtils.DestroyObject(FListConfigBlockTagInValue);
  inherited;
end;

procedure TObjectActionStructure.Clear;
begin
  FDeKeyToDate := nil;
  FDataFile := nil;
  FIDListActive := nCST_Zero;
  FIDActiveItemTag := nCST_Zero;
  FListConfigBlockTag.Clear;
  FListConfigBlockTagInValue.Clear;
end;

class procedure TObjectActionStructure.Copy(poFieldNameOrigem: TFieldNameAddOfListTag;
      poValueOrigem: TValueAddOfListTag; var poFieldNameDest: TFieldNameAddOfListTag; var poValueDest: TValueAddOfListTag);
var
  nIndex, nIndexBeginCopy: Integer;
begin
  nIndexBeginCopy := Length(poFieldNameDest);
  SetLength(poFieldNameDest, nIndexBeginCopy);
  SetLength(poValueDest, nIndexBeginCopy);
  if (Length(poFieldNameOrigem) <> Length(poValueOrigem)) then
    Exit;
  for nIndex := nCST_Zero to Length(poFieldNameOrigem) - nCST_One do
  begin
    if TDMUtils.IsEmpty(TDMUtils.VarToStr2(poFieldNameOrigem[nIndex])) then
      Continue;

    SetLength(poFieldNameDest, Length(poFieldNameDest) + 1);
    poFieldNameDest[Length(poFieldNameDest) -1] := poFieldNameOrigem[nIndex];
    SetLength(poValueDest, Length(poValueDest) + 1);
    poValueDest[Length(poValueDest) - 1] := poValueOrigem[nIndex];
  end;
end;

procedure TObjectActionStructure.DefineBlock(poConfigBlockTag: TConfigBlockTag;
  var pnLineActive: Integer; const pbCanSave: Boolean);
var
  nOldLineActive: Integer;
  oOldSucessfullBlock: Boolean;
  oNewConfigBlockTag: TConfigBlockTag;
begin
  nOldLineActive := pnLineActive;
  if not Assigned(poConfigBlockTag) then
    Exit;

  oOldSucessfullBlock := poConfigBlockTag.SucessfullBlock;
  poConfigBlockTag.SucessfullBlock := False;
  poConfigBlockTag.Processing := True;
  try
    poConfigBlockTag.NewBackupTextFound(True);
    try
      if poConfigBlockTag.ProcessingInternalData then
        poConfigBlockTag.SucessfullBlock := False
      else
      begin
        // Dados início bloco
        poConfigBlockTag.SucessfullBlock :=
          ProcessList(poConfigBlockTag.TagBeginBlock, pnLineActive, nil,
          (Assigned(poConfigBlockTag.ListObjectActionChildren) and
          TDMUtils.ExistValue(poConfigBlockTag.ListObjectActionChildren.Count))
          or Assigned(poConfigBlockTag.TagEndBlock) and
          TDMUtils.ExistValue(poConfigBlockTag.TagEndBlock.ValueSearch.
          TagSearch.Count));

        if not poConfigBlockTag.SucessfullBlock then
          Exit;

        // Conteúdo do bloco
        poConfigBlockTag.SucessfullBlock :=
          DefineItem(poConfigBlockTag.ListObjectActionChildren,
          poConfigBlockTag.TagEndBlock, pnLineActive,
          poConfigBlockTag.CanProcessAllValues);

        if poConfigBlockTag.SucessfullBlock then
          poConfigBlockTag.ProcessingInternalData := True;
      end;

      ImportFileToDBSaveAllChildren(poConfigBlockTag, pnLineActive);

      // Final do bloco
      if poConfigBlockTag.ProcessingInternalData and
        ProcessList(poConfigBlockTag.TagEndBlock, pnLineActive) then
        poConfigBlockTag.ProcessingInternalData := False
      else if TDMUtils.IsEmpty
        (poConfigBlockTag.TagBeginBlock.ValueSearch.TagSearch.Count) then
      begin
        poConfigBlockTag.ProcessingInternalData := False;
        poConfigBlockTag.SucessfullBlock := False;
      end;
      SaveText(pbCanSave, poConfigBlockTag, False, nil);

      if poConfigBlockTag.SucessfullBlock and poConfigBlockTag.CanProcessAllValues
      then
      begin
        oNewConfigBlockTag := GetNewBlockConfigTag;
        DefineBlock(oNewConfigBlockTag, pnLineActive, pbCanSave);
        if not oNewConfigBlockTag.SucessfullBlock then
        begin
          oNewConfigBlockTag.Clear;
          SetLength(oListBlockPendent[FIDListActive - 1],
            Length(oListBlockPendent[FIDListActive - 1]) + 1);
          oListBlockPendent[FIDListActive - 1]
            [Length(oListBlockPendent[FIDListActive - 1]) - 1] :=
            oNewConfigBlockTag;
        end;
      end;
    finally
      poConfigBlockTag.RevertBackupTextFound
        (not poConfigBlockTag.SucessfullBlock);
    end;
  finally
    poConfigBlockTag.Processing := False;

    if not poConfigBlockTag.SucessfullBlock then
    begin
      pnLineActive := nOldLineActive;
      poConfigBlockTag.SucessfullBlock := oOldSucessfullBlock;
    end;
  end;
end;

procedure TObjectActionStructure.DefineExportBlock(poConfigBlockTag
  : TConfigBlockTag; const pbCanSaveFile: Boolean; var poListLineDest: TStringList);
var
  oConfigItemTag: TConfigItemTag;
  nIndex: Integer;
  bSucess, bCanLoopAllRegistryForTagBeginAndEnd, bCanLoopAllRegistryForTagData: Boolean;
  nCountRegistry, nCountRegistryData, nIndexRegistryData,
  nCountDataAdd, nIndexRegistry: Integer;
  oListLineOrigem: TStringList;
begin
  if not (Assigned(poConfigBlockTag) and poConfigBlockTag.CanExportForFile) then
    Exit;

  oListLineOrigem := TStringList.Create;
  try
    bCanLoopAllRegistryForTagBeginAndEnd :=
      ((poConfigBlockTag.TagBeginBlock.ValueSearch.ExistFieldDBInTag or
      poConfigBlockTag.TagEndBlock.ValueSearch.ExistFieldDBInTag) and
      (not pbCanSaveFile));

    bCanLoopAllRegistryForTagData := ((not bCanLoopAllRegistryForTagBeginAndEnd)
      and (not pbCanSaveFile));
    nCountRegistry := nCST_One;
    if bCanLoopAllRegistryForTagBeginAndEnd then
    begin
      FObjectDao.CDSDados.First;
      nCountRegistry := FObjectDao.CDSDados.RecordCount;
    end;

    nCountDataAdd := nCST_Zero;
    for nIndexRegistry := nCST_Zero to nCountRegistry - nCST_One do
    begin
      if bCanLoopAllRegistryForTagBeginAndEnd then
        TDMUtils.SetRecno(FObjectDao.CDSDados, nIndexRegistry + nCST_One);

      bSucess := SetValueOfData(poConfigBlockTag.TagBeginBlock, oListLineOrigem);
      if not bSucess then
      begin
        FObjectDao.CDSDados.Next;
        Continue;
      end;
      nCountRegistryData := nCST_One;
      if bCanLoopAllRegistryForTagData then
      begin
        FObjectDao.CDSDados.First;
        nCountRegistryData := FObjectDao.CDSDados.RecordCount;
      end;

      for nIndexRegistryData := nCST_Zero to nCountRegistryData - nCST_One do
      begin
        if bCanLoopAllRegistryForTagData then
          TDMUtils.SetRecno(FObjectDao.CDSDados, nCountRegistryData + nCST_One);

        for nIndex := nCST_Zero to poConfigBlockTag.ListObjectActionChildren.Count
          - nCST_One do
        begin
          oConfigItemTag := poConfigBlockTag.ListObjectActionChildren.
            Items[nIndex];
          if not (Assigned(oConfigItemTag) and oConfigItemTag.CanExportForFile) then
            Continue;
          if nCountDataAdd > 0 then
            bSucess := SetValueOfData(oConfigItemTag.TagIgnoreData, oListLineOrigem);
          if not bSucess then
            Break;

          bSucess := SetValueOfData(oConfigItemTag.TagData, oListLineOrigem);
          if not bSucess then
            Break;
          inc(nCountDataAdd);
          DefineExportBlock(oConfigItemTag.SubBlock, pbCanSaveFile, oListLineOrigem);
        end;

        if not bSucess then
          Break;

        if bCanLoopAllRegistryForTagData then
        begin
          FObjectDao.CDSDados.Next;
          SetValueExporterToFile(oListLineOrigem, poListLineDest);
          oListLineOrigem.Clear;
        end;
      end;
      if not bSucess then
      begin
        FObjectDao.CDSDados.Next;
        Continue;
      end;
      ExportDBToFileAllChildren(poConfigBlockTag, oListLineOrigem);
      bSucess := SetValueOfData(poConfigBlockTag.TagEndBlock, oListLineOrigem);
      if not bSucess then
      begin
        FObjectDao.CDSDados.Next;
        Continue;
      end;

      if bCanLoopAllRegistryForTagBeginAndEnd then
      begin
        FObjectDao.CDSDados.Next;
        SetValueExporterToFile(oListLineOrigem, poListLineDest);
        oListLineOrigem.Clear;
      end;
    end;
    SetValueExporterToFile(oListLineOrigem, poListLineDest);
    oListLineOrigem.Clear;
  finally
    TDMUtils.destroyObject(oListLineOrigem);
  end;
end;

procedure TObjectActionStructure.ImportFileToDB(var pnLineActive: Integer;
  const pbCanSave: Boolean);
var
  nIndexList, nOldLineActive: Integer;
  oConfigBlockTag: TConfigBlockTag;
  bOneItemCanProcessAll, bContinue: Boolean;
begin
  if (pnLineActive >= FDataFile.Count) then
    Exit;

  FIDListActive := nCST_Zero;
  FIDActiveItemTag := nCST_Zero;
  try
    bContinue := True;
    bOneItemCanProcessAll := True;
    if (Length(oListBlockPendent) < FListConfigBlockTag.Count) then
      SetLength(oListBlockPendent, FListConfigBlockTag.Count);
    while bContinue and bOneItemCanProcessAll do
    begin
      bContinue := False;
      bOneItemCanProcessAll := False;
      for nIndexList := nCST_Zero to FListConfigBlockTag.Count - nCST_One do
      begin
        FIDListActive := nIndexList + nCST_One;
        FIDActiveItemTag := nCST_Zero;
        oConfigBlockTag := GetNewBlockConfigTag;
        nOldLineActive := pnLineActive;
        DefineBlock(oConfigBlockTag, pnLineActive, pbCanSave);
        if (oConfigBlockTag.SucessfullBlock and (nIndexList <> 0) and
          (nOldLineActive <> pnLineActive)) then
          bContinue := True;
        if (oConfigBlockTag.SucessfullBlock and
          (pnLineActive = (FListConfigBlockTag.Count - 1))) then
          bContinue := False;
        if oConfigBlockTag.CanProcessAllValues then
          bOneItemCanProcessAll := True;

        if not oConfigBlockTag.SucessfullBlock then
        begin
          oConfigBlockTag.Clear;
          SetLength(oListBlockPendent[nIndexList],
            Length(oListBlockPendent[nIndexList]) + 1);
          oListBlockPendent[nIndexList][Length(oListBlockPendent[nIndexList]) -
            1] := oConfigBlockTag;
        end;
      end;
    end;
  finally
    FIDListActive := nCST_Zero;
    FIDActiveItemTag := nCST_Zero;
  end;
end;

function TObjectActionStructure.DefineItem(poListConfigItemTag
  : TListConfigItemTag; poTagEndBlock: TValueTag; var pnLineActive: Integer;
  const pbProcessAllValues: Boolean): Boolean;
var
  nLineActive, nIndexItemTag: Integer;
  oConfigItemTag: TConfigItemTag;
  bOldSucessfullBlock, bFoundTag, bCanDefineAllItens: Boolean;
begin
  Result := False;
  bCanDefineAllItens := False;
  oConfigItemTag := nil;
  if not(Assigned(poListConfigItemTag)) then
    Exit;

  if TDMUtils.IsEmpty(poListConfigItemTag.Count) then
  begin
    Result := True;
    Exit;
  end;

  for nIndexItemTag := nCST_Zero to poListConfigItemTag.Count -
    nCST_One do
  begin
    FIDActiveItemTag := FIDActiveItemTag + nCST_One;
    oConfigItemTag := poListConfigItemTag.Items[nIndexItemTag];
    if not Assigned(oConfigItemTag) then
      Continue;

    nLineActive := pnLineActive;
    // Captura contéudo do bloco
    bFoundTag := TDMUtils.IsEmpty(oConfigItemTag.TagData.ValueSearch.TagSearch);
    while TDMUtils.ExistValue(oConfigItemTag.TagData.ValueSearch.TagSearch) and
      ProcessList(oConfigItemTag.TagData, nLineActive,
      oConfigItemTag.TagIgnoreData, False, poTagEndBlock) do
    begin
      bFoundTag := True;
      bCanDefineAllItens := True;
      if not pbProcessAllValues then
        Break;
    end;

    if not bFoundTag then
    begin
      nLineActive := pnLineActive;
      Continue;
    end;

    if (Assigned(oConfigItemTag.SubBlock) and bFoundTag and
      TDMUtils.ExistValue(oConfigItemTag.SubBlock.ListObjectActionChildren.
      Count)) then
    begin
      // Processa sub block - Capturando conteúdo dentro do sub bloco
      bOldSucessfullBlock := oConfigItemTag.SubBlock.SucessfullBlock;
      DefineBlock(oConfigItemTag.SubBlock, nLineActive, False);
      if TDMUtils.IsEmpty(oConfigItemTag.TagData.ValueSearch.TagSearch) then
        bFoundTag := oConfigItemTag.SubBlock.SucessfullBlock;
      if not oConfigItemTag.SubBlock.SucessfullBlock then
        oConfigItemTag.SubBlock.SucessfullBlock := bOldSucessfullBlock;
    end;

    if bFoundTag then
    begin
      pnLineActive := nLineActive;
      Result := True;
    end;
  end;
  if (bCanDefineAllItens and Result and pbProcessAllValues and
    TDMUtils.ExistValue(oConfigItemTag.TagData.ValueSearch.TagSearch)) then
    DefineItem(poListConfigItemTag, poTagEndBlock, pnLineActive,
      pbProcessAllValues);
end;

procedure TObjectActionStructure.ExportDBtoFile(poListLineOrigem: TStringList; const pbCanSaveFile: Boolean);
var
  nIndexList: Integer;
begin
  if not (Assigned(poListLineOrigem) and FObjectDao.ExistData) then
    Exit;

  for nIndexList := nCST_Zero to FListConfigBlockTag.Count - nCST_One do
  begin
    DefineExportBlock(FListConfigBlockTag.Items[nIndexList], pbCanSaveFile, poListLineOrigem);
  end;
end;

procedure TObjectActionStructure.SetValueConvertedToFile(poTagValue: TValueTag; var poDataFileTemp: TStringList);
var
  nIndex, nIndexStrConverted: Integer;
  oTextConverted: TStringList;
  bCanAdd: Boolean;
begin
  if not (Assigned(poTagValue) and Assigned(poDataFileTemp)) then
    Exit;

  for nIndex := nCST_Zero to poTagValue.ValueFound.ValueConverted.Count -
    nCST_One do
  begin
    oTextConverted := poTagValue.ValueFound.ValueConverted.Items[nIndex];
    bCanAdd := True;
    if (poDataFileTemp.Count >= oTextConverted.Count) then
    begin
      bCanAdd := False;
      for nIndexStrConverted := oTextConverted.Count - nCST_One downto nCST_Zero do
      begin
        if not TDMUtils.CompareIgnoreCase(oTextConverted.Strings[nIndexStrConverted],
        poDataFileTemp.Strings[poDataFileTemp.Count - ((oTextConverted.Count - nCST_One) - nIndexStrConverted) - nCST_One]) then
          bCanAdd := true;
      end;
    end;
    if not bCanAdd then
      Continue;

    for nIndexStrConverted := nCST_Zero to oTextConverted.Count - nCST_One do
    begin
      poDataFileTemp.Add(Trim(oTextConverted.Strings[nIndexStrConverted]));
    end;
  end;
end;

procedure TObjectActionStructure.SetValueExporterToFile(poListLineOrigem, poListLineDest: TStringList);
var
  nIndexStrConverted: Integer;
  nIndexDataFile, nIndexBeginAdd: Integer;
begin
  if not (Assigned(poListLineOrigem) and Assigned(poListLineDest)) then
    Exit;

  nIndexBeginAdd := nCST_Zero;
  if poListLineDest.Count > nCST_Zero then
  begin
    nIndexBeginAdd := poListLineOrigem.Count;
    nIndexDataFile := poListLineDest.Count - nCST_One;
    for nIndexStrConverted := poListLineOrigem.Count - nCST_One downto nCST_Zero do
    begin
      if (poListLineDest.Count <= nIndexDataFile) or (nIndexDataFile < nCST_Zero) then
      begin
        nIndexBeginAdd := nCST_Zero;
        Break;
      end;

      if not TDMUtils.CompareIgnoreCase(poListLineOrigem.Strings[nIndexStrConverted],
        poListLineDest.Strings[nIndexDataFile]) then
      begin
        nIndexBeginAdd := nIndexStrConverted;
        nIndexDataFile := poListLineDest.Count - nCST_One;
      end
      else
        Dec(nIndexDataFile);
    end;
  end;

  for nIndexStrConverted := nIndexBeginAdd to poListLineOrigem.Count - nCST_One do
  begin
    poListLineDest.Add(Trim(poListLineOrigem.Strings[nIndexStrConverted]));
  end;
end;

procedure TObjectActionStructure.ExportDBToFileAllChildren(poConfigBlockTag
  : TConfigBlockTag; var poListLineOrigem: TStringList);
var
  nIndex: Integer;
  oItem: TObjectAction;
begin
  if not(Assigned(poConfigBlockTag)) then
    Exit;

  for nIndex := nCST_Zero to poConfigBlockTag.ListObjectActionReference.Count -
    nCST_One do
  begin
    oItem := TObjectAction(poConfigBlockTag.ListObjectActionReference.
      Items[nIndex]);
    if not(Assigned(oItem) and (oItem is TObjectActionStructure) and
      TObjectActionStructure(oItem).CanCreateObjectDao) then
      Continue;

    TObjectActionStructure(oItem).ObjectActionOwner := Self;
    TObjectActionStructure(oItem).ExportDBtoFile(poListLineOrigem, False);
  end;
end;

procedure TObjectActionStructure.ImportFileToDBSaveAllChildren(oConfigBlockTag
  : TConfigBlockTag; var pnLineActive: Integer);
var
  nIndex: Integer;
  oItem: TObjectAction;
begin
  if not(Assigned(oConfigBlockTag) and oConfigBlockTag.ProcessingInternalData)
  then
    Exit;

  for nIndex := nCST_Zero to oConfigBlockTag.ListObjectActionReference.Count -
    nCST_One do
  begin
    oItem := TObjectAction(oConfigBlockTag.ListObjectActionReference.
      Items[nIndex]);
    if not(Assigned(oItem) and (oItem is TObjectActionStructure) and
      TObjectActionStructure(oItem).CanCreateObjectDao) then
      Continue;

    TObjectActionStructure(oItem).ImportFileToDB(pnLineActive, False);
  end;
end;

function TObjectActionStructure.ProcessList(poList: TValueTag;
  var pnLineActive: Integer; poListIgnore: TValueTag;
  const pbFirstProcess: Boolean; poListEnd: TValueTag): Boolean;
var
  nIndexQtdeTag, nOldIndex, nIndex2, nOldActiveLine: Integer;
  sNextCommand, sTagEnd, sCommand, sLine: String;
  bFoundEnd, bExistCommand, bExistSucessful: Boolean;
  oListIndexInFileOfValueFound, oListValue: TStringList;
const
  sCST_BeginLoop = '..|';
  sCST_EndLoop = '|..';

  procedure UpdateLine(const pbIncLine: Boolean = True;
    const pnQtdeInc: Integer = 1);
  var
    nIndex3: Integer;
  begin
    if pbIncLine then
      Inc(pnLineActive, pnQtdeInc)
    else
      Dec(pnLineActive, pnQtdeInc);

    if pnLineActive < nCST_Zero then
      pnLineActive := 0;
    sLine := TDMUtils.GetValueList(FDataFile, pnLineActive);

    if not(Assigned(poListIgnore) and Assigned(poListIgnore.ValueSearch)) then
      Exit;

    for nIndex3 := nCST_Zero to poListIgnore.ValueSearch.TagSearch.Count -
      nCST_One do
    begin
      if TDMUtils.ExistValue(poListIgnore.ValueSearch.TagSearch.Strings[nIndex3]
        ) and (not TItemCommand.NotIsCommandEquals(True, sLine,
        poListIgnore.ValueSearch.TagSearch.Strings[nIndex3])) then
      begin
        UpdateLine;
        bExistCommand := True;
      end;
    end;
  end;

begin
  Result := True;
  bExistSucessful := False;
  if TDMUtils.IsEmpty(poList.ValueSearch.TagSearch) then
    Exit;

  bExistCommand := True;
  nOldIndex := -1;

  while bExistCommand do
  begin
    nOldActiveLine := pnLineActive;
    try
      Dec(pnLineActive);

      oListValue := poList.ValueFound.Value.Add(sCST_EmptyStr);
      oListIndexInFileOfValueFound := poList.ValueFound.IndexInFileOfValue.Add
        (sCST_EmptyStr);
      for nIndex2 := nCST_Zero to poList.ValueSearch.TagSearch.Count -
        nCST_One do
      begin
        sCommand := poList.ValueSearch.TagSearch.Strings[nIndex2];
        UpdateLine;

        // É Comando inválido
        if TDMUtils.ExistValue(sCommand) and TItemCommand.NotIsCommandEquals
          (True, sLine, sCommand) then
        begin
          // Se for tag begin faz varias tentativas
          if pbFirstProcess then
          begin
            Result := False;
            for nIndexQtdeTag := nCST_Zero to poList.ValueSearch.TagSearch.Count
              - nCST_One do
            begin
              UpdateLine(False);
              if not(TDMUtils.ExistValue(sCommand) and
                TItemCommand.NotIsCommandEquals(True, sLine, sCommand)) then
              begin
                Result := True;
                Break;
              end;
            end;

            if not Result then
            begin
              UpdateLine(True, poList.ValueSearch.TagSearch.Count);
              Break;
            end;
          end
          else
          begin
            Result := False;
            Break;
          end;
        end;

        if Assigned(oListValue) then
        begin
          oListValue.Add(sLine);
          oListIndexInFileOfValueFound.Add(IntToStr(pnLineActive));
        end;

        if TItemCommand.IsCommandAnyValue(sCommand) and Assigned(poListEnd) then
        begin
          sTagEnd := TDMUtils.GetValueList(poListEnd.ValueSearch.TagSearch,
            nCST_Zero);
          sNextCommand := TDMUtils.GetValueList(poList.ValueSearch.TagSearch,
            nIndex2 + nCST_One);

          bFoundEnd := False;
          while (not bFoundEnd) and (FDataFile.Count > pnLineActive) do
          begin
            UpdateLine;
            // É Comando inválido
            if ((TDMUtils.ExistValue(sTagEnd) and
              (not TItemCommand.NotIsCommandEquals(True, sLine, sTagEnd))) or
              (TDMUtils.ExistValue(sNextCommand) and
              (not TItemCommand.NotIsCommandEquals(True, sLine, sNextCommand))))
            then
              bFoundEnd := True
            else if Assigned(oListValue) then
            begin
              oListValue.Add(sLine);
              oListIndexInFileOfValueFound.Add(IntToStr(pnLineActive));
            end;
          end;

          if bFoundEnd then
            UpdateLine(False);

        end;
      end;
      if Assigned(oListValue) and (not Result) then
      begin
        poList.ValueFound.Value.Delete
          (poList.ValueFound.Value.IndexOf(oListValue));
        poList.ValueFound.IndexInFileOfValue.Delete
          (poList.ValueFound.IndexInFileOfValue.IndexOf
          (oListIndexInFileOfValueFound));
      end;

      bExistCommand := False;
      if not(Assigned(poListIgnore) and (nOldIndex <> pnLineActive)) then
        Continue;
      nOldIndex := pnLineActive;
      if Result then
        UpdateLine;

      if not bExistCommand then
        UpdateLine(False);
      if Result then
        bExistSucessful := True;
    finally
      if not Result then
        pnLineActive := nOldActiveLine;
    end;
  end;
  if Result then
    UpdateLine
  else
    Result := bExistSucessful;
end;

procedure TObjectActionStructure.SaveDataInDB(poValueApplyDB: TValueApplyDB);
var
  oFieldNameAddOfListTag: TFieldNameAddOfListTag;
  oValueAddOfListTag: TValueAddOfListTag;
  nIndexTagBegin: Integer;
  procedure SaveValueInFields;
  begin
    if ((Length(oFieldNameAddOfListTag) <= nCST_Zero) or
      (Length(oFieldNameAddOfListTag) <> Length(oValueAddOfListTag))) then
      Exit;
    FindAddOrEdit(oFieldNameAddOfListTag, oValueAddOfListTag, True);
  end;
begin
  if (Length(poValueApplyDB.FoListFieldNameAddOfListTagBegin) = Length(poValueApplyDB.FoListValueAddOfListTagBegin)) then
  begin
    for nIndexTagBegin := nCST_Zero to Length(poValueApplyDB.FoListFieldNameAddOfListTagBegin) -
      nCST_One do
    begin
      SetLength(oFieldNameAddOfListTag, nCST_Zero);
      SetLength(oValueAddOfListTag, nCST_Zero);
      Copy(poValueApplyDB.FoListFieldNameAddOfListTagBegin[nIndexTagBegin], poValueApplyDB.FoListValueAddOfListTagBegin[nIndexTagBegin],
        oFieldNameAddOfListTag, oValueAddOfListTag);

      if Length(poValueApplyDB.FoListFieldNameAddOfListTagEnd) > nIndexTagBegin then
      begin
        Copy(poValueApplyDB.FoListFieldNameAddOfListTagEnd[nIndexTagBegin], poValueApplyDB.FoListValueAddOfListTagEnd[nIndexTagBegin],
          oFieldNameAddOfListTag, oValueAddOfListTag);

        SetLength(poValueApplyDB.FoListFieldNameAddOfListTagEnd[nIndexTagBegin], nCST_Zero);
        SetLength(poValueApplyDB.FoListValueAddOfListTagEnd[nIndexTagBegin], nCST_Zero);
      end;

      if Length(poValueApplyDB.FoListFieldNameAddOfListTagData) > nIndexTagBegin then
      begin
        Copy(poValueApplyDB.FoListFieldNameAddOfListTagData[nIndexTagBegin], poValueApplyDB.FoListValueAddOfListTagData[nIndexTagBegin],
          oFieldNameAddOfListTag, oValueAddOfListTag);
        SetLength(poValueApplyDB.FoListFieldNameAddOfListTagData[nIndexTagBegin], nCST_Zero);
        SetLength(poValueApplyDB.FoListValueAddOfListTagData[nIndexTagBegin], nCST_Zero);
      end;
      SavevalueInFields;

      if (Length(poValueApplyDB.FoListFieldNameAddOfListTagBegin) > nIndexTagBegin) then
        SetLength(poValueApplyDB.FoListFieldNameAddOfListTagBegin[nIndexTagBegin], nCST_Zero);
      if (Length(poValueApplyDB.FoListValueAddOfListTagBegin) > nIndexTagBegin) then
        SetLength(poValueApplyDB.FoListValueAddOfListTagBegin[nIndexTagBegin], nCST_Zero);
    end;
  end;

  if (Length(poValueApplyDB.FoListFieldNameAddOfListTagData) = Length(poValueApplyDB.FoListValueAddOfListTagData)) then
  begin
    for nIndexTagBegin := nCST_Zero to Length(poValueApplyDB.FoListFieldNameAddOfListTagData) -
      nCST_One do
    begin
      SetLength(oFieldNameAddOfListTag, nCST_Zero);
      SetLength(oValueAddOfListTag, nCST_Zero);
      Copy(poValueApplyDB.FoListFieldNameAddOfListTagData[nIndexTagBegin], poValueApplyDB.FoListValueAddOfListTagData[nIndexTagBegin],
        oFieldNameAddOfListTag, oValueAddOfListTag);

      SaveValueInFields;
      if (Length(poValueApplyDB.FoListFieldNameAddOfListTagData) > nIndexTagBegin) then
        SetLength(poValueApplyDB.FoListFieldNameAddOfListTagData[nIndexTagBegin], nCST_Zero);
      if (Length(poValueApplyDB.FoListValueAddOfListTagData) > nIndexTagBegin) then
        SetLength(poValueApplyDB.FoListValueAddOfListTagData[nIndexTagBegin], nCST_Zero);
    end;
  end;

  if (Length(poValueApplyDB.FoListFieldNameAddOfListTagEnd) = Length(poValueApplyDB.FoListValueAddOfListTagEnd)) then
  begin
    for nIndexTagBegin := nCST_Zero to Length(poValueApplyDB.FoListFieldNameAddOfListTagEnd) -
      nCST_One do
    begin
      SetLength(oFieldNameAddOfListTag, nCST_Zero);
      SetLength(oValueAddOfListTag, nCST_Zero);
      Copy(poValueApplyDB.FoListFieldNameAddOfListTagEnd[nIndexTagBegin], poValueApplyDB.FoListValueAddOfListTagEnd[nIndexTagBegin],
        oFieldNameAddOfListTag, oValueAddOfListTag);

      SaveValueInFields;
      if (Length(poValueApplyDB.FoListFieldNameAddOfListTagEnd) > nIndexTagBegin) then
        SetLength(poValueApplyDB.FoListFieldNameAddOfListTagEnd[nIndexTagBegin], nCST_Zero);
      if (Length(poValueApplyDB.FoListValueAddOfListTagEnd) > nIndexTagBegin) then
        SetLength(poValueApplyDB.FoListValueAddOfListTagEnd[nIndexTagBegin], nCST_Zero);
    end;
  end;
end;

function TObjectActionStructure.SaveText(pbCanSave: Boolean;
  poConfigBlockTag: TConfigBlockTag; const pbIsSubBlock: Boolean; poValueApplyDB: TValueApplyDB): Boolean;
var
  nIndex: Integer;
  oConfigItemTag: TConfigItemTag;

begin
  Result := False;
  if not Assigned(poConfigBlockTag) then
    Exit;

  if not poConfigBlockTag.SucessfullBlock then
    poConfigBlockTag.ClearTextFound
  else if pbCanSave then
  begin
    // Salva bloco
    for nIndex := nCST_Zero to poConfigBlockTag.ListObjectActionChildren.Count -
      nCST_One do
    begin
      oConfigItemTag := poConfigBlockTag.ListObjectActionChildren.Items[nIndex];
      if not Assigned(oConfigItemTag) then
        Continue;

      if SaveValueFoundItem(poConfigBlockTag, oConfigItemTag, poValueApplyDB) then
        Result := True;

      // Salva subblocos
      if Assigned(oConfigItemTag.SubBlock) and
        SaveText(pbCanSave, oConfigItemTag.SubBlock, True, poValueApplyDB) then
        Result := True;
    end;

    if TDMUtils.IsEmpty(poConfigBlockTag.ListObjectActionChildren.Count) then
      SaveValueFoundItem(poConfigBlockTag, nil, poValueApplyDB);

    if (pbCanSave) then
    begin
      SaveTextAllChildren(poConfigBlockTag, poValueApplyDB);
      if not pbIsSubBlock then
        ApplyDB;
    end;
  end;
end;

procedure TObjectActionStructure.SaveTextAllChildren(poConfigBlockTag
  : TConfigBlockTag; poValueApplyDB: TValueApplyDB);
var
  nIndex, nIndexList: Integer;
  oItem: TObjectAction;
  oItemStructure: TObjectActionStructure;
begin
  for nIndex := nCST_Zero to poConfigBlockTag.ListObjectActionReference.Count -
    nCST_One do
  begin
    oItem := TObjectAction(poConfigBlockTag.ListObjectActionReference.
      Items[nIndex]);
    if not(Assigned(oItem) and (oItem is TObjectActionStructure)) then
      Continue;

    oItemStructure := TObjectActionStructure(oItem);
    if not oItemStructure.CanCreateObjectDao then
      Continue;

    for nIndexList := nCST_Zero to oItemStructure.ListConfigBlockTagInValue.
      Count - nCST_One do
    begin
      FIDListActive := nIndexList + nCST_One;
      FIDActiveItemTag := nCST_Zero;
      oItemStructure.SaveText(True,
        oItemStructure.ListConfigBlockTagInValue.Items[nIndexList], True, poValueApplyDB);
    end;
  end;
end;

function TObjectActionStructure.SaveValueFoundItem(poConfigBlockTag
  : TConfigBlockTag; poConfigItemTag: TConfigItemTag; poValueApplyDB: TValueApplyDB): Boolean;
var
  oData: TValueTag;
begin
  Result := False;
  if not(Assigned(poConfigBlockTag)) then
    Exit;

  // Salva o valor encontrado
  oData := nil;
  if Assigned(poConfigItemTag) then
    oData := poConfigItemTag.TagData;

  AddData(oData, poConfigBlockTag.TagBeginBlock, poConfigBlockTag.TagEndBlock,
    poConfigBlockTag.IDCategory, poValueApplyDB);
end;

procedure TObjectActionStructure.SetDataFile(const Value: TStringList);
var
  nIndex: Integer;
  oConfigBlockTag: TConfigBlockTag;
begin
  FDataFile := Value;
  TListStructureData(ListObjectActionChildren).DataFile := FDataFile;

  for nIndex := nCST_Zero to ListConfigBlockTagInValue.Count - nCST_One do
  begin
    oConfigBlockTag := ListConfigBlockTagInValue.Items[nIndex];
    if Assigned(oConfigBlockTag) then
      TListStructureData(oConfigBlockTag.ListObjectActionReference).DataFile :=
        FDataFile;
  end;

  for nIndex := nCST_Zero to ListConfigBlockTag.Count - nCST_One do
  begin
    oConfigBlockTag := ListConfigBlockTag.Items[nIndex];
    if Assigned(oConfigBlockTag) then
      TListStructureData(oConfigBlockTag.ListObjectActionReference).DataFile :=
        FDataFile;
  end;
end;

procedure TObjectActionStructure.SetDeKeyToDate(const Value: TMethodKeyToDate);
var
  nIndex: Integer;
  oConfigBlockTag: TConfigBlockTag;
begin
  FDeKeyToDate := Value;

  TListStructureData(ListObjectActionChildren).DeKeyToDate := FDeKeyToDate;

  for nIndex := nCST_Zero to ListConfigBlockTagInValue.Count - nCST_One do
  begin
    oConfigBlockTag := ListConfigBlockTagInValue.Items[nIndex];
    if Assigned(oConfigBlockTag) then
      TListStructureData(oConfigBlockTag.ListObjectActionReference).DeKeyToDate
        := FDeKeyToDate;
  end;

  for nIndex := nCST_Zero to ListConfigBlockTag.Count - nCST_One do
  begin
    oConfigBlockTag := ListConfigBlockTag.Items[nIndex];
    if Assigned(oConfigBlockTag) then
      TListStructureData(oConfigBlockTag.ListObjectActionReference).DeKeyToDate
        := FDeKeyToDate;
  end;
end;

procedure TObjectActionStructure.SetListConfigBlockTag
  (const Value: TListConfigBlockTag);
begin
  FListConfigBlockTag := Value;
end;

procedure TObjectActionStructure.SetListConfigBlockTagInValue
  (const Value: TListConfigBlockTag);
begin
  FListConfigBlockTagInValue := Value;
end;

procedure TObjectActionStructure.SetObjectCanProcessStructure(const Value: Boolean);
var
  oItem: TObjectAction;
  nIndex: Integer;
begin
  FObjectCanProcessStructure := Value;
  for nIndex := nCST_Zero to ListObjectActionChildren.Count - nCST_One do
  begin
    oItem := ListObjectActionChildren.Items[nIndex];
    if (Assigned(oItem) and (oItem is TObjectActionStructure)) then
      SetObjectChildCanProcessStructor(TObjectActionStructure(oItem), Value);
  end;

  if FObjectCanProcessStructure then
    ConfigureBlockMapping;
end;

procedure TObjectActionStructure.SetObjectChildCanProcessStructor
  (poChildren: TObjectActionStructure; const pbCanProcess: Boolean);
begin
  if Assigned(poChildren) then
    poChildren.ObjectCanProcessStructure := pbCanProcess;
end;

function TObjectActionStructure.SetValueOfData(poTag: TValueTag; var poDataFileTemp: TStringList): Boolean;
var
  nIndex: Integer;
  oField: TField;
  oListValue, oListValueConverted: TStringList;
  bEqualFixedValueAndDBValue: Boolean;
begin
  Result := False;
  if not Assigned(poTag) then
    Exit;
  // Percore a lista de valores encontrados
  poTag.ValueFound.Value.Clear;
  poTag.ValueFound.ValueConverted.Clear;
  oListValue := poTag.ValueFound.Value.Add;
  oListValue.text := poTag.ValueSearch.TagSearch.text;
  oListValueConverted := poTag.ValueFound.ValueConverted.Add
    (DeKeyToDate(oListValue));
  try
    if TDMUtils.isEmpty(poTag.ValueSearch.TagSearch.Count) then
    begin
      oListValueConverted.Clear;
      Result := True;
      Exit;
    end;
    for nIndex := nCST_Zero to poTag.ValueSearch.TagSearch.Count - nCST_One do
    begin
      oField := nil;
      if ((poTag.ValueSearch.FieldDBName.Count > nIndex) and TDMUtils.ExistValue(poTag.ValueSearch.FieldDBName.Strings[nIndex])) then
        oField := FObjectDao.CDSDados.FindField
          (poTag.ValueSearch.FieldDBName.Strings[nIndex]);

      if not(Assigned(oField) and TDMUtils.ExistValue(oField.DataSet)) then
      begin
        if (not Assigned(oField)) and
          TDMUtils.ExistValue(poTag.ValueSearch.TagSearch.Strings[nIndex]) then
          Result := True;

        Continue;
      end;
      if (poTag.ValueSearch.FixedValue.Count > nIndex) and TDMUtils.ExistValue(poTag.ValueSearch.FixedValue.Strings[nIndex]) then
      begin
        bEqualFixedValueAndDBValue := False;
        case TDMUtilsDao.GetTypeFieldSimple(oField) of
          ftInteger:
            bEqualFixedValueAndDBValue := (TDMUtils.StrToInt2(poTag.ValueSearch.FixedValue.Strings[nIndex]) = oField.AsInteger);
          ftFloat:
              bEqualFixedValueAndDBValue := (oField.AsFloat = TDMUtils.StrToFloat2(poTag.ValueSearch.FixedValue.Strings[nIndex]));
          ftString:
              bEqualFixedValueAndDBValue := TDMUtils.CompareIgnoreCase(oField.AsString, poTag.ValueSearch.FixedValue.Strings[nIndex]);
          ftBoolean:
              bEqualFixedValueAndDBValue := (TDMUtils.StrToBoolean(oField.AsString) = TDMUtils.StrToBoolean(poTag.ValueSearch.FixedValue.Strings[nIndex]));
        end;
        if bEqualFixedValueAndDBValue then
          Result := True;
        continue;
      end;

      Result := True;


      case TDMUtilsDao.GetTypeFieldSimple(oField) of
        ftInteger:
          oListValueConverted.Strings[nIndex] := IntToStr(oField.AsInteger);
        ftFloat:
          oListValueConverted.Strings[nIndex] :=
            TDMUtils.FormatExtended(oField.AsFloat);
        ftString, ftBoolean:
          oListValueConverted.Strings[nIndex] := oField.AsString;
      end;
    end;
  finally
    if Result then
      SetValueConvertedToFile(poTag, poDataFileTemp)
    else if not Result then
    begin
      poTag.ValueFound.Value.Delete(poTag.ValueFound.Value.IndexOf(oListValue));
      poTag.ValueFound.ValueConverted.Delete
        (poTag.ValueFound.ValueConverted.IndexOf(oListValueConverted));
    end;
  end;
end;

{ TListStructureData }

function TListStructureData.Add(poListClass: TClassItemStructureData)
  : TObjectActionStructure;
begin
  Result := TFactoryObject.CreateComponent(poListClass)
    as TClassItemStructureData;
  Result.DataFile := FDataFile;
  Result.DeKeyToDate := FDeKeyToDate;
  Result.Load;
  inherited Add(Result);
end;

procedure TListStructureData.AfterConstruction;
begin
  inherited;
  FDataFile := nil;
  FDeKeyToDate := nil;
  ImportAll;
end;

procedure TListStructureData.Assign(Source: TObject;
  const pbClearOldValue: Boolean);
var
  oListObjectAction: TListStructureData;
begin
  inherited;
  if not(Assigned(Source) and (Source is TListStructureData)) then
    Exit;

  oListObjectAction := TListStructureData(Source);
  FDeKeyToDate := oListObjectAction.FDeKeyToDate;
  FDataFile := oListObjectAction.FDataFile;
end;

procedure TListStructureData.ImportAll;
begin
  Exit;
end;

procedure TListStructureData.SetDataFile(const Value: TStringList);
var
  nIndex: Integer;
  oItem: TObjectAction;
begin
  FDataFile := Value;
  for nIndex := nCST_Zero to Self.Count - nCST_One do
  begin
    oItem := Items[nIndex];
    if Assigned(oItem) and (oItem is TObjectActionStructure) and
      TObjectActionStructure(oItem).CanCreateObjectDao then
      TObjectActionStructure(oItem).DataFile := FDataFile;
  end;
end;

procedure TListStructureData.SetDeKeyToDate(const Value: TMethodKeyToDate);
var
  nIndex: Integer;
  oItem: TObjectAction;
begin
  FDeKeyToDate := Value;
  for nIndex := nCST_Zero to Self.Count - nCST_One do
  begin
    oItem := Items[nIndex];
    if Assigned(oItem) and (oItem is TObjectActionStructure) and
      TObjectActionStructure(oItem).CanCreateObjectDao then
      TObjectActionStructure(oItem).DeKeyToDate := FDeKeyToDate;
  end;
end;

destructor TListStructureData.Destroy;
begin
  FDataFile := nil;
  FDeKeyToDate := nil;
  inherited;
end;

function TListStructureData.GetDataFile: TStringList;
begin
  Result := FDataFile;
end;

function TListStructureData.GetDeKeyToDate: TMethodKeyToDate;
begin
  Result := FDeKeyToDate;
end;

{ TObjectActionStructure }

{ TValueApplyDB }

constructor TValueApplyDB.Create;
begin
  SetLength(FoListFieldNameAddOfListTagBegin, 0);
  SetLength(FoListFieldNameAddOfListTagData, 0);
  SetLength(FoListFieldNameAddOfListTagEnd, 0);
  SetLength(FoListValueAddOfListTagBegin, 0);
  SetLength(FoListValueAddOfListTagData, 0);
  SetLength(FoListValueAddOfListTagEnd, 0);
end;

initialization

RegisterClass(TObjectActionStructure);

end.
