inherited ObjectDao: TObjectDao
  OldCreateOrder = True
  inherited CDSDados: TClientDataSet
    AfterPost = CDSDadosAfterPost
  end
end
