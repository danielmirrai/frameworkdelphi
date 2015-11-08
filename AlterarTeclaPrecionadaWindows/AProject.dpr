program AProject;

uses
  Vcl.Forms,
  ProjectA in 'ProjectA.pas' {FormTeclaWindows};

{$R *.res}

vAr
  FormTeclaWindows: TFormTeclaWindows;
begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.ShowMainForm := False;
  Application.CreateForm(TFormTeclaWindows, FormTeclaWindows);
  Application.Run;
end.
