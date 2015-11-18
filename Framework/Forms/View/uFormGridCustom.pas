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

unit uFormGridCustom;

interface

uses
  uDMClasses, Classes, Controls, Forms, uDMUtilsdao,
  uFormModel,
  DB, ActnList, StdCtrls, Grids,
  ExtCtrls, Menus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  cxGroupBox, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGridCustomPopupMenu, cxGridPopupMenu, cxInplaceContainer, cxVGrid, cxOI,
  dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg, dxBkgnd, dxWrap, dxPrnDev,
  dxPSCompsProvider, dxPSFillPatterns, dxPSEdgePatterns, dxPSPDFExportCore,
  dxPSPDFExport, cxDrawTextUtils, dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon,
  dxPScxEditorProducers, dxPScxExtEditorProducers,
  dxPScxPageControlProducer, dxSkinsdxBarPainter, dxPSCore, dxPgsDlg,
  cxPropertiesStore, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue;

type
  TFormGridCustom = class(TFormModel)
    dsDados: TDataSource;
    pmGrid: TPopupMenu;
    cxDBTableGridView: TcxGridDBTableView;
    cxLevelGridViewLevel1: TcxGridLevel;
    cxgridView: TcxGrid;
    cxPopup: TcxGridPopupMenu;
    procedure ac_CloseExecute(Sender: TObject);
  protected
    { Private declarations }
    procedure DefineDataSource; virtual; abstract;
    procedure CreateColumns; virtual;
    procedure DefinePropertiesStore; override;
    procedure FooterGrid;
    procedure ActiveAction(const pbActive: BOolean); Overload; Virtual;
    procedure ActiveAction; Overload; Virtual;
  public
    { Public declarations }
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

{$R *.dfm}

uses uDMUtils;
{ TFormViewModelCustom }

procedure TFormGridCustom.ActiveAction(const pbActive: BOolean);
begin

end;

procedure TFormGridCustom.ActiveAction;
begin
  ActiveAction(TDMUtils.ExistValue(dsDados.DataSet));
end;

procedure TFormGridCustom.ac_CloseExecute(Sender: TObject);
begin
  inherited;
  //
end;

procedure TFormGridCustom.AfterConstruction;
begin
  inherited;
  DefineDataSource;
end;

procedure TFormGridCustom.BeforeDestruction;
begin
  inherited;
end;

procedure TFormGridCustom.CreateColumns;
var
  nIndex: Integer;
begin                         
  if TDMUtils.IsEmpty(cxDBTableGridView.ColumnCount) then
  begin
    cxDBTableGridView.DataController.CreateAllItems();

    for nIndex := 0 to cxDBTableGridView.ColumnCount - 1 do
    begin
      if cxDBTableGridView.Columns[nIndex].Width > 100 then
        cxDBTableGridView.Columns[nIndex].Width := 100;
    end;
  end;
  DefinePropertiesStore;
end;

procedure TFormGridCustom.DefinePropertiesStore;
  var
  vIndex: Integer;
  vComponent: TcxPropertiesStoreComponent;
  vView: TcxGridDBTableView;
begin
  cxPropertiesStore.Components.BeginUpdate;
  try
    vView := cxDBTableGridView;

    for vIndex := 0 to vView.ColumnCount - 1 do
    begin
      vComponent := TcxPropertiesStoreComponent(cxPropertiesStore.Components.Add);
      vComponent.Component := vView.Columns[vIndex];
      vComponent.Properties.Add('Width');
      vComponent.Properties.Add('Visible');
      vComponent.Properties.Add('SortIndex');
      vComponent.Properties.Add('SortOrder');
      vComponent.Properties.Add('GroupIndex');
    end;
  finally
    cxPropertiesStore.Components.EndUpdate;
  end;
  FooterGrid;
  inherited;
end;

procedure TFormGridCustom.FooterGrid;
begin
  //vItem := GridDBTableView_Dados.DataController.Summary.FooterSummaryItems[0];
end;

initialization

DMClasses.RegisterClass(TFormGridCustom);

end.