inherited FormAddSituacaoPedido: TFormAddSituacaoPedido
  Caption = 'Cadastro de Situa'#231#227'o do Pedido'
  ClientHeight = 176
  ClientWidth = 387
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 140
    Width = 387
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 48
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBEdit2
    end
    object DBEdit1: TcxDBTextEdit
      Left = 8
      Top = 32
      DataBinding.DataField = 'CODIGO'
      DataBinding.DataSource = dsDados
      TabOrder = 0
      Width = 134
    end
    object DBEdit2: TcxDBTextEdit
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
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 140
    Width = 387
    inherited btn_Cancel: TcxButton
      Left = 278
    end
    inherited btn_Confirm: TcxButton
      Left = 167
    end
  end
  inherited dsDados: TDataSource
    Left = 272
    Top = 21
  end
end
