inherited FormMainQuery: TFormMainQuery
  Left = -1114
  Width = 1103
  Height = 546
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object cxFundo: TcxGroupBox [0]
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    TabOrder = 0
    Height = 495
    Width = 1095
    object lbl6: TLabel
      Left = 392
      Top = 64
      Width = 433
      Height = 97
      AutoSize = False
      Caption = 
        'Info dos n'#237'veis joins:'#13#10'-1'#186' = Todas as tabelas filhas ser'#227'o list' +
        'adas. '#13#10' 0'#186' = Somente a tabela pr'#237'ncipal ser'#225' listada'#13#10' 1'#186' = Som' +
        'ente as tabelas vinculadas a tabela princ'#237'pal ser'#227'o listadas. '#13#10 +
        ' 2'#186' = Somente as tabelas vinculadas a tabela vinculada a tabela ' +
        'a princ'#237'pal ser'#227'o listadas. '#13#10' 3'#186' = Somente as tabelas vinculada' +
        's a tabela vinculada a tabela a princ'#237'pal ser'#227'o listadas. '#13#10' 4'#186',' +
        ' 5'#186', 6'#186'.. Sem limite definido.'#13#10
      WordWrap = True
    end
    object edtNivelJoinWichSubTables: TcxTextEdit
      Left = 392
      Top = 40
      Hint = 
        'Busca joins de tabelas filhas.'#13#10#13#10'Definir o n'#237'vel m'#225'ximo.'#13#10#13#10'0 =' +
        ' Nenhum'
      TabOrder = 0
      Text = '-1'
      Width = 121
    end
    object cxNivelJoins: TcxLabel
      Left = 392
      Top = 16
      Caption = 
        'Quantidade de n'#237'veis joins (Tabelas vinculadas a tabela estrange' +
        'ira)'
    end
    object lstColunasExibidas: TcxCheckListBox
      Left = 24
      Top = 192
      Width = 329
      Height = 249
      Items = <
        item
          State = cbsChecked
          Text = 'Obrigat'#243'rio (Not null)'
        end
        item
          State = cbsChecked
          Text = 'Chave prim'#225'ria (PK)'
        end
        item
          State = cbsChecked
          Text = 'Chave estrangeira (FK)'
        end
        item
          State = cbsChecked
          Text = 'Chave '#218'nica (Unique)'
        end
        item
          State = cbsChecked
          Text = 'Tipo Texto'
        end
        item
          State = cbsChecked
          Text = 'Tipo Blob'
        end
        item
          State = cbsChecked
          Text = 'Tipo Num'#233'rico'
        end
        item
          State = cbsChecked
          Text = 'Tipo Monet'#225'rio'
        end
        item
          State = cbsChecked
          Text = 'Tipo Boleano'
        end
        item
          State = cbsChecked
          Text = 'Colunas da Tabela Princ'#237'pal'
        end
        item
          State = cbsChecked
          Text = 'Colunas das tabelas estrangeiras'
        end
        item
          State = cbsChecked
          Text = 'Colunas das tabelas vinculadas a tabela estrangeira'
        end
        item
          State = cbsChecked
          Text = 'Outros'
        end
        item
          State = cbsChecked
          Text = 'Somente campo Nome (PK)'
        end
        item
          State = cbsChecked
          Text = 'Somente campo Nome (FK)'
        end
        item
          State = cbsChecked
          Text = 'Somente campo Nome (Vinculada '#225' FK)'
        end>
      TabOrder = 2
    end
    object cxLabel2: TcxLabel
      Left = 24
      Top = 168
      Caption = 'Colunas que ser'#227'o exibidas:'
    end
    object lstTabelasExibir: TcxCheckListBox
      Left = 24
      Top = 72
      Width = 329
      Height = 89
      Items = <
        item
          Enabled = False
          State = cbsChecked
          Text = 'Tabela Princ'#237'pal'
        end
        item
          State = cbsChecked
          Text = 'Tabela estrangeira com ligua'#231#227'o obrigat'#243'rio (Inner Join)'
        end
        item
          State = cbsChecked
          Text = 'Tabela estrangeira com ligua'#231#227'o n'#227'o obrigat'#243'rio (Left Join)'
        end
        item
          State = cbsChecked
          Text = 'Tabela vinculada a tabela estrangeira (Inner Join)'
        end
        item
          State = cbsChecked
          Text = 'Tabela vinculada a tabela estrangeira (Left Join)'
        end>
      TabOrder = 4
    end
    object cxTabelasJoins: TcxLabel
      Left = 24
      Top = 48
      Caption = 'Tabelas que ser'#227'o efetuado join:'
    end
    object cbbTipoScript: TComboBox
      Left = 96
      Top = 16
      Width = 145
      Height = 21
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 6
      Text = 'Select'
      Items.Strings = (
        'Select'
        'View')
    end
    object cxLabel4: TcxLabel
      Left = 16
      Top = 16
      Caption = 'Tipo do Script:'
    end
    object cxGroupBox1: TcxGroupBox
      Left = 392
      Top = 171
      Align = alCustom
      Caption = 'Personalize o consulta gerada'
      TabOrder = 8
      Height = 273
      Width = 689
      object lblSelect: TLabel
        Left = 24
        Top = 40
        Width = 30
        Height = 13
        Caption = 'Select'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object lbl1: TLabel
        Left = 256
        Top = 40
        Width = 169
        Height = 65
        AutoSize = False
        Caption = 
          ' A.COLUNAA, B.COLUNAB from TabelaA as A '#13#10'INNER JOIN TABELAB as ' +
          'B ON (B.COLUNAB = A.COLUNAA) '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object lbl2: TLabel
        Left = 64
        Top = 24
        Width = 121
        Height = 13
        Caption = '1'#186' Personalize as colunas'
      end
      object lbl5: TLabel
        Left = 432
        Top = 24
        Width = 155
        Height = 13
        Caption = '2'#186' Personalize adicionando JOIN'
      end
      object lbl3: TLabel
        Left = 64
        Top = 106
        Width = 180
        Height = 13
        Caption = '3'#186' Personalize adicionando condi'#231#245'es'
      end
      object lblWhere: TLabel
        Left = 16
        Top = 120
        Width = 41
        Height = 17
        AutoSize = False
        Caption = 'where'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object lblOrderBy: TLabel
        Left = 384
        Top = 202
        Width = 41
        Height = 17
        AutoSize = False
        Caption = 'Order by'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object lbl4: TLabel
        Left = 432
        Top = 186
        Width = 224
        Height = 13
        Caption = '6'#186' Personalize adicionando colunas no order by'
      end
      object Label1: TLabel
        Left = 432
        Top = 106
        Width = 111
        Height = 13
        Caption = '4'#186' Personalize group by'
      end
      object Label2: TLabel
        Left = 384
        Top = 120
        Width = 41
        Height = 17
        AutoSize = False
        Caption = 'group by'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label3: TLabel
        Left = 64
        Top = 186
        Width = 102
        Height = 13
        Caption = '5'#186' Personalize having'
      end
      object Label4: TLabel
        Left = 8
        Top = 202
        Width = 41
        Height = 17
        AutoSize = False
        Caption = 'having'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object mmoInstrucaoAntesColunas: TMemo
        Left = 64
        Top = 40
        Width = 185
        Height = 65
        Lines.Strings = (
          'distinct')
        TabOrder = 0
      end
      object mmoInstrucaoDepoisJoins: TMemo
        Left = 432
        Top = 40
        Width = 185
        Height = 65
        TabOrder = 1
      end
      object mmoCondicao: TMemo
        Left = 64
        Top = 120
        Width = 185
        Height = 65
        TabOrder = 2
      end
      object mmo: TMemo
        Left = 432
        Top = 202
        Width = 185
        Height = 65
        Lines.Strings = (
          '1 asc')
        TabOrder = 3
      end
      object Memo1: TMemo
        Left = 432
        Top = 120
        Width = 185
        Height = 65
        TabOrder = 4
      end
      object Memo2: TMemo
        Left = 64
        Top = 202
        Width = 185
        Height = 65
        TabOrder = 5
      end
    end
    object lstCalculados: TcxCheckListBox
      Left = 840
      Top = 64
      Width = 249
      Height = 94
      TabStop = False
      IntegralHeight = True
      Items = <
        item
          Enabled = False
          Text = 'Agrupar por Ano'
        end
        item
          Enabled = False
          Text = 'Agrupar por campos do tipo Check'
        end
        item
          Enabled = False
          Text = 'Agrupar por Data'
        end
        item
          Enabled = False
          Text = 'Agrupar por Data Hora'
        end
        item
          Enabled = False
          Text = 'Agrupar por Data Hora Minuto'
        end
        item
          Enabled = False
          Text = 'Agrupar por Dia'
        end
        item
          Enabled = False
          State = cbsChecked
          Text = 'Agrupar por FK'
        end
        item
          Enabled = False
          Text = 'Agrupar por Hor'#225'rio'
        end
        item
          Enabled = False
          Text = 'Agrupar por M'#234's'
        end
        item
          Enabled = False
          Text = 'Agrupar por M'#234's\Ano'
        end
        item
          Enabled = False
          Text = 'Agrupar por todos campos'
        end
        item
          Enabled = False
          Text = 'M'#225'ximo de colunas do tipo valor'
        end
        item
          Enabled = False
          Text = 'M'#233'dia de colunas do tipo valor'
        end
        item
          Enabled = False
          Text = 'M'#237'nimo de colunas do tipo valor'
        end
        item
          Enabled = False
          Text = 'Quantidade de registro agrupados'
        end
        item
          Enabled = False
          Text = 'Somar colunas do tipo inteiro'
        end
        item
          Enabled = False
          Text = 'Somar colunas do tipo valor'
        end
        item
          Enabled = False
          Text = 'Varia'#231#227'o de colunas do tipo valor'
        end>
      ReadOnly = True
      TabOrder = 9
    end
    object cxLabel5: TcxLabel
      Left = 832
      Top = 32
      Caption = 'Colunas calculadas'
    end
    object cxRodape: TcxGroupBox
      Left = 2
      Top = 449
      Align = alBottom
      TabOrder = 11
      Height = 44
      Width = 1091
      object btnTodos: TcxButton
        Left = 664
        Top = 12
        Width = 209
        Height = 29
        Cursor = crHandPoint
        Action = actGeneretorSQL
        DragCursor = crHandPoint
        TabOrder = 0
      end
      object btnGeneretorSQL: TcxButton
        Left = 880
        Top = 12
        Width = 209
        Height = 29
        Cursor = crHandPoint
        Action = actFullScript
        DragCursor = crHandPoint
        TabOrder = 1
      end
    end
  end
  inherited mm: TMainMenu
    Left = 320
    Top = 32
    object imFormViewReferenceFK: TMenuItem
      Caption = 'Tabelas'
      OnClick = imFormViewReferenceFKClick
    end
    object imFormViewFields: TMenuItem
      Caption = 'Campos'
      OnClick = imFormViewFieldsClick
    end
  end
  inherited actlst: TActionList
    Top = 88
    object actGeneretorSQL: TAction
      Caption = 'Gerar script conforme configura'#231#227'o atual'
      OnExecute = actGeneretorSQLExecute
    end
    object actFullScript: TAction
      Caption = 'Gerar todos scripts poss'#237'veis'
      OnExecute = actFullScriptExecute
    end
  end
end
