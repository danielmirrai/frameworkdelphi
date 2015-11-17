unit uFormMainQuery;

interface

uses
  Windows, Messages, uFormMain, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinsDefaultPainters, StdCtrls, cxLabel, cxTextEdit, cxButtons,
  cxGroupBox, uObjectActionReferenceFK, cxCheckListBox;

type
  TFormMainQuery = class(TFormMain)
    imFormViewFields: TMenuItem;
    imFormViewReferenceFK: TMenuItem;
    cxFundo: TcxGroupBox;
    edtNivelJoinWichSubTables: TcxTextEdit;
    cxNivelJoins: TcxLabel;
    actGeneretorSQL: TAction;
    actFullScript: TAction;
    lstColunasExibidas: TcxCheckListBox;
    cxLabel2: TcxLabel;
    lstTabelasExibir: TcxCheckListBox;
    cxTabelasJoins: TcxLabel;
    cbbTipoScript: TComboBox;
    cxLabel4: TcxLabel;
    cxGroupBox1: TcxGroupBox;
    mmoInstrucaoAntesColunas: TMemo;
    lblSelect: TLabel;
    lbl1: TLabel;
    mmoInstrucaoDepoisJoins: TMemo;
    lbl2: TLabel;
    lbl5: TLabel;
    mmoCondicao: TMemo;
    lbl3: TLabel;
    lblWhere: TLabel;
    lblOrderBy: TLabel;
    mmo: TMemo;
    lbl4: TLabel;
    lbl6: TLabel;
    lstCalculados: TcxCheckListBox;
    cxLabel5: TcxLabel;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Memo2: TMemo;
    cxRodape: TcxGroupBox;
    btnTodos: TcxButton;
    btnGeneretorSQL: TcxButton;
    procedure imFormViewFieldsClick(Sender: TObject);
    procedure imFormViewReferenceFKClick(Sender: TObject);
    procedure actGeneretorSQLExecute(Sender: TObject);
    procedure actFullScriptExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses uFormViewFields, uFormViewReferenceFK, uFactoryObject, uDMUtils;
{$R *.dfm}

procedure TFormMainQuery.imFormViewFieldsClick(Sender: TObject);
begin
  inherited;
  TFormViewFields.OpenView;
end;

procedure TFormMainQuery.imFormViewReferenceFKClick(Sender: TObject);
begin
  inherited;
  TFormViewReferenceFK.OpenView;
end;

procedure TFormMainQuery.actGeneretorSQLExecute(Sender: TObject);
var
  aObjectActionReferenceFK: TObjectActionReferenceFK;
begin
  inherited;

  aObjectActionReferenceFK := TFactoryObject.CreateComponent(TObjectActionReferenceFK) as TObjectActionReferenceFK;
  try
    aObjectActionReferenceFK.NivelJoinWichSubTables := TDMUtils.StrToInt2(edtNivelJoinWichSubTables.Text);
    aObjectActionReferenceFK.GeneratorSQL;
  finally
    aObjectActionReferenceFK.Free;
  end;
end;

procedure TFormMainQuery.actFullScriptExecute(Sender: TObject);
var
  i, i2, i3: Integer;
begin
  inherited;
  LockWindowUpdate(Self.Handle);
  try
    for i := 0 to 2 do
    begin
      for i2 := 0 to 2 do
      begin
        for i3 := -1 to 2 do
        begin
          actGeneretorSQL.Execute;
        end;
      end;
    end;
  finally
    LockWindowUpdate(0);
  end;
end;

end.
