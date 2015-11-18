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
  Classes, Controls, Forms, uFormViewModelCustom, SysUtils, uObjectAction, ActnList, uFormAddModel, DB,
  uDMClasses, Dialogs, Contnrs, ExtCtrls, StdCtrls, Grids, DBGrids,  Menus, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, cxStyles, dxSkinscxPCPainter, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridCustomPopupMenu,
  cxGridPopupMenu, cxButtons, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGroupBox, cxPropertiesStore, dxSkinsDefaultPainters, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue, uObjectDaoApplication;

type
  TFormViewModel = class;
  /// <summary>
  /// Tela de listagem de dados
  /// </summary>
  TClassFormViewModel = class of TFormViewModel;

  TListFormView = Class(TListFormViewModelCustom)
  protected
    function GetItems(Index: Integer): TFormViewModel; reintroduce;
    procedure SetItems(Index: Integer; const Value: TFormViewModel); reintroduce;
  public
    /// <summary>
    /// Adiciona nova tela
    /// </summary>
    function Add(poClassFormViewModel: TClassFormViewModel; poOwner: TComponent = nil): TFormViewModel; overload;
    function Add(poFormViewModel: TFormViewModel): TFormViewModel; Overload; Virtual;
    property Items[Index: Integer]: TFormViewModel read GetItems write SetItems;
  end;

  TFormViewModel = class(TFormViewModelCustom)
    ac_Add: TAction;
    ac_Edit: TAction;
    ac_Delete: TAction;
    ac_DeleteAll: TAction;
    mniDeleteAll: TMenuItem;
    btnDelete: TcxButton;
    btn_Select: TcxButton;
    ac_SelectAll: TAction;
    ac_SelectNone: TAction;
    ac_SelectItem: TAction;
    procedure ac_AddExecute(Sender: TObject);
    procedure ac_EditExecute(Sender: TObject);
    procedure ac_DeleteExecute(Sender: TObject);
    procedure dsDadosStateChange(Sender: TObject);
    procedure dsDadosDataChange(Sender: TObject; Field: TField);
    procedure dsDadosUpdateData(Sender: TObject);
    procedure ac_DeleteAllExecute(Sender: TObject);
    procedure ac_SelectItemExecute(Sender: TObject);
    procedure cxDBTableGridViewDblClick(Sender: TObject);
  private
    FFormViewOwner: TFormViewModel;
    FListFormViewChildren: TListFormView;
    FSelectModel: Boolean;
    FCanMultiSelect: Boolean;
    FCanCreateFormAddModel: Boolean;
  protected

    procedure Edit; virtual;
    function GetNewListFormViewChildren: TListFormViewModelCustom; Override;
    function GetListFormViewChildren: TListFormView; reintroduce; virtual;
    procedure SetListFormViewChildren(const Value: TListFormView); reintroduce; virtual;
    procedure SetFormViewOwner(const Value: TFormViewModel); virtual;
    procedure SetCanCreateFormAddModel(const Value: Boolean); virtual;
    procedure SetCanMultiSelect(const Value: Boolean); virtual;
    function GetCanMultiSelect: Boolean; virtual;
    procedure SetSelectModel(const Value: Boolean); virtual;
    procedure DefineDataSource; Override;
    function GetSelectModel: Boolean; virtual;
    function GetNameFormAdd: string; virtual;
    procedure ActiveAction(const pbActive: Boolean); Override;
  public
    { Public declarations }
    FFormAddModel: TFormAddModel;


    procedure Assign(Source: TPersistent; const pbClearOldValue: Boolean); Override;
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
      poFormAddModel: TFormAddModel = nil); reintroduce; virtual;

    /// <summary>
    /// Lista de tela de cadastro
    /// </summary>
    property ListFormViewChildren: TListFormView read GetListFormViewChildren write SetListFormViewChildren;
    procedure ConfigureMasterSource(poFormViewModel: TFormViewModel); overload;
    procedure ConfigureMasterSource(poFormAddModel: TFormAddModel); overload;

    property FormViewOwner: TFormViewModel read FFormViewOwner
      write SetFormViewOwner;
    property CanCreateFormAddModel: Boolean read FCanCreateFormAddModel
      write SetCanCreateFormAddModel default True;
    property SelectModel: Boolean read GetSelectModel write SetSelectModel;
    property CanMultiSelect: Boolean read GetCanMultiSelect write SetCanMultiSelect default False;
  end;

implementation

{$R *.dfm}

uses uDMFileInfoUtils, uConstantUtils, uDMUtils, uFactoryObject;

{ TFormViewModel }

procedure TFormViewModel.ac_DeleteAllExecute(Sender: TObject);
begin
  inherited;
  FFormAddModel.FObjectAction.DeleteAll;
end;

procedure TFormViewModel.ac_DeleteExecute(Sender: TObject);
begin
  inherited;
  FFormAddModel.FObjectAction.Delete;
end;

procedure TFormViewModel.ActiveAction(const pbActive: Boolean);
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
  Edit;
end;

procedure TFormViewModel.ac_SelectItemExecute(Sender: TObject);
begin
  inherited;
  Self.ModalResult := mrOk;
end;

procedure TFormViewModel.AfterConstruction;
begin
  inherited;
end;

procedure TFormViewModel.Assign(Source: TPersistent; const pbClearOldValue: Boolean);
var
  oFormModelCustom: TFormViewModel;
begin
  inherited Assign(Source);
  if not(Assigned(Source) and (Source is TFormViewModel)) then
    Exit;

  oFormModelCustom := TFormViewModel(Source);
  FFormViewOwner := oFormModelCustom.FFormViewOwner;
  FListFormViewChildren.Assign(oFormModelCustom.FListFormViewChildren);
  FSelectModel := oFormModelCustom.FSelectModel;
  FCanMultiSelect := oFormModelCustom.FCanMultiSelect;
  FCanCreateFormAddModel := oFormModelCustom.FCanCreateFormAddModel;
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

  FSelectModel := False;
  FCanMultiSelect := False;
  FFormAddModel := poFormAddModel;
  FCanCreateFormAddModel := not Assigned(FFormAddModel);
  FFormAddModel := GetFormAddModel;

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

function TFormViewModel.GetCanMultiSelect: Boolean;
begin
  Result := FCanMultiSelect;
end;

function TFormViewModel.GetFormAddModel: TFormAddModel;
begin
  if (not Assigned(FFormAddModel)) then
    FFormAddModel := TFactoryObject.CreateComponent(GetNameFormAdd)
      as TFormAddModel;

  Result := FFormAddModel;
end;

function TFormViewModel.GetListFormViewChildren: TListFormView;
begin
  Result := TListFormView(inherited GetListFormViewChildren);
end;

function TFormViewModel.GetNameFormAdd: string;
begin
  Result := TFactoryObject.GetNameFormAdd(Self.ClassName);
end;

function TFormViewModel.GetNewListFormViewChildren: TListFormViewModelCustom;
begin
  Result := TListFormView.Create(Self);
end;

function TFormViewModel.GetSelectModel: Boolean;
begin
  Result := FSelectModel;
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

procedure TFormViewModel.SetCanMultiSelect(const Value: Boolean);
begin
  FCanMultiSelect := Value;
end;

procedure TFormViewModel.SetFormViewOwner(const Value: TFormViewModel);
begin
  FFormViewOwner := Value;
  if Assigned(FFormViewOwner) then
  begin
    FFormAddModel.FormAddOwner := FFormViewOwner.FFormAddModel;
    ConfigureMasterSource(FFormViewOwner);
  end
end;

procedure TFormViewModel.SetListFormViewChildren(const Value: TListFormView);
begin
  FListFormViewChildren := Value;
end;

procedure TFormViewModel.SetSelectModel(const Value: Boolean);
begin
  FSelectModel := Value;
  if Assigned(ac_SelectItem) then
  begin
    ac_SelectItem.Visible := FSelectModel;
    ac_SelectItem.Enabled := FSelectModel;
  end;
  if FSelectModel then
    btn_Select.Width := 105;
end;

procedure TFormViewModel.Edit;
begin
  FFormAddModel.FObjectAction.Edit;
  FFormAddModel.ShowModal;
end;

{ TListFormView }

function TListFormView.Add(poClassFormViewModel: TClassFormViewModel;
  poOwner: TComponent): TFormViewModel;
begin
  Result := TFactoryObject.CreateComponent(poClassFormViewModel, poOwner)
    as TFormViewModel;
  inherited Add(Result);
end;


function TListFormView.Add(poFormViewModel: TFormViewModel): TFormViewModel;
begin
  Result := TFormViewModel(inherited Add(poFormViewModel));
end;

function TListFormView.GetItems(Index: Integer): TFormViewModel;
begin
  Result := TFormViewModel(inherited Items[index]);
end;

procedure TListFormView.SetItems(Index: Integer; const Value: TFormViewModel);
begin
  inherited Items[Index] := Value;
end;

procedure TFormViewModel.cxDBTableGridViewDblClick(Sender: TObject);
begin
  inherited;
  if ac_SelectItem.Enabled then
    ac_SelectItem.Execute
  else
    ac_Edit.Execute;
end;

initialization
 DMClasses.RegisterClass(TFormViewModel);

end.