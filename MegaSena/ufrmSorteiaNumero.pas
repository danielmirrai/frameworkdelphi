unit ufrmSorteiaNumero;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, dateUtils, StdCtrls, 
  ActnList, Mask;

type
  TFrmSorteiaNumero = class(TForm)
    lblNumerosSorteados: TLabel;
    lst1: TListBox;
    chkPodeRepertirNumero: TCheckBox;
    btnLimparGrupoBox: TButton;
    btnSortearNumeros: TButton;
    btnSortearNumeros1: TButton;
    actlst1: TActionList;
    ac_LimparGrupoBox: TAction;
    ac_SortearNumeros: TAction;
    ac_NumeroFoiSorteado: TAction;
    ac_Ordenar: TAction;
    btnNumeroFoiSorteado: TButton;
    edtNumeroDigitado: TMaskEdit;
    lbl1: TLabel;
    procedure ac_LimparGrupoBoxExecute(Sender: TObject);
    procedure ac_SortearNumerosExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ac_NumeroFoiSorteadoExecute(Sender: TObject);
    procedure ac_OrdenarExecute(Sender: TObject);
  private
    { Private declarations }
    FListaNumerosJaSorteados: array of integer;
    procedure AddLabelNumeroSorteado(NumeroSorteadoFormatado: string);
  public
    { Public declarations }
  end;

var
  FrmSorteiaNumero: TFrmSorteiaNumero;

implementation

uses Math;

{$R *.dfm}

procedure TFrmSorteiaNumero.ac_LimparGrupoBoxExecute(Sender: TObject);
begin
  lst1.Clear;
  lblNumerosSorteados.Caption := Emptystr;
end;

procedure TFrmSorteiaNumero.ac_NumeroFoiSorteadoExecute(Sender: TObject);
var
  NumeroFoiSorteado: Boolean;
  i: Integer;
const
  MESSAGEM_NUMERO_SORTEADO: array[Boolean] of string = ('O número não %s foi sorteado', 'O número %s foi sorteado');
begin
  NumeroFoiSorteado := False;
  for i := 0 to lst1.Items.Count - 1 do
  begin
    NumeroFoiSorteado := edtNumeroDigitado.Text = lst1.Items.Strings[i];
    if NumeroFoiSorteado then
      Break;
  end;

  Application.MessageBox(PChar(Format(MESSAGEM_NUMERO_SORTEADO[NumeroFoiSorteado], [edtNumeroDigitado.Text])), PChar('Alerta'));
end;

procedure TFrmSorteiaNumero.ac_OrdenarExecute(Sender: TObject);
var
  i: Integer;
  NumeroSorteadoFormatado: String;
begin
  lst1.Sorted := not lst1.Sorted;
  lblNumerosSorteados.Caption := EmptyStr;
  for i := 0 to lst1.Items.Count -1 do
  begin
    NumeroSorteadoFormatado := lst1.Items.Strings[i];
    AddLabelNumeroSorteado(NumeroSorteadoFormatado);
    FListaNumerosJaSorteados[i] := StrToInt(NumeroSorteadoFormatado);
  end;
end;

procedure TFrmSorteiaNumero.AddLabelNumeroSorteado(NumeroSorteadoFormatado: string);
begin
  if (lblNumerosSorteados.Caption <> EmptyStr) then
    lblNumerosSorteados.Caption := lblNumerosSorteados.Caption + ',';
  lblNumerosSorteados.Caption := lblNumerosSorteados.Caption + NumeroSorteadoFormatado;
end;

procedure TFrmSorteiaNumero.ac_SortearNumerosExecute(Sender: TObject);
var
  NumeroSorteado: Integer;
  NumeroSorteadoFormatado: String;

  procedure SorteiaNumero;
  begin
    NumeroSorteado := RandomRange(1, 60);
  end;

  function NumeroJaExiste: Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := 0 to Length(FListaNumerosJaSorteados) + 1 do
    begin
      Result := (FListaNumerosJaSorteados[Length(FListaNumerosJaSorteados) - 1] = NumeroSorteado);
      if Result then
        Break;
    end;
  end;

var
  i: Byte;
begin
  for i := 1 to 6 do
  begin
    SorteiaNumero;
    while (chkPodeRepertirNumero.Checked and NumeroJaExiste) do
    begin
      SorteiaNumero;
    end;
    SetLength(FListaNumerosJaSorteados, Length(FListaNumerosJaSorteados) + 1);
    FListaNumerosJaSorteados[Length(FListaNumerosJaSorteados) - 1] := NumeroSorteado;

    NumeroSorteadoFormatado := FormatFloat('00', NumeroSorteado);
    lst1.Items.Add(NumeroSorteadoFormatado);
    AddLabelNumeroSorteado(NumeroSorteadoFormatado);
  end;
end;

procedure TFrmSorteiaNumero.FormCreate(Sender: TObject);
begin
  inherited;
  SetLength(FListaNumerosJaSorteados, 0);
  
  lblNumerosSorteados.Caption := EmptyStr;
end;

end.

