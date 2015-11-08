object Form_Principal: TForm_Principal
  Left = 0
  Top = 0
  Caption = 'Descriptografar'
  ClientHeight = 374
  ClientWidth = 731
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object cxGroupBox3: TcxGroupBox
    Left = 0
    Top = 330
    Align = alBottom
    PanelStyle.Active = True
    TabOrder = 2
    Height = 44
    Width = 731
    object cxButton1: TcxButton
      Left = 549
      Top = 9
      Width = 75
      Height = 25
      Action = ac_Criptografar
      TabOrder = 0
    end
    object cxButton2: TcxButton
      Left = 630
      Top = 9
      Width = 88
      Height = 25
      Action = ac_Descripografar
      TabOrder = 1
    end
  end
  object gb_Origem: TcxGroupBox
    Left = 0
    Top = 46
    Align = alClient
    Caption = 'Origem'
    TabOrder = 0
    Height = 284
    Width = 379
    object cxMemoOrigem: TcxMemo
      Left = 2
      Top = 18
      Align = alClient
      Properties.ScrollBars = ssBoth
      TabOrder = 0
      Height = 264
      Width = 375
    end
  end
  object gb_Destino: TcxGroupBox
    Left = 379
    Top = 46
    Align = alRight
    Caption = 'Destino'
    TabOrder = 1
    Height = 284
    Width = 352
    object cxMemoDestino: TcxMemo
      Left = 2
      Top = 18
      Align = alClient
      Properties.ScrollBars = ssBoth
      TabOrder = 0
      Height = 264
      Width = 348
    end
  end
  object gb_Topo: TcxGroupBox
    Left = 0
    Top = 0
    Align = alTop
    PanelStyle.Active = True
    TabOrder = 3
    Height = 46
    Width = 731
    object edt_File: TcxTextEdit
      Left = 93
      Top = 12
      TabOrder = 0
      Width = 244
    end
    object cxButton3: TcxButton
      Left = 346
      Top = 10
      Width = 93
      Height = 25
      Action = ac_AbrirArquivo
      TabOrder = 1
    end
    object cxLabel1: TcxLabel
      Left = 15
      Top = 13
      Caption = 'Local Arquivo:'
      Transparent = True
    end
    object cxButton4: TcxButton
      Left = 445
      Top = 10
      Width = 93
      Height = 25
      Action = ac_Processar
      TabOrder = 3
    end
    object cxButton5: TcxButton
      Left = 544
      Top = 10
      Width = 126
      Height = 25
      Action = ac_FileInfo
      Caption = 'Informa'#231#245'es Arquivo'
      TabOrder = 4
    end
  end
  object ActionList1: TActionList
    Left = 159
    Top = 123
    object ac_Descripografar: TAction
      Caption = 'Descripografar'
      OnExecute = ac_DescripografarExecute
    end
    object ac_Criptografar: TAction
      Caption = 'Criptografar'
      OnExecute = ac_CriptografarExecute
    end
    object ac_Close: TAction
      Caption = 'Fechar'
      ShortCut = 27
      OnExecute = ac_CloseExecute
    end
    object ac_AbrirArquivo: TAction
      Caption = 'Abrir Arquivo'
      OnExecute = ac_AbrirArquivoExecute
    end
    object ac_Processar: TAction
      Caption = 'Processar'
      OnExecute = ac_ProcessarExecute
    end
    object ac_FileInfo: TAction
      Caption = 'ac_FileInfo'
      OnExecute = ac_FileInfoExecute
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 12
    Top = 111
  end
end
