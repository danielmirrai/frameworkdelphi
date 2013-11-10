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

unit uFormViewModel;

interface

uses
  Classes, Controls, Forms,
  uFormViewModelCustom, System.SysUtils,
  ActnList, uFormAddModel, DB, System.Actions, Vcl.Grids, Vcl.DBGrids,
  Contnrs, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TFormViewModel = class;
  /// <summary>
  /// Tela de listagem de dados
  /// </summary>
  TClassFormViewModel = class of TFormViewModel;

  TListFormView = Class(TObjectList)
  protected
    function GetItems(Index: Integer): TFormViewModel; Virtual;
    procedure SetItems(Index: Integer; const Value: TFormViewModel); Virtual;
  public
    constructor Create;
    destructor Destroy; Override;

    /// <summary>
    /// Adiciona nova tela
    /// </summary>
    function Add(poClassFormViewModel: TClassFormViewModel; poOwner: TComponent = nil): TFormViewModel; overload;
    property Items[Index: Integer]: TFormViewModel read GetItems write SetItems;
  end;

  TFormViewModel = class(TFormViewModelCustom)
    ac_Add: TAction;
    ac_Edit: TAction;
    btn_Edit: TButton;
    btn_Add: TButton;
    ac_Delete: TAction;
    btnDlete: TButton;
    procedure ac_AddExecute(Sender: TObject);
    procedure ac_EditExecute(Sender: TObject);
    procedure ac_DeleteExecute(Sender: TObject);
    procedure GridDblClick(Sender: TObject);
    procedure dsDadosStateChange(Sender: TObject);
    procedure dsDadosDataChange(Sender: TObject; Field: TField);
    procedure dsDadosUpdateData(Sender: TObject);
    procedure ac_RefreshExecute(Sender: TObject);
  private
    FFormViewOwner: TFormViewModel;
    FListFormViewChildren: TListFormView;
    procedure SetFormViewOwner(const Value: TFormViewModel);
    procedure SetCanCreateFormAddModel(const Value: Boolean);
    procedure SetListFormViewChildren(const Value: TListFormView);
  protected
    FFormAddModel: TFormAddModel;
    FCanCreateFormAddModel: Boolean;
    procedure DefineDataSource; Override;
    function GetNameFormAdd: string; virtual;
    procedure ActiveAction;
  public
    { Public declarations }
    procedure Refresh; overload;

    /// <summary>
    /// Retornar a tela de cadastro, inicializando a estância caso não esteja nil.
    /// </summary>
    function GetFormAddModel: TFormAddModel; Virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    /// <summary>
    /// Cria o tela de listagem
    /// </summary>
    /// <param name="poOwner">
    /// Componente pai
    /// </param>
    /// <param name="poFormAddModel">
    ///
    /// <font style="BACKGROUND-COLOR: #ffffe0">Tela de Cadastro caso já tenha um estância criada, caso não informado a tela de listagem cria a tela de cadastro </font>
    /// </param>
    constructor Create(poOwner: TComponent;
      poFormAddModel: TFormAddModel = nil); reintroduce;

    procedure ConfigureMasterSource(poFormViewModel: TFormViewModel); overload;
    procedure ConfigureMasterSource(poFormAddModel: TFormAddModel); overload;

    property FormViewOwner: TFormViewModel read FFormViewOwner
      write SetFormViewOwner;
    property CanCreateFormAddModel: Boolean read FCanCreateFormAddModel
      write SetCanCreateFormAddModel;
    /// <summary>
    /// Lista de tela de cadastro
    /// </summary>
    property ListFormViewChildren: TListFormView read FListFormViewChildren write SetListFormViewChildren;
  end;

implementation

{$R *.dfm}

uses uDMFileInfoUtils, uConstantUtils, uDMUtils, uFactoryObject;

{ TFormViewModel }

procedure TFormViewModel.ac_DeleteExecute(Sender: TObject);
begin
  inherited;
  FFormAddModel.FObjectAction.Delete;
end;

procedure TFormViewModel.ActiveAction;
var
  bEnabled: Boolean;
begin
  inherited;
  bEnabled := False;
  if Assigned(FFormAddModel) then
    bEnabled := FFormAddModel.FObjectAction.FObjectDao.ExistData;
  ac_Edit.Enabled := bEnabled;
  ac_Delete.Enabled := bEnabled;
end;

procedure TFormViewModel.ac_AddExecute(Sender: TObject);
begin
  inherited;
  FFormAddModel.FObjectAction.Add;
  FFormAddModel.ShowModal;
end;

procedure TFormViewModel.ac_EditExecute(Sender: TObject);
begin
  inherited;
  FFormAddModel.FObjectAction.Edit;
  FFormAddModel.ShowModal;
end;

procedure TFormViewModel.ac_RefreshExecute(Sender: TObject);
begin
  inherited;
  FFormAddModel.Refresh;
end;

procedure TFormViewModel.AfterConstruction;
begin
  inherited;
  if Assigned(FFormViewOwner) then
    ConfigureMasterSource(FFormViewOwner);
end;

procedure TFormViewModel.BeforeDestruction;
begin
  if FCanCreateFormAddModel then
    TDMUtils.DestroyObject(FFormAddModel)
  else
    FFormAddModel := nil;
  FormViewOwner := nil;
  TDMUtils.DestroyObject(FListFormViewChildren);
  inherited;
end;

procedure TFormViewModel.ConfigureMasterSource(poFormViewModel: TFormViewModel);
begin
  if Assigned(poFormViewModel) then
    ConfigureMasterSource(poFormViewModel.FFormAddModel);
end;

procedure TFormViewModel.ConfigureMasterSource(poFormAddModel: TFormAddModel);
begin
  FFormAddModel.ConfigureMasterSource(poFormAddModel);
end;

constructor TFormViewModel.Create(poOwner: TComponent;
  poFormAddModel: TFormAddModel);
begin
  inherited Create(poOwner);
  FFormAddModel := poFormAddModel;
  FCanCreateFormAddModel := not Assigned(FFormAddModel);
  FFormAddModel := GetFormAddModel;
  FListFormViewChildren := TListFormView.Create;

  FormViewOwner := nil;
  if Assigned(poOwner) and (poOwner is TFormViewModel) then
    FormViewOwner := TFormViewModel(poOwner);
end;

procedure TFormViewModel.DefineDataSource;
begin
  DSDados.DataSet := FFormAddModel.FObjectAction.FObjectDao.CDSDados;
  ActiveAction;
end;

procedure TFormViewModel.dsDadosDataChange(Sender: TObject; Field: TField);
begin
  inherited;
  ActiveAction;
end;

procedure TFormViewModel.dsDadosStateChange(Sender: TObject);
begin
  inherited;
  ActiveAction;
end;

procedure TFormViewModel.dsDadosUpdateData(Sender: TObject);
begin
  inherited;
  ActiveAction;
end;

function TFormViewModel.GetFormAddModel: TFormAddModel;
begin
  if (not Assigned(FFormAddModel)) then
    FFormAddModel := TFactoryObject.CreateComponent(GetNameFormAdd)
      as TFormAddModel;

  Result := FFormAddModel;
end;

function TFormViewModel.GetNameFormAdd: string;
begin
  Result := StringReplace(Self.ClassName, 'FormView', 'FormAdd',
    [rfReplaceAll]);
end;

procedure TFormViewModel.GridDblClick(Sender: TObject);
begin
  inherited;
  ac_Edit.Execute;
end;

procedure TFormViewModel.Refresh;
begin
  inherited;
  FFormAddModel.Refresh;
end;

procedure TFormViewModel.SetCanCreateFormAddModel(const Value: Boolean);
begin
  FCanCreateFormAddModel := Value;
end;

procedure TFormViewModel.SetFormViewOwner(const Value: TFormViewModel);
begin
  FFormViewOwner := Value;
end;

procedure TFormViewModel.SetListFormViewChildren(const Value: TListFormView);
begin
  FListFormViewChildren := Value;
end;

{ TListFormView }

function TListFormView.Add(poClassFormViewModel: TClassFormViewModel; poOwner: TComponent): TFormViewModel;
begin
  Result := TFactoryObject.CreateComponent(poClassFormViewModel, poOwner) as TFormViewModel;
  inherited Add(Result);
end;

constructor TListFormView.Create;
begin
  inherited;
end;

destructor TListFormView.Destroy;
begin

  inherited;
end;

function TListFormView.GetItems(Index: Integer): TFormViewModel;
begin
  Result := TFormViewModel(inherited Items[index]);
end;

procedure TListFormView.SetItems(Index: Integer; const Value: TFormViewModel);
begin
  inherited Items[Index] := Value;
end;

initialization

RegisterClass(TFormViewModel);

end.
