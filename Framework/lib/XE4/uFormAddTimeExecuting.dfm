inherited FormAddTimeExecuting: TFormAddTimeExecuting
  Caption = 'Cadastro de TimeExecuting'
  ClientHeight = 317
  ClientWidth = 410
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Width = 410
    Height = 281
    object Label1: TLabel
      Left = 84
      Top = 8
      Width = 12
      Height = 16
      Caption = 'ID'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 74
      Top = 38
      Width = 22
      Height = 16
      Caption = 'Unit'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 66
      Top = 68
      Width = 30
      Height = 16
      Caption = 'Class'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 48
      Top = 98
      Width = 48
      Height = 16
      Caption = 'Function'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 69
      Top = 128
      Width = 27
      Height = 16
      Caption = 'Nivel'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 32
      Top = 158
      Width = 64
      Height = 16
      Caption = 'Time Begin'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 42
      Top = 188
      Width = 54
      Height = 16
      Caption = 'Time End'
      FocusControl = DBEdit7
    end
    object Label8: TLabel
      Left = 58
      Top = 248
      Width = 38
      Height = 16
      Caption = 'Owner'
      FocusControl = DBEdit8
    end
    object Label9: TLabel
      Left = 9
      Top = 218
      Width = 87
      Height = 16
      Caption = 'Time Executing'
      FocusControl = DBEdit9
    end
    object DBEdit1: TcxDBTextEdit
      Left = 102
      Top = 5
      Width = 134
      Height = 24
      DataBinding.DataField = 'ID_TIME_EXECUTING'
      DataBinding.DataSource = dsDados
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TcxDBTextEdit
      Left = 102
      Top = 35
      Width = 300
      Height = 24
      DataBinding.DataField = 'ID_UNIT'
      DataBinding.DataSource = dsDados
      TabOrder = 1
    end
    object DBEdit3: TcxDBTextEdit
      Left = 102
      Top = 65
      Width = 300
      Height = 24
      DataBinding.DataField = 'ID_CLASS'
      DataBinding.DataSource = dsDados
      TabOrder = 2
    end
    object DBEdit4: TcxDBTextEdit
      Left = 102
      Top = 95
      Width = 300
      Height = 24
      DataBinding.DataField = 'ID_FUNCTION'
      DataBinding.DataSource = dsDados
      TabOrder = 3
    end
    object DBEdit5: TcxDBTextEdit
      Left = 102
      Top = 125
      Width = 134
      Height = 24
      DataBinding.DataField = 'ID_NIVEL'
      DataBinding.DataSource = dsDados
      TabOrder = 4
    end
    object DBEdit6: TcxDBTextEdit
      Left = 102
      Top = 155
      Width = 134
      Height = 24
      DataBinding.DataField = 'DATE_BEGIN'
      DataBinding.DataSource = dsDados
      TabOrder = 5
    end
    object DBEdit7: TcxDBTextEdit
      Left = 102
      Top = 185
      Width = 134
      Height = 24
      DataBinding.DataField = 'DATE_END'
      DataBinding.DataSource = dsDados
      TabOrder = 6
    end
    object DBEdit8: TcxDBTextEdit
      Left = 102
      Top = 245
      Width = 134
      Height = 24
      DataBinding.DataField = 'ID_OWNER'
      DataBinding.DataSource = dsDados
      TabOrder = 8
    end
    object DBEdit9: TcxDBTextEdit
      Left = 102
      Top = 215
      Width = 134
      Height = 24
      DataBinding.DataField = 'TIME_EXECUTING'
      DataBinding.DataSource = dsDados
      ReadOnly = True
      TabOrder = 7
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
