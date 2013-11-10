program Clear;

uses
  Vcl.Forms, Vcl.FileCtrl, WIndows,  System.SysUtils, uDMUtils;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
  TDMUtils.DeleteFileDelphiTemp(ExtractFilePath(Application.ExeName));
end.
