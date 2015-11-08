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
  uFormViewModelCustom, SysUtils,
  ActnList, uFormAddModel, DB, Grids, DBGrids,
  Contnrs, ExtCtrls,
  StdCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinsDefaultPainters,
  Menus, cxClasses, cxPropertiesStore, cxButtons, cxGroupBox, cxStyles,
  dxSkinscxPCPainter, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxNavigator, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

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
    /// <summary>
    /// Adiciona nova tela
    /// </summary>
    function Add(poClassFormViewModel: TClassFormViewModel; poOwner: TComponent = nil): TFormViewModel; overload;
    property Items[Index: Integer]: TFormViewModel read GetItems write SetItems;
  end;

  TFormViewModel = class(TFormViewModelCustom)
    ac_Add: TAction;
    ac_Edit: TAction;
    btn_Edit: TcxButton;
    btn_Add: TcxButton;
    ac_Delete: TAction;
    btnDlete: TcxButton;
    procedure ac_AddExecute(Sender: TObject);
    procedure ac_EditExecute(Sender: TObject);
    procedure ac_DeleteExecute(Sender: TObject);
    procedure dsDadosStateChange(Sender: TObject);
    procedure dsDadosDataChange(Sender: TObject; Field: TField);
    procedure dsDadosUpdateData(Sender: TObject);
    procedure GridDBTableView_DadosDblClick(Sender: TObject);
  private
    FFormViewOwner: TFormViewModel;
    FListFormViewChildren: TListFormView;
    procedure SetFormViewOwner(const Value: TFormViewModel);
    procedure SetCanCreateFormAddModel(const Value: Boolean);
    procedure SetListFormViewChildren(const Value: TListFormView);
  protected
    FCanCreateFormAddModel: Boolean;
    procedure DefineDataSource; Override;
    function GetNameFormAdd: string; virtual;
    procedure ActiveAction(const pbActive: BOolean); Override;
  public
    { Public declarations }
    FFormAddModel: TFormAddModel;

    /// <summary>
    /// Retornar a tela de cadastro, inicializando a estância caso não esteja nil.
    /// </summary>
    function GetFormAddModel: TFormAddModel; Virtual;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    procedure Refresh; Override;

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

procedure TFormViewModel.ActiveAction(const pbActive: BOolean);
begin
  inherited;
  ac_Edit.Enabled := pbActive;
  ac_Delete.Enabled := pbActive;
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

procedure TFormViewModel.Refresh;
begin
  inherited;
  if Assigned(FFormAddModel) then
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

function TListFormView.GetItems(Index: Integer): TFormViewModel;
begin
  Result := TFormViewModel(inherited Items[index]);
end;

procedure TListFormView.SetItems(Index: Integer; const Value: TFormViewModel);
begin
  inherited Items[Index] := Value;
end;

procedure TFormViewModel.GridDBTableView_DadosDblClick(Sender: TObject);
begin
  inherited;
  ac_Edit.Execute;
end;

initialization

RegisterClass(TFormViewModel);

end.
