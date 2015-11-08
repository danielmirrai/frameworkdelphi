object FormSimuladorVenda: TFormSimuladorVenda
  Left = 0
  Top = 0
  Caption = 'Simulador para venda de ve'#237'culos'
  ClientHeight = 202
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object grpSimulacao: TGroupBox
    Left = 0
    Top = 161
    Width = 447
    Height = 41
    Align = alBottom
    Caption = 'Simula'#231#227'o'
    TabOrder = 0
    object lblValorTotalVeiculo: TLabel
      Left = 176
      Top = 16
      Width = 100
      Height = 13
      Caption = 'Valor total do ve'#237'culo'
    end
    object btnCalcular: TButton
      Left = 64
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Calcular'
      TabOrder = 0
      OnClick = btnCalcularClick
    end
    object edtValorTotalVeiculo: TEdit
      Left = 282
      Top = 17
      Width = 121
      Height = 21
      TabOrder = 1
      Text = 'edtValorTotalVeiculo'
    end
  end
  object gbDados: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 161
    Align = alClient
    TabOrder = 1
    object grpOpcionais: TGroupBox
      Left = 207
      Top = 1
      Width = 239
      Height = 159
      Align = alClient
      Caption = 'Opcionais'
      TabOrder = 0
      ExplicitLeft = 261
      ExplicitWidth = 185
      object chklstOpcionais: TCheckListBox
        Left = 2
        Top = 15
        Width = 235
        Height = 142
        OnClickCheck = chklstOpcionaisClickCheck
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        ExplicitWidth = 181
      end
    end
    object rgModeloDoVeiculo: TRadioGroup
      Left = 1
      Top = 1
      Width = 206
      Height = 159
      Align = alLeft
      Caption = 'Modelo do Ve'#237'culo'
      TabOrder = 1
      OnClick = rgModeloDoVeiculoClick
      ExplicitLeft = 11
      ExplicitTop = -4
    end
  end
end
