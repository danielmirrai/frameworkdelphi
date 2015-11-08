inherited FormAddPais: TFormAddPais
  Caption = 'Cadastro de Pais'
  ClientHeight = 240
  ClientWidth = 370
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 204
    Width = 370
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
      Width = 28
      Height = 13
      Caption = 'Nome'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 8
      Top = 112
      Width = 19
      Height = 13
      Caption = 'DDI'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 8
      Top = 160
      Width = 23
      Height = 13
      Caption = 'Sigla'
      FocusControl = DBEdit4
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
      DataBinding.DataField = 'NOME'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 350
    end
    object DBEdit3: TcxDBTextEdit
      Left = 8
      Top = 128
      DataBinding.DataField = 'DDI'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 134
    end
    object DBEdit4: TcxDBTextEdit
      Left = 8
      Top = 176
      DataBinding.DataField = 'SIGLA'
      DataBinding.DataSource = dsDados
      TabOrder = 3
      Width = 30
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 204
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
