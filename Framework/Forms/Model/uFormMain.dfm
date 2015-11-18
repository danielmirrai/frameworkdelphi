object FormMain: TFormMain
  Left = 220
  Top = 117
  Width = 928
  Height = 480
  Caption = 'Princ'#237'pal'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mm
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object mm: TMainMenu
    Left = 64
    Top = 80
  end
  object actlst: TActionList
    Left = 398
    Top = 128
    object ac_Close: TAction
      Caption = '(ESC) - &Close'
      ImageIndex = 2
      ShortCut = 27
    end
    object ac_Refresh: TAction
      Caption = 'ac_Refresh'
      ShortCut = 116
    end
    object act_OpenForm: TAction
      Caption = 'Cadastro de Pedidos'
      OnExecute = act_OpenFormExecute
    end
  end
end
