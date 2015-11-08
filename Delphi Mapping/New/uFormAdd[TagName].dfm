inherited FormAdd[TagName]: TFormAdd[TagName]
  Caption = 'Cadastro de [TagName]'
  ClientHeight = 247
  ClientWidth = 397
  ExplicitWidth = 403
  ExplicitHeight = 275
  PixelsPerInch = 96
  TextHeight = 13
  inherited dsDados: TDataSource
    DataSet = ObjectDao[TagName].CDSDados
    Left = 336
    Top = 21
  end
end
