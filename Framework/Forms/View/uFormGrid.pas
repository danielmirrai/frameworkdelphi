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

unit uFormGrid;

interface

uses
  uDMClasses, Classes, Controls, Forms,
  uFormGridCustom, DB, ActnList, Grids,
  ExtCtrls, Menus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridCustomPopupMenu, cxGridPopupMenu,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, cxGroupBox,
  dxSkinsDefaultPainters, cxPropertiesStore, dxSkinBlue, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinValentine, dxSkinXmas2008Blue;

type
  TFormGrid = class(TFormGridCustom)
    procedure ac_CloseExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TFormGrid.ac_CloseExecute(Sender: TObject);
begin
  inherited;
  //
end;

initialization

DMClasses.RegisterClass(TFormGrid);

end.