inherited FormAddFields: TFormAddFields
  Caption = 'Cadastro de Fields'
  ClientHeight = 247
  ClientWidth = 397
  PixelsPerInch = 96
  TextHeight = 13
  inherited gb_Dados: TcxGroupBox
    Height = 211
    Width = 397
  end
  inherited gb_Navegate: TcxGroupBox
    Top = 211
    Width = 397
    inherited btn_Cancel: TcxButton
      Left = 283
    end
    inherited btn_Confirm: TcxButton
      Left = 172
    end
  end
  inherited dsDados: TDataSource
    Left = 336
    Top = 21
  end
end
