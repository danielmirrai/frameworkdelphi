unit uFormAddPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  uConstantPedido, Dialogs, uFormAddModel, uObjectActionPedido, StdCtrls, ExtCtrls,
  DB, ActnList, DBCtrls, Classes, Mask, uFrameLookupModel, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy, dxSkinGlassOceans,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinXmas2008Blue, Menus,
  cxTextEdit, cxDBEdit, cxPropertiesStore, cxButtons, cxGroupBox;

type
  TFormAddPedido = Class(TFormAddModel)
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
    DBEdit6: TcxDBTextEdit;
    Label8: TLabel;
    DBEdit8: TcxDBTextEdit;
    Label11: TLabel;
    DBEdit11: TcxDBTextEdit;
    Label12: TLabel;
    DBEdit12: TcxDBTextEdit;
    Label13: TLabel;
    DBEdit13: TcxDBTextEdit;
    Label14: TLabel;
    DBMemo1: TDBMemo;
    btnItem: TcxButton;
    act_ItemPedido: TAction;
    FrameLookupModel2: TFrameLookupModel;
    frmlkpmdlCODIGO_SITUACAO: TFrameLookupModel;
    frmlkpmdlCODIGO_CLIENTE: TFrameLookupModel;
    procedure act_ItemPedidoExecute(Sender: TObject);
  public
    FObjectActionPedido: TObjectActionPedido;
    procedure AfterConstruction; override;
  end;

implementation

uses uFactoryObject, uObjectDaoPedido, uFormViewModel;
{$R *.dfm}


procedure TFormAddPedido.act_ItemPedidoExecute(Sender: TObject);
var
  ViewItemPedido: TFormViewModel;
begin
  ViewItemPedido := TFactoryObject.CreateComponent('TFormViewItemPedido', FObjectActionPedido) as TFormViewModel;
  try
    ViewItemPedido.FFormAddModel.GetObjectAction.ConfigureMasterSource(FObjectActionPedido);
    ViewItemPedido.ShowModal;
  finally
    FreeAndNil(ViewItemPedido);
  end;
end;

{ TFormAddPedido }

procedure TFormAddPedido.AfterConstruction;
begin
  inherited;
  FObjectActionPedido := (GetObjectAction as TObjectActionPedido);
end;

initialization

RegisterClass(TFormAddPedido);

end.
