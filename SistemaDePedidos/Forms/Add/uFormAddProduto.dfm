inherited FormAddProduto: TFormAddProduto
  Left = 315
  Top = 188
  Caption = 'Cadastro de Produto'
  ClientHeight = 474
  ClientWidth = 830
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 438
    Width = 830
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 28
      Height = 13
      Caption = 'Nome'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 16
      Top = 112
      Width = 48
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 16
      Top = 160
      Width = 40
      Height = 13
      Caption = 'Barcode'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 16
      Top = 208
      Width = 63
      Height = 13
      Caption = 'Valor Unit'#225'rio'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 16
      Top = 328
      Width = 58
      Height = 13
      Caption = 'Observa'#231#227'o'
      FocusControl = DBMemo1
    end
    object Label8: TLabel
      Left = 16
      Top = 256
      Width = 41
      Height = 13
      Caption = 'Empresa'
      FocusControl = DBEdit7
    end
    object DBEdit1: TcxDBTextEdit
      Left = 16
      Top = 32
      DataBinding.DataField = 'CODIGO'
      DataBinding.DataSource = dsDados
      TabOrder = 0
      Width = 134
    end
    object DBEdit2: TcxDBTextEdit
      Left = 16
      Top = 80
      DataBinding.DataField = 'NOME'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 3254
    end
    object DBEdit3: TcxDBTextEdit
      Left = 16
      Top = 128
      DataBinding.DataField = 'DESCRICAO'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 3254
    end
    object DBEdit4: TcxDBTextEdit
      Left = 16
      Top = 176
      DataBinding.DataField = 'BARCODE'
      DataBinding.DataSource = dsDados
      TabOrder = 3
      Width = 134
    end
    object DBEdit5: TcxDBTextEdit
      Left = 16
      Top = 224
      DataBinding.DataField = 'VALOR_UNITARIO'
      DataBinding.DataSource = dsDados
      TabOrder = 4
      Width = 134
    end
    object DBMemo1: TDBMemo
      Left = 2
      Top = 347
      Width = 826
      Height = 89
      Align = alBottom
      TabOrder = 5
    end
    object DBEdit7: TcxDBTextEdit
      Left = 16
      Top = 272
      DataBinding.DataField = 'CODIGO_EMPRESA'
      DataBinding.DataSource = dsDados
      TabOrder = 6
      Width = 134
    end
    object dbchkAtivo: TDBCheckBox
      Left = 16
      Top = 304
      Width = 97
      Height = 17
      Caption = 'Ativo'
      TabOrder = 7
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 438
    Width = 830
    inherited btn_Cancel: TcxButton
      Left = 721
    end
    inherited btn_Confirm: TcxButton
      Left = 610
    end
  end
  inherited dsDados: TDataSource
    Left = 272
    Top = 21
  end
end
