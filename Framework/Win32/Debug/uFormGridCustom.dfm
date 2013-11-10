inherited FormGridCustom: TFormGridCustom
  Caption = 'View Model'
  ClientHeight = 336
  ClientWidth = 793
  ExplicitWidth = 799
  ExplicitHeight = 364
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TPanel
    Width = 793
    Height = 336
    ParentDoubleBuffered = False
    ExplicitWidth = 793
    ExplicitHeight = 336
    object Grid: TDBGrid
      Left = 1
      Top = 1
      Width = 791
      Height = 334
      Align = alClient
      DataSource = dsDados
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
end
