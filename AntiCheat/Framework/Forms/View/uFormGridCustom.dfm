inherited FormGridCustom: TFormGridCustom
  Caption = 'View Model'
  ClientHeight = 336
  ClientWidth = 793
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 336
    Width = 793
  end
  object Grid: TcxGrid [1]
    Left = 0
    Top = 0
    Width = 793
    Height = 336
    Align = alClient
    TabOrder = 1
    object GridDBTableView_Dados: TcxGridDBTableView
      Navigator.Buttons.CustomButtons = <>
      DataController.DataSource = dsDados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = 'Total ###0'
          Kind = skCount
        end>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para filtrar'
      FilterRow.Visible = True
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Editing = False
      OptionsData.Inserting = False
      OptionsSelection.CellSelect = False
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.Footer = True
    end
    object GridLevel1: TcxGridLevel
      GridView = GridDBTableView_Dados
    end
  end
  inherited cxEditStyleController: TcxEditStyleController
    Style.IsFontAssigned = True
    PixelsPerInch = 96
  end
  object dsDados: TDataSource
    Left = 312
    Top = 72
  end
end
