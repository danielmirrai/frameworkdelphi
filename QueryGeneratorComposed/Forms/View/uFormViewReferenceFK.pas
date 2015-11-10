unit uFormViewReferenceFK;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, uConstantReferenceFK,
  Dialogs, uFormViewModel, uFormAddReferenceFK, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  dxSkinBlack, dxSkinsDefaultPainters, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, Menus,
  cxPropertiesStore, cxGridCustomPopupMenu, cxGridPopupMenu, ActnList,
  StdCtrls, cxButtons, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  uDMRTTI, cxGroupBox, cxTextEdit, cxLabel;

type
  TFormViewReferenceFK = class(TFormViewModel)
    actGeneretorSQL: TAction;
    cxGroupBox1: TcxGroupBox;
    chkIsView: TCheckBox;
    chkIncludeOnlyFieldDCOfReference: TCheckBox;
    btnGeneretorSQL: TcxButton;
    edtNivelJoinWichSubTables: TcxTextEdit;
    cxLabel1: TcxLabel;
    actFullScript: TAction;
    btnTodos: TcxButton;
    procedure actGeneretorSQLExecute(Sender: TObject);
    procedure actFullScriptExecute(Sender: TObject);
  public
    { Public declarations }
    FFormAddReferenceFK: TFormAddReferenceFK;
    procedure AfterConstruction; override;
  end;

implementation

uses uDMUtils;
{$R *.dfm}

{ TFormViewReferenceFK }

procedure TFormViewReferenceFK.AfterConstruction;
begin
  inherited;
  FFormAddReferenceFK := GetFormAddModel as TFormAddReferenceFK;
end;

procedure TFormViewReferenceFK.actGeneretorSQLExecute(Sender: TObject);
begin
  inherited;
  FFormAddReferenceFK.FObjectActionReferenceFK.ScriptIsView := chkIsView.Checked;
  FFormAddReferenceFK.FObjectActionReferenceFK.IncludeOnlyFieldDCOfReference := chkIncludeOnlyFieldDCOfReference.Checked;
  FFormAddReferenceFK.FObjectActionReferenceFK.NivelJoinWichSubTables := TDMUtils.StrToInt2(edtNivelJoinWichSubTables.Text);
  FFormAddReferenceFK.FObjectActionReferenceFK.GeneratorSQL;
end;

procedure TFormViewReferenceFK.actFullScriptExecute(Sender: TObject);
var
  i, i2, i3: Integer;
begin
  inherited;
  for i := 0 to 2 do
  begin     
    for i2 := 0 to 2 do
    begin          
      for i3 := -1 to 2 do
      begin
        chkIsView.Checked := Boolean(i);
        chkIncludeOnlyFieldDCOfReference.Checked := Boolean(i2);
        edtNivelJoinWichSubTables.Text := IntToStr(i3);
        actGeneretorSQL.Execute;
      end;
    end;
  end;
end;

initialization
  DMRTTI.RegisterClass(TFormViewReferenceFK);

end.
