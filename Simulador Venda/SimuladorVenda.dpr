program SimuladorVenda;

uses
  Vcl.Forms,
  System.SysUtils,
  uFormSimuladorVenda in 'Form\uFormSimuladorVenda.pas' {FormSimuladorVenda},
  uRegraSimuladorVenda in 'Regra\uRegraSimuladorVenda.pas';

{$R *.res}


type
  ENaoPermiteAcesssarSistemaDiaNaoUtil = class(Exception);
  function FNCL_DIA_UTIL(const data: TDateTime): Boolean; external 'utils.dll';

const
  MSG_NaoPermiteAcesssarSistemaDiaNaoUtil = 'Não é possível acessar sistema em dia não útil.';
var
  FormSimuladorVenda: TFormSimuladorVenda;
begin
  if not FNCL_DIA_UTIL(Date) then
    raise ENaoPermiteAcesssarSistemaDiaNaoUtil.Create(MSG_NaoPermiteAcesssarSistemaDiaNaoUtil);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Simulador para venda de veículos';
  Application.CreateForm(TFormSimuladorVenda, FormSimuladorVenda);
  Application.Run;
end.
