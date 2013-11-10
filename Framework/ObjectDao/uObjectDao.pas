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
  Classes, Contnrs, uObjectDaoCustom, DB, DBClient, MidasLib;

type
  TObjectDao = class;
  TClassObjectDao = class of TObjectDao;

  TListObjectDao = Class(TObjectList)
  protected
    function GetItems(Index: Integer): TObjectDao; Virtual;
    procedure SetItems(Index: Integer; const Value: TObjectDao); Virtual;
  public
    constructor Create;
    destructor Destroy; Override;

    /// <summary>
    /// Adiciona novo objeto dados
    /// </summary>
    function Add(poClassDao: TClassObjectDao; poOwner: TComponent = nil)
      : TObjectDao; overload;
    property Items[Index: Integer]: TObjectDao read GetItems write SetItems;
  end;

  TObjectDao = class(TObjectDaoCustom)
    procedure CDSDadosAfterPost(DataSet: TDataSet);
    procedure CDSDadosBeforeCancel(DataSet: TDataSet);
  private
    FObjectDaoOwner: TObjectDao;
    FListObjectDaoChildren: TListObjectDao;
    { Private declarations }
  protected
    procedure SetListObjectDaoChildren(const Value: TListObjectDao); virtual;
    procedure SetObjectDaoOwner(const Value: TObjectDao); virtual;
    function GetNameFileSave: string; virtual;
  public
    { Public declarations }
    /// <summary>
    /// Ativa o dataset caso não esteja ativo
    /// </summary>
    procedure ActiveDataSet; Virtual;

    /// <summary>
    /// Retorno se está cadastrando ou editando o registro
    /// </summary>
    function Editing: Boolean; virtual;

    /// <summary>
    /// Grava os registro alterado
    /// </summary>
    procedure Save; virtual;

    /// <summary>
    /// Edita o registro selecionado
    /// </summary>
    procedure Load; Virtual;

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

    /// <summary>
    /// Limpa todos os dados do dataset
    /// </summary>
    procedure Clear; Override;

    /// <summary>
    /// Exclui o registro atual
    /// </summary>
    function Delete: Boolean; Virtual;

    /// <summary>
    /// Busca novamente as informações atualizada na base
    /// </summary>
    procedure Refresh; Override;

    constructor Create(poOwner: TComponent); Override;
    procedure BeforeDestruction; override;

    procedure ConfigureMasterSource(poObjectDao: TObjectDao); overload;
    procedure ConfigureMasterSource(poDataSource: TDataSource); overload;
    procedure AfterConstruction; override;
    property ObjectDaoOwner: TObjectDao read FObjectDaoOwner
      write SetObjectDaoOwner;

    /// <summary>
    /// Lista de objetos dados filhos
    /// </summary>
    property ListObjectDaoChildren: TListObjectDao read FListObjectDaoChildren
      write SetListObjectDaoChildren;
  end;

implementation

uses uDMUtilsDao, uDMUtils, uConstantUtils, uFactoryObject;

{$R *.dfm}
{ TObjectDao }

procedure TObjectDao.ActiveDataSet;
begin
  TDMUtilsDao.ActiveDataSet(CDSDados);
end;

procedure TObjectDao.AfterConstruction;
begin
  inherited;
  if Assigned(FObjectDaoOwner) then
    ConfigureMasterSource(FObjectDaoOwner);
end;

procedure TObjectDao.BeforeDestruction;
begin
  Cancel;
  FObjectDaoOwner := nil;
  TDMUtils.DestroyObject(FListObjectDaoChildren);
  inherited;
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

procedure TObjectDao.CDSDadosBeforeCancel(DataSet: TDataSet);
begin
  inherited;
  if True then

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

procedure TObjectDao.ConfigureMasterSource(poObjectDao: TObjectDao);
begin
  if Assigned(poObjectDao) then
    ConfigureMasterSource(poObjectDao.DSDados);
end;

procedure TObjectDao.ConfigureMasterSource(poDataSource: TDataSource);
begin
  FieldIDOwner := nil;
  CDSDados.MasterFields := sCST_EmptyStr;
  CDSDados.MasterSource := nil;

  if not(Assigned(FieldID) and Assigned(poDataSource) and
    Assigned(poDataSource.DataSet)) then
    Exit;

  FieldIDOwner := TDMUtilsDao.GetFieldID(poDataSource.DataSet);

  if not (Assigned(FieldIDOwner) and Assigned(CDSDados.FindField(FieldIDOwner.FieldName))) then
    Exit;

  CDSDados.IndexFieldNames := FieldIDOwner.FieldName + ';' + FieldID.FieldName;
  CDSDados.MasterFields := FieldIDOwner.FieldName;
  CDSDados.MasterSource := poDataSource;
end;

constructor TObjectDao.Create(poOwner: TComponent);
begin
  inherited;
  ObjectDaoOwner := nil;
  if Assigned(poOwner) and (poOwner is TObjectDao) then
    ObjectDaoOwner := TObjectDao(poOwner);
  FListObjectDaoChildren := TListObjectDao.Create;
end;

function TObjectDao.Delete: Boolean;
begin
  Result := TDMUtilsDao.Delete(CDSDados);
  Save;
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

function TObjectDao.GetNameFileSave: string;
begin
  Result := TDMUtils.GetDirectoryTempApp + Self.ClassName + CDSDados.Name
    + '.data';
end;

procedure TObjectDao.Insert;
begin
  TDMUtilsDao.Insert(CDSDados);
end;

procedure TObjectDao.Load;
var
  sFile: String;
  nOldRecno: Integer;
begin
  nOldRecno := -1;
  if CDSDados.Active then
  begin
    nOldRecno := CDSDados.RecNo;
    CDSDados.Close;
  end;
  sFile := GetNameFileSave;

  try
    if TDMUtils.FileExists2(sFile) then
      CDSDados.LoadFromFile(sFile)
    else
      ActiveDataSet;
    CDSDados.Active := True;
  finally
    TDMUtils.SetRecno(CDSDados, nOldRecno);
  end;
end;

procedure TObjectDao.Refresh;
begin
  inherited;
  if not TDMUtilsDao.Editing(CDSDados) then
    Load;
end;

procedure TObjectDao.Save;
var
  sFile: String;
begin
  TDMUtilsDao.Save(CDSDados);
  if not TDMUtilsDao.IsActiveDataSet(CDSDados) then
    Exit;

  sFile := GetNameFileSave;
  TDMUtils.DeleteFile2(sFile);
  TDMUtils.CreateDirectory(sFile);
  CDSDados.SaveToFile(sFile);
end;

procedure TObjectDao.SetListObjectDaoChildren(const Value: TListObjectDao);
begin
  FListObjectDaoChildren := Value;
end;

procedure TObjectDao.SetObjectDaoOwner(const Value: TObjectDao);
begin
  FObjectDaoOwner := Value;
end;

{ TListObjectDao }

function TListObjectDao.Add(poClassDao: TClassObjectDao; poOwner: TComponent)
  : TObjectDao;
begin
  Result := TFactoryObject.CreateComponent(poClassDao, poOwner) as TObjectDao;
  inherited Add(Result);
end;

constructor TListObjectDao.Create;
begin

end;

destructor TListObjectDao.Destroy;
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
