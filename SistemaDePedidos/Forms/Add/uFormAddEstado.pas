unit uFormAddEstado;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  uConstantEstado, Dialogs, uFormAddModel, uObjectActionEstado, StdCtrls, ExtCtrls,
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
  TFormAddEstado = Class(TFormAddModel)
    Label1: TLabel;
    DBEdit1: TcxDBTextEdit;
    Label2: TLabel;
    DBEdit2: TcxDBTextEdit;
    Label3: TLabel;
    DBEdit3: TcxDBTextEdit;
    Label4: TLabel;
    DBEdit4: TcxDBTextEdit;
  public
    FObjectActionEstado: TObjectActionEstado;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDaoEstado;

{ TFormAddEstado }

procedure TFormAddEstado.AfterConstruction;
begin
  inherited;
  FObjectActionEstado := (GetObjectAction as TObjectActionEstado);
end;

initialization

RegisterClass(TFormAddEstado);

end.
