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
unit uObjectDao;

interface

uses
  Classes, Contnrs, uObjectDaoCustom, DB, DBClient, MidasLib, SysUtils,
  TypInfo, FMTBcd, uDMException, Dialogs,
  Provider, SqlExpr;

type
  TObjectDao = class;
  TClassObjectDao = class of TObjectDao;

  TListObjectDao = Class(TListObjectDaoCustom)
  protected
    function GetItems(Index: Integer): TObjectDao; reintroduce; Virtual;
    procedure SetItems(Index: Integer; const Value: TObjectDao); reintroduce; Virtual;
  public
    procedure Assign(Source: TObject; const pbClearOldValue: Boolean = True); Override;

    /// <summary>
    /// Adiciona novo objeto dados
    /// </summary>
    function Add(poClassDao: TClassObjectDao; poOwner: TComponent = nil)
      : TObjectDao; Reintroduce; Overload; Virtual;
    function Add(AObject: TObjectDao): TObjectDao; Reintroduce; Overload; Virtual;
    property Items[Index: Integer]: TObjectDao read GetItems write SetItems;
  end;

  TObjectDao = class(TObjectDaoCustom)
    procedure CDSDadosAfterPost(DataSet: TDataSet);
    procedure CDSDadosBeforeDelete(DataSet: TDataSet);
  private
    FObjectDaoOwner: TObjectDao;
    FSufixTable: String;
    { Private declarations }
  protected
    function GetListObjectDaoChildren: TListObjectDao; reintroduce; Virtual;
    procedure SetListObjectDaoChildren(const Value: TListObjectDao); reintroduce; Virtual;
    procedure SetObjectDaoOwner(const Value: TObjectDao); virtual;
    function GetNameFileSave: string; virtual;
    function GetNewListObjectDao: TListObjectDao; Reintroduce; Virtual;
    function GetFieldIDOwner: TField; Override;
  public
    function OwnerIsObjectMestre: Boolean; virtual;
    function OwnerIsObjectDetail: Boolean; virtual;

    function IsObjectMestre(poObjectDaoOwner: TObjectDao): Boolean; virtual;
    function IsObjectDetail(poObjectDaoChildren: TObjectDao): Boolean; virtual;

    { Public declarations }
    /// <summary>
    /// Ativa o dataset caso não esteja ativo
    /// </summary>
    procedure ActiveDataSet; Virtual;

    /// <summary>
    /// Retorno se está cadastrando ou editando o registro
    /// </summary>
    function Editing: Boolean; virtual;

    procedure Assign(Source: TPersistent; const pbClearOldValue: Boolean); Override;

    /// <summary>
    /// Grava os registro alterado
    /// </summary>
    procedure Save; virtual;
    procedure ApplyDB; virtual;
    function CanApplyDB: Boolean; virtual;

    /// <summary>
    /// Buscar DB
    /// </summary>
    procedure Load; Override;
    procedure AddFilterOwner;
    function GetSufixTable(const pbAddPonte: BOolean): String;

    /// <summary>
    /// Adiciona um novo registro
    /// </summary>
    procedure Insert; virtual;

    /// <summary>
    /// Edita o registro selecionado
    /// </summary>
    procedure Edit; virtual;

    /// <summary>
    /// Existe algum registro no dataset
    /// </summary>
    function ExistData: Boolean; virtual;

    /// <summary>
    /// Cancela a modificação do registro
    /// </summary>
    procedure Cancel; virtual;

    procedure Filter(const poField: TField; const psValue: string); Overload; Virtual;
    procedure Filter(const psNameField, psValue: string); Overload; Virtual;
    procedure Filter(const psNameField: String; const pnValue: Extended); Overload; Virtual;
    procedure Filter(const psFilter: string); Overload; Virtual;

    /// <summary>
    /// Limpa todos os dados do dataset
    /// </summary>
    procedure Clear; Override;


    /// <summary>
    /// Busca novamente as informações atualizada na base
    /// </summary>
    procedure Refresh; Override;

    constructor Create(poOwner: TComponent); Override;
    procedure BeforeDestruction; override;

    function ConfigureMasterSource(poObjectDao: TObjectDao): Boolean; overload;
    function ConfigureMasterSource(poDataSource: TDataSource): Boolean; overload;
    procedure AfterConstruction; override;
    property ObjectDaoOwner: TObjectDao read FObjectDaoOwner
      write SetObjectDaoOwner;

    /// <summary>
    /// Lista de objetos dados filhos
    /// </summary>
    property ListObjectDaoChildren: TListObjectDao read GetListObjectDaoChildren
      write SetListObjectDaoChildren;
  end;

implementation

uses uDMUtilsDao, uDMUtils, uConstantUtils, uFactoryObject,
  uObjectDaoApplication;

const
  sCST_FiltroField = '(%s = %s)';

{$R *.dfm}
  { TObjectDao }

procedure TObjectDao.ActiveDataSet;
begin
  TDMUtilsDao.ActiveDataSet(CDSDados);
end;

procedure TObjectDao.AddFilterOwner;
var
  oParam: TParam;
  sWhere, sNameField: String;
  nINdex, nValueParam: Integer;
begin
  if not (assigned(FObjectDaoOwner)) then
    Exit;
  sNameField := FObjectDaoOwner.FieldID.FieldName;
  if not Assigned(Self.CDSDados.FindField(sNameField)) then
    Exit;
  oParam := CDSDados.Params.FindParam(sNameField);
  try
    if Assigned(oParam) then
      Exit;
    sWhere := Format('((%s =:%s) or (0=:%s))', [GetSufixTable(True) + sNameField, sNameField, sNameField, sNameField]);

    if TDMUtils.ExisteString(sWhere, SQLDADOS.CommandText) then
      Exit;

    if TDMUtils.ExistePalavra('where', SQLDADOS.CommandText) then
      SQLDADOS.CommandText := SQLDADOS.CommandText + ' AND ' + ' ' + sWhere
    else
      SQLDADOS.CommandText := SQLDADOS.CommandText + ' WHERE ' + ' ' + sWhere;

  finally
    FObjectDaoOwner.SetBackupMasterSource;
    try
      nValueParam := 0;
      if (FObjectDaoOwner.CDSDados.Active and (FObjectDaoOwner.CDSDados.RecordCount <= 1)) then
        nValueParam := FObjectDaoOwner.FieldID.AsInteger;
    finally
      FObjectDaoOwner.RevertBackupMasterSource;
    end;
    for nIndex := 0 to SQLDADOS.Params.Count -1 do
    begin
      oParam := SQLDADOS.Params.Items[nIndex];
      if not TDMUtils.CompareIgnoreCase(oParam.Name, sNameField) then
        Continue;

      oParam.DataType := ftInteger;
      oParam.ParamType := ptInput;
      oParam.AsInteger := nValueParam;
    end;
  end;
end;

procedure TObjectDao.AfterConstruction;
begin
  inherited;
end;

procedure TObjectDao.ApplyDB;
var
  sFile: String;
begin

  if not CanApplyDB then
    Exit;
  if IsFileDB then
  begin
    sFile := GetNameFileSave;
    TDMUtils.DeleteFile2(sFile);
    TDMUtils.CreateDirectory(sFile);
    CDSDados.SaveToFile(sFile);
  end
  else
  begin
    if TDMUtils.IsEmpty(CDSDados.ProviderName) then
      Exit;

    if (assigned(ObjectDaoOwner) and IsObjectMestre(ObjectDaoOwner)) then
      ObjectDaoOwner.ApplyDB;
    try
      CDSDados.ApplyUpdates(-1);
    except
      raise eDMExcepetion.Create('Erro ao salvar DB. ' + Self.ClassName + #13 + TDMException.GetMessageException);

    end;
  end;
end;

procedure TObjectDao.Assign(Source: TPersistent; const pbClearOldValue: Boolean);
var
  oObjectDao: TObjectDao;
begin
  inherited;
  if not(Assigned(Source) and (Source is TObjectDao)) then
    Exit;

  oObjectDao := TObjectDao(Source);
  ObjectDaoOwner  := oObjectDao.FObjectDaoOwner;
  FSufixTable := oObjectDao.FSufixTable;
end;

procedure TObjectDao.BeforeDestruction;
begin
  Cancel;
  ApplyDB;

  FObjectDaoOwner := nil;
  inherited;
end;

function TObjectDao.CanApplyDB: Boolean;
begin
  Result := TDMUtilsDao.IsActiveDataSet(CDSDados) and
    (CDSDados.ChangeCount <> 0);
end;

procedure TObjectDao.Cancel;
begin
  TDMUtilsDao.Cancel(CDSDados);
end;

procedure TObjectDao.CDSDadosAfterPost(DataSet: TDataSet);
begin
  inherited;
  Save;
end;

procedure TObjectDao.CDSDadosBeforeDelete(DataSet: TDataSet);
begin
  inherited;
  CancelAutoIncrement;
end;

procedure TObjectDao.Clear;
var
  nOldRecno: Integer;
begin
  nOldRecno := nCST_Zero;
  if TDMUtilsDao.IsActiveDataSet(CDSDados) then
    nOldRecno := CDSDados.RecNo;

  try
    TDMUtilsDao.Clear(CDSDados);
    FAutoIncrement := nCST_Zero;
  finally
    TDMUtils.SetRecno(CDSDados, nOldRecno);
  end;
end;

function TObjectDao.ConfigureMasterSource(poObjectDao: TObjectDao): Boolean;
begin
  Result := False;
  if assigned(poObjectDao) then
    Result := ConfigureMasterSource(poObjectDao.DSDados);
end;

function TObjectDao.ConfigureMasterSource(poDataSource: TDataSource): Boolean;
var
  oFieldIDOwner: TField;
begin
  Result := False;
  CDSDados.MasterFields := sCST_EmptyStr;
  CDSDados.MasterSource := nil;

  if not(assigned(FieldID) and assigned(poDataSource) and
    assigned(poDataSource.DataSet)) then
    Exit;

  oFieldIDOwner := TDMUtilsDao.GetFieldID(poDataSource.DataSet);

  if not(assigned(oFieldIDOwner) and
    assigned(CDSDados.FindField(oFieldIDOwner.FieldName))) then
    Exit;

  if TDMUtils.CompareIgnoreCase(oFieldIDOwner.FieldName, FieldID.FieldName) then
    Exit;

  CDSDados.IndexFieldNames := oFieldIDOwner.FieldName + ';' + FieldID.FieldName;
  CDSDados.MasterFields := oFieldIDOwner.FieldName;
  CDSDados.MasterSource := poDataSource;
  Result := True;
end;

constructor TObjectDao.Create(poOwner: TComponent);
begin
  inherited;
  FSufixTable := '';
  ObjectDaoOwner := nil;
  if assigned(poOwner) and (poOwner is TObjectDao) then
    ObjectDaoOwner := TObjectDao(poOwner);
  if IsFileDB then
    CDSDados.ProviderName := sCST_EmptyStr;
end;


procedure TObjectDao.Edit;
begin
  TDMUtilsDao.Edit(CDSDados);
end;

function TObjectDao.Editing: Boolean;
begin
  Result := TDMUtilsDao.Editing(CDSDados);
end;

function TObjectDao.ExistData: Boolean;
begin
  Result := TDMUtils.ExistValue(CDSDados);
end;

procedure TObjectDao.Filter(const poField: TField; const psValue: string);
begin
  case poField.DataType of
    ftString, ftDate, ftTime, ftTimeStamp:
      Filter(poField.FieldName, psValue);
    ftLargeint, ftFloat, ftCurrency, ftSmallint, ftInteger, ftWord:
      Filter(poField.FieldName, TDMUtils.StrToFloat2(psValue));
  end;
end;

procedure TObjectDao.Filter(const psFilter: string);
begin
  CDSDados.Filtered := False;
  CDSDados.Filter := psFilter;
  if TDMUtils.ExistValue(psFilter) then
    CDSDados.Filtered := True;
end;

procedure TObjectDao.Filter(const psNameField, psValue: string);
begin
  Filter(Format(sCST_FiltroField, [psNameField, quotedStr(psValue)]));
end;

procedure TObjectDao.Filter(const psNameField: String; const pnValue: Extended);
begin
  Filter(Format(sCST_FiltroField, [psNameField, FloatToStr(pnValue)]));
end;

function TObjectDao.GetFieldIDOwner: TField;
begin
  Result := nil;
  if Assigned(FObjectDaoOwner) and FObjectDaoOwner.IsObjectDetail(self) then
    Result := FObjectDaoOwner.FieldID;
end;

function TObjectDao.GetListObjectDaoChildren: TListObjectDao;
begin
  Result := TListObjectDao(Inherited ListObjectDaoChildren);
end;

function TObjectDao.GetNameFileSave: string;
begin
  Result := TDMUtils.GetDirectoryTempApp + Self.ClassName + CDSDados.Name
    + '.data';
end;

function TObjectDao.GetNewListObjectDao: TListObjectDao;
begin
  Result := TListObjectDao.Create(Self);
end;

function TObjectDao.GetSufixTable(const pbAddPonte: BOolean): String;
var
  nIndexBegin: Integer;
  oSQL: TStringList;
  nIndex: Integer;
begin
  Result := ' ';
  try
    if FSufixTable <> '' then
    begin
      Result := Trim(FSufixTable);
      Exit;
    end;
    oSQL := TStringList.Create;
    try
      oSQL.Text := SQLDADOS.CommandText;
      for nIndex := 0 to oSQL.Count - 1 do
      begin
        oSQL.Strings[nIndex] := ' ' + oSQL.Strings[nIndex] + ' ';
      end;
      nIndexBegin := TDMUtils.PosIgnoreCase(' FROM ', oSQL.Text);
      if TDMUtils.IsEmpty(nIndexBegin) then
        Exit;

      if TDMUtils.IsEmpty(pos('.', Trim(Copy(oSQL.Text, 1, nINdexBegin)))) then
        Exit;
      oSQL.Text := Trim(Copy(oSQL.Text, nINdexBegin, Length(oSQL.Text)));
      oSQL.Text := Trim(Copy(oSQL.Text, Length('FROM '), Length(oSQL.Text)));
      nIndexBegin := TDMUtils.PosIgnoreCase(' ', oSQL.Text);
      if TDMUtils.IsEmpty(nIndexBegin) then
        Exit;
      oSQL.Text := Trim(Copy(oSQL.Text, nINdexBegin, Length(oSQL.Text)));
      nIndexBegin := TDMUtils.PosIgnoreCase(' ', oSQL.Text);
      if TDMUtils.IsEmpty(nIndexBegin) then
        Exit;
      Result := Trim(Copy(oSQL.Text, 1, nINdexBegin));
    finally
      FSufixTable := Result;
      TDMUtils.DestroyObject(oSQL);
    end;
  finally
    if pbAddPonte and TDMUtils.ExistValue(Result) then
      Result := Result + '.';
  end;
end;

procedure TObjectDao.Insert;
begin
  TDMUtilsDao.Insert(CDSDados);
end;

function TObjectDao.IsObjectDetail(poObjectDaoChildren: TObjectDao): Boolean;
begin
  Result := assigned(poObjectDaoChildren) and
    assigned(poObjectDaoChildren.CDSDados.MasterSource) and
    (DSDados = poObjectDaoChildren.CDSDados.MasterSource);
end;

function TObjectDao.IsObjectMestre(poObjectDaoOwner: TObjectDao): Boolean;
begin
  Result := assigned(poObjectDaoOwner) and assigned(CDSDados.MasterSource) and
    (CDSDados.MasterSource = poObjectDaoOwner.DSDados);
end;

procedure TObjectDao.Load;
var
  sFile: String;
  nOldRecno: Integer;
begin
  inherited;
  ApplyDB;

  nOldRecno := -1;
  if CDSDados.Active then
  begin
    nOldRecno := CDSDados.RecNo;
    CDSDados.Close;
  end;

  try
    if IsFileDB then
    begin
      sFile := GetNameFileSave;
      if TDMUtils.FileExists2(sFile) then
        CDSDados.LoadFromFile(sFile)
      else
        ActiveDataSet;
    end
    else
    begin
      AddFilterOwner;
      ActiveDataSet;
    end;
    TDMUtilsDao.ClearUpdate(CDSDados);
  finally
    TDMUtils.SetRecno(CDSDados, nOldRecno);
  end;
end;

function TObjectDao.OwnerIsObjectDetail: Boolean;
begin
  Result := IsObjectDetail(FObjectDaoOwner);
end;

function TObjectDao.OwnerIsObjectMestre: Boolean;
begin
  Result := IsObjectMestre(FObjectDaoOwner);
end;

procedure TObjectDao.Refresh;
begin
  inherited;
end;

procedure TObjectDao.Save;
begin
  TDMUtilsDao.Save(CDSDados);
end;

procedure TObjectDao.SetListObjectDaoChildren(const Value: TListObjectDao);
begin
  inherited ListObjectDaoChildren := Value;
end;

procedure TObjectDao.SetObjectDaoOwner(const Value: TObjectDao);
begin
  FObjectDaoOwner := Value;
  if assigned(FObjectDaoOwner) then
    ConfigureMasterSource(FObjectDaoOwner);
end;

{ TListObjectDao }

function TListObjectDao.Add(poClassDao: TClassObjectDao; poOwner: TComponent)
  : TObjectDao;
begin
  Result := TFactoryObject.CreateComponent(poClassDao, poOwner) as TObjectDao;
  Add(Result);
end;

function TListObjectDao.Add(AObject: TObjectDao): TObjectDao;
begin
  inherited Add(AObject);
  Result := AObject;
end;

procedure TListObjectDao.Assign(Source: TObject; const pbClearOldValue: Boolean);

begin
  inherited;
end;


function TListObjectDao.GetItems(Index: Integer): TObjectDao;
begin
  Result := TObjectDao(inherited Items[index]);
end;

procedure TListObjectDao.SetItems(Index: Integer; const Value: TObjectDao);
begin
  inherited Items[Index] := Value;
end;

initialization

RegisterClass(TObjectDao);

end.
