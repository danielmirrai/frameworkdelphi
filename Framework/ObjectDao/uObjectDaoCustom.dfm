object ObjectDaoCustom: TObjectDaoCustom
  OldCreateOrder = False
  Height = 150
  Width = 215
  object CDSDados: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    ProviderName = 'PRVDADOS'
    StoreDefs = True
    AfterOpen = CDSDadosAfterOpen
    AfterInsert = CDSDadosAfterInsert
    BeforeCancel = CDSDadosBeforeCancel
    BeforeDelete = CDSDadosBeforeDelete
    Left = 31
    Top = 54
  end
  object DSDados: TDataSource
    DataSet = CDSDados
    Left = 96
    Top = 52
  end
  object SQLDADOS: TSQLDataSet
    GetMetadata = False
    CommandType = ctTable
    MaxBlobSize = -1
    Params = <>
    Left = 33
    Top = 8
  end
  object PRVDADOS: TDataSetProvider
    DataSet = SQLDADOS
    UpdateMode = upWhereChanged
    Left = 96
    Top = 8
  end
end
