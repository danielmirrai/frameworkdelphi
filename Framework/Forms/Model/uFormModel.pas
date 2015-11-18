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

unit uFormModel;

interface

uses
  uDMClasses, Messages, Classes, Controls, Forms,
  uFormModelCustom, ActnList, StdCtrls, ExtCtrls,
  Mask, DBCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxGroupBox, cxPropertiesStore;

type
  TClassFormModel = Class of TFormModel;

  TFormModel = class(TFormModelCustom)
    ActionList: TActionList;
    ac_Close: TAction;
    gb_Dados: TcxGroupBox;
    ac_Refresh: TAction;
    cxPropertiesStore: TcxPropertiesStore;
    procedure ac_CloseExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ac_RefreshExecute(Sender: TObject);
  public
    { Public declarations }
    procedure Refresh; Virtual;
  end;

implementation

{$R *.dfm}

procedure TFormModel.ac_CloseExecute(Sender: TObject);
begin
  inherited;
  ac_Close.Enabled := False;
  try
    Self.Close;
  finally
    ac_Close.Enabled := true;
  end;
end;

procedure TFormModel.ac_RefreshExecute(Sender: TObject);
begin
  inherited;
  Refresh;
end;

procedure TFormModel.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
  begin
    Key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end
  else
    inherited;
end;

procedure TFormModel.FormShow(Sender: TObject);
begin
  inherited;
  ac_Refresh.Execute;
end;

procedure TFormModel.Refresh;
begin

end;

initialization

DMClasses.RegisterClass(TFormModel);

end.