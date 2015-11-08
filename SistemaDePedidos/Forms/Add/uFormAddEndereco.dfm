inherited FormAddEndereco: TFormAddEndereco
  Top = 24
  Caption = 'Cadastro de Endere'#231'o'
  ClientHeight = 581
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 545
    object lblCod: TLabel
      Left = 8
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = dbedtCod
    end
    object lblPessoa: TLabel
      Left = 8
      Top = 64
      Width = 35
      Height = 13
      Caption = 'Pessoa'
      FocusControl = dbedtPessoa
    end
    object lblTipoEndereco: TLabel
      Left = 8
      Top = 112
      Width = 69
      Height = 13
      Caption = 'Tipo endere'#231'o'
      FocusControl = dbedtTipoEndereco
    end
    object lblCep: TLabel
      Left = 8
      Top = 160
      Width = 21
      Height = 13
      Caption = 'CEP'
      FocusControl = dbedtCep
    end
    object lblCidade: TLabel
      Left = 8
      Top = 208
      Width = 33
      Height = 13
      Caption = 'Cidade'
      FocusControl = dbedtCidade
    end
    object lblBairro: TLabel
      Left = 8
      Top = 256
      Width = 27
      Height = 13
      Caption = 'Bairro'
      FocusControl = dbedtBairro
    end
    object lblRua: TLabel
      Left = 8
      Top = 304
      Width = 20
      Height = 13
      Caption = 'Rua'
      FocusControl = dbedtRua
    end
    object lblNumero: TLabel
      Left = 8
      Top = 352
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
      FocusControl = dbedtNumero
    end
    object lblBloco: TLabel
      Left = 8
      Top = 400
      Width = 67
      Height = 13
      Caption = 'N'#250'mero Bloco'
      FocusControl = dbedtBloco
    end
    object lblAp: TLabel
      Left = 8
      Top = 448
      Width = 68
      Height = 13
      Caption = 'N'#250'mero Apart.'
      FocusControl = dbedtAp
    end
    object lblObs: TLabel
      Left = 8
      Top = 496
      Width = 58
      Height = 13
      Caption = 'Observa'#231#227'o'
      FocusControl = dbedtObs
    end
    object dbedtCod: TcxDBTextEdit
      Left = 8
      Top = 32
      DataBinding.DataField = 'CODIGO'
      DataBinding.DataSource = dsDados
      TabOrder = 0
      Width = 134
    end
    object dbedtPessoa: TcxDBTextEdit
      Left = 8
      Top = 80
      DataBinding.DataField = 'CODIGO_PESSOA'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 134
    end
    object dbedtTipoEndereco: TcxDBTextEdit
      Left = 8
      Top = 128
      DataBinding.DataField = 'TIPO_ENDERECO'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 134
    end
    object dbedtCep: TcxDBTextEdit
      Left = 8
      Top = 176
      DataBinding.DataField = 'CEP'
      DataBinding.DataSource = dsDados
      TabOrder = 3
      Width = 264
    end
    object dbedtCidade: TcxDBTextEdit
      Left = 8
      Top = 224
      DataBinding.DataField = 'CODIGO_CIDADE'
      DataBinding.DataSource = dsDados
      TabOrder = 4
      Width = 134
    end
    object dbedtBairro: TcxDBTextEdit
      Left = 8
      Top = 272
      DataBinding.DataField = 'BAIRRO'
      DataBinding.DataSource = dsDados
      TabOrder = 5
      Width = 3254
    end
    object dbedtRua: TcxDBTextEdit
      Left = 8
      Top = 320
      DataBinding.DataField = 'RUA'
      DataBinding.DataSource = dsDados
      TabOrder = 6
      Width = 3254
    end
    object dbedtNumero: TcxDBTextEdit
      Left = 8
      Top = 368
      DataBinding.DataField = 'NUMERO'
      DataBinding.DataSource = dsDados
      TabOrder = 7
      Width = 134
    end
    object dbedtBloco: TcxDBTextEdit
      Left = 8
      Top = 416
      DataBinding.DataField = 'NUMERO_BLOCO'
      DataBinding.DataSource = dsDados
      TabOrder = 8
      Width = 134
    end
    object dbedtAp: TcxDBTextEdit
      Left = 8
      Top = 464
      DataBinding.DataField = 'NUMERO_APARTAMENTO'
      DataBinding.DataSource = dsDados
      TabOrder = 9
      Width = 134
    end
    object dbedtObs: TcxDBTextEdit
      Left = 8
      Top = 512
      DataBinding.DataField = 'OBSERVACAO'
      DataBinding.DataSource = dsDados
      TabOrder = 10
      Width = 3254
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 545
  end
  inherited dsDados: TDataSource
    Left = 272
    Top = 21
  end
end
