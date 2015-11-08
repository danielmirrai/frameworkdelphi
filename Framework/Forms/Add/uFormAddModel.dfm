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
    Height = 166
    Width = 456
  end
  object gb_Navegate: TcxGroupBox [1]
    Left = 0
    Top = 166
    Align = alBottom
    PanelStyle.Active = True
    ParentFont = False
    TabOrder = 1
    DesignSize = (
      456
      36)
    Height = 36
    Width = 456
    object btn_Cancel: TcxButton
      Left = 347
      Top = 4
      Width = 105
      Height = 28
      Cursor = crHandPoint
      Action = ac_Cancel
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btn_Confirm: TcxButton
      Left = 236
      Top = 4
      Width = 105
      Height = 28
      Cursor = crHandPoint
      Action = ac_Confirm
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
  end
  inherited ActionList: TActionList
    Left = 70
  end
  object dsDados: TDataSource
    Left = 30
    Top = 17
  end
end
