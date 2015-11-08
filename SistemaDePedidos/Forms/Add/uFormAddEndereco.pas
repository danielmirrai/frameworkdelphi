unit uFormAddEndereco;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  uConstantEndereco, Dialogs, uFormAddModel, uObjectActionEndereco, StdCtrls, ExtCtrls,
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
  TFormAddEndereco = Class(TFormAddModel)
    lblCod: TLabel;
    dbedtCod: TcxDBTextEdit;
    lblPessoa: TLabel;
    dbedtPessoa: TcxDBTextEdit;
    lblTipoEndereco: TLabel;
    dbedtTipoEndereco: TcxDBTextEdit;
    lblCep: TLabel;
    dbedtCep: TcxDBTextEdit;
    lblCidade: TLabel;
    dbedtCidade: TcxDBTextEdit;
    lblBairro: TLabel;
    dbedtBairro: TcxDBTextEdit;
    lblRua: TLabel;
    dbedtRua: TcxDBTextEdit;
    lblNumero: TLabel;
    dbedtNumero: TcxDBTextEdit;
    lblBloco: TLabel;
    dbedtBloco: TcxDBTextEdit;
    lblAp: TLabel;
    dbedtAp: TcxDBTextEdit;
    lblObs: TLabel;
    dbedtObs: TcxDBTextEdit;
  public
    FObjectActionEndereco: TObjectActionEndereco;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDaoEndereco;

{ TFormAddEndereco }

procedure TFormAddEndereco.AfterConstruction;
begin
  inherited;
  FObjectActionEndereco := (GetObjectAction as TObjectActionEndereco);
end;

initialization

RegisterClass(TFormAddEndereco);

end.
