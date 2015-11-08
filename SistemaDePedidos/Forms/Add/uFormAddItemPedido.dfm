inherited FormAddItemPedido: TFormAddItemPedido
  Top = 44
  Caption = 'Cadastro de Item do Pedido'
  ClientHeight = 488
  ClientWidth = 371
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 452
    Width = 371
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
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 8
      Top = 112
      Width = 37
      Height = 13
      Caption = 'Produto'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 8
      Top = 160
      Width = 33
      Height = 13
      Caption = 'Pedido'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 8
      Top = 208
      Width = 55
      Height = 13
      Caption = 'Quantidade'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 8
      Top = 256
      Width = 51
      Height = 13
      Caption = 'Cancelado'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 8
      Top = 304
      Width = 76
      Height = 13
      Caption = 'Valor Acrescimo'
      FocusControl = DBEdit7
    end
    object Label8: TLabel
      Left = 8
      Top = 352
      Width = 73
      Height = 13
      Caption = 'Valor Desconto'
      FocusControl = DBEdit8
    end
    object Label9: TLabel
      Left = 8
      Top = 400
      Width = 63
      Height = 13
      Caption = 'Valor Unit'#225'rio'
      FocusControl = DBEdit9
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
      DataBinding.DataField = 'NUMERO'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 134
    end
    object DBEdit3: TcxDBTextEdit
      Left = 8
      Top = 128
      DataBinding.DataField = 'CODIGO_PRODUTO'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 134
    end
    object DBEdit4: TcxDBTextEdit
      Left = 8
      Top = 176
      DataBinding.DataField = 'CODIGO_PEDIDO'
      DataBinding.DataSource = dsDados
      TabOrder = 3
      Width = 134
    end
    object DBEdit5: TcxDBTextEdit
      Left = 8
      Top = 224
      DataBinding.DataField = 'QUANTIDADE'
      DataBinding.DataSource = dsDados
      TabOrder = 4
      Width = 134
    end
    object DBEdit6: TcxDBTextEdit
      Left = 8
      Top = 272
      DataBinding.DataField = 'FL_CANCELADO'
      DataBinding.DataSource = dsDados
      TabOrder = 5
      Width = 134
    end
    object DBEdit7: TcxDBTextEdit
      Left = 8
      Top = 320
      DataBinding.DataField = 'VALOR_ACRESCIMO'
      DataBinding.DataSource = dsDados
      TabOrder = 6
      Width = 134
    end
    object DBEdit8: TcxDBTextEdit
      Left = 8
      Top = 368
      DataBinding.DataField = 'VALOR_DESCONTO'
      DataBinding.DataSource = dsDados
      TabOrder = 7
      Width = 134
    end
    object DBEdit9: TcxDBTextEdit
      Left = 8
      Top = 416
      DataBinding.DataField = 'VALOR_UNITARIO'
      DataBinding.DataSource = dsDados
      TabOrder = 8
      Width = 134
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 452
    Width = 371
    inherited btn_Cancel: TcxButton
      Left = 262
    end
    inherited btn_Confirm: TcxButton
      Left = 151
    end
  end
  inherited dsDados: TDataSource
    Left = 272
    Top = 21
  end
end
