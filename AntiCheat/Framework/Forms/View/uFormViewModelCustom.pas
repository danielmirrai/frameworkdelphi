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

unit uFormViewModelCustom;

interface

uses
  Classes, Controls, Forms, DB, uFormAddModelCustom, uFormGrid, StdCtrls, SysUtils,
   
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinsDefaultPainters,
  cxStyles, dxSkinscxPCPainter, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxNavigator, cxDBData, ExtCtrls, ActnList,
  cxClasses, cxPropertiesStore, cxGridLevel, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxGroupBox;

type
  TFormViewModelCustom = class(TFormGrid)
    gb_Navegate: TPanel;
    btn_Close: TButton;
    ac_OpenView: TAction;
    procedure ac_OpenViewExecute(Sender: TObject);
  protected
    { Private declarations }
    procedure SetTitle; virtual;
  public
    { Public declarations }
    procedure AfterConstruction; override;
    class procedure OpenView(Sender: TObject; poOwner: TComponent = nil);
  end;

implementation

uses uDMUtils, uFactoryObject;

{$R *.dfm}
{ TFormViewModelCustom }

procedure TFormViewModelCustom.ac_OpenViewExecute(Sender: TObject);
begin
  TFormViewModelCustom.OpenView(Sender, Self);
end;

procedure TFormViewModelCustom.AfterConstruction;
begin
  inherited;
  CreateColuns;
  SetTitle;
end;

class procedure TFormViewModelCustom.OpenView(Sender: TObject; poOwner: TComponent);
var
  FFormViewModelCustom: TFormViewModelCustom;
  sName: string;
begin
  sName := TAction(Sender).Name;
  sName := StringReplace(sName, 'ac_', 'TFormView', [rfReplaceAll]);
  FFormViewModelCustom := TFactoryObject.CreateComponent(sName, poOwner)
    as TFormViewModelCustom;
  try
    FFormViewModelCustom.ShowModal;
  finally
    TDMUtils.DestroyObject(FFormViewModelCustom);
  end;
end;

procedure TFormViewModelCustom.SetTitle;
begin
  gb_Dados.Caption := Self.Caption;
end;

initialization

RegisterClass(TFormViewModelCustom);

end.
