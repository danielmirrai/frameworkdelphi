inherited FormViewModelCustom: TFormViewModelCustom
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'View Model'
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 299
    Caption = 'T'#237'tulo'
    inherited Grid: TDBGrid
      Height = 297
    end
  end
  object gb_Navegate: TcxGroupBox [1]
    Left = 0
    Top = 299
    Width = 793
    Height = 37
    Align = alBottom
    TabOrder = 1
    object btn_Close: TcxButton
      Left = 684
      Top = 4
      Width = 105
      Height = 29
      Cursor = crHandPoint
      Action = ac_Close
      Default = True
      DragCursor = crHandPoint
      TabOrder = 0
    end
  end
  inherited ActionList: TActionList
    Top = 119
    object ac_OpenView: TAction
      Caption = 'ac_OpenView'
      OnExecute = ac_OpenViewExecute
    end
  end
end
