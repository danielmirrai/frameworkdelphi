program UpdateDFM;

uses
  Dialogs, uConstantUtils, Forms, uDMUtils, FileCtrl, Classes, SysUtils;

{$R *.res}

begin
  Application.Initialize;      
  TDMUtils.CopyDFMForLib(ExtractFilePath(Application.ExeName), ExtractFilePath(Application.ExeName) + 'lib\D7\');
  TDMUtils.CopyDFMForLib(ExtractFilePath(Application.ExeName), ExtractFilePath(Application.ExeName) + 'lib\XE4\');
  Application.Run;
  if (ParamStr(nCST_Zero) <> sCST_Nao) then
    Showmessage(sCST_AtualizacaoDFMLib);
end.
