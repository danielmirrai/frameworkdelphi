inherited FormAddPessoa: TFormAddPessoa
  Top = 244
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 411
  ClientWidth = 386
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 375
    Width = 386
    object Label1: TLabel
      Left = 24
      Top = 8
      Width = 33
      Height = 13
      Caption = 'C'#243'digo'
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 24
      Top = 56
      Width = 28
      Height = 13
      Caption = 'Nome'
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 24
      Top = 104
      Width = 63
      Height = 13
      Caption = 'Raz'#227'o Social'
      FocusControl = DBEdit3
    end
    object Label4: TLabel
      Left = 24
      Top = 152
      Width = 20
      Height = 13
      Caption = 'CPF'
      FocusControl = DBEdit4
    end
    object Label5: TLabel
      Left = 24
      Top = 200
      Width = 27
      Height = 13
      Caption = 'CNPJ'
      FocusControl = DBEdit5
    end
    object Label6: TLabel
      Left = 24
      Top = 248
      Width = 42
      Height = 13
      Caption = 'Telefone'
      FocusControl = DBEdit6
    end
    object Label7: TLabel
      Left = 24
      Top = 296
      Width = 28
      Height = 13
      Caption = 'E-mail'
      FocusControl = DBEdit7
    end
    object DBEdit1: TcxDBTextEdit
      Left = 24
      Top = 24
      DataBinding.DataField = 'CODIGO'
      DataBinding.DataSource = dsDados
      TabOrder = 0
      Width = 134
    end
    object DBEdit2: TcxDBTextEdit
      Left = 24
      Top = 72
      DataBinding.DataField = 'NOME'
      DataBinding.DataSource = dsDados
      TabOrder = 1
      Width = 350
    end
    object DBEdit3: TcxDBTextEdit
      Left = 24
      Top = 120
      DataBinding.DataField = 'RAZAO_SOCIAL'
      DataBinding.DataSource = dsDados
      TabOrder = 2
      Width = 350
    end
    object DBEdit4: TcxDBTextEdit
      Left = 24
      Top = 168
      DataBinding.DataField = 'CPF'
      DataBinding.DataSource = dsDados
      TabOrder = 3
      Width = 147
    end
    object DBEdit5: TcxDBTextEdit
      Left = 24
      Top = 216
      DataBinding.DataField = 'CNPJ'
      DataBinding.DataSource = dsDados
      TabOrder = 4
      Width = 186
    end
    object DBEdit6: TcxDBTextEdit
      Left = 24
      Top = 264
      DataBinding.DataField = 'TELEFONE'
      DataBinding.DataSource = dsDados
      TabOrder = 5
      Width = 264
    end
    object DBEdit7: TcxDBTextEdit
      Left = 24
      Top = 312
      DataBinding.DataField = 'EMAIL'
      DataBinding.DataSource = dsDados
      TabOrder = 6
      Width = 350
    end
    object DBCheckBox1: TDBCheckBox
      Left = 24
      Top = 344
      Width = 97
      Height = 17
      Caption = 'Ativo'
      TabOrder = 7
      ValueChecked = '0'
      ValueUnchecked = '1'
    end
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 375
    Width = 386
    inherited btn_Cancel: TcxButton
      Left = 277
    end
    inherited btn_Confirm: TcxButton
      Left = 166
    end
  end
  inherited dsDados: TDataSource
    Left = 272
    Top = 21
  end
end
