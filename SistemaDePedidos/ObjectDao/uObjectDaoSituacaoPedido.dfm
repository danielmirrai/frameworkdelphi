inherited ObjectDaoSituacaoPedido: TObjectDaoSituacaoPedido
  Left = 551
  Top = 180
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 250
      end
      item
        Name = 'FL_ATIVO'
        DataType = ftSmallint
      end>
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'SITUACAO_PEDIDO'
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    Top = 16
  end
end
