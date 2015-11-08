inherited FormGridCustom: TFormGridCustom
  Left = 459
  Top = 234
  Caption = 'View Model'
  ClientHeight = 336
  ClientWidth = 793
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 336
    Width = 793
    object cxgridView: TcxGrid
      Left = 2
      Top = 2
      Width = 789
      Height = 332
      Align = alClient
      TabOrder = 0
      object cxDBTableGridView: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
      end
      object cxLevelGridViewLevel1: TcxGridLevel
        GridView = cxDBTableGridView
      end
    end
  end
  object dsDados: TDataSource [2]
    Left = 312
    Top = 72
  end
  object pmGrid: TPopupMenu [3]
    Left = 208
    Top = 96
  end
  object cxPopup: TcxGridPopupMenu [4]
    Grid = cxgridView
    PopupMenus = <>
    Left = 264
    Top = 120
  end
end
