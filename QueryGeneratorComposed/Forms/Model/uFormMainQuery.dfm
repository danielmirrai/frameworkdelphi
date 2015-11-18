inherited FormMainQuery: TFormMainQuery
  Left = 0
  Top = 101
  Width = 1103
  Height = 572
  Caption = 'Principal'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object cxFundo: TcxGroupBox [0]
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    TabOrder = 0
    Height = 521
    Width = 1095
    object cxNivelJoins: TcxLabel
      Left = 368
      Top = 16
      Caption = 'Profundidade dos joins (n'#237'veis)'
    end
    object lstColunasExibidas: TcxCheckListBox
      Left = 24
      Top = 184
      Width = 329
      Height = 281
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
          Text = 'Tipo Data'
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
          Text = 'Somente campo "Nome\Descri'#231#227'o" da PK'
        end
        item
          State = cbsChecked
          Text = 'Somente campo "Nome\Descri'#231#227'o" da FK'
        end
        item
          State = cbsChecked
          Text = 'Somente campo "Nome\Descri'#231#227'o" da tabela vinculada '#225' FK'
        end
        item
          Text = 'PK da tabela estrangeira'
        end
        item
          Text = 'PK da tabela tabela vinculada '#225' FK'
        end
        item
          State = cbsChecked
          Text = 'Outros (Campos que n'#227'o se enquadram na lista acima.)'
        end>
      TabOrder = 2
    end
    object cxLabel2: TcxLabel
      Left = 24
      Top = 165
      Caption = 'Colunas que ser'#227'o exibidas: (Configura'#231#227'o excludente)'
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
        end
        item
          State = cbsChecked
          Text = 'Rela'#231#227'o 1 para 1'
        end
        item
          State = cbsChecked
          Text = 'Rela'#231#227'o 1 para N (Um para muitos)'
        end
        item
          State = cbsChecked
          Text = 'Rela'#231#227'o N para N (Muitos para muitos)'
        end>
      TabOrder = 1
    end
    object cxTabelasJoins: TcxLabel
      Left = 24
      Top = 48
      Caption = 'Tabelas que ser'#227'o efetuado join:'
    end
    object cxLabel4: TcxLabel
      Left = 16
      Top = 16
      Caption = 'Tipo do Script:'
    end
    object cxPersonalizacaoQuery: TcxGroupBox
      Left = 368
      Top = 40
      Align = alCustom
      Caption = 'Personalize o consulta gerada'
      TabOrder = 5
      Height = 423
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
        Left = 260
        Top = 40
        Width = 161
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
        Left = 24
        Top = 120
        Width = 33
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
        Left = 16
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
      object lbl6: TLabel
        Left = 5
        Top = 282
        Width = 57
        Height = 41
        AutoSize = False
        Caption = 'Colunas calculadas'
        WordWrap = True
      end
      object mmoSQLUserSelect: TMemo
        Left = 64
        Top = 40
        Width = 185
        Height = 65
        Lines.Strings = (
          'distinct')
        ScrollBars = ssVertical
        TabOrder = 0
      end
      object mmoSQLUserJoin: TMemo
        Left = 432
        Top = 40
        Width = 249
        Height = 65
        ScrollBars = ssVertical
        TabOrder = 1
      end
      object mmoSQLUserWhere: TMemo
        Left = 64
        Top = 120
        Width = 313
        Height = 65
        ScrollBars = ssVertical
        TabOrder = 2
      end
      object mmoSQLUserOrderBy: TMemo
        Left = 432
        Top = 202
        Width = 249
        Height = 65
        Lines.Strings = (
          '1 asc')
        ScrollBars = ssVertical
        TabOrder = 5
      end
      object mmoSQLUserGroupBy: TMemo
        Left = 432
        Top = 120
        Width = 249
        Height = 65
        ScrollBars = ssVertical
        TabOrder = 3
      end
      object mmoSQLUserHaving: TMemo
        Left = 64
        Top = 202
        Width = 313
        Height = 65
        ScrollBars = ssVertical
        TabOrder = 4
      end
      object lstCalculados: TcxCheckListBox
        Left = 64
        Top = 280
        Width = 617
        Height = 139
        TabStop = False
        Enabled = False
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
        TabOrder = 6
      end
    end
    object cxRodape: TcxGroupBox
      Left = 2
      Top = 474
      Align = alBottom
      PanelStyle.Active = True
      TabOrder = 10
      Height = 45
      Width = 1091
      object btnTodos: TcxButton
        Left = 661
        Top = 8
        Width = 209
        Height = 29
        Cursor = crHandPoint
        Action = actGeneretorSQL
        DragCursor = crHandPoint
        TabOrder = 0
        TabStop = False
      end
      object btnGeneretorSQL: TcxButton
        Left = 877
        Top = 8
        Width = 209
        Height = 29
        Cursor = crHandPoint
        Action = actFullScript
        DragCursor = crHandPoint
        TabOrder = 1
        TabStop = False
      end
      object btnTestaScripts: TcxButton
        Left = 445
        Top = 8
        Width = 209
        Height = 29
        Cursor = crHandPoint
        Action = actTestaScripts
        DragCursor = crHandPoint
        TabOrder = 2
        TabStop = False
      end
      object chkAbrirSQLGerado: TcxCheckBox
        Left = 320
        Top = 16
        Caption = 'Abrir SQL Gerado'
        TabOrder = 3
        Width = 121
      end
    end
    object cbbNiveisJoin: TcxComboBox
      Left = 528
      Top = 16
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        '-1. "Todos" (Todas as tabelas filhas ser'#227'o listadas).'
        '0. "Nenhum" (Somente a tabela pr'#237'ncipal ser'#225' listada).'
        
          '1. "Ligua'#231#227'o direta" (Somente as tabelas s'#227'o FK da tabela princ'#237 +
          'pal ser'#227'o listadas).'
        
          '2. "Ligua'#231#227'o direta e liguaga'#231#227'o indireta de n'#237'vel 1". Lista tab' +
          'elas da ligua'#231#227'o direta + tabelas filhas.'
        '3. "Ligua'#231#227'o direta e liguaga'#231#227'o indireta de n'#237'vel 2".'
        '4. "Ligua'#231#227'o direta e liguaga'#231#227'o indireta de n'#237'vel 3".'
        'Outro')
      Properties.OnChange = cbbNiveisJoinPropertiesChange
      TabOrder = 3
      Text = '-1. "Todos" (Todas as tabelas filhas ser'#227'o listadas).'
      OnExit = cbbNiveisJoinExit
      Width = 489
    end
    object edtNivelJoinComSubTabelas: TcxTextEdit
      Left = 1024
      Top = 16
      Hint = 
        'Busca joins de tabelas filhas.'#13#10#13#10'Definir o n'#237'vel m'#225'ximo.'#13#10#13#10'0 =' +
        ' Nenhum'
      TabStop = False
      Properties.OnChange = edtNivelJoinComSubTabelasPropertiesChange
      TabOrder = 4
      Text = '-1'
      OnExit = edtNivelJoinComSubTabelasExit
      OnKeyPress = edtNivelJoinComSubTabelasKeyPress
      Width = 33
    end
    object cbbTipoScript: TcxComboBox
      Left = 96
      Top = 16
      Properties.DropDownListStyle = lsEditFixedList
      Properties.Items.Strings = (
        '1. Select (Gerar SQL de pesquisa)'
        '2. View (Gerar vis'#227'o contendo o SQL de pesquisa)')
      TabOrder = 0
      Text = '1. Select (Gerar SQL de pesquisa)'
      Width = 257
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
    Left = 382
    Top = 200
    object actGeneretorSQL: TAction
      Caption = 'Gerar script conforme configura'#231#227'o atual'
      OnExecute = actGeneretorSQLExecute
    end
    object actFullScript: TAction
      Caption = 'Gerar todos scripts poss'#237'veis'
      OnExecute = actFullScriptExecute
    end
    object actTestaScripts: TAction
      Caption = 'Testa Scripts'
      OnExecute = actTestaScriptsExecute
    end
    object actAbrirSQLGerados: TAction
      Caption = 'actAbrirSQLGerados'
    end
  end
end
