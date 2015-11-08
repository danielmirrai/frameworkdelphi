unit uFormAddProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  uConstantProduto, Dialogs, uFormAddModel, uObjectActionProduto, StdCtrls, ExtCtrls,
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
  TFormAddProduto = Class(TFormAddModel)
    Label1: TLabel;
    DBEdit1: TcxDBTextEdit;
    Label2: TLabel;
    DBEdit2: TcxDBTextEdit;
    Label3: TLabel;
    DBEdit3: TcxDBTextEdit;
    Label4: TLabel;
    DBEdit4: TcxDBTextEdit;
    Label5: TLabel;
    DBEdit5: TcxDBTextEdit;
    Label6: TLabel;
    DBMemo1: TDBMemo;
    Label8: TLabel;
    DBEdit7: TcxDBTextEdit;
    dbchkAtivo: TDBCheckBox;
  public
    FObjectActionProduto: TObjectActionProduto;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDaoProduto;

{ TFormAddProduto }

procedure TFormAddProduto.AfterConstruction;
begin
  inherited;
  FObjectActionProduto := (GetObjectAction as TObjectActionProduto);
end;

initialization

RegisterClass(TFormAddProduto);

end.
