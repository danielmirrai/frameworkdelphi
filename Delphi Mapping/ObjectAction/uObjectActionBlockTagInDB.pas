unit uObjectActionBlockTagInDB;

interface

uses uDMUtils, Windows, Messages, SysUtils, Variants, Classes, Graphics,
  uDMList, uObjectActionCommand, uConstantUtils,
  Controls, Forms, Dialogs, StdCtrls, uObjectActionCustom, uObjectAction,
  Contnrs, DB, DBClient;

type

  TMethodKeyToDate = function(const poListKey: TStringList)
    : TStringList of Object;
  TGetValueConverted = function(const psValue: string;
    const pbValueToValueInDB: Boolean = True): String of Object;


  TRecordParamValueSearch = class(TObjectActionCustom)
  private
    FFieldDBName: String;
    FTagSearch: String;
    FFixedValue: String;
  protected
    function GetFieldDBName: String; virtual;
    function GetFixedValue: String; virtual;
    function GetTagSearch: String; virtual;
    procedure SetFieldDBName(const Value: String); virtual;
    procedure SetFixedValue(const Value: String); virtual;
    procedure SetTagSearch(const Value: String); virtual;
    procedure AddTag(var psTag: String; const psValueadd: String); virtual;
  public
    ListGetValueConverted: Array of TGetValueConverted;
    procedure AfterConstruction; override;
    procedure Clear; Override;
    procedure Add(const psNameField: String; const psTagSearch: String = '';
      const psFixedValue: String = '');
    procedure Assign(Source: TPersistent;
      const pbClearOldValue: Boolean); Override;

    property FieldDBName: String read GetFieldDBName write SetFieldDBName;
    property TagSearch: String read GetTagSearch write SetTagSearch;
    property FixedValue: String read GetFixedValue write SetFixedValue;
  end;

  TItemValueTagSearch = class(TObjectActionCustom)
  private
    FFieldDBName: TStringList;
    FTagSearch: TStringList;
    FFixedValue: TStringList;
  protected
    procedure SetFieldDBName(const Value: TStringList); virtual;
    procedure SetFixedValue(const Value: TStringList); virtual;
    procedure SetTagSearch(const Value: TStringList); virtual;
    function GetFieldDBName: TStringList; virtual;
    function GetFixedValue: TStringList; virtual;
    function GetTagSearch: TStringList; virtual;
  public
    ListGetValueConverted: Array of TGetValueConverted;
    procedure Assign(Source: TPersistent;
      const pbClearOldValue: Boolean); Override;
    function ExistFieldDBInTag: Boolean;
    procedure AfterConstruction; override;
    destructor Destroy; override;
    procedure AddValue(const psValue: string;
      const psFixedValue: string = ''; const psNameField: String = '');
      Overload;
    procedure AddValue(const poRecordParamValueSearch
      : TRecordParamValueSearch); Overload;

    property TagSearch: TStringList read GetTagSearch write SetTagSearch;
    property FieldDBName: TStringList read GetFieldDBName write SetFieldDBName;
    property FixedValue: TStringList read GetFixedValue write SetFixedValue;
  end;

  TItemValueTagFound = class(TObjectActionCustom)
  private
    FsOldMD5: string;
    FIndexInFileOfValue: TListOfStringList;
    FValueConverted: TListOfStringList;
    FValue: TListOfStringList;
  protected
    function GetIndexInFileOfValue: TListOfStringList; virtual;
    function GetValue: TListOfStringList; virtual;
    function GetValueConverted: TListOfStringList; virtual;
    procedure SetIndexInFileOfValue(const Value: TListOfStringList); virtual;
    procedure SetValue(const Value: TListOfStringList); virtual;
    procedure SetValueConverted(const Value: TListOfStringList); virtual;
  public
    procedure Assign(Source: TPersistent;
      const pbClearOldValue: Boolean); Override;
    procedure NewBackup(const pbClearOldValue: Boolean = True); virtual;
    procedure RevertBackup(const pbClearOldValue: Boolean = False); virtual;
    procedure ConverteKeyFound(poDeKeyToDate: TMethodKeyToDate); virtual;
    procedure Clear; Override;
    procedure AfterConstruction; override;
    destructor Destroy; override;
    // <summary>
    /// Key que foi capturado
    /// </summary>
    property Value: TListOfStringList read GetValue write SetValue;

    /// <summary>
    // Converte os id dos valores encontrados para string
    /// </summary>
    property ValueConverted: TListOfStringList read GetValueConverted
      write SetValueConverted;
    property IndexInFileOfValue: TListOfStringList read GetIndexInFileOfValue
      write SetIndexInFileOfValue;

  end;

  TValueTag = Class(TObjectActionCustom)
  private
    FValueSearch: TItemValueTagSearch;
    FValueFound: TItemValueTagFound;

  protected
    function GetValueFound: TItemValueTagFound; virtual;
    procedure SetValueFound(const Value: TItemValueTagFound); virtual;
    procedure SetValueSearch(const Value: TItemValueTagSearch); virtual;
    function GetValueSearch: TItemValueTagSearch; virtual;
  public
    procedure Assign(Source: TPersistent;
      const pbClearOldValue: Boolean); Override;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure NewBackup(const pbClearOldValue: Boolean = True); virtual;
    procedure RevertBackup(const pbClearOldValue: Boolean = False); virtual;
    /// <summary>
    /// Tags Key que devem ser encontradas no arquivo
    /// </summary>
    property ValueSearch: TItemValueTagSearch read GetValueSearch
      write SetValueSearch;

    // <summary>
    /// Key que foi capturado
    /// </summary>
    property ValueFound: TItemValueTagFound read GetValueFound
      write SetValueFound;
  End;

implementation

uses uFactoryObject, uConstantCommand;
{ TItemValueTagSearch }

procedure TItemValueTagSearch.Assign(Source: TPersistent;
  const pbClearOldValue: Boolean);
var
  oItemValueTagFound: TItemValueTagSearch;
  nIndex, nIndexInicial: Integer;
begin
  inherited;
  if not(Assigned(Source) and (Source is TItemValueTagSearch)) then
    Exit;

  oItemValueTagFound := TItemValueTagSearch(Source);

  TDMUtils.AssignStringList(FFieldDBName, oItemValueTagFound.FFieldDBName,
    pbClearOldValue);
  TDMUtils.AssignStringList(FTagSearch, oItemValueTagFound.FTagSearch,
    pbClearOldValue);
  TDMUtils.AssignStringList(FFixedValue, oItemValueTagFound.FFixedValue,
    pbClearOldValue);

  if pbClearOldValue then
    SetLength(ListGetValueConverted, nCST_Zero);

  nIndexInicial := Length(ListGetValueConverted);
  SetLength(ListGetValueConverted,
    Length(oItemValueTagFound.ListGetValueConverted) + nIndexInicial);
  for nIndex := nCST_Zero to Length(oItemValueTagFound.ListGetValueConverted) -
    nCST_One do
  begin
    ListGetValueConverted[nIndexInicial + nIndex] :=
      oItemValueTagFound.ListGetValueConverted[nIndex];
  end;
end;

destructor TItemValueTagSearch.Destroy;
begin
  TDMUtils.DestroyObject(FTagSearch);
  TDMUtils.DestroyObject(FFieldDBName);
  TDMUtils.DestroyObject(FFixedValue);
  SetLength(ListGetValueConverted, nCST_Zero);
  inherited;
end;

function TItemValueTagSearch.ExistFieldDBInTag: Boolean;
var
  nIndex: Integer;
begin
  Result := False;
  for nIndex := 0 to FieldDBName.Count - nCST_One do
  begin
    Result := TDMUtils.ExistValue(FieldDBName.Strings[nIndex]);
    if Result then
      Break;
  end;
end;

function TItemValueTagSearch.GetFieldDBName: TStringList;
begin
  Result := FFieldDBName;
end;

function TItemValueTagSearch.GetFixedValue: TStringList;
begin
  Result := FFixedValue;
end;

function TItemValueTagSearch.GetTagSearch: TStringList;
begin
  Result := FTagSearch;
end;

procedure TItemValueTagSearch.SetFieldDBName(const Value: TStringList);
begin
  FFieldDBName := Value;
end;

procedure TItemValueTagSearch.SetFixedValue(const Value: TStringList);
begin
  FFixedValue := Value;
end;

procedure TItemValueTagSearch.SetTagSearch(const Value: TStringList);
begin
  FTagSearch := Value;
end;

{ TItemValueTagSearch }

procedure TItemValueTagSearch.AfterConstruction;
begin
  TagSearch := TStringList.Create;
  FieldDBName := TStringList.Create;
  FixedValue := TStringList.Create;
  SetLength(ListGetValueConverted, nCST_Zero);
  inherited;
end;

{ TItemValueTagFound }

procedure TItemValueTagFound.AfterConstruction;
begin
  FsOldMD5 := sCST_EmptyStr;
  ValueConverted := TListOfStringList.Create;
  IndexInFileOfValue := TListOfStringList.Create;
  Value := TListOfStringList.Create;
  inherited;
end;

procedure TItemValueTagFound.Assign(Source: TPersistent;
  const pbClearOldValue: Boolean);
var
  oItemValueTagFound: TItemValueTagFound;
begin
  inherited;
  if not(Assigned(Source) and (Source is TItemValueTagFound)) then
    Exit;

  oItemValueTagFound := TItemValueTagFound(Source);
  if pbClearOldValue then
    FsOldMD5 := oItemValueTagFound.FsOldMD5
  else
    FsOldMD5 := sCST_EmptyStr;

  FIndexInFileOfValue.Assign(oItemValueTagFound.FIndexInFileOfValue,
    pbClearOldValue);
  FValueConverted.Assign(oItemValueTagFound.FValueConverted, pbClearOldValue);
  FValue.Assign(oItemValueTagFound.FValue, pbClearOldValue);
end;

procedure TItemValueTagFound.Clear;
begin
  inherited;
  FsOldMD5 := sCST_EmptyStr;
  Value.Clear;
  ValueConverted.Clear;
  IndexInFileOfValue.Clear;
end;

procedure TItemValueTagFound.ConverteKeyFound(poDeKeyToDate: TMethodKeyToDate);
var
  nIndex: Integer;
  sNewMd5: String;
begin
  sNewMd5 := Value.GetMD5;
  if (FsOldMD5 = sNewMd5) then
    Exit;
  FsOldMD5 := sNewMd5;
  ValueConverted.Clear;
  for nIndex := 0 to Value.Count - 1 do
  begin
    ValueConverted.Add(poDeKeyToDate(Value.Items[nIndex]));
  end;
end;

destructor TItemValueTagFound.Destroy;
begin
  TDMUtils.DestroyObject(FValueConverted);
  TDMUtils.DestroyObject(FIndexInFileOfValue);
  TDMUtils.DestroyObject(FValue);
  inherited;
end;

function TItemValueTagFound.GetIndexInFileOfValue: TListOfStringList;
begin
  Result := FIndexInFileOfValue;
end;

function TItemValueTagFound.GetValue: TListOfStringList;
begin
  Result := FValue;
end;

function TItemValueTagFound.GetValueConverted: TListOfStringList;
begin
  Result := FValueConverted;
end;

procedure TItemValueTagFound.NewBackup(const pbClearOldValue: Boolean);
begin
  Value.NewBackup(pbClearOldValue);
  ValueConverted.NewBackup(pbClearOldValue);
  IndexInFileOfValue.NewBackup(pbClearOldValue);
end;

procedure TItemValueTagFound.RevertBackup(const pbClearOldValue: Boolean);
begin
  Value.RevertBackup(pbClearOldValue);
  ValueConverted.RevertBackup(pbClearOldValue);
  IndexInFileOfValue.RevertBackup(pbClearOldValue);
end;

procedure TItemValueTagFound.SetIndexInFileOfValue
  (const Value: TListOfStringList);
begin
  FIndexInFileOfValue := Value;
end;

procedure TItemValueTagFound.SetValue(const Value: TListOfStringList);
begin
  FValue := Value;
end;

procedure TItemValueTagFound.SetValueConverted(const Value: TListOfStringList);
begin
  FValueConverted := Value;
end;

{ TValueTag }

procedure TItemValueTagSearch.AddValue(const psValue, psFixedValue,
  psNameField: String);
var
  nIndex, nMaxCount: Integer;

  procedure ExplodeListSearchAndSet(poList: TStringList;
    const psValue: String);
  begin
    poList.Clear;
    poList.Text := psValue;
    TDMUtils.ExplodeStr(poList, ',');
    if nMaxCount < poList.Count then
      nMaxCount := poList.Count;
  end;

  procedure DefineSizeEqualsList(poList: TStringList);
  begin
    while poList.Count < nMaxCount do
    begin
      poList.Add('');
    end;
  end;
begin
  nMaxCount := 0;
  ExplodeListSearchAndSet(TagSearch, psValue);
  ExplodeListSearchAndSet(FieldDBName, psNameField);
  ExplodeListSearchAndSet(FixedValue, psFixedValue);
  DefineSizeEqualsList(TagSearch);
  DefineSizeEqualsList(FieldDBName);
  DefineSizeEqualsList(FixedValue);

  for nIndex := nMaxCount - 1 downto 0 do
  begin
    if TDMUtils.IsEmpty(TagSearch.Strings[nIndex]) and
      TDMUtils.IsEmpty(FieldDBName.Strings[nIndex]) and
      TDMUtils.IsEmpty(FixedValue.Strings[nIndex]) then
    begin
      TagSearch.Delete(nIndex);
      FieldDBName.Delete(nIndex);
      FixedValue.Delete(nIndex);
    end;
  end;
end;

procedure TItemValueTagSearch.AddValue(const poRecordParamValueSearch
  : TRecordParamValueSearch);
var
  nIndex: Integer;
begin
  if not Assigned(poRecordParamValueSearch) then
    Exit;
  AddValue(poRecordParamValueSearch.FTagSearch,
    poRecordParamValueSearch.FFixedValue,
    poRecordParamValueSearch.FFieldDBName);

  for nIndex := 0 to Length
    (poRecordParamValueSearch.ListGetValueConverted) - 1 do
  begin
    SetLength(ListGetValueConverted,
      Length(ListGetValueConverted) + 1);
    ListGetValueConverted
      [Length(ListGetValueConverted) - 1] :=
      poRecordParamValueSearch.ListGetValueConverted[nIndex];
  end;
end;

procedure TValueTag.AfterConstruction;
begin
  inherited;
  ValueFound := TItemValueTagFound.Create(Self);
  ValueSearch := TItemValueTagSearch.Create(Self);
end;

procedure TValueTag.Assign(Source: TPersistent; const pbClearOldValue: Boolean);
var
  oValueTag: TValueTag;
begin
  inherited;
  if not(Assigned(Source) and (Source is TValueTag)) then
    Exit;
  oValueTag := TValueTag(Source);
  Self.ValueSearch.Assign(oValueTag.ValueSearch, pbClearOldValue);
  Self.ValueFound.Clear;
end;

procedure TValueTag.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FValueSearch);
  TDMUtils.DestroyObject(FValueFound);
  inherited;
end;

function TValueTag.GetValueFound: TItemValueTagFound;
begin
  Result := FValueFound;
end;

function TValueTag.GetValueSearch: TItemValueTagSearch;
begin
  Result := FValueSearch;
end;

procedure TValueTag.NewBackup(const pbClearOldValue: Boolean);
begin
  ValueFound.NewBackup(pbClearOldValue);
end;

procedure TValueTag.RevertBackup(const pbClearOldValue: Boolean);
begin
  ValueFound.RevertBackup(pbClearOldValue);
end;

procedure TValueTag.SetValueFound(const Value: TItemValueTagFound);
begin
  FValueFound := Value;
end;

procedure TValueTag.SetValueSearch(const Value: TItemValueTagSearch);
begin
  FValueSearch := Value;
end;

{ TRecordParamValueSearch }
procedure TRecordParamValueSearch.Add(const psNameField, psTagSearch,
  psFixedValue: String);
begin
  AddTag(FFieldDBName, psNameField);
  AddTag(FFixedValue, psFixedValue);
  AddTag(FTagSearch, psTagSearch);
end;

procedure TRecordParamValueSearch.AddTag(var psTag: String;
  const psValueadd: String);
begin
  psTag := psTag + psValueadd + ',';
end;

procedure TRecordParamValueSearch.AfterConstruction;
begin
  inherited;

end;

procedure TRecordParamValueSearch.Assign(Source: TPersistent;
  const pbClearOldValue: Boolean);
var
  oItemValueTagFound: TRecordParamValueSearch;
  nIndexInicial, nIndex: Integer;
begin
  inherited;
  if not(Assigned(Source) and (Source is TRecordParamValueSearch)) then
    Exit;

  oItemValueTagFound := TRecordParamValueSearch(Source);
  if pbClearOldValue then
  begin
    FFieldDBName := sCST_EmptyStr;
    FTagSearch := sCST_EmptyStr;
    FFixedValue := sCST_EmptyStr;
  end;

  Add(oItemValueTagFound.FFieldDBName, oItemValueTagFound.FFieldDBName,
    oItemValueTagFound.FFieldDBName);

  if pbClearOldValue then
    SetLength(ListGetValueConverted, nCST_Zero);

  nIndexInicial := Length(ListGetValueConverted);
  SetLength(ListGetValueConverted,
    Length(oItemValueTagFound.ListGetValueConverted) + nIndexInicial);
  for nIndex := nCST_Zero to Length(oItemValueTagFound.ListGetValueConverted) -
    nCST_One do
  begin
    ListGetValueConverted[nIndexInicial + nIndex] :=
      oItemValueTagFound.ListGetValueConverted[nIndex];
  end;
end;

procedure TRecordParamValueSearch.Clear;
begin
  FTagSearch := sCST_EmptyStr;
  FFieldDBName := sCST_EmptyStr;
  FFixedValue := sCST_EmptyStr;
  SetLength(ListGetValueConverted, 0);
end;

function TRecordParamValueSearch.GetFieldDBName: String;
begin
  Result := FFieldDBName;
end;

function TRecordParamValueSearch.GetFixedValue: String;
begin
  Result := FFixedValue;
end;

function TRecordParamValueSearch.GetTagSearch: String;
begin
  Result := FTagSearch;
end;

procedure TRecordParamValueSearch.SetFieldDBName(const Value: String);
begin
  FFieldDBName := Value;
  if TDMUtils.ExistValue(FFieldDBName) then
    TagSearch := sCST_DataOtherValue;
end;

procedure TRecordParamValueSearch.SetFixedValue(const Value: String);
begin
  FFixedValue := Value;
end;

procedure TRecordParamValueSearch.SetTagSearch(const Value: String);
begin
  FTagSearch := Value;
end;

initialization

RegisterClass(TValueTag);
RegisterClass(TItemValueTagSearch);
RegisterClass(TItemValueTagFound);
RegisterClass(TRecordParamValueSearch);

end.
