inherited FormModel: TFormModel
  Left = 404
  Top = 287
  BorderIcons = [biSystemMenu]
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gb_Dados: TcxGroupBox
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    Height = 172
    Width = 470
  end
  object ActionList: TActionList
    Left = 398
    Top = 128
    object ac_Close: TAction
      Caption = '(ESC) - &Close'
      ImageIndex = 2
      ShortCut = 27
      OnExecute = ac_CloseExecute
    end
    object ac_Refresh: TAction
      Caption = 'ac_Refresh'
      ShortCut = 116
      OnExecute = ac_RefreshExecute
    end
  end
  object cxPropertiesStore: TcxPropertiesStore
    Components = <>
    StorageName = 'TelaModel'
    Left = 280
    Top = 56
  end
end
