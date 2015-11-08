inherited FormViewModelCustom: TFormViewModelCustom
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'View Model'
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Caption = 'T'#237'tulo'
    Height = 299
  end
  object gb_Navegate: TPanel [1]
    Left = 0
    Top = 299
    Width = 793
    Height = 37
    Align = alBottom
    TabOrder = 2
    object btn_Close: TButton
      Left = 659
      Top = 5
      Width = 125
      Height = 25
      Action = ac_Close
      TabOrder = 0
    end
  end
  inherited Grid: TcxGrid
    Height = 299
  end
  inherited cxEditStyleController: TcxEditStyleController
    Style.IsFontAssigned = True
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Top = 127
    object ac_OpenView: TAction
      Caption = 'ac_OpenView'
      OnExecute = ac_OpenViewExecute
    end
  end
end
