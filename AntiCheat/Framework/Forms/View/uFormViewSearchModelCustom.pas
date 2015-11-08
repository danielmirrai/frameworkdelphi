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
  DB, ActnList, uFormGrid, uFormGridCustom, uObjectActionCustom, StdCtrls,
  
  Grids, DBGrids, ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinsDefaultPainters, Menus, cxButtons, cxClasses, cxPropertiesStore,
  cxGroupBox, cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type
  TFormViewSearchModelCustom = class(TFormGrid)
    gb_Navegate: TPanel;
    btn_Close: TcxButton;
    btn_Select: TcxButton;
    ac_Select: TAction;
    procedure ac_SelectExecute(Sender: TObject);
    procedure GridDBTableView_DadosDblClick(Sender: TObject);
    procedure cxGridDBTableViewDadosDblClick(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure SetTitle; virtual;
    procedure SelectItem; virtual;
    procedure ActiveAction(const pbActive: BOolean); Override;
  public
    { Public declarations }
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;
  end;

implementation

uses uDMUtils, uFactoryObject;

{$R *.dfm}
{ TFormViewSearchModelCustom }

procedure TFormViewSearchModelCustom.ActiveAction(const pbActive: BOolean);
begin
  inherited;
  ac_Select.Enabled := pbActive;
end;

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
  SetTitle;
end;

procedure TFormViewSearchModelCustom.BeforeDestruction;
begin
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


procedure TFormViewSearchModelCustom.SetTitle;
begin
  gb_Dados.Caption := Self.Caption;
end;

initialization

RegisterClass(TFormViewSearchModelCustom);

end.
