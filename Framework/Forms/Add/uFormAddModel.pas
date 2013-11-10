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

/// <summary>
/// Form Add
/// </summary>
unit uFormAddModel;

interface

uses
  Classes, Controls, Forms, Dialogs,
  Contnrs, uFormAddModelCustom, uObjectAction, System.SysUtils,
  Menus, StdCtrls, DB, ActnList, Vcl.Buttons, System.Actions, Vcl.ExtCtrls;

type
  TFormAddModel = class;
  TClassFormAddModel = class of TFormAddModel;

  TListFormAdd = Class(TObjectList)
  protected
    function GetItems(Index: Integer): TFormAddModel; Virtual;
    procedure SetItems(Index: Integer; const Value: TFormAddModel); Virtual;
  public
    constructor Create;
    destructor Destroy; Override;

    /// <summary>
    /// Adiciona nova tela
    /// </summary>
    function Add(poClassFormAdd: TClassFormAddModel; poOwner: TComponent = nil): TFormAddModel; overload;
    property Items[Index: Integer]: TFormAddModel read GetItems write SetItems;
  end;

  TFormAddModel = class(TFormAddModelCustom)
    gb_Navegate: TPanel;
    btn_Cancel: TButton;
    btn_Confirm: TButton;
    dsDados: TDataSource;
    procedure ac_ConfirmExecute(Sender: TObject);
    procedure ac_CancelExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ac_RefreshExecute(Sender: TObject);
  private
    FFormAddOwner: TFormAddModel;
    FListFormAddChildren: TListFormAdd;
    procedure SeTFormAddOwner(const Value: TFormAddModel);
    procedure SetCanCreateObjectAction(const Value: Boolean);
    procedure SetListFormAddChildren(const Value: TListFormAdd);
    { Private declarations }
  protected
    FCanCreateObjectAction: Boolean;
    procedure DefineDataSource;
    procedure CloseForm; OVerride;
    function GetNameObjectAction: string; virtual;
  public
    { Public declarations }
    FObjectAction: TObjectAction;

    /// <summary>
    /// Save os dados alterados
    /// </summary>
    procedure Save; override;

    /// <summary>
    /// Atualiza as informações da tela
    /// </summary>
    procedure Refresh; overload;
    procedure BeforeDestruction; override;

    /// <summary>
    /// Retornar o objeto de ação, inicializando a estância caso esteja nil.
    /// </summary>
    function GetObjectAction: TObjectAction; Virtual;
    constructor Create(poOwner: TComponent;
      poObjectAction: TObjectAction = nil); reintroduce;
    procedure AfterConstruction; override;

    procedure ConfigureMasterSource(poObjectAction: TObjectAction); overload;
    procedure ConfigureMasterSource(poFormAddModel: TFormAddModel); overload;

    property FormAddOwner: TFormAddModel read FFormAddOwner
      write SeTFormAddOwner;
    property CanCreateObjectAction: Boolean read FCanCreateObjectAction
      write SetCanCreateObjectAction;
    /// <summary>
    /// Lista de tela de cadastro
    /// </summary>
    property ListFormAddChildren: TListFormAdd read FListFormAddChildren write SetListFormAddChildren;
  end;

implementation

uses uDMUtils, uFactoryObject;

{$R *.dfm}
{ TFormAddModel }

{ TFormAddModel }

procedure TFormAddModel.ac_CancelExecute(Sender: TObject);
begin
  TDMUtils.FocusSet(btn_Cancel);
  inherited;
end;

procedure TFormAddModel.ac_ConfirmExecute(Sender: TObject);
begin
  TDMUtils.FocusSet(btn_Confirm);
  inherited;
end;

procedure TFormAddModel.ac_RefreshExecute(Sender: TObject);
begin
  inherited;
  GetObjectAction.Refresh;
end;

procedure TFormAddModel.AfterConstruction;
begin
  inherited;
  DefineDataSource;
  if Assigned(FFormAddOwner) then
    ConfigureMasterSource(FFormAddOwner);
end;

procedure TFormAddModel.BeforeDestruction;
begin
  if FCanCreateObjectAction then
    TDMUtils.DestroyObject(FObjectAction)
  else
    FObjectAction := nil;
  FormAddOwner := nil;
  TDMUtils.DestroyObject(FListFormAddChildren);
  inherited;
end;

procedure TFormAddModel.CloseForm;
begin
  inherited;
end;

procedure TFormAddModel.ConfigureMasterSource(poObjectAction: TObjectAction);
begin
  FObjectAction.ConfigureMasterSource(poObjectAction);
end;

procedure TFormAddModel.ConfigureMasterSource(poFormAddModel: TFormAddModel);
begin
  if Assigned(poFormAddModel) then
    ConfigureMasterSource(poFormAddModel.FObjectAction);
end;

constructor TFormAddModel.Create(poOwner: TComponent;
  poObjectAction: TObjectAction);
begin
  inherited Create(poOwner);
  FObjectAction := poObjectAction;
  FCanCreateObjectAction := not Assigned(FObjectAction);
  FObjectAction := GetObjectAction;
  FListFormAddChildren := TListFormAdd.Create;
  FormAddOwner := nil;
  if Assigned(poOwner) and (poOwner is TFormAddModel) then
    FormAddOwner := TFormAddModel(poOwner);
end;

procedure TFormAddModel.DefineDataSource;
begin
  dsDados.DataSet := FObjectAction.FObjectDao.CDSDados;
end;

procedure TFormAddModel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FObjectAction) then
    FObjectAction.Cancel;
  inherited;
end;

function TFormAddModel.GetNameObjectAction: string;
begin
  Result := StringReplace(Self.ClassName, 'FormAdd', 'ObjectAction',
    [rfReplaceAll]);
end;

function TFormAddModel.GetObjectAction: TObjectAction;
begin
  if ((not Assigned(FObjectAction)) and (FCanCreateObjectAction)) then
    FObjectAction := TFactoryObject.CreateComponent(GetNameObjectAction, Self)
      as TObjectAction;
  Result := FObjectAction;
end;

procedure TFormAddModel.Refresh;
begin
  inherited;
  FObjectAction.Refresh;
end;

procedure TFormAddModel.Save;
begin
  FObjectAction.Save;
  inherited;
end;

procedure TFormAddModel.SetCanCreateObjectAction(const Value: Boolean);
begin
  FCanCreateObjectAction := Value;
end;

procedure TFormAddModel.SeTFormAddOwner(const Value: TFormAddModel);
begin
  FFormAddOwner := Value;
end;

procedure TFormAddModel.SetListFormAddChildren(const Value: TListFormAdd);
begin
  FListFormAddChildren := Value;
end;

{ TListFormAdd }

function TListFormAdd.Add(poClassFormAdd: TClassFormAddModel; poOwner: TComponent): TFormAddModel;
begin
  Result := TFactoryObject.CreateComponent(poClassFormAdd, poOwner) as TFormAddModel;
  inherited Add(Result);
end;

constructor TListFormAdd.Create;
begin
  inherited;
end;

destructor TListFormAdd.Destroy;
begin

  inherited;
end;

function TListFormAdd.GetItems(Index: Integer): TFormAddModel;
begin
  Result := TFormAddModel(inherited Items[index]);
end;

procedure TListFormAdd.SetItems(Index: Integer; const Value: TFormAddModel);
begin
  inherited Items[Index] := Value;
end;

initialization

RegisterClass(TFormAddModel);

end.
