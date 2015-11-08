inherited FormViewSearchGame: TFormViewSearchGame
  Caption = 'Selecionar Partida'
  ClientHeight = 352
  ClientWidth = 994
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 316
    Width = 994
  end
  inherited gb_Navegate: TPanel
    Top = 316
    Width = 994
    inherited btn_Close: TcxButton
      Left = 917
      Top = 50
      Visible = False
    end
    inherited btn_Select: TcxButton
      Left = 866
    end
  end
  inherited Grid: TcxGrid
    Width = 994
    Height = 316
    inherited GridDBTableView_Dados: TcxGridDBTableView
      DataController.Summary.FooterSummaryItems = <
        item
          Format = 'Partidas dispon'#237'veis: ###0'
          Kind = skCount
          FieldName = 'CODIGO'
          Column = GridDBTableView_DadosDESCRICAO
        end>
      OptionsView.NoDataToDisplayInfoText = '<Nenhuma partida dispon'#237'vel>'
      OptionsView.GroupByBox = False
      object GridDBTableView_DadosCODIGO: TcxGridDBColumn
        DataBinding.FieldName = 'CODIGO'
      end
      object GridDBTableView_DadosID_PARTIDA: TcxGridDBColumn
        DataBinding.FieldName = 'ID_PARTIDA'
      end
      object GridDBTableView_DadosDESCRICAO: TcxGridDBColumn
        DataBinding.FieldName = 'DESCRICAO'
      end
    end
  end
  inherited cxEditStyleController: TcxEditStyleController
    Style.IsFontAssigned = True
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    inherited ac_Close: TAction
      Enabled = False
    end
  end
end
