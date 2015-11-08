inherited FormAddModelCustom: TFormAddModelCustom
  Caption = 'Add Model Custom'
  PixelsPerInch = 96
  TextHeight = 13
  inherited cxEditStyleController: TcxEditStyleController
    Style.IsFontAssigned = True
    Top = 59
    PixelsPerInch = 96
  end
  inherited ActionList: TActionList
    Images = ObjectDaoApplication.ImageList_16
    Left = 390
    Top = 104
    inherited ac_Refresh: TAction
      Caption = '(F5) - Atualizar'
    end
    object ac_Confirm: TAction
      Caption = '(F3) - &Confirmar'
      ImageIndex = 0
      ShortCut = 114
      OnExecute = ac_ConfirmExecute
    end
    object ac_Cancel: TAction
      Caption = '(F4) - Ca&ncelar'
      ImageIndex = 1
      ShortCut = 115
      OnExecute = ac_CancelExecute
    end
    object ac_OpenFormAdd: TAction
      Caption = 'ac_OpenFormAdd'
      OnExecute = ac_OpenFormAddExecute
    end
  end
end
