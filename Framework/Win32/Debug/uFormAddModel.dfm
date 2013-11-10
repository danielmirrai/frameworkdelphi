inherited FormAddModel: TFormAddModel
  Left = 404
  Top = 268
  Caption = 'Add Model'
  ClientWidth = 466
  OnClose = FormClose
  ExplicitWidth = 472
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TPanel
    Width = 466
    Height = 176
    ExplicitWidth = 466
    ExplicitHeight = 176
  end
  object gb_Navegate: TPanel [1]
    Left = 0
    Top = 176
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
    object btn_Cancel: TButton
      Left = 338
      Top = 6
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Cancel
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btn_Confirm: TButton
      Left = 207
      Top = 6
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Confirm
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
  end
  inherited ActionList: TActionList
    Left = 78
    inherited ac_Refresh: TAction
      OnExecute = ac_RefreshExecute
    end
  end
  object dsDados: TDataSource
    Left = 30
    Top = 17
  end
end
