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
  uFormModelCustom, ActnList, System.Actions, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls;

type
  TClassFormModel = Class of TFormModel;

  TFormModel = class(TFormModelCustom)
    ActionList: TActionList;
    ac_Close: TAction;
    gb_Dados: TPanel;
    ac_Refresh: TAction;
    procedure ac_CloseExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    { Public declarations }
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

initialization

RegisterClass(TFormModel);

end.
