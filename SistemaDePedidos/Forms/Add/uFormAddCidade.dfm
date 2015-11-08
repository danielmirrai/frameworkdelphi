inherited FormAddCidade: TFormAddCidade
  Caption = 'Cadastro de Cidade'
  ClientHeight = 189
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 153
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
      Width = 28
      Height = 13
      Caption = 'Nome'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 16
      Top = 104
      Width = 33
      Height = 13
      Caption = 'Estado'
      FocusControl = DBEdit3
    end
    object DBEdit1: TcxDBTextEdit
      Left = 16
      Top = 24
      DataBinding.DataField = 'CODIGO'
      DataBinding.DataSource = dsDados
      TabOrder = 0
      Width = 134
    end
    object DBEdit2: TcxDBTextEdit
      Left = 16
      Top = 72
      DataBinding.DataField = 'NOME'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 350
    end
    object DBEdit3: TcxDBTextEdit
      Left = 16
      Top = 120
      DataBinding.DataField = 'CODIGO_ESTADO'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 134
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 153
  end
  inherited dsDados: TDataSource
    Left = 272
    Top = 21
  end
end
