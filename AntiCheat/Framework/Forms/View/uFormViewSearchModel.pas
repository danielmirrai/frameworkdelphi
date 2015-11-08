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

unit uFormViewSearchModel;

interface

uses
  Classes, Controls, Forms, uFormAddModel, uFormViewModel,
  uFormViewSearchModelCustom, SysUtils,
  uObjectAction, DB, ActnList, StdCtrls, Grids,
  DBGrids, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinsDefaultPainters, Menus, cxClasses, cxPropertiesStore, cxButtons,
  cxGroupBox, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TClassFormViewSearchModel = class of TFormViewSearchModel;
  TFormViewSearchModel = class(TFormViewSearchModelCustom)
    procedure ac_CloseExecute(Sender: TObject);
  private
    { Private declarations }
  protected
    FCreateObjectAction: Boolean;
    procedure DefineDataSource; override;
    function GetNameObjectAction: string; virtual;
    procedure SelectItem; Override;
  public
    { Public declarations }
    FObjectAction: TObjectAction;
    FNamePrefix: String;
    function GetObjectAction: TObjectAction; virtual;
    procedure Refresh; Override;

    constructor Create(poOwner: TComponent; const psNamePrefix: String; poFormView: TFormViewModel); reintroduce; Overload;
    constructor Create(poOwner: TComponent; const psNamePrefix: String; poFormAdd: TFormAddModel); reintroduce; Overload;
    constructor Create(poOwner: TComponent; const psNamePrefix: String; poObjectAction: TObjectAction = nil); reintroduce; Overload;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

{$R *.dfm}

uses uDMUtils, uFactoryObject, uConstantUtils;

{ TFormViewSearchModel }

procedure TFormViewSearchModel.ac_CloseExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFormViewSearchModel.AfterConstruction;
begin
  inherited;
end;

procedure TFormViewSearchModel.BeforeDestruction;
begin
  if FCreateObjectAction then
    TDMUtils.DestroyObject(FObjectAction)
  else
    FObjectAction := nil;
  inherited;
end;


constructor TFormViewSearchModel.Create(poOwner: TComponent; const psNamePrefix: String; poFormAdd: TFormAddModel);
var
  oObjectAction: TObjectAction;
begin
  oObjectAction := nil;
  if Assigned(poFormAdd) then
    oObjectAction := poFormAdd.FObjectAction;
  Create(poOwner, psNamePrefix, oObjectAction);
end;

constructor TFormViewSearchModel.Create(poOwner: TComponent; const psNamePrefix: String; poFormView: TFormViewModel);
var
  oFormAddModel: TFormAddModel;
begin
  oFormAddModel := nil;
  if Assigned(poFormView) then
    oFormAddModel := poFormView.FFormAddModel;
  Create(poOwner, psNamePrefix, oFormAddModel);
end;

constructor TFormViewSearchModel.Create(poOwner: TComponent; const psNamePrefix: String; poObjectAction: TObjectAction);
begin
  inherited Create(poOwner);
  FObjectAction := poObjectAction;
  FNamePrefix := psNamePrefix;
  if Assigned(poObjectAction) then
    FNamePrefix := copy(poObjectAction.ClassName, Length(TObjectAction.ClassName), Length(poObjectAction.ClassName));
  FNamePrefix := StringReplace(FNamePrefix, 'TObjectAction', sCST_EmptyStr, [rfReplaceAll]);
  FCreateObjectAction := not Assigned(FObjectAction);
  FObjectAction := GetObjectAction;
end;

procedure TFormViewSearchModel.DefineDataSource;
begin
  inherited;
  dsDados.DataSet := FObjectAction.GetObjectDao.CDSDados;
end;

function TFormViewSearchModel.GetNameObjectAction: string;
begin
  Result := 'TObjectAction' + FNamePrefix;
end;

function TFormViewSearchModel.GetObjectAction: TObjectAction;
begin
  if ((not Assigned(FObjectAction)) and (FCreateObjectAction)) then
    FObjectAction := TFactoryObject.CreateComponent(GetNameObjectAction, Self)
      as TObjectAction;

  Result := FObjectAction;
end;

procedure TFormViewSearchModel.Refresh;
begin
  if Assigned(FObjectAction) then
    FObjectAction.Refresh;
  inherited;
end;

procedure TFormViewSearchModel.SelectItem;
begin
  inherited;
  close;
end;

initialization

RegisterClass(TFormViewSearchModel);

end.
