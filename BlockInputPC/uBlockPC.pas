unit uBlockPC;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.UITypes, uDMUtils, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Vcl.CheckLst;

type
  TDia = (tdDomingo, tdSegunda, tdTerca, tdQuarta, tdQuinta, tdSexta, tdSabado);
  TDias = set of TDia;

  TFormBlockPC = class(TForm)
    edtSenha: TEdit;
    btnBloquear: TButton;
    tmrExibeTela: TTimer;
    lblTempo: TLabel;
    btn1: TButton;
    CDS1: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure btnBloquearClick(Sender: TObject);
    procedure edtSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDeactivate(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure edtSenhaExit(Sender: TObject);
    procedure tmrExibeTelaTimer(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn1Click(Sender: TObject);

  private
    { Private declarations }
    FbBloqueou: Boolean;
    FdHoraInicio, FdHoraUltimoKey: TDateTime;
    FnQtdeDesativacao, FnQtdeTentativas: Integer;
    FsSenha: string;
    function GetBloqueou: Boolean;
    procedure SetBloqueou(const Value: Boolean);
    procedure BloquearTeclado;
    procedure BloquearMouse;
    function PosicaoMouseBlock: TPoint;
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    { Public declarations }
    property Bloqueou: Boolean read GetBloqueou write SetBloqueou;
    procedure Bloquear;
    procedure Registrar(const pbRegistrar: Boolean = True);
    procedure Desregistrar;
    procedure ForcaForm(Sender: TObject);
    procedure OnDeactivateApp(Sender: TObject);
    procedure WMHotkey(var Msg: TWMHotkey); message WM_HOTKEY;
  end;

  TIndexKey = (INDEX_NENHUM, INDEX_CONTROL, INDEX_SHIFT, INDEX_WIN, INDEX_ALT);
  TListIndexKey = Set of TIndexKey;



var
  FormBlockPC: TFormBlockPC;

implementation

const
  MAX_TENTATIVAS = 3;
  TValuesIndexKey: array[TIndexKey] of Cardinal = (MOD_NOREPEAT, MOD_CONTROL, MOD_SHIFT, MOD_WIN, MOD_ALT);
{$R *.dfm}

function ForceForegroundWindow(hwnd: THandle): Boolean;
const
  SPI_GETFOREGROUNDLOCKTIMEOUT = $2000;
  SPI_SETFOREGROUNDLOCKTIMEOUT = $2001;
var
  ForegroundThreadID: DWORD;
  ThisThreadID: DWORD;
  timeout: DWORD;
begin
  if IsIconic(hwnd) then ShowWindow(hwnd, SW_RESTORE);

  if GetForegroundWindow = hwnd then Result := True
  else
  begin
    // Windows 98/2000 doesn't want to foreground a window when some other
    // window has keyboard focus

    if ((Win32Platform = VER_PLATFORM_WIN32_NT) and (Win32MajorVersion > 4)) or
      ((Win32Platform = VER_PLATFORM_WIN32_WINDOWS) and
      ((Win32MajorVersion > 4) or ((Win32MajorVersion = 4) and
      (Win32MinorVersion > 0)))) then
    begin
      // Code from Karl E. Peterson, www.mvps.org/vb/sample.htm
      // Converted to Delphi by Ray Lischner
      // Published in The Delphi Magazine 55, page 16

      Result := False;
      ForegroundThreadID := GetWindowThreadProcessID(GetForegroundWindow, nil);
      ThisThreadID := GetWindowThreadPRocessId(hwnd, nil);
      if AttachThreadInput(ThisThreadID, ForegroundThreadID, True) then
      begin
        BringWindowToTop(hwnd); // IE 5.5 related hack
        SetForegroundWindow(hwnd);
        AttachThreadInput(ThisThreadID, ForegroundThreadID, False);
        Result := (GetForegroundWindow = hwnd);
      end;
      if not Result then
      begin
        // Code by Daniel P. Stasinski
        SystemParametersInfo(SPI_GETFOREGROUNDLOCKTIMEOUT, 0, @timeout, 0);
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(0),
          SPIF_SENDCHANGE);
        BringWindowToTop(hwnd); // IE 5.5 related hack
        SetForegroundWindow(hWnd);
        SystemParametersInfo(SPI_SETFOREGROUNDLOCKTIMEOUT, 0, TObject(timeout), SPIF_SENDCHANGE);
      end;
    end
    else
    begin
      BringWindowToTop(hwnd); // IE 5.5 related hack
      SetForegroundWindow(hwnd);
    end;

    Result := (GetForegroundWindow = hwnd);
  end;
end; { ForceForegroundWindow }



procedure TFormBlockPC.Bloquear;
begin
  if FbBloqueou then
  begin
    inc(FnQtdeTentativas);
    if (FnQtdeTentativas > MAX_TENTATIVAS) then
    begin
      btnBloquear.Enabled := False;
      ShowMessage('PC Bloqueado!!!!');
      BloquearTeclado;
      Exit;
    end;

    if (FsSenha = edtSenha.Text) then
      Bloqueou := False;
    TDMUtils.FocusSet(edtSenha);
  end
  else
    Bloqueou := True;
end;

procedure TFormBlockPC.btn1Click(Sender: TObject);
begin
  BloquearMouse;
end;

procedure TFormBlockPC.btnBloquearClick(Sender: TObject);
begin
  if btnBloquear.Enabled then
    Bloquear;
end;

procedure TFormBlockPC.Desregistrar;
begin
  Registrar(False);
end;

procedure TFormBlockPC.edtSenhaExit(Sender: TObject);
begin
  if Bloqueou then
  begin
    Self.SetFocus;
    edtSenha.SetFocus;
  end;
end;

procedure TFormBlockPC.edtSenhaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    btnBloquear.OnClick(btnBloquear);
end;

procedure TFormBlockPC.ForcaForm(Sender: TObject);
begin
  if Bloqueou then
    Exit;

  Application.BringToFront;
  ForceForegroundWindow(Application.Handle);
  TDMUtils.FocusSet(edtSenha);
end;

procedure TFormBlockPC.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := not Bloqueou;
end;

procedure TFormBlockPC.FormCreate(Sender: TObject);
begin
  FsSenha := EmptyStr;
  FnQtdeTentativas := 0;
  Bloqueou := False;
  FdHoraInicio := 0;
  FnQtdeDesativacao := 0;
  FdHoraUltimoKey := 0;
  RegisterPowerSettingNotification()
  Application.OnDeactivate := OnDeactivateApp;
end;

procedure TFormBlockPC.FormDeactivate(Sender: TObject);
begin
  OnDeactivateApp(Sender);
end;

procedure TFormBlockPC.FormDestroy(Sender: TObject);
begin
  if Bloqueou then
    Desregistrar;
end;

procedure TFormBlockPC.FormHide(Sender: TObject);
begin

  if Bloqueou then
  begin
    Self.ShowModal;
    Self.SetFocus;
  end;
end;


function TFormBlockPC.GetBloqueou: Boolean;
begin
  Result := FbBloqueou;
end;

procedure TFormBlockPC.OnDeactivateApp(Sender: TObject);
begin
  if Bloqueou then
  begin
    ForcaForm(Sender);
    BloquearTeclado;
    Inc(FnQtdeDesativacao);
  end;
end;

function TFormBlockPC.PosicaoMouseBlock: TPoint;
begin
  Result := Point(self.Left + btnBloquear.Left + Trunc((btnBloquear.Width / 2)) + (Self.Width - Self.ClientWidth), self.Top + btnBloquear.Top
    + Trunc(btnBloquear.Height / 2) + (Self.Height - Self.ClientHeight));
end;

procedure TFormBlockPC.Registrar(const pbRegistrar: Boolean = True);
var
  i, CountKey, CountAlt: Integer;
  id: Integer;

  procedure SobreescreveKey(const KeyJaSobreescritos: TListIndexKey; const ID_VK: Integer);
  var
    index: Integer;
    ItemModificar: Cardinal;
    IndexKeyModificar: TIndexKey;
  begin
    for Index := Ord(Low(TIndexKey)) to CountAlt do
    begin
      if (TIndexKey(Index) = INDEX_NENHUM) or (TIndexKey(Index) in KeyJaSobreescritos) then
        Continue;

      ItemModificar := 0;
      for IndexKeyModificar in KeyJaSobreescritos do
      begin
        ItemModificar := ItemModificar or Word(TValuesIndexKey[IndexKeyModificar]);
      end;

      Inc(id);
      if pbRegistrar then
        RegisterHotkey(Handle, id, ItemModificar, Cardinal(ID_VK))
      else
        UnregisterHotKey(Handle, id);
      SobreescreveKey(KeyJaSobreescritos + [TIndexKey(index)], ID_VK);
    end;
  end;
begin
  CountAlt := Ord(High(TIndexKey));

  CountKey := Integer(VK_OEM_CLEAR);
  id := CountKey;
  for i := Integer(VK_LBUTTON) to CountKey do
  begin
    if (pbRegistrar) then
      RegisterHotkey(Handle, i, Word(MOD_NOREPEAT), Cardinal(i))
    else
      UnregisterHotKey(Handle, i);

    SobreescreveKey([], i);
  end;

  SobreescreveKey([], -1);
end;

procedure TFormBlockPC.SetBloqueou(const Value: Boolean);
var
  ModificouBloqueio: Boolean;
begin
  ModificouBloqueio := (FbBloqueou <> Value);
  FbBloqueou := Value;
  if ModificouBloqueio then
  begin
    if not FbBloqueou then
    begin
      Desregistrar;
      FnQtdeTentativas := 0;
      FdHoraInicio := 0;
      FnQtdeDesativacao := 0;
      Self.Close;
    end
    else
    begin
      FsSenha := edtSenha.Text;
      edtSenha.Clear;
      Registrar;
      if edtSenha.CanFocus then
        edtSenha.SetFocus;
      FdHoraInicio := now;
    end;
  end;
  btnBloquear.Caption := TDMUtils.IIf(FbBloqueou, 'Desbloquear', 'Bloquear');
  tmrExibeTela.Enabled := FbBloqueou;
end;

procedure TFormBlockPC.tmrExibeTelaTimer(Sender: TObject);
begin
  ForcaForm(Sender);
  lblTempo.Caption := 'Tempo: ' +  TDMUtils.FormatDateTime2(Now - FdHoraInicio)
   + ' - Qtde Desativação: ' + IntToStr(FnQtdeDesativacao) + ' - Último key ' + TDMUtils.FormatDateTime2(FdHoraUltimoKey)
   + ' - Qtde tentativas restantes: ' + IntToStr(MAX_TENTATIVAS - FnQtdeTentativas);
end;

procedure TFormBlockPC.WMHotkey(var Msg: TWMHotkey);
var
  idKey: Integer;
  NovaSenha: string;
begin
  NovaSenha := edtSenha.Text;
  FdHoraUltimoKey := Now;
  idKey := Msg.HotKey;
  case idKey of
    vk0..vkZ: NovaSenha := NovaSenha + Char(idKey);
    VK_BACK: Delete(NovaSenha, Length(NovaSenha), 1);
    VK_RETURN, VK_ESCAPE, VK_END: btnBloquear.OnClick(btnBloquear);
  end;
  edtSenha.Text := NovaSenha;
  edtSenha.ClearSelection;
  edtSenha.SelStart := Length(edtSenha.Text);
end;

procedure TFormBlockPC.WndProc(var Message: TMessage);
begin
  case (Message.Msg) of
    WM_MOUSELEAVE, WM_MOUSEWHEEL, WM_MOUSEACTIVATE,
    WM_MOUSEMOVE, WM_LBUTTONDOWN,
    WM_MOUSELAST, WM_MOUSEHOVER,
    WM_CLOSE, WM_ACTIVATE, WM_QUIT:
    begin
      if Bloqueou then
      begin
        BloquearMouse;
        if (Message.Msg = WM_MOUSEACTIVATE) then
        begin
          btnBloquear.OnClick(btnBloquear);
          SendMessage(Self.Handle, WM_MOUSELEAVE, 0, 0);
        end;
      end
      else
        inherited;
    end;
  else
    inherited;
  end;
end;

procedure TFormBlockPC.BloquearMouse;
var
  Posicao: TPoint;
begin
  Posicao := PosicaoMouseBlock;
  SetCursorPos(Posicao.X, Posicao.Y);
end;

procedure TFormBlockPC.BloquearTeclado;
begin
  Exit;
  BlockInput(true);
  try
    Sleep(10000);
  finally
    BlockInput(False);
  end;
end;

end.

