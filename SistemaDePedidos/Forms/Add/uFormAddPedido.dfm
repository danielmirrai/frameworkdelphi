inherited FormAddPedido: TFormAddPedido
  Left = 288
  Top = 43
  Caption = 'Cadastro de Pedido'
  ClientHeight = 475
  ClientWidth = 435
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 439
    Width = 435
    object Label1: TLabel
      Left = 23
      Top = 19
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 7
      Top = 51
      Width = 48
      Height = 13
      Caption = 'Descri'#231#227'o'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 18
      Top = 83
      Width = 37
      Height = 13
      Caption = 'N'#250'mero'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 240
      Top = 84
      Width = 65
      Height = 13
      Caption = 'Data Emiss'#227'o'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 3
      Top = 115
      Width = 54
      Height = 13
      Caption = 'Data Venc.'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 240
      Top = 112
      Width = 63
      Height = 13
      Caption = 'Data Entrega'
      FocusControl = DBEdit6
    end
    object Label8: TLabel
      Left = 16
      Top = 168
      Width = 46
      Height = 13
      Caption = 'Endere'#231'o'
      FocusControl = DBEdit8
    end
    object Label11: TLabel
      Left = 216
      Top = 267
      Width = 73
      Height = 13
      Caption = 'Perc. Comiss'#227'o'
      FocusControl = DBEdit11
    end
    object Label12: TLabel
      Left = 5
      Top = 267
      Width = 51
      Height = 13
      Caption = 'Valor Total'
      FocusControl = DBEdit12
    end
    object Label13: TLabel
      Left = 46
      Top = 294
      Width = 21
      Height = 13
      Caption = 'NFE'
      FocusControl = DBEdit13
    end
    object Label14: TLabel
      Left = 2
      Top = 324
      Width = 58
      Height = 13
      Anchors = [akLeft, akBottom]
      Caption = 'Observa'#231#227'o'
      FocusControl = DBMemo1
    end
    object DBEdit1: TcxDBTextEdit
      Left = 72
      Top = 16
      DataBinding.DataField = 'CODIGO'
      DataBinding.DataSource = dsDados
      TabOrder = 0
      Width = 49
    end
    object DBEdit2: TcxDBTextEdit
      Left = 72
      Top = 48
      DataBinding.DataField = 'DESCRICAO'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 353
    end
    object DBEdit3: TcxDBTextEdit
      Left = 72
      Top = 80
      DataBinding.DataField = 'NUMERO'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 134
    end
    object DBEdit4: TcxDBTextEdit
      Left = 320
      Top = 80
      DataBinding.DataField = 'DATA_EMISSAO'
      DataBinding.DataSource = dsDados
      TabOrder = 3
      Width = 105
    end
    object DBEdit5: TcxDBTextEdit
      Left = 72
      Top = 112
      DataBinding.DataField = 'DATA_VENCIMENTO'
      DataBinding.DataSource = dsDados
      TabOrder = 4
      Width = 100
    end
    object DBEdit6: TcxDBTextEdit
      Left = 320
      Top = 112
      DataBinding.DataField = 'DATA_ENTREGA'
      DataBinding.DataSource = dsDados
      TabOrder = 5
      Width = 105
    end
    object DBEdit8: TcxDBTextEdit
      Left = 72
      Top = 168
      DataBinding.DataField = 'CODIGO_ENDERECO_CLIENTE'
      DataBinding.DataSource = dsDados
      TabOrder = 6
      Width = 353
    end
    object DBEdit11: TcxDBTextEdit
      Left = 312
      Top = 264
      DataBinding.DataField = 'PERC_COMISSAO_VERDEDOR'
      DataBinding.DataSource = dsDados
      TabOrder = 10
      Width = 113
    end
    object DBEdit12: TcxDBTextEdit
      Left = 72
      Top = 264
      DataBinding.DataField = 'VALOR_TOTAL'
      DataBinding.DataSource = dsDados
      TabOrder = 9
      Width = 134
    end
    object DBEdit13: TcxDBTextEdit
      Left = 72
      Top = 291
      DataBinding.DataField = 'NFE'
      DataBinding.DataSource = dsDados
      TabOrder = 11
      Width = 353
    end
    object DBMemo1: TDBMemo
      Left = 2
      Top = 348
      Width = 431
      Height = 89
      Align = alBottom
      TabOrder = 12
    end
    object FrameLookupModel2: TFrameLookupModel
      Left = 8
      Top = 226
      Width = 417
      Height = 31
      AutoScroll = False
      TabOrder = 8
      Title = 'Vendedor'
    end
    object frmlkpmdlCODIGO_SITUACAO: TFrameLookupModel
      Left = 13
      Top = 195
      Width = 412
      Height = 31
      AutoScroll = False
      TabOrder = 7
      Title = 'Situa'#231#227'o'
    end
    object frmlkpmdlCODIGO_CLIENTE: TFrameLookupModel
      Left = 24
      Top = 139
      Width = 401
      Height = 30
      AutoScroll = False
      TabOrder = 13
      Title = 'Cliente'
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 439
    Width = 435
    inherited btn_Cancel: TcxButton
      Left = 326
    end
    inherited btn_Confirm: TcxButton
      Left = 215
    end
    object btnItem: TcxButton
      Left = 9
      Top = 5
      Width = 105
      Height = 28
      Cursor = crHandPoint
      Action = act_ItemPedido
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
  end
  inherited ActionList: TActionList
    Left = 134
    object act_ItemPedido: TAction
      Caption = 'Itens'
      OnExecute = act_ItemPedidoExecute
    end
  end
  inherited dsDados: TDataSource
    Left = 272
    Top = 21
  end
end
