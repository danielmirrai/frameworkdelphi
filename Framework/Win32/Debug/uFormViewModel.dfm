inherited FormViewModel: TFormViewModel
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TPanel
    inherited Grid: TDBGrid
      OnDblClick = GridDblClick
    end
  end
  inherited gb_Navegate: TPanel
    inherited btn_Close: TButton
      TabOrder = 3
    end
    object btn_Edit: TButton
      Left = 397
      Top = 5
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Edit
      TabOrder = 1
    end
    object btn_Add: TButton
      Left = 266
      Top = 5
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Add
      TabOrder = 0
    end
    object btnDlete: TButton
      Left = 528
      Top = 5
      Width = 125
      Height = 25
      Cursor = crHandPoint
      Action = ac_Delete
      TabOrder = 2
    end
  end
  inherited ActionList: TActionList
    Top = 128
    object ac_Add: TAction [1]
      Caption = '(F2) - &Add'
      ShortCut = 113
      OnExecute = ac_AddExecute
    end
    object ac_Edit: TAction [2]
      Caption = '(F3) - &Edit'
      Enabled = False
      ShortCut = 114
      OnExecute = ac_EditExecute
    end
    object ac_Delete: TAction [3]
      Caption = '(Del) - &Delete'
      ShortCut = 46
      OnExecute = ac_DeleteExecute
    end
    inherited ac_Refresh: TAction
      OnExecute = ac_RefreshExecute
    end
  end
  inherited dsDados: TDataSource
    OnStateChange = dsDadosStateChange
    OnDataChange = dsDadosDataChange
    OnUpdateData = dsDadosUpdateData
  end
end
