unit ProjectA;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TFormTeclaWindows = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    procedure WMHotkey(var Msg: TWMHotkey); message WM_HOTKEY;
    procedure EnviaWindowsNovaTecla(const RemoverTeclaAlt: Boolean);
    procedure Registrar;
    procedure Desregistrar;
  public
    { Public declarations }
  end;



var
  FormTeclaWindows: TFormTeclaWindows;

implementation

type
  TIndexKey = (INDEX_NENHUM = MOD_NOREPEAT, INDEX_CONTROL = MOD_CONTROL,
    INDEX_SHIFT = MOD_SHIFT, INDEX_ALT = MOD_ALT);

const
  KEY_Y = 89;

{$R *.dfm}

procedure TFormTeclaWindows.FormCreate(Sender: TObject);
begin
  Registrar;
end;

procedure TFormTeclaWindows.FormDestroy(Sender: TObject);
begin
  Desregistrar;
end;

procedure TFormTeclaWindows.Desregistrar;
var
  i: Integer;
begin
  for i := Ord(Low(TIndexKey)) to Ord(High(TIndexKey)) do
  begin
    UnRegisterHotkey(Handle, Integer(TIndexKey(i)));
  end;
  Application.ProcessMessages;
end;

procedure TFormTeclaWindows.Registrar;
var
  i: Integer;
begin
  Application.ProcessMessages;
  for i := Ord(Low(TIndexKey)) to Ord(High(TIndexKey)) do
  begin
    RegisterHotkey(Handle, Integer(TIndexKey(i)), Word(TIndexKey(i)), KEY_Y);
  end;
  Application.ProcessMessages;
end;

procedure TFormTeclaWindows.EnviaWindowsNovaTecla(const RemoverTeclaAlt: Boolean);
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
    KeyInputs[LengthKeys].ki.wScan := MapVirtualKey(KeyInputs[LengthKeys].ki.wVk, 0);
    KeyInputs[LengthKeys].ki.dwFlags := Flags;
  end;

  procedure PrecisarTodas;
  var
    LengthKeys, i: Byte;
  begin
    LengthKeys := Length(KeyInputs) - 1;
    for i := LengthKeys downto 0 do
    begin
      KeybdInput(KeyInputs[i].ki.wVk, True);
    end;
  end;
begin
//  Desregistrar;
  try
    SetLength(KeyInputs, 0);
    if RemoverTeclaAlt then
    begin
      KeybdInput(VK_MENU);
      KeybdInput(Ord('W'));//Y
      KeybdInput(VK_MENU, True);
      KeybdInput(Ord('d'));
      KeybdInput(Ord('d'), True);
    end
    else
    begin
      KeybdInput(Ord('A'));
      PrecisarTodas;
    end;

    SendInput(Length(KeyInputs), KeyInputs[0], SizeOf(KeyInputs[0]));
  finally
//    Registrar;
  END;
end;

procedure TFormTeclaWindows.WMHotkey(var Msg: TWMHotkey);
begin
  EnviaWindowsNovaTecla(msg.HotKey = Cardinal(INDEX_ALT));
end;

end.
