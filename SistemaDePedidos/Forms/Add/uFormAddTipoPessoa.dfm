inherited FormAddTipoPessoa: TFormAddTipoPessoa
  Caption = 'Cadastro de Tipo da Pessoa'
  ClientHeight = 193
  ClientWidth = 280
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 157
    Width = 280
    object Label1: TLabel
      Left = 16
      Top = 8
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 16
      Top = 56
      Width = 21
      Height = 13
      Caption = 'Tipo'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 16
      Top = 104
      Width = 35
      Height = 13
      Caption = 'Pessoa'
      FocusControl = DBEdit3
    end
    object DBEdit1: TcxDBTextEdit
      Left = 16
      Top = 24
      DataBinding.DataField = 'CODIGO'
      DataBinding.DataSource = dsDados
      TabOrder = 0
      Width = 65
    end
    object DBEdit2: TcxDBTextEdit
      Left = 16
      Top = 72
      DataBinding.DataField = 'CODIGO_TIPO'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 249
    end
    object DBEdit3: TcxDBTextEdit
      Left = 16
      Top = 120
      DataBinding.DataField = 'CODIGO_PESSOA'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 249
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 157
    Width = 280
    inherited btn_Cancel: TcxButton
      Left = 167
    end
    inherited btn_Confirm: TcxButton
      Left = 56
    end
  end
  inherited dsDados: TDataSource
    Left = 104
    Top = 13
  end
end
