unit ProjectA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormTeclaWindows = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure WMHotkey(var Msg: TWMHotkey); message WM_HOTKEY;
    procedure EnviaWindowsNovaTecla;
    procedure Registrar;
    procedure Desregistrar;
  public
    { Public declarations }
    FRegistrou: Boolean;
  end;

  TIndexKey = (INDEX_NENHUM = MOD_NOREPEAT, INDEX_SHIFT = MOD_SHIFT);
implementation


{$R *.dfm}

procedure TFormTeclaWindows.FormCreate(Sender: TObject);
begin
  FRegistrou := False;
  RegisterHotkey(Handle, Integer(MOD_CONTROL), Word(MOD_SHIFT) or
    Word(MOD_CONTROL), Word('W'));
  Registrar;
end;

procedure TFormTeclaWindows.FormDestroy(Sender: TObject);
begin
  Desregistrar;
  UnRegisterHotkey(Handle, Integer(MOD_CONTROL));
end;

procedure TFormTeclaWindows.Desregistrar;
var
  i: Integer;
begin
  if FRegistrou then
  begin
    // UnRegisterHotkey(Handle, 1);

    for i := Ord(Low(TIndexKey)) to Ord(High(TIndexKey)) do
    begin
      UnRegisterHotkey(Handle, Integer(TIndexKey(i)));
    end;
    FRegistrou := False;
  end;
end;

procedure TFormTeclaWindows.Registrar;
var
  i: Integer;
begin
  if not FRegistrou then
  begin
    FRegistrou := True;
    for i := Ord(Low(TIndexKey)) to Ord(High(TIndexKey)) do
    begin
      RegisterHotkey(Handle, Integer(TIndexKey(i)), Word(TIndexKey(i)),Word('W'));
    end;
  end;
end;

procedure TFormTeclaWindows.EnviaWindowsNovaTecla;
var
  KeyInputs: array of TInput;

  procedure KeybdInput(VKey: Byte; const Precionar: Boolean = False);
  var
    Flags: DWORD;
    LengthKeys: Byte;
  begin
    Flags := 0;
    if Precionar then
      Flags := KEYEVENTF_KEYUP;

    LengthKeys := Length(KeyInputs);
    SetLength(KeyInputs, LengthKeys + 1);
    KeyInputs[LengthKeys].Itype := INPUT_KEYBOARD;
    KeyInputs[LengthKeys].ki.wVk := VKey;
    KeyInputs[LengthKeys].ki.wScan :=
      MapVirtualKey(KeyInputs[LengthKeys].ki.wVk, 0);
    KeyInputs[LengthKeys].ki.dwFlags := Flags;
  end;

  procedure PrecionarTodas;
  var
    LengthKeys, i: Byte;
  begin
    LengthKeys := Length(KeyInputs) - 1;
    for i := LengthKeys downto 0 do
    begin
      KeybdInput(KeyInputs[i].ki.wVk, True);
    end;
  end;

  procedure Enviar;
  var
    LengthKeys, i: Byte;
  begin
    LengthKeys := Length(KeyInputs) - 1;
    for i := 0 to LengthKeys do
    begin
      SendInput(Length(KeyInputs), KeyInputs[i], SizeOf(KeyInputs[i]));
    end;
  end;

begin
  SetLength(KeyInputs, 0);
  KeybdInput(Ord('A'));
  PrecionarTodas;
  Enviar;
end;

procedure TFormTeclaWindows.WMHotkey(var Msg: TWMHotkey);
begin
  case Msg.HotKey of
    Integer(MOD_CONTROL):
      begin
        if FRegistrou then
          Desregistrar
        else
          Registrar;
      end;
  else
    EnviaWindowsNovaTecla;
  end;
end;

end.
