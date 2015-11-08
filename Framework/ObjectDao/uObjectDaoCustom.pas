{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Programador Delphi Sênior }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Fones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }
unit uObjectDaoCustom;

interface

uses
  Classes, DB, DBClient, MidasLib, uDMUtils, uDMUtilsDao, FMTBcd, SqlExpr,
  Provider, Contnrs;

type
  TTypeDB = (tdbFirebird, tdbFile);

  TObjectDaoCustom = class;
  TClassObjectDaoCustom = Class of TObjectDaoCustom;

  TListObjectDaoCustom = Class(TObjectList)
  protected
    function GetItems(Index: Integer): TObjectDaoCustom; reintroduce; Virtual;
    procedure SetItems(Index: Integer; const Value: TObjectDaoCustom); reintroduce; Virtual;
  public
    FOwner: TComponent;
    procedure Load; virtual;
    constructor Create(AOwner: TComponent); virtual;
    procedure Assign(Source: TObject; const pbClearOldValue: Boolean = True); Virtual;

    /// <summary>
    /// Adiciona novo objeto dados
    /// </summary>
    function Add(poClassDao: TClassObjectDaoCustom; poOwner: TComponent = nil)
      : TObjectDaoCustom; Reintroduce; Overload; Virtual;
    function Add(AObject: TObjectDaoCustom): TObjectDaoCustom; Reintroduce; Overload; Virtual;
    property Items[Index: Integer]: TObjectDaoCustom read GetItems write SetItems;
  end;

  TObjectDaoCustom = class(TDataModule)
    CDSDados: TClientDataSet;
    DSDados: TDataSource;
    SQLDADOS: TSQLDataSet;
    PRVDADOS: TDataSetProvider;
    procedure CDSDadosAfterInsert(DataSet: TDataSet);
    procedure CDSDadosAfterOpen(DataSet: TDataSet);
    procedure CDSDadosBeforeCancel(DataSet: TDataSet);
    procedure CDSDadosBeforeDelete(DataSet: TDataSet);
  private
    FFieldID: TField;
    FListObjectDaoChildren: TListObjectDaoCustom;
    FFieldDC: TField;
  protected
    { Private declarations }
    FAutoIncrement: Integer;
    FActiveAutoGenetorID: Boolean;
    FOldMasterSource: TDataSource;

    function GetFieldDC: TField;
    procedure SetFieldDC(const Value: TField); virtual;
    procedure SetFieldID(const Value: TField); virtual;
    procedure SetListObjectDaoChildren(const Value: TListObjectDaoCustom); virtual;
    function GetListObjectDaoChildren: TListObjectDaoCustom; virtual;
    procedure SetActiveAutoGenetorID(const Value: Boolean); virtual;
    procedure SetNewID; virtual;
    procedure GetFirstAutoID; virtual;
    procedure CancelFieldID; virtual;

    function GetFieldID: TField; virtual;
    function GetFieldIDOwner: TField; virtual;
    function GetNewListObjectDao: TListObjectDaoCustom; virtual;
  public
    { Public declarations }
    procedure CloneCursor(poDataSetOrigem: TClientDataSet; const pbClearOldValue: Boolean = True; const
      pbCloneRegistryForAllMasterSource: Boolean = True); virtual;
    /// <summary>
    /// Exclui o registro atual
    /// </summary>
    function Delete: Boolean; Virtual;
    procedure deleteAll;
    constructor Create(poOwner: TComponent); Override;
    procedure Assign(Source: TPersistent); overload; Override;
    procedure Assign(Source: TPersistent; const pbClearOldValue: Boolean); reintroduce; overload; virtual;
    function IsFileDB: Boolean; Virtual;
    function GetTypeDB: TTypeDB; Virtual;
    /// <summary>
    /// Atualiza informações
    /// </summary>
    procedure Refresh; virtual;
    procedure Load; Virtual;
    /// <summary>
    /// Limpa dataset
    /// </summary>
    procedure Clear; Virtual;

    procedure BeforeDestruction; override;
    procedure AfterConstruction; override;
    function GetIDOwner: Integer; Virtual;
    procedure SetBackupMasterSource;
    procedure RevertBackupMasterSource;
    /// <summary>
    /// Gera próximo ID
    /// </summary>
    function IncAutoIncrement(const pnQtdeInc: Integer = 1): Integer; virtual;
    function GetTableName: String; virtual;
    function CancelAutoIncrement(const pnQtdeDec: Integer = -1): Integer; virtual;
    procedure CancelUpdate; Virtual;

    /// <summary>
    /// Pode gerar automático ID
    /// </summary>
    property ActiveAutoGenetorID: Boolean read FActiveAutoGenetorID
      write SetActiveAutoGenetorID;
    property FieldID: TField read GetFieldID write SetFieldID;
    property FieldDC: TField read GetFieldDC write SetFieldDC;
    property FieldIDOwner: TField read GetFieldIDOwner;
    /// <summary>
    /// Lista de objetos dados filhos
    /// </summary>
    property ListObjectDaoChildren: TListObjectDaoCustom read GetListObjectDaoChildren
      write SetListObjectDaoChildren;
  end;

implementation

{$R *.dfm}

uses uFactoryObject, uConstantUtils, uObjectDaoApplication, SysUtils;

{ TObjectDaoCustom }

procedure TObjectDaoCustom.AfterConstruction;
begin
  inherited;
  FOldMasterSource := nil;
  if Assigned(ObjectDaoApplication) and (Not Assigned(SQLDADOS.SQLConnection))
  then
    SQLDADOS.SQLConnection := ObjectDaoApplication.FBConnection;
  FAutoIncrement := nCST_Zero;
  FActiveAutoGenetorID := True;
  FFieldID := TDMUtilsDao.GetFieldID(CDSDados);
  FFieldDC := TDMUtilsDao.GetFieldDC(CDSDados);
end;

procedure TObjectDaoCustom.Assign(Source: TPersistent; const pbClearOldValue: Boolean);
var
  oObjectDaoCustom: TObjectDaoCustom;
begin
  if not(Assigned(Source) and (Source is TObjectDaoCustom)) then
    Exit;

  oObjectDaoCustom := TObjectDaoCustom(Source);
  FListObjectDaoChildren.Assign(oObjectDaoCustom.FListObjectDaoChildren, pbClearOldValue);


  FFieldID := nil;
  FFieldDC := nil;
  if Assigned(oObjectDaoCustom.FFieldID) then
    FFieldID := CDSDados.FindField(oObjectDaoCustom.FFieldID.FieldName);
  if Assigned(oObjectDaoCustom.FFieldDC) then
    FFieldDC := CDSDados.FindField(oObjectDaoCustom.FFieldDC.FieldName);

  FAutoIncrement := oObjectDaoCustom.FAutoIncrement;
  FActiveAutoGenetorID := oObjectDaoCustom.FActiveAutoGenetorID;
  CloneCursor(oObjectDaoCustom.CDSDados, pbClearOldValue);
  if TDMUtils.ExistValue(oObjectDaoCustom.CDSDados) then
    TDMUtils.SetRecno(CDSDados, oObjectDaoCustom.CDSDados.RecNo);
end;

procedure TObjectDaoCustom.Assign(Source: TPersistent);
begin
  Assign(Source, True);
end;

procedure TObjectDaoCustom.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FListObjectDaoChildren);
  inherited;
end;

function TObjectDaoCustom.CancelAutoIncrement(const pnQtdeDec: Integer): Integer;
var
  FSqlGenID: TSQLDataSet;
begin
  if IsFileDB then
  begin
    if FAutoIncrement = FFieldID.AsInteger then
      Inc(FAutoIncrement, pnQtdeDec);
  end
  else
  begin
    FSqlGenID := TSQLDataSet.Create(Self);
    try
      FSqlGenID.CommandText :=
        Format('SELECT GEN_ID(GEN_%s_ID, %d) FROM RDB$DATABASE where '+
        ' (SELECT GEN_ID(GEN_%s_ID, 0) FROM RDB$DATABASE) = %d',
        [GetTableName, pnQtdeDec, GetTableName, FFieldID.AsInteger]);
      FSqlGenID.SQLConnection := ObjectDaoApplication.FBConnection;
      if FSqlGenID.Active then
        FSqlGenID.Close;
      FSqlGenID.Open;
      FAutoIncrement := FSqlGenID.FieldByName('GEN_ID').AsInteger;
    finally
      TDMUtils.DestroyObject(FSqlGenID);
    end;
  end;
  Result := FAutoIncrement;
end;

procedure TObjectDaoCustom.CancelFieldID;
begin
  CancelAutoIncrement(-1);
end;

procedure TObjectDaoCustom.CancelUpdate;
var
  nIndex: Integer;
begin
  TDMUtilsDao.ClearUpdate(CDSDados);
  for nIndex := 0 to ListObjectDaoChildren.Count -1 do
  begin
    if Assigned(ListObjectDaoChildren.Items[nIndex]) then
      ListObjectDaoChildren.Items[nIndex].CancelUpdate;
  end;
end;

procedure TObjectDaoCustom.CDSDadosAfterInsert(DataSet: TDataSet);
begin
  inherited;
  SetNewID;
end;

procedure TObjectDaoCustom.CDSDadosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  GetFirstAutoID;
end;

procedure TObjectDaoCustom.CDSDadosBeforeCancel(DataSet: TDataSet);
begin
  if CDSDados.State = dsInsert then
    CancelFieldID;
  inherited;
end;

procedure TObjectDaoCustom.CDSDadosBeforeDelete(DataSet: TDataSet);
begin
  CancelFieldID;
  inherited;
end;

procedure TObjectDaoCustom.Clear;
begin

end;

constructor TObjectDaoCustom.Create(poOwner: TComponent);
begin
  inherited;
  FListObjectDaoChildren := GetNewListObjectDao;
end;

function TObjectDaoCustom.Delete: Boolean;
begin
  Result := TDMUtilsDao.Delete(CDSDados);
end;

procedure TObjectDaoCustom.deleteAll;
begin
  CDSDados.First;
  while not CDSDados.Eof do
  begin
    Delete;
  end;
end;

function TObjectDaoCustom.GetFieldDC: TField;
begin
  Result := FFieldDC;
end;

function TObjectDaoCustom.GetFieldID: TField;
begin
  Result := FFieldID;
end;

function TObjectDaoCustom.GetFieldIDOwner: TField;
begin
  Result := nil;
  if Assigned(CDSDados.MasterSource) then
    Result :=TDMUtilsDao.GetFieldID(CDSDados.MasterSource.DataSet);

end;

procedure TObjectDaoCustom.GetFirstAutoID;
var
  oField: TField;
  sOldFieldName: String;
  nOldRecno: Integer;
begin
  FAutoIncrement := nCST_Zero;

  if not ActiveAutoGenetorID or TDMUtils.IsEmpty(CDSDados) then
    Exit;

  oField := GetFieldID;
  if not Assigned(oField) then
    Exit;

  sOldFieldName := CDSDados.IndexFieldNames;
  nOldRecno := CDSDados.RecNo;
  CDSDados.IndexFieldNames := oField.FieldName;
  try
    CDSDados.Last;
    FAutoIncrement := oField.AsInteger;
  finally
    CDSDados.IndexFieldNames := sOldFieldName;
    CDSDados.RecNo := nOldRecno;
  end;
end;

function TObjectDaoCustom.GetIDOwner: Integer;
begin
  Result := nCST_Zero;
  if Assigned(FieldIDOwner) and TDMUtils.ExistValue(FieldIDOwner.DataSet) then
    Result := FieldIDOwner.AsInteger;
end;

function TObjectDaoCustom.GetListObjectDaoChildren: TListObjectDaoCustom;
begin
  Result := FListObjectDaoChildren;
end;

function TObjectDaoCustom.GetNewListObjectDao: TListObjectDaoCustom;
begin
  Result := TListObjectDaoCustom.Create(Self);
end;

function TObjectDaoCustom.GetTableName: String;
const
  sCST_From = ' from ';
var
  nIndexBegin: SmallInt;
begin
  Result := Trim(SQLDADOS.CommandText);
  nIndexBegin := TDMUtils.PosIgnoreCase(sCST_From, Result);
  if nIndexBegin <= 0 then
    Exit;

  Result := Trim(Copy(Result, nIndexBegin + Length(sCST_From), Length(Result)));
  Result := Trim(Copy(Result, 1, Pos(' ', Result + ' ')));
end;

function TObjectDaoCustom.GetTypeDB: TTypeDB;
begin
  Result := tdbFile;
  if TDMUtils.ExistValue(SQLDADOS.CommandText) then
    Result := tdbFirebird;
end;

function TObjectDaoCustom.IncAutoIncrement(const pnQtdeInc: Integer): Integer;
var
  FSqlGenID: TSQLDataSet;
begin
  if IsFileDB then
    FAutoIncrement := FAutoIncrement + pnQtdeInc
  else
  begin
    FSqlGenID := TSQLDataSet.Create(Self);
    try
      FSqlGenID.CommandText :=
        Format('SELECT GEN_ID(GEN_%s_ID, %d) FROM RDB$DATABASE',
        [GetTableName, pnQtdeInc]);
      FSqlGenID.SQLConnection := ObjectDaoApplication.FBConnection;
      if FSqlGenID.Active then
        FSqlGenID.Close;
      FSqlGenID.Open;
      FAutoIncrement := FSqlGenID.FieldByName('GEN_ID').AsInteger;
    finally
      TDMUtils.DestroyObject(FSqlGenID);
    end;
  end;
  Result := FAutoIncrement;
end;

procedure TObjectDaoCustom.CloneCursor(poDataSetOrigem: TClientDataSet; const pbClearOldValue, pbCloneRegistryForAllMasterSource: Boolean);
var
  nIndex: Integer;
  oField: TField;
  oOldMasterOrigem: TDataSource;
begin
  if not Assigned(poDataSetOrigem) then
    Exit;

  if not CDSDados.Active then
    TDMUtilsDao.ActiveDataSet(CDSDados);
  if TDMUtils.IsEmpty(poDataSetOrigem) then
    Exit;


  oOldMasterOrigem := nil;
  if pbCloneRegistryForAllMasterSource then
  begin
    SetBackupMasterSource;
    oOldMasterOrigem := poDataSetOrigem.MasterSource;
  end;
  poDataSetOrigem.DisableControls;
  try
    if pbCloneRegistryForAllMasterSource then
      poDataSetOrigem.MasterSource := nil;

    if pbClearOldValue then
      deleteAll;

    poDataSetOrigem.First;
    while not poDataSetOrigem.Eof do
    begin
      CDSDados.Insert;
      for nIndex := nCST_Zero to poDataSetOrigem.FieldDefs.Count - nCST_One do
      begin
        oField := CDSDados.FindField(poDataSetOrigem.Fields[nIndex].FieldName);
        if Assigned(oField) then
          oField.Value := poDataSetOrigem.Fields[nIndex].Value;
      end;
      CDSDados.Post;
      poDataSetOrigem.Next;
    end;
  finally
    if pbCloneRegistryForAllMasterSource then
    begin
      poDataSetOrigem.MasterSource := oOldMasterOrigem;
      RevertBackupMasterSource;
    end;
    poDataSetOrigem.EnableControls;
  end;
end;

function TObjectDaoCustom.IsFileDB: Boolean;
begin
  Result := GetTypeDB = tdbFile;
end;

procedure TObjectDaoCustom.Load;
begin
  ListObjectDaoChildren.Load;
end;

procedure TObjectDaoCustom.Refresh;
begin

end;

procedure TObjectDaoCustom.RevertBackupMasterSource;
begin
  CDSDados.MasterSource := FOldMasterSource;
  FOldMasterSource := nil;
end;

procedure TObjectDaoCustom.SetActiveAutoGenetorID(const Value: Boolean);
begin
  FActiveAutoGenetorID := Value;
end;

procedure TObjectDaoCustom.SetBackupMasterSource;
begin
  FOldMasterSource := CDSDados.MasterSource;
  CDSDados.MasterSource := nil;
end;

procedure TObjectDaoCustom.SetFieldDC(const Value: TField);
begin
  FFieldDC := Value;
end;

procedure TObjectDaoCustom.SetFieldID(const Value: TField);
begin
  FFieldID := Value;
end;

procedure TObjectDaoCustom.SetListObjectDaoChildren(const Value: TListObjectDaoCustom);
begin
  FListObjectDaoChildren := Value;
end;

procedure TObjectDaoCustom.SetNewID;
var
  oField: TField;
begin
  if not ActiveAutoGenetorID then
    Exit;
  oField := GetFieldID;
  if Assigned(oField) then
    oField.AsInteger := IncAutoIncrement;
end;

{ TListObjectDaoCustom }

function TListObjectDaoCustom.Add(poClassDao: TClassObjectDaoCustom; poOwner: TComponent): TObjectDaoCustom;
begin
  Result := TFactoryObject.CreateComponent(poClassDao, poOwner) as TObjectDaoCustom;
  Add(Result);
end;

function TListObjectDaoCustom.Add(AObject: TObjectDaoCustom): TObjectDaoCustom;
begin
  inherited Add(AObject);
  Result := AObject;
end;

procedure TListObjectDaoCustom.Assign(Source: TObject; const pbClearOldValue: Boolean);
var
  nIndex: Integer;
  oListObjectDao: TListObjectDaoCustom;
begin
  if not(Assigned(Source) and (Source is TListObjectDaoCustom)) then
    Exit;

  oListObjectDao := TListObjectDaoCustom(Source);
  if oListObjectDao.Count <> Self.Count then
  begin
    if pbClearOldValue then
      Self.Clear;
    for nIndex := 0 to oListObjectDao.count - 1 do
    begin
      Self.Add(TFactoryObject.CloneComponent(oListObjectDao.Items[nIndex], FOwner));
    end;
    Exit;
  end;
  for nIndex := 0 to oListObjectDao.count - 1 do
  begin
    if not Assigned(Self.Items[nIndex]) then
      Continue;
    Self.Items[nIndex].Assign(oListObjectDao.Items[nIndex], pbClearOldValue);
  end;
end;

constructor TListObjectDaoCustom.Create(AOwner: TComponent);
begin
  Fowner := aOWner;
end;

function TListObjectDaoCustom.GetItems(Index: Integer): TObjectDaoCustom;
begin
  Result := TObjectDaoCustom(inherited Items[index]);
end;

procedure TListObjectDaoCustom.Load;
var
  nIndex: Integer;
begin
  for nIndex := 0 to Self.Count - 1 do
  begin
    if Assigned(Items[nIndex]) then
      Items[nIndex].Load;
  end;
end;

procedure TListObjectDaoCustom.SetItems(Index: Integer; const Value: TObjectDaoCustom);
begin
  inherited Items[Index] := Value;
end;

initialization

RegisterClass(TObjectDaoCustom);

end.
