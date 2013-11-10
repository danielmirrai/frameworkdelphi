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
  uObjectActionCustom, System.Classes, uObjectDao, System.SysUtils, Data.DB,
  Contnrs, uConstantUtils, System.Variants;

type
  TObjectAction = class;
  TClassObjectAction = class of TObjectAction;

  TListObjectAction = Class(TObjectList)
  protected
    function GetItems(Index: Integer): TObjectAction; Virtual;
    procedure SetItems(Index: Integer; const Value: TObjectAction); Virtual;
  public
    constructor Create; Virtual;
    destructor Destroy; Override;

    /// <summary>
    /// Adiciona novo objeto ação
    /// </summary>
    function Add(poClassAction: TClassObjectAction; poOwner: TComponent = nil)
      : TObjectAction; overload;
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
    FObjectActionOwner: TObjectAction;
    FCanCreateObjectDao: Boolean;
    FListObjectActionChildren: TListObjectAction;
  protected
    procedure SetObjectActionOwner(const Value: TObjectAction); virtual;
    procedure SetCanCreateObjectDao(const Value: Boolean); virtual;
    procedure SetListObjectActionChildren(const Value
      : TListObjectAction); virtual;

    function GetNameObjectDao: string; virtual;
    function GetIdentClass: String; Virtual;
  public
    FObjectDao: TObjectDao;
    /// <summary>
    /// Atualiza informações
    /// </summary>
    procedure Refresh; Override;
    /// <summary>
    /// Limpa o dataset
    /// </summary>
    procedure Clear; Override;

    /// <summary>
    /// Retornar o objeto de dados, inicializando a estância caso esteja nil.
    /// </summary>
    function GetObjectDao: TObjectDao; Virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

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

    /// <summary>
    /// Editar o registro caso já existe caso contrario adiciona um novo registro já setendo o valor do campo
    /// </summary>
    /// <example>
    /// FindAddOrEdit('NMUSUARIO', 'Daniel')
    /// </example>
    procedure FindAddOrEdit(const poFieldName: Array of string;
     const poValue: Array of Variant; const pbAutoSave: Boolean = False; const pbIncludeIDOwner: Boolean = True);

    constructor Create(poOwner: TComponent; poObjectDao: TObjectDao = nil);
      Reintroduce; virtual;
    destructor Destroy; override;

    /// <summary>
    /// objeto pai
    /// </summary>
    property ObjectActionOwner: TObjectAction read FObjectActionOwner
      write SetObjectActionOwner;

    /// <summary>
    /// Lista de objetos ação filhos
    /// </summary>
    property ListObjectActionChildren: TListObjectAction
      read FListObjectActionChildren write SetListObjectActionChildren;

    property CanCreateObjectDao: Boolean read FCanCreateObjectDao
      write SetCanCreateObjectDao;

    procedure ConfigureMasterSource(poObjectAction: TObjectAction); overload;
    procedure ConfigureMasterSource(poObjectDao: TObjectDao); overload;
  end;

implementation

{ TObjectAction }

uses uDMUtils, uFactoryObject, uDMException;

procedure TObjectAction.Add;
begin
  FObjectDao.Insert;
end;

procedure TObjectAction.AfterConstruction;
begin
  inherited;
  if Assigned(FObjectActionOwner) then
    ConfigureMasterSource(FObjectActionOwner);
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

procedure TObjectAction.Clear;
begin
  inherited;
  FObjectDao.Clear;
end;

procedure TObjectAction.ConfigureMasterSource(poObjectAction: TObjectAction);
begin
  if assigned(poObjectAction) then
    ConfigureMasterSource(poObjectAction.FObjectDao);
end;

procedure TObjectAction.ConfigureMasterSource(poObjectDao: TObjectDao);
begin
  FObjectDao.ConfigureMasterSource(poObjectDao);
end;

constructor TObjectAction.Create(poOwner: TComponent; poObjectDao: TObjectDao);
begin
  inherited Create(poOwner);
  FObjectDao := poObjectDao;
  FCanCreateObjectDao := not Assigned(FObjectDao);
  FObjectDao := GetObjectDao;
  FListObjectActionChildren := TListObjectAction.Create;

  ObjectActionOwner := nil;
  if Assigned(poOwner) and (poOwner is TObjectAction) then
    ObjectActionOwner := TObjectAction(poOwner);
end;

procedure TObjectAction.Delete;
begin
  FObjectDao.Delete;
end;

destructor TObjectAction.Destroy;
begin
  Cancel;
  FObjectActionOwner := nil;
  TDMUtils.DestroyObject(FListObjectActionChildren);

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
begin
  if (Length(poValue) <> Length(poFieldName)) then
    raise eDataError.Create(sMSG_DataError);

  SetLength(oValue, 0);
  sFieldNames := sCST_EmptyStr;

  if pbIncludeIDOwner then
  begin
    oFieldOwner := FObjectDao.FieldIDOwner;
    if Assigned(oFieldOwner) then
    begin
      sFieldNames := oFieldOwner.FieldName;
      SetLength(oValue, Length(oValue) + 1);
      oValue[Length(oValue) - 1] := oFieldOwner.AsInteger;
    end;
  end;

  for nIndex := 0 to Length(poValue) - 1 do
  begin
    SetLength(oValue, Length(oValue) + 1);
    oValue[Length(oValue) - 1] := poValue[nIndex];
  end;

  for nIndex := 0 to Length(poFieldName) - 1 do
  begin
    TDMUtils.AddIfExistValue(sFieldNames, ';');
    sFieldNames := sFieldNames + poFieldName[nIndex];
  end;

  if FObjectDao.CDSDados.Locate(sFieldNames, varArrayOf(oValue),
    [loCaseInsensitive]) then
    Edit
  else
    Add;

  for nIndex := 0 to Length(poFieldName) - 1 do
  begin
    FObjectDao.CDSDados.FieldByName(poFieldName[nIndex]).AsString :=
      TDMUtils.VarToStr2(poValue[nIndex]);
  end;

  if pbAutoSave then
    Save;
end;

function TObjectAction.GetIdentClass: String;
begin
  Result := Copy(Self.ClassName, Length('TObjectAction') + nCST_One,
    Length(Self.ClassName));
end;

function TObjectAction.GetNameObjectDao: string;
begin
  Result := StringReplace(Self.ClassName, 'ObjectAction', 'ObjectDao',
    [rfReplaceAll]);
end;

function TObjectAction.GetObjectDao: TObjectDao;
begin
  if (not Assigned(FObjectDao)) then
    FObjectDao := TObjectDao(TFactoryObject.CreateComponent
      (GetNameObjectDao, Self));
  Result := FObjectDao;
end;

procedure TObjectAction.Refresh;
begin
  inherited;
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

procedure TObjectAction.SetListObjectActionChildren
  (const Value: TListObjectAction);
begin
  FListObjectActionChildren := Value;
end;

procedure TObjectAction.SetObjectActionOwner(const Value: TObjectAction);
begin
  FObjectActionOwner := Value;
end;

{ TListObjectAction }

function TListObjectAction.Add(poClassAction: TClassObjectAction;
  poOwner: TComponent): TObjectAction;
begin
  Result := TFactoryObject.CreateComponent(poClassAction, poOwner)
    as TObjectAction;
  inherited Add(Result);
end;

constructor TListObjectAction.Create;
begin
  inherited;
end;

destructor TListObjectAction.Destroy;
begin
  inherited;
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

RegisterClass(TObjectAction);

end.
