program Clear;

uses
  Forms, FileCtrl, Dialogs, uConstantUtils, WIndows, SysUtils, uDMUtils;

{$R *.res}

begin
  Application.Initialize;
  Application.Run;
  TDMUtils.DeleteFileDelphiTemp(ExtractFilePath(Application.ExeName));
  if (ParamStr(nCST_Zero) <> sCST_Nao) then
    Showmessage(sCST_ArquivosTempExcluidos);
end.
