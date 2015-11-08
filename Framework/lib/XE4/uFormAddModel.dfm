inherited FormAddModel: TFormAddModel
  Left = 408
  Top = 245
  Caption = 'Add Model'
  ClientHeight = 202
  ClientWidth = 456
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Width = 456
    Height = 166
    Font.Height = -13
  end
  object gb_Navegate: TcxGroupBox [1]
    Left = 0
    Top = 166
    Width = 456
    Height = 36
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object btn_Cancel: TcxButton
      Left = 347
      Top = 4
      Width = 105
      Height = 28
      Cursor = crHandPoint
      Action = ac_Cancel
      TabOrder = 1
    end
    object btn_Confirm: TcxButton
      Left = 236
      Top = 4
      Width = 105
      Height = 28
      Cursor = crHandPoint
      Action = ac_Confirm
      TabOrder = 0
    end
  end
  inherited ActionList: TActionList
    Left = 94
    Top = 24
  end
  object dsDados: TDataSource
    Left = 30
    Top = 17
  end
end
