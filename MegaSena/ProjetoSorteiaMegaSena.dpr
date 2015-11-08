program ProjetoSorteiaMegaSena;

uses
  Forms,
  ufrmSorteiaNumero in 'ufrmSorteiaNumero.pas' {FrmSorteiaNumero};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmSorteiaNumero, FrmSorteiaNumero);
  Application.Run;
end.
