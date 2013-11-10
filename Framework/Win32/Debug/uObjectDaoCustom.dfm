object ObjectDaoCustom: TObjectDaoCustom
  OldCreateOrder = False
  Height = 150
  Width = 215
  object CDSDados: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    AfterOpen = CDSDadosAfterOpen
    AfterInsert = CDSDadosAfterInsert
    BeforeCancel = CDSDadosBeforeCancel
    BeforeDelete = CDSDadosBeforeDelete
    Left = 36
    Top = 36
  end
  object DSDados: TDataSource
    DataSet = CDSDados
    Left = 96
    Top = 36
  end
end
