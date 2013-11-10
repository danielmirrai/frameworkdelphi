inherited FormViewModelCustom: TFormViewModelCustom
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'View Model'
  ExplicitWidth = 799
  ExplicitHeight = 364
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TPanel
    Height = 299
    Caption = 'T'#237'tulo'
    ExplicitHeight = 299
    inherited Grid: TDBGrid
      Height = 297
    end
  end
  object gb_Navegate: TPanel [1]
    Left = 0
    Top = 299
    Width = 793
    Height = 37
    Align = alBottom
    TabOrder = 1
    object btn_Close: TButton
      Left = 659
      Top = 5
      Width = 125
      Height = 25
      Action = ac_Close
      TabOrder = 0
    end
  end
  inherited ActionList: TActionList
    Top = 127
    object ac_OpenView: TAction
      Caption = 'ac_OpenView'
      OnExecute = ac_OpenViewExecute
    end
  end
end
