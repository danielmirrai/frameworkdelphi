object FrmSorteiaNumero: TFrmSorteiaNumero
  Left = 402
  Top = 252
  Width = 311
  Height = 237
  Caption = 'Sorteia Mega Sena'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lblNumerosSorteados: TLabel
    Left = 135
    Top = 33
    Width = 162
    Height = 72
    AutoSize = False
    Caption = 'Lista n'#250'meros sorteados: '
    WordWrap = True
  end
  object lbl1: TLabel
    Left = 8
    Top = 144
    Width = 221
    Height = 13
    Caption = 'Digite o n'#250'mero para verificar se foi sorteado.'
  end
  object lst1: TListBox
    Left = 8
    Top = 8
    Width = 121
    Height = 97
    TabStop = False
    ItemHeight = 13
    TabOrder = 0
  end
  object chkPodeRepertirNumero: TCheckBox
    Left = 135
    Top = 12
    Width = 150
    Height = 17
    Caption = 'Pode repertir n'#250'mero'
    TabOrder = 1
  end
  object btnLimparGrupoBox: TButton
    Left = 96
    Top = 111
    Width = 80
    Height = 25
    Action = ac_LimparGrupoBox
    TabOrder = 2
  end
  object btnSortearNumeros: TButton
    Left = 8
    Top = 111
    Width = 80
    Height = 25
    Action = ac_SortearNumeros
    TabOrder = 3
  end
  object btnSortearNumeros1: TButton
    Left = 137
    Top = 159
    Width = 128
    Height = 25
    Action = ac_NumeroFoiSorteado
    TabOrder = 4
  end
  object btnNumeroFoiSorteado: TButton
    Left = 181
    Top = 111
    Width = 80
    Height = 25
    Action = ac_Ordenar
    TabOrder = 5
  end
  object edtNumeroDigitado: TMaskEdit
    Left = 8
    Top = 163
    Width = 118
    Height = 21
    EditMask = '99'
    MaxLength = 2
    TabOrder = 6
    Text = '  '
  end
  object actlst1: TActionList
    Left = 208
    Top = 72
    object ac_LimparGrupoBox: TAction
      Caption = 'Limpar'
      OnExecute = ac_LimparGrupoBoxExecute
    end
    object ac_SortearNumeros: TAction
      Caption = 'Sortear'
      OnExecute = ac_SortearNumerosExecute
    end
    object ac_NumeroFoiSorteado: TAction
      Caption = 'Verificar'
      OnExecute = ac_NumeroFoiSorteadoExecute
    end
    object ac_Ordenar: TAction
      Caption = 'Ordenar'
      OnExecute = ac_OrdenarExecute
    end
  end
end
