inherited FormViewReferenceFK: TFormViewReferenceFK
  Caption = 'Listagem de ReferenceFK'
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    inherited cxgridView: TcxGrid
      Left = 187
      Width = 604
    end
    object cxGroupBox1: TcxGroupBox
      Left = 2
      Top = 2
      Align = alLeft
      PanelStyle.Active = True
      TabOrder = 1
      Height = 295
      Width = 185
      object chkIsView: TCheckBox
        Left = 8
        Top = 20
        Width = 57
        Height = 17
        Caption = #201' view'
        TabOrder = 0
      end
      object chkIncludeOnlyFieldDCOfReference: TCheckBox
        Left = 8
        Top = 44
        Width = 145
        Height = 17
        Caption = 'Incluir somente DC da FK'
        TabOrder = 1
      end
      object btnGeneretorSQL: TcxButton
        Left = 8
        Top = 124
        Width = 105
        Height = 29
        Cursor = crHandPoint
        Action = actGeneretorSQL
        DragCursor = crHandPoint
        TabOrder = 2
      end
      object edtNivelJoinWichSubTables: TcxTextEdit
        Left = 8
        Top = 88
        Hint = 
          'Busca joins de tabelas filhas.'#13#10#13#10'Definir o n'#237'vel m'#225'ximo.'#13#10#13#10'0 =' +
          ' Nenhum'
        TabOrder = 3
        Text = '-1'
        Width = 121
      end
      object cxLabel1: TcxLabel
        Left = 8
        Top = 64
        Caption = 'Quantidade de n'#237'veis joins'
      end
      object btnTodos: TcxButton
        Left = 8
        Top = 164
        Width = 105
        Height = 29
        Cursor = crHandPoint
        Action = actFullScript
        DragCursor = crHandPoint
        TabOrder = 5
      end
    end
  end
  inherited ActionList: TActionList
    object actGeneretorSQL: TAction
      Caption = 'Generetor SQL'
      OnExecute = actGeneretorSQLExecute
    end
    object actFullScript: TAction
      Caption = 'Todos tipos SQL'
      OnExecute = actFullScriptExecute
    end
  end
end
