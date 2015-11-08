inherited FormAddTipo: TFormAddTipo
  Caption = 'Cadastro de Tipo'
  ClientHeight = 178
  ClientWidth = 370
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 142
    Width = 370
    object lblCodigo: TLabel
      Left = 8
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = dbedtCodigo
    end
    object lblDesc: TLabel
      Left = 8
      Top = 64
      Width = 48
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = dbedtDesc
    end
    object dbedtCodigo: TcxDBTextEdit
      Left = 8
      Top = 32
      DataBinding.DataField = 'CODIGO'
      DataBinding.DataSource = dsDados
      TabOrder = 0
      Width = 134
    end
    object dbedtDesc: TcxDBTextEdit
      Left = 8
      Top = 80
      DataBinding.DataField = 'DESCRICAO'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 350
    end
    object dbchkAtivo: TDBCheckBox
      Left = 8
      Top = 112
      Width = 97
      Height = 17
      Caption = 'Ativo'
      TabOrder = 2
      ValueChecked = '1'
      ValueUnchecked = '0'
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 142
    Width = 370
    inherited btn_Cancel: TcxButton
      Left = 261
    end
    inherited btn_Confirm: TcxButton
      Left = 150
    end
  end
  inherited dsDados: TDataSource
    Left = 272
    Top = 21
  end
end
