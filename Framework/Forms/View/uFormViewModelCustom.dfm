inherited FormViewModelCustom: TFormViewModelCustom
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  Caption = 'View Model'
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Caption = 'T'#237'tulo'
    Height = 299
    inherited cxgridView: TcxGrid
      Height = 295
    end
    object cxGroupBox1: TcxGroupBox
      Left = 448
      Top = 112
      Caption = 'cxGroupBox1'
      TabOrder = 1
      Height = 105
      Width = 185
    end
  end
  object gb_Navegate: TcxGroupBox [1]
    Left = 0
    Top = 299
    Align = alBottom
    PanelStyle.Active = True
    TabOrder = 1
    Height = 37
    Width = 793
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
