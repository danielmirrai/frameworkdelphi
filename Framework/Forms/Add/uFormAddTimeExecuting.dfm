inherited FormAddTimeExecuting: TFormAddTimeExecuting
  Caption = 'Cadastro de TimeExecuting'
  ClientHeight = 317
  ClientWidth = 410
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 281
    Width = 410
    object Label1: TLabel
      Left = 84
      Top = 8
      Width = 11
      Height = 13
      Caption = 'ID'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 74
      Top = 38
      Width = 19
      Height = 13
      Caption = 'Unit'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 66
      Top = 68
      Width = 25
      Height = 13
      Caption = 'Class'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 48
      Top = 98
      Width = 41
      Height = 13
      Caption = 'Function'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 69
      Top = 128
      Width = 24
      Height = 13
      Caption = 'Nivel'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 32
      Top = 158
      Width = 53
      Height = 13
      Caption = 'Time Begin'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 42
      Top = 188
      Width = 45
      Height = 13
      Caption = 'Time End'
      FocusControl = DBEdit7
    end
    object Label8: TLabel
      Left = 58
      Top = 248
      Width = 31
      Height = 13
      Caption = 'Owner'
      FocusControl = DBEdit8
    end
    object Label9: TLabel
      Left = 9
      Top = 218
      Width = 73
      Height = 13
      Caption = 'Time Executing'
      FocusControl = DBEdit9
    end
    object DBEdit1: TcxDBTextEdit
      Left = 102
      Top = 5
      DataBinding.DataField = 'ID_TIME_EXECUTING'
      DataBinding.DataSource = dsDados
      TabOrder = 0
      Width = 134
    end
    object DBEdit2: TcxDBTextEdit
      Left = 102
      Top = 35
      DataBinding.DataField = 'ID_UNIT'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 300
    end
    object DBEdit3: TcxDBTextEdit
      Left = 102
      Top = 65
      DataBinding.DataField = 'ID_CLASS'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 300
    end
    object DBEdit4: TcxDBTextEdit
      Left = 102
      Top = 95
      DataBinding.DataField = 'ID_FUNCTION'
      DataBinding.DataSource = dsDados
      TabOrder = 3
      Width = 300
    end
    object DBEdit5: TcxDBTextEdit
      Left = 102
      Top = 125
      DataBinding.DataField = 'ID_NIVEL'
      DataBinding.DataSource = dsDados
      TabOrder = 4
      Width = 134
    end
    object DBEdit6: TcxDBTextEdit
      Left = 102
      Top = 155
      DataBinding.DataField = 'DATE_BEGIN'
      DataBinding.DataSource = dsDados
      TabOrder = 5
      Width = 134
    end
    object DBEdit7: TcxDBTextEdit
      Left = 102
      Top = 185
      DataBinding.DataField = 'DATE_END'
      DataBinding.DataSource = dsDados
      TabOrder = 6
      Width = 134
    end
    object DBEdit8: TcxDBTextEdit
      Left = 102
      Top = 245
      DataBinding.DataField = 'ID_OWNER'
      DataBinding.DataSource = dsDados
      TabOrder = 8
      Width = 134
    end
    object DBEdit9: TcxDBTextEdit
      Left = 102
      Top = 215
      DataBinding.DataField = 'TIME_EXECUTING'
      DataBinding.DataSource = dsDados
      TabOrder = 7
      Width = 134
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 281
    Width = 410
    inherited btn_Cancel: TcxButton
      Left = 301
    end
    inherited btn_Confirm: TcxButton
      Left = 190
    end
  end
  inherited ActionList: TActionList
    Left = 278
  end
  inherited dsDados: TDataSource
    Left = 336
    Top = 21
  end
end
