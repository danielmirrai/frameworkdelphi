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
unit uObjectActionCustom;

interface

uses
  uObjectDaoCustom, Classes, Contnrs, SysUtils;

type
  TObjectActionCustom = class;
  TClassTObjectActionCustom = class of TObjectActionCustom;

  TListObjectActionCustom = Class(TObjectList)
  private
    FIsObjectLookup: Boolean;
  protected
    function GetIsObjectLookup: Boolean; Virtual;
    procedure SetIsObjectLookup(const Value: Boolean); Virtual;
    function GetItems(Index: Integer): TObjectActionCustom; Virtual;
    procedure SetItems(Index: Integer; const Value: TObjectActionCustom); Virtual;
  public
    FOwner: TComponent;
    constructor Create(AOwner: TComponent); virtual;
    procedure Load; Virtual;
    procedure Assign(Source: TObject;
      const pbClearOldValue: Boolean = true); virtual;
    /// <summary>
    /// Adiciona novo objeto ação
    /// </summary>
    function Add(poClassAction: TClassTObjectActionCustom;
      poOwner: TComponent = nil; const pbAutoLoad: Boolean = True): TObjectActionCustom; overload;
    function Add(poClassAction: TObjectActionCustom)
      : TObjectActionCustom; overload;
    property Items[Index: Integer]: TObjectActionCustom read GetItems
      write SetItems;
    property IsObjectLookup: Boolean read GetIsObjectLookup write SetIsObjectLookup;
  end;

  /// <summary>
  /// Controle ação
  /// </summary>
  /// <remarks>
  /// E desenvolvido todos as implementação de regra de negócio
  /// </remarks>
  TObjectActionCustom = class(TComponent)
  private
    FListObjectActionChildren: TListObjectActionCustom;
    FObjectActionOwner: TObjectActionCustom;
    FCanAutoLoad: Boolean;
    FCanCreateObjectLookup: Boolean;
    FIsObjectLookup: Boolean;
  protected
    function GetIsObjectLookup: Boolean; Virtual;
    procedure SetIsObjectLookup(const Value: Boolean); Virtual;
    procedure SetCanCreateObjectLookup(const Value: Boolean); Virtual;
    function GetCanCreateObjectLookup: Boolean; Virtual;
    procedure SetCanAutoLoad(const Value: Boolean); Virtual;
    function GetCanAutoLoad: Boolean; Virtual;
    procedure SetObjectActionOwner(const Value: TObjectActionCustom); Virtual;
    function GetObjectActionOwner: TObjectActionCustom; Virtual;
    function GetListObjectActionChildren: TListObjectActionCustom; Virtual;
    procedure SetListObjectActionChildren(const Value
      : TListObjectActionCustom); Virtual;
    function GetNewListObjectAction: TListObjectActionCustom; Virtual;
    function GetObjectActionLookup(const poClassObject: TClassTObjectActionCustom): TObjectActionCustom; virtual;
  public
    /// <summary>
    /// Atualiza informações
    /// </summary>
    procedure Refresh; virtual;
    procedure CreateObjectLookup; virtual;

    procedure Assign(Source: TPersistent); overload; Override;
    procedure Assign(Source: TPersistent; const pbClearOldValue: Boolean);
      reintroduce; Overload; virtual;

    destructor Destroy; Override;
    /// <summary>
    /// Limpa variáveis
    /// </summary>
    /// <example>
    /// FNome := '';
    /// </example>
    procedure Clear; Virtual;
    procedure Load(const pbLoadAllChildren: Boolean = true); Virtual;
    function GetTitle: string; virtual;
    constructor Create(poOwner: TComponent); Override;
    procedure AfterConstruction; override;
    /// <summary>
    /// Lista de objetos ação filhos
    /// </summary>
    property ListObjectActionChildren: TListObjectActionCustom
      read GetListObjectActionChildren write SetListObjectActionChildren;

    property ObjectActionOwner: TObjectActionCustom read GetObjectActionOwner
      write SetObjectActionOwner;
    property CanAutoLoad: Boolean read GetCanAutoLoad write SetCanAutoLoad;
    property CanCreateObjectLookup: Boolean read GetCanCreateObjectLookup write SetCanCreateObjectLookup;
    property IsObjectLookup: Boolean read GetIsObjectLookup write SetIsObjectLookup;
  end;

implementation

uses uDMUtils, uFactoryObject;

{ TObjectActionCustom }

procedure TObjectActionCustom.AfterConstruction;
begin
  inherited;
  Clear;
  if CanCreateObjectLookup then
  begin
    ListObjectActionChildren.IsObjectLookup := true;
    CreateObjectLookup;
    ListObjectActionChildren.IsObjectLookup := False;
  end;
end;

procedure TObjectActionCustom.Assign(Source: TPersistent;
  const pbClearOldValue: Boolean);
var
  oObjectAction: TObjectActionCustom;
begin
  if not(Assigned(Source) and (Source is TObjectActionCustom)) then
    Exit;

  oObjectAction := TObjectActionCustom(Source);
  ObjectActionOwner := oObjectAction.ObjectActionOwner;
  FListObjectActionChildren.Assign(oObjectAction.ListObjectActionChildren,
    pbClearOldValue);
end;

procedure TObjectActionCustom.Assign(Source: TPersistent);
begin
  Assign(Source, true);
end;

procedure TObjectActionCustom.Clear;
begin
  Exit;
end;

constructor TObjectActionCustom.Create(poOwner: TComponent);
begin
  IsObjectLookup := False;
  if TDMUtils.IsEmpty(Name) then
    Name := Copy(Self.ClassName, 2, Length(Self.ClassName));
  CanAutoLoad := true;
  CanCreateObjectLookup := False;
  inherited;
  FListObjectActionChildren := GetNewListObjectAction;

  FObjectActionOwner := nil;
  if Assigned(poOwner) and (poOwner is TObjectActionCustom) then
    FObjectActionOwner := TObjectActionCustom(poOwner);
end;

procedure TObjectActionCustom.CreateObjectLookup;
begin
  CanCreateObjectLookup := False;
end;

destructor TObjectActionCustom.Destroy;
begin

  FObjectActionOwner := nil;
  TDMUtils.DestroyObject(FListObjectActionChildren);
  inherited;
end;

function TObjectActionCustom.GetCanAutoLoad: Boolean;
begin
  Result := FCanAutoLoad;
end;

function TObjectActionCustom.GetCanCreateObjectLookup: Boolean;
begin
  Result := FCanCreateObjectLookup;
end;

function TObjectActionCustom.GetIsObjectLookup: Boolean;
begin
  Result := FIsObjectLookup;
end;

function TObjectActionCustom.GetListObjectActionChildren
  : TListObjectActionCustom;
begin
  Result := FListObjectActionChildren;
end;

function TObjectActionCustom.GetNewListObjectAction: TListObjectActionCustom;
begin
  Result := TListObjectActionCustom.Create(Self);
end;

function TObjectActionCustom.GetObjectActionLookup(const poClassObject: TClassTObjectActionCustom): TObjectActionCustom;
begin
  if Assigned(ObjectActionOwner) and (ObjectActionOwner is poClassObject) then
    Result := ObjectActionOwner
  else
    Result := ListObjectActionChildren.Add(poClassObject);
end;

function TObjectActionCustom.GetObjectActionOwner: TObjectActionCustom;
begin
  Result := FObjectActionOwner;
end;

function TObjectActionCustom.GetTitle: string;
begin
  Result := Self.ClassName;
  Result := StringReplace(Result, 'TObjectAction', '',
    [rfReplaceAll, rfIgnoreCase]);
end;

procedure TObjectActionCustom.Load(const pbLoadAllChildren: Boolean);
begin
  if CanAutoLoad and pbLoadAllChildren then
    FListObjectActionChildren.Load;
end;

procedure TObjectActionCustom.Refresh;
begin
  Exit;
end;

procedure TObjectActionCustom.SetCanAutoLoad(const Value: Boolean);
begin
  FCanAutoLoad := Value;
end;

procedure TObjectActionCustom.SetCanCreateObjectLookup(const Value: Boolean);
begin
  FCanCreateObjectLookup := Value;
end;

procedure TObjectActionCustom.SetIsObjectLookup(const Value: Boolean);
begin
  FIsObjectLookup := Value;
end;

procedure TObjectActionCustom.SetListObjectActionChildren
  (const Value: TListObjectActionCustom);
begin
  FListObjectActionChildren := Value;
end;

procedure TObjectActionCustom.SetObjectActionOwner
  (const Value: TObjectActionCustom);
begin
  FObjectActionOwner := Value;
end;

{ TListObjectActionCustom }

function TListObjectActionCustom.Add(poClassAction: TClassTObjectActionCustom;
  poOwner: TComponent; const pbAutoLoad: Boolean): TObjectActionCustom;
var
  oObjectaction: TObjectActionCustom;
begin
  if Assigned(poOwner) and (poOwner is TObjectActionCustom) then
  begin
    oObjectaction := TObjectActionCustom(poOwner);
    if Assigned(oObjectaction.ObjectActionOwner) and (oObjectaction.ObjectActionOwner.ClassType = poClassAction)  then
    begin
      Result := Add(oObjectaction.ObjectActionOwner);
      Exit;
    end;
  end;

  Result := Add(TFactoryObject.CreateComponent(poClassAction, poOwner) as TObjectActionCustom);
  Result.CanAutoLoad := pbAutoLoad;
  Result.IsObjectLookup := IsObjectLookup;
end;

function TListObjectActionCustom.Add(poClassAction: TObjectActionCustom)
  : TObjectActionCustom;
begin
  Result := poClassAction;
  inherited Add(poClassAction);
end;

procedure TListObjectActionCustom.Assign(Source: TObject;
  const pbClearOldValue: Boolean);
var
  nIndex: Integer;
  oListObjectAction: TListObjectActionCustom;
begin
  if not(Assigned(Source) and (Source is TListObjectActionCustom)) then
    Exit;

  oListObjectAction := TListObjectActionCustom(Source);
  if (oListObjectAction.Count <> Self.Count) then
  begin
    if pbClearOldValue then
      Self.Clear;
    for nIndex := 0 to oListObjectAction.Count - 1 do
    begin
      if ((Assigned(FOwner) and (FOwner is TObjectActionCustom) and
        (TObjectActionCustom(FOwner).ObjectActionOwner = Self.Items[nIndex]))
        or (Self.Items[nIndex].IsObjectLookup)) then
        continue;


      Self.Add(TFactoryObject.CloneComponent(oListObjectAction.Items
        [nIndex], FOwner));
    end;
  end
  else
  begin
    for nIndex := 0 to oListObjectAction.Count - 1 do
    begin
      if not Assigned(Self.Items[nIndex]) then
        Continue;

      if ((Assigned(FOwner) and (FOwner is TObjectActionCustom) and
        (TObjectActionCustom(FOwner).ObjectActionOwner = Self.Items[nIndex]))
        or (Self.Items[nIndex].IsObjectLookup)) then
        continue;

      Self.Items[nIndex].Assign(oListObjectAction.Items[nIndex],
        pbClearOldValue);
      if Assigned(FOwner) and (FOwner is TObjectActionCustom) then
        Self.Items[nIndex].ObjectActionOwner := TObjectActionCustom(FOwner);
    end;
  end;
end;

constructor TListObjectActionCustom.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
  FIsObjectLookup := False;

end;

function TListObjectActionCustom.GetIsObjectLookup: Boolean;
begin
  Result := FIsObjectLookup;
end;

function TListObjectActionCustom.GetItems(Index: Integer): TObjectActionCustom;
begin
  Result := TObjectActionCustom(inherited Items[index]);
end;

procedure TListObjectActionCustom.Load;
var
  nIndex: Integer;
begin
  for nIndex := 0 to Self.Count - 1 do
  begin
    if not Assigned(Items[nIndex]) then
      Continue;
    if (Assigned(FOwner) and (FOwner is TObjectActionCustom) and
      ((TObjectActionCustom(FOwner).ObjectActionOwner = Items[nIndex]) or
      (not TObjectActionCustom(FOwner).CanAutoLoad))) then
      Continue;

    if Items[nIndex].CanAutoLoad then
      Items[nIndex].Load;
  end;
end;

procedure TListObjectActionCustom.SetIsObjectLookup(const Value: Boolean);
begin
  FIsObjectLookup := Value;
end;

procedure TListObjectActionCustom.SetItems(Index: Integer;
  const Value: TObjectActionCustom);
begin
  inherited Items[Index] := Value;
end;

initialization

RegisterClass(TObjectActionCustom);

end.
