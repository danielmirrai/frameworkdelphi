unit uFormSimuladorVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  uRegraSimuladorVenda, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.CheckLst, Vcl.Mask;

type
  TFormSimuladorVenda = class(TForm)
    grpSimulacao: TGroupBox;
    gbDados: TPanel;
    grpOpcionais: TGroupBox;
    rgModeloDoVeiculo: TRadioGroup;
    chklstOpcionais: TCheckListBox;
    btnCalcular: TButton;
    lblValorTotalVeiculo: TLabel;
    edtValorTotalVeiculo: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnCalcularClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rgModeloDoVeiculoClick(Sender: TObject);
    procedure chklstOpcionaisClickCheck(Sender: TObject);
  strict private
    FRegraSimuladorVenda: TRegraSimuladorVenda;
    { Private declarations }
  protected
    procedure SetModeloVeiculoAtivo;
    procedure SetModeloOpcionaisVeiculo(const removeCheck: Boolean = False);

    procedure SetToRegraModeloOpcionaisVeiculo;

    procedure AdicionaModeloVeiculo;
    procedure AdicionaOpcionaisVeiculo;
    procedure SetRegraSimuladorVenda(const Value: TRegraSimuladorVenda);
    function GetRegraSimuladorVenda: TRegraSimuladorVenda;
  public
    { Public declarations }
    property RegraSimuladorVenda: TRegraSimuladorVenda read GetRegraSimuladorVenda write SetRegraSimuladorVenda;
  end;

implementation

{$R *.dfm}

procedure TFormSimuladorVenda.AdicionaModeloVeiculo;
var
  i: Integer;
begin
  for i := Ord(Low(TModeloVeiculo)) to Ord(High(TModeloVeiculo)) do
  begin
    rgModeloDoVeiculo.Items.Add(TRegraSimuladorVenda.GetDescricaoModeloVeiculo(TModeloVeiculo(i)));
  end;
end;

procedure TFormSimuladorVenda.AdicionaOpcionaisVeiculo;
var
  i: Integer;
begin
  for i := Ord(Low(TOpcionalVeiculo)) to Ord(High(TOpcionalVeiculo)) do
  begin
    chklstOpcionais.Items.Add(TRegraSimuladorVenda.GetDescricaoOpcionalVeiculo(TOpcionalVeiculo(i)));
  end;
end;

procedure TFormSimuladorVenda.btnCalcularClick(Sender: TObject);
begin
  edtValorTotalVeiculo.Text := FormatCurr(sCST_FormatacaoValorVirgula, FRegraSimuladorVenda.ValorTotalVeiculo);
end;

procedure TFormSimuladorVenda.chklstOpcionaisClickCheck(Sender: TObject);
begin
  SetToRegraModeloOpcionaisVeiculo;
  SetModeloOpcionaisVeiculo;
end;

procedure TFormSimuladorVenda.FormCreate(Sender: TObject);
begin
  inherited;
  FRegraSimuladorVenda := TRegraSimuladorVenda.Create;

  edtValorTotalVeiculo.Text := FormatCurr(sCST_FormatacaoValorVirgula, 0);
  AdicionaModeloVeiculo;
  AdicionaOpcionaisVeiculo;
end;

procedure TFormSimuladorVenda.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FRegraSimuladorVenda);
end;

function TFormSimuladorVenda.GetRegraSimuladorVenda: TRegraSimuladorVenda;
begin
  Result := FRegraSimuladorVenda;
end;

procedure TFormSimuladorVenda.rgModeloDoVeiculoClick(Sender: TObject);
begin
  FRegraSimuladorVenda.ModeloVeiculo := TModeloVeiculo(rgModeloDoVeiculo.ItemIndex);
  SetModeloVeiculoAtivo;
end;

procedure TFormSimuladorVenda.SetModeloOpcionaisVeiculo(const removeCheck: Boolean);
var
  tpOpcionalVeiculo: TOpcionalVeiculo;
  I: Integer;
  oldOnClickCheck: TNotifyEvent;
begin
  oldOnClickCheck := chklstOpcionais.OnClickCheck;
  try
    chklstOpcionais.OnClickCheck := nil;
    for I := Ord(Low(TOpcionalVeiculo)) to Ord(High(TOpcionalVeiculo)) do
    begin
      tpOpcionalVeiculo := TOpcionalVeiculo(i);
      chklstOpcionais.Checked[i] := ((not removeCheck) and (tpOpcionalVeiculo in RegraSimuladorVenda.OpcionaisVeiculos));
      chklstOpcionais.ItemEnabled[i] := (not (tpOpcionalVeiculo in TModeloSerieVeiculo[RegraSimuladorVenda.ModeloVeiculo]));
      if (not chklstOpcionais.ItemEnabled[i]) then
        chklstOpcionais.Checked[i] := True;
    end;
    SetToRegraModeloOpcionaisVeiculo;
  finally
    chklstOpcionais.OnClickCheck := oldOnClickCheck;
  end;
end;

procedure TFormSimuladorVenda.SetModeloVeiculoAtivo;
begin
  rgModeloDoVeiculo.ItemIndex := Integer(RegraSimuladorVenda.ModeloVeiculo);
  SetModeloOpcionaisVeiculo(True);
end;

procedure TFormSimuladorVenda.SetRegraSimuladorVenda(const Value: TRegraSimuladorVenda);
begin
  FRegraSimuladorVenda := Value;
end;

procedure TFormSimuladorVenda.SetToRegraModeloOpcionaisVeiculo;
var
  i: Integer;
begin
  FRegraSimuladorVenda.OpcionaisVeiculos := [];
  for i := 0 to chklstOpcionais.Items.Count - 1 do
  begin
    if chklstOpcionais.Checked[i] then
      FRegraSimuladorVenda.OpcionaisVeiculos := FRegraSimuladorVenda.OpcionaisVeiculos + [TOpcionalVeiculo(i)];
  end;
end;

initialization
  RegisterClass(TFormSimuladorVenda);
end.
