inherited FormPrincipal: TFormPrincipal
  Caption = 'l'
  ClientHeight = 152
  Menu = MainMenu1
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 152
    object mmo1: TMemo
      Left = 2
      Top = 2
      Width = 466
      Height = 148
      Align = alClient
      TabOrder = 1
    end
    object btn1: TButton
      Left = 120
      Top = 80
      Width = 75
      Height = 25
      Caption = 'btn1'
      TabOrder = 0
      OnClick = btn1Click
    end
  end
  inherited ActionList: TActionList
    object actViewPedido: TAction
      Caption = 'Pesquisa de Pedidos'
      OnExecute = actViewPedidoExecute
    end
    object actAddPedido: TAction
      Caption = 'Cadastro de Pedidos'
      OnExecute = actAddPedidoExecute
    end
  end
  object MainMenu1: TMainMenu
    Left = 72
    Top = 80
    object mnuPedido: TMenuItem
      Action = actViewPedido
    end
    object mnuCadastrodePedidos: TMenuItem
      Action = actAddPedido
    end
  end
end
