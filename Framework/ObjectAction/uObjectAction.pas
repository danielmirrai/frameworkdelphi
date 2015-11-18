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

unit uObjectAction;

interface

uses
  uDMClasses, uObjectActionCustom, Classes, uObjectDao, SysUtils, DB,
  uDMUtilsDao, DBClient, Contnrs, uConstantUtils, Variants;

type


  TObjectAction = class;
  TClassObjectAction = class of TObjectAction;

  TListObjectAction = Class(TLisTObjectActionCustom)
  protected
    function GetItems(Index: Integer): TObjectAction; reintroduce; Virtual;
    procedure SetItems(Index: Integer; const Value: TObjectAction); reintroduce; Virtual;

  public
    /// <summary>
    /// Adiciona novo objeto ação
    /// </summary>
    function Add(poClassAction: TClassObjectAction; poOwner: TComponent = nil; const pbAutoLoad: Boolean = True)
      : TObjectAction; overload; Virtual;
    function Add(poClassAction: TObjectAction): TObjectAction; overload; Virtual;

    property Items[Index: Integer]: TObjectAction read GetItems write SetItems;
  end;

  /// <summary>
  /// Controle ação
  /// </summary>
  /// <remarks>
  /// E desenvolvido todos as implementação de regra de negócio, efetua a liguação com os registro da base de dados
  /// </remarks>
  TObjectAction = class(TObjectActionCustom)
  private
    FCanCreateObjectDao: Boolean;
  protected
    function GetObjectActionOwner: TObjectAction; Reintroduce; Virtual;
    procedure SetObjectActionOwner(const Value: TObjectActionCustom); overload; Override;
    procedure SetObjectActionOwner2(const Value: TObjectAction); Reintroduce; Overload; Virtual;
    procedure SetCanCreateObjectDao(const Value: Boolean); virtual;
    procedure SetListObjectActionChildren(const Value: TListObjectAction); reintroduce; Virtual;
    function GetListObjectActionChildren: TListObjectAction; reintroduce; Virtual;

    function GetNameObjectDao: string; virtual;
    function GetNewListObjectAction: TListObjectActionCustom; Override;

  public
    FObjectDao: TObjectDao;
    function GetIdentClass: String; Virtual;
    procedure Assign(Source: TPersistent; const pbClearOldValue: Boolean); Override;
    /// <summary>
    /// Atualiza informações
    /// </summary>
    procedure Refresh; Override;
    /// <summary>
    /// Limpa o dataset
    /// </summary>
    procedure Clear; Override;

    procedure Import; virtual;
    /// <summary>
    /// Retornar o objeto de dados, inicializando a estância caso esteja nil.
    /// </summary>
    function GetObjectDao: TObjectDao; Virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;


    procedure ApplyDB; virtual;
    /// <summary>
    /// Grava os registro alterado
    /// </summary>
    procedure Save; virtual;

    /// <summary>
    /// Cancela a modificação do registro
    /// </summary>
    procedure Cancel; virtual;

    /// <summary>
    /// Adiciona um novo registro
    /// </summary>
    procedure Add; virtual;

    /// <summary>
    /// Edita o registro selecionado
    /// </summary>
    procedure Edit; virtual;

    /// <summary>
    /// Exclui o registro selecionado
    /// </summary>
    procedure Delete; virtual;
    procedure DeleteAll; virtual;
    procedure DeleteChildren; virtual;
    procedure CancelUpdate; Virtual;

    function OwnerIsObjectMestre: Boolean; Virtual;
    function OwnerIsObjectDetail: Boolean; Virtual;

    function IsObjectMestre(poObjectActionOwner: TObjectAction)
      : Boolean; Overload; Virtual;
    function IsObjectMestre(poObjectDaoOwner: TObjectDao): Boolean; Overload; Virtual;

    function IsObjectDetail(poObjectActionChildren: TObjectAction)
      : Boolean; Overload; Virtual;
    function IsObjectDetail(poObjectDaoChildren: TObjectDao): Boolean; Overload; Virtual;

    /// <summary>
    /// Editar o registro caso já existe caso contrario adiciona um novo registro já setendo o valor do campo
    /// </summary>
    /// <example>
    /// FindAddOrEdit('NMUSUARIO', 'Daniel')
    /// </example>
    procedure FindAddOrEdit(const poFieldName: Array of string;
      const poValue: Array of Variant; const pbAutoSave: Boolean = False;
      const pbIncludeIDOwner: Boolean = True); Virtual;


    function ConfigureMasterSource(poObjectAction: TObjectAction; const pbRecursive: boolean = False): Boolean; overload;
    function ConfigureMasterSource(poObjectDao: TObjectDao; const pbRecursive: boolean = False): Boolean; overload;
    procedure DBConvert; Virtual;

    constructor Create(poOwner: TComponent; poObjectDao: TObjectDao = nil);
      Reintroduce; virtual;
    destructor Destroy; override;
    procedure Load(const pbLoadAllChildren: Boolean = True); Override;

    /// <summary>
    /// objeto pai
    /// </summary>
    property ObjectActionOwner: TObjectAction read GetObjectActionOwner write SetObjectActionOwner2;

    /// <summary>
    /// Lista de objetos ação filhos
    /// </summary>
    property ListObjectActionChildren: TListObjectAction
      read GetListObjectActionChildren write SetListObjectActionChildren;

    property CanCreateObjectDao: Boolean read FCanCreateObjectDao
      write SetCanCreateObjectDao;
  end;

implementation

{ TObjectAction }

uses uDMUtils, uFactoryObject, uDMException, uDBConvert;


procedure TObjectAction.Add;
begin
  FObjectDao.Insert;
end;
procedure TObjectAction.AfterConstruction;
begin
  inherited;
end;

procedure TObjectAction.ApplyDB;
var
  nIndex: Integer;
  bChange: Boolean;
begin
  bChange := (FObjectDao.CDSDados.ChangeCount > 0);
  FObjectDao.ApplyDB;
  for nIndex := 0 to ListObjectActionChildren.count - 1 do
  begin
    if not (Assigned(ListObjectActionChildren.Items[nIndex]) and
      (ListObjectActionChildren.Items[nIndex] <> ObjectActionOwner)) then
      Continue;
    if ((not bChange) and (not ListObjectActionChildren.Items[nIndex].CanAutoLoad) and
      TDMUtils.IsEmpty(ListObjectActionChildren.Items[nIndex].FObjectDao.CDSDados.ChangeCount)) then
      Continue;

    if ListObjectActionChildren.Items[nIndex].IsObjectLookup then
      Continue;

    ListObjectActionChildren.Items[nIndex].ApplyDB;
  end;
end;

procedure TObjectAction.Assign(Source: TPersistent; const pbClearOldValue: Boolean);
var
  oObjectAction: TObjectAction;
begin
  inherited;
  if not(Assigned(Source) and (Source is TObjectAction)) then
    Exit;

  oObjectAction := TObjectAction(Source);
  FObjectDao.Assign(oObjectAction.FObjectDao);
end;

procedure TObjectAction.BeforeDestruction;
begin
  inherited;

end;

procedure TObjectAction.Cancel;
begin
  if Assigned(FObjectDao) then
    FObjectDao.Cancel;
end;

procedure TObjectAction.CancelUpdate;
var
  nIndex: Integer;
begin
  FObjectDao.CancelUpdate;
  for nIndex := 0 to ListObjectActionChildren.Count -1 do
  begin
    if Assigned(ListObjectActionChildren.Items[nIndex]) and
     (not ListObjectActionChildren.Items[nIndex].IsObjectLookup)  and
     (not IsObjectDetail(ListObjectActionChildren.Items[nIndex]))  then
      ListObjectActionChildren.Items[nIndex].CancelUpdate;
  end;
end;

procedure TObjectAction.Clear;
begin
  inherited;
  if Assigned(FObjectDao) then
    FObjectDao.Clear;
end;

function TObjectAction.ConfigureMasterSource(poObjectAction: TObjectAction; const pbRecursive: boolean): Boolean;
begin
  Result := False;
  if not Assigned(poObjectAction) then
    Exit;
  Result := ConfigureMasterSource(poObjectAction.FObjectDao);
  if (not Result) and pbRecursive and Assigned(poObjectAction.ObjectActionOwner) then
    Result := ConfigureMasterSource(poObjectAction.ObjectActionOwner, pbRecursive);
end;

function TObjectAction.ConfigureMasterSource(poObjectDao: TObjectDao; const pbRecursive: boolean): Boolean;
begin
  Result := FObjectDao.ConfigureMasterSource(poObjectDao);
end;

constructor TObjectAction.Create(poOwner: TComponent; poObjectDao: TObjectDao);
begin
  inherited Create(poOwner);
  FObjectDao := poObjectDao;

  FCanCreateObjectDao := not Assigned(FObjectDao);
  FObjectDao := GetObjectDao;

  ObjectActionOwner := nil;
  if Assigned(poOwner) and (poOwner is TObjectAction) then
    ObjectActionOwner := TObjectAction(poOwner);
end;

procedure TObjectAction.DBConvert;
var
  oDBConvert: TDBConvert;
begin
  oDBConvert := TDBConvert.Create;
  try
    oDBConvert.ObjectAction := Self;
    oDBConvert.ExporteScriptCreateDB;
  finally
    TDMUtils.DestroyObject(oDBConvert);
  end;
end;

procedure TObjectAction.Delete;
begin
  if FObjectDao.IsFileDB then
    DeleteChildren;
  FObjectDao.Delete;
end;

procedure TObjectAction.DeleteAll;
begin
  Cancel;
  FObjectDao.CDSDados.Last;
  while not FObjectDao.CDSDados.Bof do
  begin
    Delete;
  end;
end;

procedure TObjectAction.DeleteChildren;
var
  nIndex: Integer;
begin
  for nIndex := 0 to ListObjectActionChildren.count - 1 do
  begin
    if (Assigned(ListObjectActionChildren.Items[nIndex]) and
      (not ListObjectActionChildren.Items[nIndex].IsObjectLookup) and
      ListObjectActionChildren.Items[nIndex].IsObjectMestre(Self)) then
      ListObjectActionChildren.Items[nIndex].DeleteAll;
  end;
end;

destructor TObjectAction.Destroy;
begin
  Cancel;
  if FCanCreateObjectDao then
    TDMUtils.DestroyObject(FObjectDao)
  else
    FObjectDao := nil;
  inherited;

end;

procedure TObjectAction.Edit;
begin
  FObjectDao.Edit;
end;

procedure TObjectAction.FindAddOrEdit(const poFieldName: Array of string;
  const poValue: Array of Variant; const pbAutoSave, pbIncludeIDOwner: Boolean);
var
  sFieldNames: String;
  nIndex: Integer;
  oFieldOwner: TField;
  oValue: Array of Variant;
  oFieldName: array of String;

  procedure AddFieldLista(const psField: String);
  begin
    TDMUtils.AddIfExistValue(sFieldNames, ';');
    sFieldNames := sFieldNames + psField;
    SetLength(oFieldName, Length(oFieldName) + 1);
    oFieldName[Length(oFieldName) - 1] := psField;
  end;

begin
  if (Length(poValue) <> Length(poFieldName)) then
    raise eDataError.Create(sMSG_DataError);

  SetLength(oValue, 0);
  SetLength(oFieldName, 0);

  sFieldNames := sCST_EmptyStr;

  if pbIncludeIDOwner then
  begin
    oFieldOwner := FObjectDao.FieldIDOwner;
    if Assigned(oFieldOwner) then
    begin
      AddFieldLista(oFieldOwner.FieldName);

      SetLength(oValue, Length(oValue) + 1);
      oValue[Length(oValue) - 1] := oFieldOwner.AsInteger;
    end;
  end;

  for nIndex := 0 to Length(poValue) - 1 do
  begin
    SetLength(oValue, Length(oValue) + 1);
    oValue[Length(oValue) - 1] := poValue[nIndex];

    AddFieldLista(poFieldName[nIndex]);
  end;

  if FObjectDao.CDSDados.Locate(sFieldNames, varArrayOf(oValue),
    [loCaseInsensitive]) then
    Edit
  else
    Add;

  for nIndex := 0 to Length(oFieldName) - 1 do
  begin
    TDMUtilsDao.SetValorField(FObjectDao.CDSDados.FindField(oFieldName[nIndex]),
      oValue[nIndex]);
  end;

  if pbAutoSave then
    Save;
end;

function TObjectAction.GetIdentClass: String;
begin
  Result := Copy(Self.ClassName, Length('TObjectAction') + nCST_One,
    Length(Self.ClassName));
end;

function TObjectAction.GetListObjectActionChildren: TListObjectAction;
begin
  Result := inherited ListObjectActionChildren as TListObjectAction;
end;

function TObjectAction.GetNameObjectDao: string;
begin
  Result := TFactoryObject.GetNameObjectDao(Self.ClassName);
end;

function TObjectAction.GetNewListObjectAction: TListObjectActionCustom;
begin
  Result := TListObjectAction.Create(Self);
end;

function TObjectAction.GetObjectActionOwner: TObjectAction;
begin
  Result := TObjectAction(inherited GetObjectActionOwner);
end;

function TObjectAction.GetObjectDao: TObjectDao;
begin
  if (not Assigned(FObjectDao)) then
    FObjectDao := TObjectDao(TFactoryObject.CreateComponent
      (GetNameObjectDao, Self));
  Result := FObjectDao;
end;

function TObjectAction.IsObjectDetail(poObjectActionChildren
  : TObjectAction): Boolean;
begin
  Result := Assigned(poObjectActionChildren) and
    FObjectDao.IsObjectDetail(poObjectActionChildren.FObjectDao);
end;

procedure TObjectAction.Import;
begin
  Exit;
end;


function TObjectAction.IsObjectDetail(poObjectDaoChildren: TObjectDao): Boolean;
begin
  Result := FObjectDao.IsObjectDetail(poObjectDaoChildren);
end;

function TObjectAction.IsObjectMestre(poObjectActionOwner
  : TObjectAction): Boolean;
begin
  Result := Assigned(poObjectActionOwner) and
    FObjectDao.IsObjectMestre(poObjectActionOwner.FObjectDao);
end;

function TObjectAction.IsObjectMestre(poObjectDaoOwner: TObjectDao): Boolean;
begin
  Result := FObjectDao.IsObjectMestre(poObjectDaoOwner);
end;

procedure TObjectAction.Load(const pbLoadAllChildren: Boolean);
begin
  if not CanAutoLoad then
    Exit;

  inherited;
  FObjectDao.Load;
  if not FObjectDao.ExistData then
    Import;
end;



function TObjectAction.OwnerIsObjectDetail: Boolean;
begin
  Result := FObjectDao.OwnerIsObjectDetail;
end;

function TObjectAction.OwnerIsObjectMestre: Boolean;
begin
  Result := FObjectDao.OwnerIsObjectMestre;
end;

procedure TObjectAction.Refresh;
begin
  inherited;
  if Assigned(FObjectDao) then
    FObjectDao.Refresh;
end;

procedure TObjectAction.Save;
begin
  FObjectDao.Save;
end;

procedure TObjectAction.SetCanCreateObjectDao(const Value: Boolean);
begin
  FCanCreateObjectDao := Value;
end;

procedure TObjectAction.SetListObjectActionChildren(const Value: TListObjectAction);
begin
  inherited ListObjectActionChildren := Value;
end;

procedure TObjectAction.SetObjectActionOwner(const Value: TObjectActionCustom);
begin
  if Assigned(ObjectActionOwner) then
  begin
    FObjectDao.ObjectDaoOwner := ObjectActionOwner.FObjectDao;
    ConfigureMasterSource(ObjectActionOwner);
  end;                 {
  if FObjectDao.IsFileDB then
    DBConvert;        }
end;

procedure TObjectAction.SetObjectActionOwner2(const Value: TObjectAction);
begin
  SetObjectActionOwner(TObjectActionCustom(Value));
end;

{ TListObjectAction }

function TListObjectAction.Add(poClassAction: TClassObjectAction; poOwner: TComponent; const pbAutoLoad: Boolean): TObjectAction;
var
  oObjectaction: TObjectAction;
begin
  if Assigned(poOwner) and (poOwner is TObjectAction) then
  begin
    oObjectaction := TObjectAction(poOwner);
    if Assigned(oObjectaction.ObjectActionOwner) and (oObjectaction.ObjectActionOwner.ClassType = poClassAction)  then
    begin
      Result := Add(oObjectaction.ObjectActionOwner);
      oObjectaction.ConfigureMasterSource(oObjectaction.ObjectActionOwner, True);
      Exit;
    end;
  end;

  Result := Add(TFactoryObject.CreateComponent(poClassAction, poOwner) as TObjectAction);
  Result.CanAutoLoad := pbAutoLoad;
  Result.IsObjectLookup := IsObjectLookup;
end;

function TListObjectAction.Add(poClassAction: TObjectAction): TObjectAction;
begin
  Result := inherited Add(poClassAction) as TObjectAction;
end;

function TListObjectAction.GetItems(Index: Integer): TObjectAction;
begin
  Result := TObjectAction(inherited Items[index]);
end;


procedure TListObjectAction.SetItems(Index: Integer;
  const Value: TObjectAction);
begin
  inherited Items[Index] := Value;
end;

initialization

DMClasses.RegisterClass(TObjectAction);

end.