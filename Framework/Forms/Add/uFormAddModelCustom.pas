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
unit uFormAddModelCustom;

interface

uses
  ActnList,
  Classes, Controls, SysUtils, Forms, uFormModel, uObjectActionCustom,
  DB,
  ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, cxGroupBox, dxSkinBlue,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinFoggy,
  dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSharp, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinXmas2008Blue, cxPropertiesStore;

type
  TFormAddModelCustom = class(TFormModel)
    ac_Confirm: TAction;
    ac_Cancel: TAction;
    ac_OpenFormAdd: TAction;
    procedure ac_ConfirmExecute(Sender: TObject);
    procedure ac_CancelExecute(Sender: TObject);
    procedure ac_closeExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ac_OpenFormAddExecute(Sender: TObject);
  protected
    procedure CloseForm; Virtual;
  public
    /// <summary>
    /// Save os dados alterados
    /// </summary>
    procedure Save; virtual;
    { Public declarations }
    class procedure OpenFormAdd(Sender: TObject; poOwner: TComponent = nil); Overload;  
    class procedure OpenFormAdd(poOwner: TComponent = nil); Overload;
  end;

implementation

uses uDMUtils, uFactoryObject;

{$R *.dfm}
{ TFormAddModelCustom }

procedure TFormAddModelCustom.ac_CancelExecute(Sender: TObject);
begin
  ac_Cancel.Enabled := False;
  try
    inherited;
  finally
    ac_Cancel.Enabled := True;
    ac_close.Execute;
  end;
end;

procedure TFormAddModelCustom.ac_closeExecute(Sender: TObject);
begin
  ac_close.Enabled := False;
  try
    CloseForm;
  finally
    ac_close.Enabled := True;
  end;
end;

procedure TFormAddModelCustom.ac_ConfirmExecute(Sender: TObject);
begin
  ac_Confirm.Enabled := False;
  try
    inherited;
    Save;
  finally
    ac_Confirm.Enabled := True;
  end;
end;

procedure TFormAddModelCustom.ac_OpenFormAddExecute(Sender: TObject);
begin
  inherited;
  TFormAddModelCustom.OpenFormAdd(Sender);
end;

procedure TFormAddModelCustom.CloseForm;
begin
  inherited;
  Self.Tag := mrAbort;
  if FormStyle <> fsMDIChild then
    Close;
end;

procedure TFormAddModelCustom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  ModalResult := Self.Tag;

end;

class procedure TFormAddModelCustom.OpenFormAdd(Sender: TObject;
  poOwner: TComponent);
var
  FFormAddModelCustom: TFormAddModelCustom;
  sName: string;
begin
  sName := TAction(Sender).Name;
  sName := StringReplace(sName, 'ac_', 'TFormAdd', [rfReplaceAll]);
  FFormAddModelCustom := TFactoryObject.CreateComponent(sName, poOwner)
    as TFormAddModelCustom;
  try
    FFormAddModelCustom.ShowModal;
  finally
    TDMUtils.DestroyObject(FFormAddModelCustom);
  end;
end;

class procedure TFormAddModelCustom.OpenFormAdd(poOwner: TComponent);
var
  FFormAddModelCustom: TFormAddModelCustom;
begin
  FFormAddModelCustom := TFactoryObject.CreateComponent(Self.ClassName, poOwner)
    as TFormAddModelCustom;
  try
    FFormAddModelCustom.ShowModal;
  finally
    TDMUtils.DestroyObject(FFormAddModelCustom);
  end;
end;

procedure TFormAddModelCustom.Save;
begin
  ac_close.Execute;
end;

initialization

RegisterClass(TFormAddModelCustom);

end.
