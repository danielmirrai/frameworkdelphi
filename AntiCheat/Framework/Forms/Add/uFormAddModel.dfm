inherited FormAddModel: TFormAddModel
  Left = 404
  Top = 268
  Caption = 'Add Model'
  ClientWidth = 466
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 248
    Width = 466
  end
  object gb_Navegate: TPanel [1]
    Left = 0
    Top = 248
    Width = 466
    Height = 36
    Align = alBottom
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      466
      36)
    object btn_Cancel: TcxButton
      Left = 332
      Top = 6
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Cancel
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btn_Confirm: TcxButton
      Left = 201
      Top = 6
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Confirm
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited cxEditStyleController: TcxEditStyleController
    Style.IsFontAssigned = True
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Left = 78
  end
  object dsDados: TDataSource
    Left = 30
    Top = 17
  end
end
