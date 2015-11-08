unit uFrmPrincipal;

interface

uses
  SysUtils, Classes, Controls, Forms, Clipbrd,
  cxButtons, cxMemo, cxGroupBox, Menus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  cxTextEdit, StdCtrls, ActnList, Dialogs, cxLabel;

type
  TForm_Principal = class(TForm)
    gb_Origem: TcxGroupBox;
    gb_Destino: TcxGroupBox;
    cxMemoDestino: TcxMemo;
    cxGroupBox3: TcxGroupBox;
    cxMemoOrigem: TcxMemo;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    gb_Topo: TcxGroupBox;
    ActionList1: TActionList;
    ac_Descripografar: TAction;
    ac_Criptografar: TAction;
    ac_Close: TAction;
    edt_File: TcxTextEdit;
    OpenDialog1: TOpenDialog;
    cxButton3: TcxButton;
    ac_AbrirArquivo: TAction;
    cxLabel1: TcxLabel;
    ac_Processar: TAction;
    cxButton4: TcxButton;
    ac_FileInfo: TAction;
    cxButton5: TcxButton;
    procedure ac_CriptografarExecute(Sender: TObject);
    procedure ac_DescripografarExecute(Sender: TObject);
    procedure ac_CloseExecute(Sender: TObject);
    procedure ac_AbrirArquivoExecute(Sender: TObject);
    procedure ac_ProcessarExecute(Sender: TObject);
    procedure ac_FileInfoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Principal: TForm_Principal;

implementation

uses uDMCript, uDMUtils, uDMFileInfoUtils;

{$R *.dfm}

procedure TForm_Principal.ac_AbrirArquivoExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    if TDMUtils.FileExists2(OpenDialog1.FileName) then
    begin
      edt_File.Text := OpenDialog1.FileName;
    end;
  end;
end;

procedure TForm_Principal.ac_CloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TForm_Principal.ac_CriptografarExecute(Sender: TObject);
var
  vIndex: Integer;
begin
  cxMemoDestino.Lines.Clear;
  for vIndex := 0 to cxMemoOrigem.Lines.Count -1 do
  begin
    if Trim(cxMemoOrigem.Lines[vIndex]) <> '' then
      cxMemoDestino.Lines.Add(TDMCript.Encrypts(Trim(cxMemoOrigem.Lines[vIndex])));
  end;
end;

procedure TForm_Principal.ac_DescripografarExecute(Sender: TObject);
var
  vIndex: Integer;
begin
  cxMemoDestino.Lines.Clear;
  for vIndex := 0 to cxMemoOrigem.Lines.Count  do
  begin
    if Trim(cxMemoOrigem.Lines[vIndex]) <> '' then
      cxMemoDestino.Lines.Add(TDMCript.Decrypt(Trim(cxMemoOrigem.Lines[vIndex])));
  end;
end;

procedure TForm_Principal.ac_FileInfoExecute(Sender: TObject);
var
  vDMFileInfoUtils: TDMFileInfoUtils;
begin
  vDMFileInfoUtils := TDMFileInfoUtils.Create;
  vDMFileInfoUtils.SetFileInfo(Trim(edt_File.Text));
  cxMemoDestino.Clear;
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils                  :=  FDMListFileInfoUtils.Add;');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.CompanyName      := '+QuotedStr(vDMFileInfoUtils.CompanyName)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.FileDescription  := '+QuotedStr(vDMFileInfoUtils.FileDescription)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.FileVersion      := '+QuotedStr(vDMFileInfoUtils.FileVersion)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.InternalName     := '+QuotedStr(vDMFileInfoUtils.InternalName)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.LegalCopyright   := '+QuotedStr(vDMFileInfoUtils.LegalCopyright)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.OriginalFilename := '+QuotedStr(vDMFileInfoUtils.OriginalFilename)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.ProductName      := '+QuotedStr(vDMFileInfoUtils.ProductName)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.ProductVersion   := '+QuotedStr(vDMFileInfoUtils.ProductVersion)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.Comments         := '+QuotedStr(vDMFileInfoUtils.Comments)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.Attribute        := '+QuotedStr(vDMFileInfoUtils.Attribute)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.TypeFile         := '+QuotedStr(vDMFileInfoUtils.TypeFile)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.OS               := '+QuotedStr(vDMFileInfoUtils.OS)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.FileName         := '+QuotedStr(vDMFileInfoUtils.FileName)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.NameValidate     := '+QuotedStr(vDMFileInfoUtils.NameValidate)+';');
  cxMemoDestino.Lines.Add('  vDMFileInfoUtils.MD5              := '+QuotedStr(vDMFileInfoUtils.MD5)+';');
  Clipboard.AsText := cxMemoDestino.Text;
end;

procedure TForm_Principal.ac_ProcessarExecute(Sender: TObject);
var
  vArq: TextFile;
  vFileName, vLine: String;
begin
  cxMemoOrigem.Lines.Clear;
  vFileName := edt_File.Text;
  if FileExists(vFileName) then
  begin
    AssignFile(vArq, vFileName);
    Reset(vArq);
    while not eof(vArq) do
    begin
    	Readln(vArq, vLine);
      cxMemoOrigem.Lines.Add(vLine);
    end;
    CloseFile(vArq);
  end;
end;

end.
