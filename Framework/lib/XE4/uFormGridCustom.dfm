inherited FormGridCustom: TFormGridCustom
  Left = 459
  Top = 234
  Caption = 'View Model'
  ClientHeight = 336
  ClientWidth = 793
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Width = 793
    Height = 336
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 791
      Height = 334
      Align = alClient
      DataBinding.DataSource = dsDados
      PopupMenu = pmGrid
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
  object dsDados: TDataSource
    Left = 312
    Top = 72
  end
  object pmGrid: TPopupMenu
    Left = 208
    Top = 96
  end
end
