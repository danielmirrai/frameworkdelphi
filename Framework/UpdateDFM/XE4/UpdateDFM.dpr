program UpdateDFM;

uses
  Dialogs, uConstantUtils, Vcl.Forms, Vcl.FileCtrl, WIndows,  System.SysUtils, uDMUtils;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
  TDMUtils.CopyDFMForLib(ExtractFilePath(Application.ExeName), ExtractFilePath(Application.ExeName) + 'lib\D7\');
  TDMUtils.CopyDFMForLib(ExtractFilePath(Application.ExeName), ExtractFilePath(Application.ExeName) + 'lib\XE4\');

  if (ParamStr(nCST_Zero) <> sCST_Nao) then
    Showmessage(sCST_AtualizacaoDFMLib);
end.
