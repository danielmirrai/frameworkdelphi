unit uFormAddPessoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Graphics, Controls, Forms,
  uConstantPessoa, Dialogs, uFormAddModel, uObjectActionPessoa, StdCtrls, ExtCtrls,
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
  TFormAddPessoa = Class(TFormAddModel)
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
    Label7: TLabel;
    DBEdit7: TcxDBTextEdit;
    DBCheckBox1: TDBCheckBox;
  public
    FObjectActionPessoa: TObjectActionPessoa;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}

uses uObjectDaoPessoa;

{ TFormAddPessoa }

procedure TFormAddPessoa.AfterConstruction;
begin
  inherited;
  FObjectActionPessoa := (GetObjectAction as TObjectActionPessoa);
end;

initialization

RegisterClass(TFormAddPessoa);

end.
