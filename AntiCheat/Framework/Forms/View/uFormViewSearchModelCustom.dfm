inherited FormViewSearchModelCustom: TFormViewSearchModelCustom
  Caption = 'FormViewSearchModelCustom'
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Caption = 'T'#237'tulo'
    Height = 300
  end
  object gb_Navegate: TPanel [1]
    Left = 0
    Top = 300
    Width = 793
    Height = 36
    Align = alBottom
    TabOrder = 2
    DesignSize = (
      793
      36)
    object btn_Close: TcxButton
      Left = 665
      Top = 6
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Close
      Anchors = [akTop, akRight]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btn_Select: TcxButton
      Left = 534
      Top = 6
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Select
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
  inherited Grid: TcxGrid
    Height = 300
    inherited GridDBTableView_Dados: TcxGridDBTableView
      OnDblClick = GridDBTableView_DadosDblClick
    end
  end
  inherited cxEditStyleController: TcxEditStyleController
    Style.IsFontAssigned = True
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
