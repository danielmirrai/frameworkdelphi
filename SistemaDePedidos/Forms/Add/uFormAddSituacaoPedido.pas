unit uFormAddSituacaoPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  uConstantSituacaoPedido, Dialogs, uFormAddModel, uObjectActionSituacaoPedido, StdCtrls, ExtCtrls,
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
  TFormAddSituacaoPedido = Class(TFormAddModel)
    Label1: TLabel;
    DBEdit1: TcxDBTextEdit;
    Label2: TLabel;
    DBEdit2: TcxDBTextEdit;
    dbchkAtivo: TDBCheckBox;
  public
    FObjectActionSituacaoPedido: TObjectActionSituacaoPedido;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDaoSituacaoPedido;

{ TFormAddSituacaoPedido }

procedure TFormAddSituacaoPedido.AfterConstruction;
begin
  inherited;
  FObjectActionSituacaoPedido := (GetObjectAction as TObjectActionSituacaoPedido);
end;

initialization

RegisterClass(TFormAddSituacaoPedido);

end.
