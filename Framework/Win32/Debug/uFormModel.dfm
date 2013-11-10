inherited FormModel: TFormModel
  BorderIcons = [biSystemMenu]
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  ExplicitWidth = 476
  PixelsPerInch = 96
  TextHeight = 13
  object gb_Dados: TPanel
    Left = 0
    Top = 0
    Width = 470
    Height = 212
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object ActionList: TActionList
    Left = 398
    Top = 128
    object ac_Close: TAction
      Caption = '(ESC) - &Close'
      ImageIndex = 2
      ShortCut = 27
      OnExecute = ac_CloseExecute
    end
    object ac_Refresh: TAction
      Caption = 'ac_Refresh'
      ShortCut = 116
    end
  end
end
