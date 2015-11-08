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
  Contnrs, uFormAddModelCustom, uObjectAction, SysUtils,
  Menus, StdCtrls, DB, ActnList, Buttons, ExtCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, cxButtons, cxGroupBox, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxPropertiesStore;

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
    procedure Assign(Source: TObject; const pbClearOldValue: Boolean = true); virtual;

    /// <summary>
    /// Adiciona nova tela
    /// </summary>
    function Add(poClassFormAdd: TClassFormAddModel; poOwner: TComponent = nil)
      : TFormAddModel; overload;
    property Items[Index: Integer]: TFormAddModel read GetItems write SetItems;
  end;

  TFormAddModel = class(TFormAddModelCustom)
    gb_Navegate: TcxGroupBox;
    btn_Cancel: TcxButton;
    btn_Confirm: TcxButton;
    dsDados: TDataSource;
    procedure ac_ConfirmExecute(Sender: TObject);
    procedure ac_CancelExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FFormAddOwner: TFormAddModel;
    FListFormAddChildren: TListFormAdd;
    { Private declarations }
  protected
    FCanCreateObjectAction: Boolean;
    procedure SeTFormAddOwner(const Value: TFormAddModel); virtual;
    procedure SetCanCreateObjectAction(const Value: Boolean); virtual;
    procedure SetListFormAddChildren(const Value: TListFormAdd); virtual;
    function GetNewListFormAdd: TListFormAdd; virtual;
    procedure DefineDataSource; virtual;
    procedure CloseForm; OVerride;
    function GetNameObjectAction: string; virtual;
  public
    { Public declarations }
    FObjectAction: TObjectAction;


    procedure Assign(Source: TPersistent; const pbClearOldValue: Boolean); Override;
    /// <summary>
    /// Save os dados alterados
    /// </summary>
    procedure Save; override;

    procedure Refresh; Override;
    procedure BeforeDestruction; override;

    /// <summary>
    /// Retornar o objeto de ação, inicializando a estância caso esteja nil.
    /// </summary>
    function GetObjectAction: TObjectAction; Virtual;
    constructor Create(poOwner: TComponent;
      poObjectAction: TObjectAction = nil); reintroduce; virtual;
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
    property ListFormAddChildren: TListFormAdd read FListFormAddChildren
      write SetListFormAddChildren;
  end;

implementation

uses uDMUtils, uFactoryObject, uFormViewModelCustom;

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

procedure TFormAddModel.AfterConstruction;
begin
  FObjectAction.CanCreateObjectLookup := True;
  FObjectAction.ListObjectActionChildren.IsObjectLookup := true;
  FObjectAction.CreateObjectLookup;
  FObjectAction.ListObjectActionChildren.IsObjectLookup := False;
  inherited;
  DefineDataSource;
end;

procedure TFormAddModel.Assign(Source: TPersistent; const pbClearOldValue: Boolean);
var
  oFormModelCustom: TFormAddModel;
begin
  inherited Assign(Source);
  if not(Assigned(Source) and (Source is TFormAddModel)) then
    Exit;

  oFormModelCustom := TFormAddModel(Source);
  FFormAddOwner := oFormModelCustom.FFormAddOwner;
  FObjectAction.Assign(oFormModelCustom.FObjectAction, pbClearOldValue);
  FCanCreateObjectAction := oFormModelCustom.FCanCreateObjectAction;
  FListFormAddChildren.Assign(oFormModelCustom.FListFormAddChildren, pbClearOldValue);
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

function TFormAddModel.GetNewListFormAdd: TListFormAdd;
begin
  Result := TListFormAdd.Create;
end;

constructor TFormAddModel.Create(poOwner: TComponent;
  poObjectAction: TObjectAction);
var
  bOldCanAutoLoad: Boolean;
begin
  inherited Create(poOwner);
  FObjectAction := poObjectAction;
  FCanCreateObjectAction := not Assigned(FObjectAction);
  FObjectAction := GetObjectAction;

  if ((not FObjectAction.CanAutoLoad) or
    (FCanCreateObjectAction and CanCreateObjectAction)) then
  begin
    bOldCanAutoLoad := FObjectAction.CanAutoLoad;
    try
      FObjectAction.CanAutoLoad := True;
      FObjectAction.Load;
    finally
      FObjectAction.CanAutoLoad := bOldCanAutoLoad;
    end;
  end;
  FListFormAddChildren := GetNewListFormAdd;
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
  Result := TFactoryObject.GetNameObjectAction(Self.ClassName);
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
  if Assigned(FObjectAction) then
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
  if Assigned(FFormAddOwner) then
  begin
    FObjectAction.ObjectActionOwner := FFormAddOwner.FObjectAction;
    ConfigureMasterSource(FFormAddOwner);
  end;
end;

procedure TFormAddModel.SetListFormAddChildren(const Value: TListFormAdd);
begin
  FListFormAddChildren := Value;
end;

{ TListFormAdd }

function TListFormAdd.Add(poClassFormAdd: TClassFormAddModel;
  poOwner: TComponent): TFormAddModel;
begin
  Result := TFactoryObject.CreateComponent(poClassFormAdd, poOwner)
    as TFormAddModel;
  inherited Add(Result);
end;

procedure TListFormAdd.Assign(Source: TObject; const pbClearOldValue: Boolean);
begin

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
