program BlockPC;

uses
  Vcl.Forms,
  uDMUtils,
  uBlockPC in 'uBlockPC.pas' {FormBlockPC};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormBlockPC, FormBlockPC);
  Application.Run;
end.
