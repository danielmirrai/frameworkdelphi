inherited FormViewModel: TFormViewModel
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Navegate: TPanel
    inherited btn_Close: TcxButton
      Left = 659
      TabOrder = 3
    end
    object btn_Edit: TcxButton
      Left = 398
      Top = 5
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Edit
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object btn_Add: TcxButton
      Left = 267
      Top = 5
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Add
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object btnDlete: TcxButton
      Left = 529
      Top = 5
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Delete
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
  end
  inherited Grid: TcxGrid
    inherited GridDBTableView_Dados: TcxGridDBTableView
      OnDblClick = GridDBTableView_DadosDblClick
    end
  end
  inherited cxEditStyleController: TcxEditStyleController
    Style.IsFontAssigned = True
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Top = 128
    inherited ac_Close: TAction
      Category = 'Control'
    end
    object ac_Add: TAction [1]
      Category = 'Control'
      Caption = '(F2) - &Add'
      ShortCut = 113
      OnExecute = ac_AddExecute
    end
    object ac_Edit: TAction [2]
      Category = 'Control'
      Caption = '(F3) - &Edit'
      Enabled = False
      ShortCut = 114
      OnExecute = ac_EditExecute
    end
    object ac_Delete: TAction [3]
      Category = 'Control'
      Caption = '(Del) - &Delete'
      ShortCut = 46
      OnExecute = ac_DeleteExecute
    end
  end
  inherited dsDados: TDataSource
    OnStateChange = dsDadosStateChange
    OnDataChange = dsDadosDataChange
    OnUpdateData = dsDadosUpdateData
  end
end
