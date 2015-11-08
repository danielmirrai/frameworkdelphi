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

unit uFormViewModelCustom;

interface

uses
  Classes, Controls, Forms, DB, uFormAddModelCustom, uFormGrid, StdCtrls,
  SysUtils, uObjectDaoApplication,
   Contnrs, ActnList, Grids, DBGrids, ExtCtrls, Menus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, cxStyles, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGroupBox, cxButtons;

type
  TFormViewModelCustom = class;
  /// <summary>
  /// Tela de listagem de dados
  /// </summary>
  TClassFormViewModelCustom = class of TFormViewModelCustom;
  TListFormViewModelCustom = Class(TObjectList)
  protected
    function GetItems(Index: Integer): TFormViewModelCustom; Virtual;
    procedure SetItems(Index: Integer; const Value: TFormViewModelCustom); Virtual;
  public
    FOwner: TComponent;

    constructor Create(AOwner: TComponent); virtual;
    procedure Assign(Source: TObject; const pbClearOldValue: Boolean = true); virtual;
    /// <summary>
    /// Adiciona nova tela
    /// </summary>
    function Add(poClassFormViewModel: TClassFormViewModelCustom;
      poOwner: TComponent = nil): TFormViewModelCustom; overload; Virtual;
    function Add(poFormViewModel: TFormViewModelCustom): TFormViewModelCustom; Overload; Virtual;
    property Items[Index: Integer]: TFormViewModelCustom read GetItems write SetItems;
  end;

  TFormViewModelCustom = class(TFormGrid)
    ac_OpenView: TAction;
    btn_Close: TcxButton;
    cxGroupBox1: TcxGroupBox;
    procedure ac_OpenViewExecute(Sender: TObject);
  private
    FListFormViewChildren: TListFormViewModelCustom;
    procedure SetListFormViewChildren(const Value: TListFormViewModelCustom);
  protected
    { Private declarations }
    function GetListFormViewChildren: TListFormViewModelCustom;Virtual;
    function GetNewListFormViewChildren: TListFormViewModelCustom; Virtual;
    class function FormatNameFormView(const psName: String): string;
    procedure SetTitle; virtual;
  public
    { Public declarations }
    procedure AfterConstruction; override;
    constructor Create(poOwner: TComponent); Override;
    /// <summary>
    /// Lista de tela de cadastro
    /// </summary>
    property ListFormViewChildren: TListFormViewModelCustom read GetListFormViewChildren
      write SetListFormViewChildren;
    class procedure OpenView(Sender: TObject; poOwner: TComponent = nil; poChild: TObject = nil); Overload;
    class procedure OpenView(poOwner: TComponent = nil; poChild: TObject = nil); Overload;
  end;

implementation

uses uDMUtils, uFactoryObject;

{$R *.dfm}
{ TFormViewModelCustom }

procedure TFormViewModelCustom.ac_OpenViewExecute(Sender: TObject);
begin
  TFormViewModelCustom.OpenView(Sender, Self);
end;

procedure TFormViewModelCustom.AfterConstruction;
begin
  inherited;
  CreateColumns;
  SetTitle;
end;

constructor TFormViewModelCustom.Create(poOwner: TComponent);
begin
  inherited Create(poOwner);
  FListFormViewChildren := GetNewListFormViewChildren;
end;

class function TFormViewModelCustom.FormatNameFormView(const psName: String): string;
begin
  Result := StringReplace(psName, 'ac_', 'TFormView', [rfReplaceAll]);
  Result := StringReplace(Result, 'ac', 'TFormView', [rfReplaceAll]);
end;


function TFormViewModelCustom.GetListFormViewChildren: TListFormViewModelCustom;
begin
  Result := FListFormViewChildren;
end;

function TFormViewModelCustom.GetNewListFormViewChildren: TListFormViewModelCustom;
begin
  Result := TListFormViewModelCustom.Create(Self);
end;

class procedure TFormViewModelCustom.OpenView(Sender: TObject;
  poOwner: TComponent; poChild: TObject);
var
  FFormViewModelCustom: TFormViewModelCustom;
  sName: string;
begin
  sName := FormatNameFormView(TAction(Sender).Name);
  FFormViewModelCustom := TFactoryObject.CreateComponent(sName, poOwner,
    poChild) as TFormViewModelCustom;
  try
    FFormViewModelCustom.ShowModal;
  finally
    TDMUtils.DestroyObject(FFormViewModelCustom);
  end;
end;


class procedure TFormViewModelCustom.OpenView(poOwner: TComponent = nil; poChild: TObject = nil);
var
  FFormViewModelCustom: TFormViewModelCustom;
begin
  FFormViewModelCustom := TFactoryObject.CreateComponent(Self.ClassName, poOwner,
    poChild) as TFormViewModelCustom;
  try
    FFormViewModelCustom.ShowModal;
  finally
    TDMUtils.DestroyObject(FFormViewModelCustom);
  end;
end;

procedure TFormViewModelCustom.SetListFormViewChildren(const Value: TListFormViewModelCustom);
begin
  FListFormViewChildren := Value;
end;

procedure TFormViewModelCustom.SetTitle;
begin
  gb_Dados.Caption := Self.Caption;
end;

{ TListFormViewModelCustom }

function TListFormViewModelCustom.Add(poClassFormViewModel: TClassFormViewModelCustom; poOwner: TComponent): TFormViewModelCustom;
begin
  Result := TFactoryObject.CreateComponent(poClassFormViewModel, poOwner)
    as TFormViewModelCustom;
  inherited Add(Result);
end;

function TListFormViewModelCustom.Add(poFormViewModel: TFormViewModelCustom): TFormViewModelCustom;
begin
  inherited Add(poFormViewModel);
  Result := poFormViewModel;
end;

procedure TListFormViewModelCustom.Assign(Source: TObject; const pbClearOldValue: Boolean);
var
  nIndex: Integer;
  oListObjectAction: TListFormViewModelCustom;
begin
  if not(Assigned(Source) and (Source is TListFormViewModelCustom)) then
    Exit;

  oListObjectAction := TListFormViewModelCustom(Source);
  if (oListObjectAction.Count <> Self.Count) then
  begin
    if pbClearOldValue then
      Self.Clear;
    for nIndex := 0 to oListObjectAction.count - 1 do
    begin
      Self.Add(TFactoryObject.CloneComponent(oListObjectAction.Items[nIndex], FOwner));
    end;
  end
  else
  begin
    for nIndex := 0 to oListObjectAction.count - 1 do
    begin
      if not Assigned(Self.Items[nIndex]) then
        Continue;
      Self.Items[nIndex].Assign(oListObjectAction.Items[nIndex], pbClearOldValue);
    end;
  end;
end;


constructor TListFormViewModelCustom.Create(AOwner: TComponent);
begin
  Fowner := aOWner;
end;

function TListFormViewModelCustom.GetItems(Index: Integer): TFormViewModelCustom;
begin
  Result := TFormViewModelCustom(inherited Items[index]);
end;

procedure TListFormViewModelCustom.SetItems(Index: Integer; const Value: TFormViewModelCustom);
begin
  inherited Items[Index] := Value;
end;

initialization

RegisterClass(TFormViewModelCustom);

end.
