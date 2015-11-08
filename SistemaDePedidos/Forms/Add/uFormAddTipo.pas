unit uFormAddTipo;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  uConstantTipo, Dialogs, uFormAddModel, uObjectActionTipo, StdCtrls, ExtCtrls,
  DB, ActnList, DBCtrls, Classes, Mask, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver, dxSkinSpringTime,
  dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, Menus, cxTextEdit, cxDBEdit,
  cxPropertiesStore, cxButtons, cxGroupBox;

type
  TFormAddTipo = Class(TFormAddModel)
    lblCodigo: TLabel;
    dbedtCodigo: TcxDBTextEdit;
    lblDesc: TLabel;
    dbedtDesc: TcxDBTextEdit;
    dbchkAtivo: TDBCheckBox;
  public
    FObjectActionTipo: TObjectActionTipo;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDaoTipo;

{ TFormAddTipo }

procedure TFormAddTipo.AfterConstruction;
begin
  inherited;
  FObjectActionTipo := (GetObjectAction as TObjectActionTipo);
end;

initialization

RegisterClass(TFormAddTipo);

end.
