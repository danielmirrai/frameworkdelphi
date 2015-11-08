inherited FormModel: TFormModel
  BorderIcons = [biSystemMenu]
  ClientHeight = 284
  KeyPreview = True
  OldCreateOrder = True
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gb_Dados: TcxGroupBox [0]
    Left = 0
    Top = 0
    Align = alClient
    PanelStyle.Active = True
    ParentFont = False
    Style.StyleController = cxEditStyleController
    TabOrder = 0
    Height = 284
    Width = 470
  end
  inherited cxEditStyleController: TcxEditStyleController
    Style.IsFontAssigned = True
    PixelsPerInch = 96
  end
  object ActionList: TActionList
    Images = ObjectDaoApplication.ImageList_16
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
end
