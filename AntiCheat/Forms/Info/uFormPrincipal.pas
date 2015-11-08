unit uFormPrincipal;

interface

uses MagicApiHook, uFormViewSearchGame, uDMHTTP,
  uFormViewSearchPlayers, uObjectActionPlayers, uFormAddLogin, Windows,TlHelp32,
    Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, ShellAPI,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
    uObjectActionLogin,
  cxClasses, cxPropertiesStore, ActnList, dxRibbonSkins,
  dxSkinsdxRibbonPainter, dxRibbon, dxSkinsdxBarPainter, dxBar, dxStatusBar,
  dxRibbonStatusBar, ExtCtrls, dxGDIPlusClasses, cxImage,
  uObjectActionProcess, uObjectActionImage, uFormModelCustom,
  uObjectActionGame, uFactoryObject, dxBarExtItems, 
  IdBaseComponent, IdMultipartFormData, IdComponent, IdTCPConnection,
  IdTCPClient,
  IdHTTP, cxProgressBar,
  cxGroupBox, cxBarEditItem, Menus, StdCtrls, cxButtons, jpeg,
  dxSkinsDefaultPainters;

type
  TFormPrincipal = class(TFormModelCustom)
    tagPrincipal: TdxRibbonTab;
    dxRibbon1: TdxRibbon;
    dxBarManager1: TdxBarManager;
    dxRibbonStatusBar1: TdxRibbonStatusBar;
    Timer: TTimer;
    dxBarManager1BarPrincipal: TdxBar;
    dxBarApplicationMenu1: TdxBarApplicationMenu;
    dxBarManager1Bar1: TdxBar;
    dxBarStaticIP: TdxBarStatic;
    dxBarLargeButton3: TdxBarLargeButton;
    ActionList: TActionList;
    ac_close: TAction;
    ac_SelectGame: TAction;
    dxBarStaticNomeProcessador: TdxBarStatic;
    dxBarStaticPlacaVideo: TdxBarStatic;
    dxBarStaticMemoriaRam: TdxBarStatic;
    dxBarStaticEnderecoMAC: TdxBarStatic;
    dxBarStaticSistemaOperacional: TdxBarStatic;
    ac_Hide: TAction;
    ac_Show: TAction;
    dxBarLargeButton1: TdxBarLargeButton;
    ac_ViewPlayers: TAction;
    dxBarLargeButton2: TdxBarLargeButton;
    gb_dados: TcxGroupBox;
    img_Login: TcxImage;
    dxbrProgresso: TdxBar;
    cxprogressBar: TcxBarEditItem;
    IdHTTP: TIdHTTP;
    dxControl2: TdxBarDockControl;
    procedure TimerTimer(Sender: TObject);
    procedure ac_SelectGameExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
    procedure ac_CloseExecute(Sender: TObject);
    procedure ac_ShowExecute(Sender: TObject);
    procedure ac_HideExecute(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure ac_ViewPlayersExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dxRibbonStatusBar1Panels5DblClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    FObjectActionImage: TObjectActionImage;
    FObjectActionProcess: TObjectActionProcess;
    FObjectActionGame: TObjectActionGame;
    FObjectActionPlayers: TObjectActionPlayers;
    FObjectActionLogin: TObjectActionLogin;
    { Private declarations }
    procedure UpdateStatusTime;
    procedure UpdateStatus;
    procedure UpdateInfo;
    procedure ActiveActions(aActive: Boolean);
    procedure RequestLogin;
    procedure OnCloseGame;
    procedure IdHTTPWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Integer);
    procedure IdHTTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Integer);
    procedure IdHTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
  public
    procedure ConfigureHTTP(poHTTP: TDMHTTP);
    procedure Refresh; overload;
    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses uDMUtils, uFormGrid, uFormAddModelCustom, uFormModel, uFormGridCustom,
  uFormViewSearchModel, uFormViewModelCustom, uFormViewSearchModelCustom,
  uObjectDaoApplication, uDMInfoComputer, uConstantSystem,
  uDMUtilsMessage, uDMCript, MD5, uConstantUtils, uConstantAntiCheat;
{$R *.dfm}


procedure TFormPrincipal.ActiveActions(aActive: Boolean);
begin
  ac_Close.Enabled := aActive;
  ac_SelectGame.Enabled := aActive;
  ac_ViewPlayers.Enabled := aActive and (TConstantSystem.GetGameActive > 0);
  if aActive then
  begin
    FObjectActionImage.Active;
    FObjectActionProcess.Active;
    FObjectActionGame.Refresh;
    Refresh;
  end
  else
  begin
    FObjectActionImage.Disable;
    FObjectActionProcess.Disable;
    FObjectActionPlayers.Disable;
  end;
end;

procedure TFormPrincipal.ac_CloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TFormPrincipal.ac_HideExecute(Sender: TObject);
begin
  inherited;
  try
    if TConstantSystem.GetUserActive > 0 then
      Self.Hide;
  except
    //
  end;
end;

procedure TFormPrincipal.ac_SelectGameExecute(Sender: TObject);
var
  FormViewSearchGame: TFormViewSearchGame; 
begin
  inherited;
  Exit;
  ac_ViewPlayers.Enabled := False;
  FormViewSearchGame := nil;
  if not Assigned(FormViewSearchGame) then
    FormViewSearchGame := TFactoryObject.CreateComponent(TFormViewSearchGame,
      Self, FObjectActionGame) as TFormViewSearchGame;
  if Assigned(FormViewSearchGame) then
    Exit;
end;

procedure TFormPrincipal.ac_ShowExecute(Sender: TObject);
begin
  inherited;
  Self.Show;
end;

procedure TFormPrincipal.ac_ViewPlayersExecute(Sender: TObject);
begin
  inherited;
  try
    Application.ProcessMessages;
    ac_ViewPlayers.Enabled := False;
    if not Assigned(FormViewSearchPlayers) then
      FormViewSearchPlayers := TFactoryObject.CreateComponent(TFormViewSearchPlayers, Self, FObjectActionPlayers) as TFormViewSearchPlayers;
  except
    TDMUtils.MyException(sCST_ErrorListPlayers, True);
    exit;
  end;
end;

procedure TFormPrincipal.AfterConstruction;
begin
  inherited;
  TDMUtils.FreeAplication;

  FObjectActionImage := TFactoryObject.CreateComponent(TObjectActionImage) as TObjectActionImage;
  ConfigureHTTP(FObjectActionImage.FDMHTTP);
  FObjectActionProcess := TFactoryObject.CreateComponent(TObjectActionProcess) as TObjectActionProcess;
  FObjectActionGame := TFactoryObject.CreateComponent(TObjectActionGame) as TObjectActionGame;
  FObjectActionPlayers := TFactoryObject.CreateComponent(TObjectActionPlayers) as TObjectActionPlayers;

  FObjectActionLogin := TFactoryObject.CreateComponent(TObjectActionLogin) as TObjectActionLogin;
  
  ActiveActions(False);
  Refresh;
  UpdateInfo;
end;

procedure TFormPrincipal.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FormViewSearchPlayers);
  TDMUtils.DestroyObject(FObjectActionProcess);
  TDMUtils.DestroyObject(FObjectActionImage);
  TDMUtils.DestroyObject(FObjectActionGame);
  TDMUtils.DestroyObject(FObjectActionPlayers);
  TDMUtils.DestroyObject(FObjectActionLogin);
  inherited;
end;

procedure TFormPrincipal.dxRibbonStatusBar1Panels5DblClick(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle, 'open', cSiteDeveloper, '', '', 1);
end;

procedure TFormPrincipal.FormActivate(Sender: TObject);
begin
  if FFirstActivate then
    RequestLogin
  else
    OnCloseGame;
  inherited;
end;

procedure TFormPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  inherited;
  Action := caFree;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  inherited;
  Application.OnException := TDMUtils.MyException;

end;

procedure TFormPrincipal.OnCloseGame;
begin
  if self.Visible then
  begin
    try
      Refresh;
      ac_ViewPlayers.Enabled := TConstantSystem.GetGameActive > 0;
      gb_dados.Visible := True;
      TDMUtils.FocusSet(gb_dados);
    except
      TDMUtils.MyException('Erro ao fechar tela.', true);
    end;
  end;
end;


procedure TFormPrincipal.Refresh;
begin
  UpdateStatus;
  UpdateStatusTime;
end;

procedure TFormPrincipal.RequestLogin;
var
  vFormAddLogin: TFormAddLogin;
begin
  vFormAddLogin := nil;
  try
    vFormAddLogin := TFactoryObject.CreateComponent(TFormAddLogin, Self, FObjectActionLogin) as TFormAddLogin;
    if (vFormAddLogin.ShowModal = mrOk) then
    begin
      Refresh;
      ActiveActions(True);
      ac_SelectGame.Execute;
    end
    else
    begin
      ac_Close.Enabled := True;
      ac_Close.Execute;
    end;
  finally
    TDMUtils.DestroyObject(vFormAddLogin);
  end;
end;

procedure TFormPrincipal.TimerTimer(Sender: TObject);
begin
  inherited;
  UpdateStatusTime;
end;

procedure TFormPrincipal.TrayIconDblClick(Sender: TObject);
begin
  inherited;
  ac_Show.Execute;
end;

procedure TFormPrincipal.UpdateInfo;
  procedure DefineData(aField: TdxBarStatic; aCaption, aValue: string);
  begin
    aField.Caption := aCaption + ' ' + aValue;
  end;
begin
  DefineData(dxBarStaticIP, 'IP:', TDMInfoComputer.GetAdress_IP_Rede);
  DefineData(dxBarStaticNomeProcessador, 'Processador:',
    TDMInfoComputer.GetName_Processor);
  DefineData(dxBarStaticPlacaVideo, 'Placa de Vídeo:',
    TDMInfoComputer.GetName_VideoCard);
  DefineData(dxBarStaticMemoriaRam, 'Memória (RAM):',
    TDMInfoComputer.GetMemory_RAM_Format);
  DefineData(dxBarStaticEnderecoMAC, 'MAC:', TDMInfoComputer.GetAdress_MAC);
  DefineData(dxBarStaticSistemaOperacional, 'SO:', TDMInfoComputer.GetSO);
end;

procedure TFormPrincipal.UpdateStatus;

  function Agrega(aValue: string): string;
  begin
    Result := '';
    if TDMUtils.ExistValue(aValue) then
      Result := ' - ' + aValue;
  end;
begin
  if (FObjectActionLogin.LocateUserActive) then
  begin
    dxRibbonStatusBar1.Panels[1].Text := 'Usuário: ' +
      FObjectActionLogin.GetObjectDao.CDSDadosCODIGO.AsString +
      Agrega(FObjectActionLogin.GetObjectDao.CDSDadosNOME.AsString);
    dxRibbonStatusBar1.Panels[2].Text := 'Clã: ' +
      FObjectActionLogin.GetObjectDao.CDSDadosCLA.AsString;
  end
  else
  begin
    dxRibbonStatusBar1.Panels[1].Text := '';
    dxRibbonStatusBar1.Panels[2].Text := '';
  end;

  if (Assigned(FObjectActionGame) and (FObjectActionGame.LocateGameActive)) then
    dxRibbonStatusBar1.Panels[3].Text := 'Partida: ' +
      FObjectActionGame.GetObjectDao.CDSDadosID_PARTIDA.AsString +
      Agrega(FObjectActionGame.GetObjectDao.CDSDadosDESCRICAO.AsString)
  else
    dxRibbonStatusBar1.Panels[3].Text := '';
  Application.ProcessMessages;
end;

procedure TFormPrincipal.UpdateStatusTime;
begin
  if Assigned(dxRibbonStatusBar1) then
  begin
    dxRibbonStatusBar1.Panels[4].Text := TDMUtils.FormatDateTime2(Now);
  end;

  Application.ProcessMessages;
end;

procedure TFormPrincipal.FormDeactivate(Sender: TObject);
begin    
  gb_dados.Visible := False;
  inherited;

end;

procedure TFormPrincipal.IdHTTPWork(Sender: TObject; AWorkMode: TWorkMode; AWorkCount: Integer);
begin
  cxprogressBar.EditValue := cxprogressBar.EditValue + 1;
  cxprogressBar.Caption := 'Aguarde... Sincronizando dados.';
  Application.ProcessMessages;
end;

procedure TFormPrincipal.IdHTTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Integer);
begin
  dxControl2.Visible := True;
  TcxProgressBarProperties(cxprogressBar.Properties).max := Integer(AWorkCountMax);
  cxprogressBar.EditValue := 0;
  cxprogressBar.Caption := 'Aguarde... Iniciando sincronia dos dados.';
  Application.ProcessMessages;
end;

procedure TFormPrincipal.IdHTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  cxprogressBar.EditValue := TcxProgressBarProperties(cxprogressBar.Properties).max;
  cxprogressBar.Caption := 'Sincronia concluída com sucesso.';
  dxControl2.Visible := False;                                         
  Application.ProcessMessages;
  Application.Terminate;
end;

procedure TFormPrincipal.ConfigureHTTP(poHTTP: TDMHTTP);
begin
  if not Assigned(poHTTP) then
    Exit;

  poHTTP.OnWork := IdHTTPWork;
  poHTTP.OnWorkBegin := IdHTTPWorkBegin;
  poHTTP.OnWorkEnd := IdHTTPWorkEnd;
end;

procedure TFormPrincipal.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;           
  CanClose := False;
  Application.ProcessMessages;
  FObjectActionImage.SendImage;
end;

initialization
  RegisterClass(TFormPrincipal);

end.

