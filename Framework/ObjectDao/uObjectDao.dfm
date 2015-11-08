inherited ObjectDao: TObjectDao
  OldCreateOrder = True
  inherited CDSDados: TClientDataSet
    FilterOptions = [foCaseInsensitive]
    AfterPost = CDSDadosAfterPost
  end
end
