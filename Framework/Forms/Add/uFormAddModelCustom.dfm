inherited FormAddModelCustom: TFormAddModelCustom
  Left = 405
  Top = 218
  Caption = 'Add Model Custom'
  PixelsPerInch = 96
  TextHeight = 13
  inherited ActionList: TActionList
    Top = 16
    object ac_Confirm: TAction
      Caption = '(F3) - Co&nfirm'
      ImageIndex = 0
      ShortCut = 114
      OnExecute = ac_ConfirmExecute
    end
    object ac_Cancel: TAction
      Caption = '(F4) - C&ancel'
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
