inherited FormAddEstado: TFormAddEstado
  Caption = 'Cadastro de Estado'
  ClientHeight = 243
  ClientWidth = 367
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 207
    Width = 367
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
      Width = 14
      Height = 13
      Caption = 'UF'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 8
      Top = 160
      Width = 22
      Height = 13
      Caption = 'Pa'#237's'
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
      DataBinding.DataField = 'UF'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 30
    end
    object DBEdit4: TcxDBTextEdit
      Left = 8
      Top = 176
      DataBinding.DataField = 'CODIGO_PAIS'
      DataBinding.DataSource = dsDados
      TabOrder = 3
      Width = 134
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 207
    Width = 367
    inherited btn_Cancel: TcxButton
      Left = 258
    end
    inherited btn_Confirm: TcxButton
      Left = 147
    end
  end
  inherited dsDados: TDataSource
    Left = 272
    Top = 21
  end
end
