inherited FormViewSearchPlayers: TFormViewSearchPlayers
  Caption = 'Jogadores Online'
  ClientHeight = 346
  ClientWidth = 803
  FormStyle = fsMDIChild
  Position = poDefault
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 310
    Width = 803
  end
  inherited gb_Navegate: TPanel
    Top = 310
    Width = 803
    inherited btn_Close: TcxButton
      Left = 675
    end
    inherited btn_Select: TcxButton
      Left = 542
    end
  end
  inherited Grid: TcxGrid
    Width = 803
    Height = 310
    inherited GridDBTableView_Dados: TcxGridDBTableView
      DataController.Summary.FooterSummaryItems = <
        item
          Format = 'Jogadores Online: ###0'
          Kind = skCount
          FieldName = 'LOGIN'
          Column = GridDBTableView_DadosLOGIN
        end>
      OptionsView.NoDataToDisplayInfoText = '<Nenhum jogador online>'
      OptionsView.GroupByBox = False
      object GridDBTableView_DadosLOGIN: TcxGridDBColumn
        DataBinding.FieldName = 'LOGIN'
      end
      object GridDBTableView_DadosCLA: TcxGridDBColumn
        DataBinding.FieldName = 'CLA'
      end
      object GridDBTableView_DadosDATA_INICIO: TcxGridDBColumn
        DataBinding.FieldName = 'DATA_INICIO'
      end
    end
  end
  inherited cxEditStyleController: TcxEditStyleController
    Style.IsFontAssigned = True
  end
  inherited ActionList: TActionList
    inherited ac_Select: TAction
      Visible = False
    end
  end
end
