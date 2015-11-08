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
  Messages, Classes, Controls, Forms,
  uFormModelCustom, ActnList, StdCtrls, ExtCtrls,
  Mask, DBCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinsDefaultPainters, cxGroupBox, cxClasses, cxPropertiesStore;

type
  TClassFormModel = Class of TFormModel;

  TFormModel = class(TFormModelCustom)
    ActionList: TActionList;
    ac_Close: TAction;
    ac_Refresh: TAction;
    gb_Dados: TcxGroupBox;
    procedure ac_CloseExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure ac_RefreshExecute(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    { Public declarations }
    procedure Refresh; Virtual;
  end;

implementation

uses uObjectDaoApplication;

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

RegisterClass(TFormModel);

end.
