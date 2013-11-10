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
unit uFormViewSearchModelCustom;

interface

uses
  Classes, Controls, Forms,
  DB, ActnList, uFormGrid, uFormGridCustom, uObjectActionCustom, Vcl.StdCtrls,
  System.Actions,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  TOnCloseChild = procedure() of object;

  TFormViewSearchModelCustom = class(TFormGrid)
    gb_Navegate: TPanel;
    btn_Close: TButton;
    btn_Select: TButton;
    ac_Select: TAction;
    procedure ac_SelectExecute(Sender: TObject);
    procedure GridDBTableView_DadosDblClick(Sender: TObject);
    procedure cxGridDBTableViewDadosDblClick(Sender: TObject);
  private
    { Private declarations }
  protected
    FOnCloseChild: TOnCloseChild;
    procedure SetTitle; virtual;
    procedure SelectItem; virtual;
    procedure SetActiveDataAction; virtual;
  public
    { Public declarations }
    procedure SetOnCloseChild(aOnCloseChild: TOnCloseChild);
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

uses uDMUtils, uFactoryObject;

{$R *.dfm}
{ TFormViewSearchModelCustom }

procedure TFormViewSearchModelCustom.ac_SelectExecute(Sender: TObject);
begin
  try
    TDMUtils.FocusSet(btn_Select);
    ac_Select.Enabled := False;
    inherited;
    SelectItem;
  finally
    if (Self.Tag = mrNone) then
      ac_Select.Enabled := True;
  end;
end;

procedure TFormViewSearchModelCustom.AfterConstruction;
begin
  inherited;
  FOnCloseChild := nil;
  SetTitle;
end;

procedure TFormViewSearchModelCustom.BeforeDestruction;
begin
  if Assigned(FOnCloseChild) then
    FOnCloseChild;
  FOnCloseChild := nil;
  inherited;
end;

procedure TFormViewSearchModelCustom.cxGridDBTableViewDadosDblClick
  (Sender: TObject);
begin
  inherited;
  ac_Select.Execute;
end;

procedure TFormViewSearchModelCustom.GridDBTableView_DadosDblClick
  (Sender: TObject);
begin
  inherited;
  ac_Select.Execute;
end;

procedure TFormViewSearchModelCustom.SelectItem;
begin
end;

procedure TFormViewSearchModelCustom.SetActiveDataAction;
begin
  ac_Select.Enabled := TDMUtils.ExistValue(dsDados.DataSet);
end;

procedure TFormViewSearchModelCustom.SetOnCloseChild(aOnCloseChild
  : TOnCloseChild);
begin
  FOnCloseChild := aOnCloseChild;
end;

procedure TFormViewSearchModelCustom.SetTitle;
begin
  gb_Dados.Caption := Self.Caption;
end;

initialization

RegisterClass(TFormViewSearchModelCustom);

end.
