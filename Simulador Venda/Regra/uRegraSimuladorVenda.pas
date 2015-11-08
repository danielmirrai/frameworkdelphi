unit uRegraSimuladorVenda;

interface

type
  TModeloVeiculo = (tmvBasic, tmvUtility, tmvSedan, tmvSport, tmvExecutive);
  TOpcionalVeiculo = (tovVidroTravasEletricas, tovArCondicionado, tovDirecaoHidraulica, tovBancosDeCouro, tovFreiosABS, tovAirbag);
  TOpcionaisVeiculos = set of TOpcionalVeiculo;

  TRegraSimuladorVenda = class
  strict private
    FOpcionaisVeiculos: TOpcionaisVeiculos;
    FModeloVeiculo: TModeloVeiculo;
  protected
    class function GetDescricaoItemVeiculo(const psNome: string; const pnValor: Currency): String;
    function GetOpcionaisVeiculos: TOpcionaisVeiculos;
    procedure SetOpcionaisVeiculos(const Value: TOpcionaisVeiculos);
    procedure SetModeloVeiculo(const Value: TModeloVeiculo);
    function GetModeloVeiculo: TModeloVeiculo;
    function GetValorTotalVeiculo: Currency;
    function GetValorModeloVeiculo: Currency;
    function GetValorOpcionaisVeiculos: Currency;
  public
    constructor Create; Virtual;
    class function GetDescricaoModeloVeiculo(const ptpModeloVeiculo: TModeloVeiculo): String;
    class function GetDescricaoOpcionalVeiculo(const ptpOpcionalVeiculo: TOpcionalVeiculo): String;
    property OpcionaisVeiculos: TOpcionaisVeiculos read GetOpcionaisVeiculos write SetOpcionaisVeiculos;
    property ModeloVeiculo: TModeloVeiculo read GetModeloVeiculo write SetModeloVeiculo;
    property ValorTotalVeiculo: Currency read GetValorTotalVeiculo;

  end;

const
  sCST_FormatacaoValor = '#,####,##0';
  sCST_FormatacaoValorVirgula = '#,####,##0.00';
  TModeloSeriePadrao = [tovVidroTravasEletricas, tovArCondicionado, tovDirecaoHidraulica];
  TModeloSerieExecutive = [tovVidroTravasEletricas, tovArCondicionado, tovDirecaoHidraulica, tovBancosDeCouro, tovFreiosABS];
  TValorOpcionalVeiculo: array[TOpcionalVeiculo] of Currency = (500, 1000, 1300, 1900, 2500, 3000);
  TValorModeloVeiculo: array[TModeloVeiculo] of Currency = (19000, 25850, 27900, 31600, 39700);

  TDescricaoOpcionalVeiculo: array[TOpcionalVeiculo] of String =
  ('Vidro e Travas Elétricas', 'Ar Condicionado', 'Direção Hidráulica', 'Bancos de Couro', 'Freios ABS', 'Airbag');

  TDescricaoModeloVeiculo: array[TModeloVeiculo] of String =
    ('Matrix Basic', 'Matrix Utility', 'Matrix Sedan', 'Matrix Sport', 'Matrix Executive');
  TModeloSerieVeiculo: array[TModeloVeiculo] of TOpcionaisVeiculos = ([], [], TModeloSeriePadrao, TModeloSeriePadrao, TModeloSerieExecutive);


implementation

uses System.SysUtils;
{ TRegraSimuladorVenda }

constructor TRegraSimuladorVenda.Create;
begin
  FOpcionaisVeiculos := [];
  FModeloVeiculo := tmvBasic;
end;

class function TRegraSimuladorVenda.GetDescricaoItemVeiculo(const psNome: string; const pnValor: Currency): String;
const
  sCST_FormatacaoDescricao = '%s (%s)';
begin
  Result := Format(sCST_FormatacaoDescricao, [psNome, FormatCurr(sCST_FormatacaoValor, pnValor)]);
end;

class function TRegraSimuladorVenda.GetDescricaoModeloVeiculo(const ptpModeloVeiculo: TModeloVeiculo): String;
begin
  Result := TRegraSimuladorVenda.GetDescricaoItemVeiculo(TDescricaoModeloVeiculo[ptpModeloVeiculo], TValorModeloVeiculo[ptpModeloVeiculo]);
end;

class function TRegraSimuladorVenda.GetDescricaoOpcionalVeiculo(const ptpOpcionalVeiculo: TOpcionalVeiculo): String;
begin
  Result := TRegraSimuladorVenda.GetDescricaoItemVeiculo(TDescricaoOpcionalVeiculo[ptpOpcionalVeiculo], TValorOpcionalVeiculo[ptpOpcionalVeiculo]);
end;

function TRegraSimuladorVenda.GetModeloVeiculo: TModeloVeiculo;
begin
  Result := FModeloVeiculo;
end;

function TRegraSimuladorVenda.GetOpcionaisVeiculos: TOpcionaisVeiculos;
begin
  Result := FOpcionaisVeiculos;
end;

function TRegraSimuladorVenda.GetValorModeloVeiculo: Currency;
begin
  Result := TValorModeloVeiculo[ModeloVeiculo];
end;

function TRegraSimuladorVenda.GetValorOpcionaisVeiculos: Currency;
var
  tpOpcionalVeiculo: TOpcionalVeiculo;
begin
  Result := 0;
  for tpOpcionalVeiculo in FOpcionaisVeiculos do
  begin
    if (not (tpOpcionalVeiculo in TModeloSerieVeiculo[ModeloVeiculo])) then
      Result := Result + TValorOpcionalVeiculo[tpOpcionalVeiculo];
  end;
end;

function TRegraSimuladorVenda.GetValorTotalVeiculo: Currency;
begin
  Result := GetValorModeloVeiculo + GetValorOpcionaisVeiculos;
end;

procedure TRegraSimuladorVenda.SetModeloVeiculo(const Value: TModeloVeiculo);
begin
  FModeloVeiculo := Value;
end;

procedure TRegraSimuladorVenda.SetOpcionaisVeiculos(const Value: TOpcionaisVeiculos);
begin
  FOpcionaisVeiculos := Value;
end;

end.
