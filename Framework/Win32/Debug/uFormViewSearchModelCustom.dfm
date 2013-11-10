inherited FormViewSearchModelCustom: TFormViewSearchModelCustom
  Caption = 'FormViewSearchModelCustom'
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TPanel
    Height = 300
    Caption = 'T'#237'tulo'
    ExplicitHeight = 300
    inherited Grid: TDBGrid
      Height = 298
    end
  end
  object gb_Navegate: TPanel [1]
    Left = 0
    Top = 300
    Width = 793
    Height = 36
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      793
      36)
    object btn_Close: TButton
      Left = 665
      Top = 6
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Close
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btn_Select: TButton
      Left = 534
      Top = 6
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Select
      Anchors = [akTop, akRight]
      TabOrder = 0
    end
  end
  inherited ActionList: TActionList
    object ac_Select: TAction
      Caption = '(F2) - Selecionar'
      Enabled = False
      ImageIndex = 0
      ShortCut = 113
      OnExecute = ac_SelectExecute
    end
  end
end
