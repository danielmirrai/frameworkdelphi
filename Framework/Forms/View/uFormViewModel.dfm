inherited FormViewModel: TFormViewModel
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Navegate: TcxGroupBox
    inherited btn_Close: TcxButton
      TabOrder = 3
    end
    object btn_Add: TcxButton
      Left = 351
      Top = 4
      Width = 105
      Height = 29
      Cursor = crHandPoint
      Action = ac_Add
      DragCursor = crHandPoint
      TabOrder = 0
    end
    object btn_Edit: TcxButton
      Left = 462
      Top = 4
      Width = 105
      Height = 29
      Cursor = crHandPoint
      Action = ac_Edit
      TabOrder = 1
    end
    object btnDelete: TcxButton
      Left = 573
      Top = 4
      Width = 105
      Height = 29
      Cursor = crHandPoint
      Action = ac_Delete
      TabOrder = 2
    end
    object btn_Select: TcxButton
      Left = 328
      Top = 4
      Width = 17
      Height = 29
      Cursor = crHandPoint
      Action = ac_SelectItem
      Cancel = True
      DragCursor = crHandPoint
      TabOrder = 4
    end
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
      Enabled = False
      ShortCut = 46
      OnExecute = ac_DeleteExecute
    end
    object ac_DeleteAll: TAction
      Category = 'Control'
      Caption = 'Delete All'
      OnExecute = ac_DeleteAllExecute
    end
    object ac_SelectAll: TAction
      Caption = 'ac_SelectAll'
      Visible = False
    end
    object ac_SelectNone: TAction
      Caption = 'ac_SelectNone'
      Visible = False
    end
    object ac_SelectItem: TAction
      Category = 'Control'
      Caption = '(F6) - &Selecionar'
      Enabled = False
      ShortCut = 117
      Visible = False
      OnExecute = ac_SelectItemExecute
    end
  end
  inherited dsDados: TDataSource
    OnStateChange = dsDadosStateChange
    OnDataChange = dsDadosDataChange
    OnUpdateData = dsDadosUpdateData
  end
  inherited pmGrid: TPopupMenu
    object mniDeleteAll: TMenuItem
      Action = ac_DeleteAll
    end
  end
end
