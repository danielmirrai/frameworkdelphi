inherited ObjectDaoPais: TObjectDaoPais
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOME'
        Attributes = [faRequired]
        DataType = ftString
        Size = 250
      end
      item
        Name = 'DDI'
        DataType = ftSmallint
      end
      item
        Name = 'SIGLA'
        Attributes = [faFixed]
        DataType = ftString
        Size = 2
      end>
    object CDSDadosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Required = True
    end
    object CDSDadosNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Required = True
      Size = 250
    end
    object CDSDadosDDI: TSmallintField
      FieldName = 'DDI'
    end
    object CDSDadosSIGLA: TStringField
      DisplayLabel = 'Sigla'
      FieldName = 'SIGLA'
      FixedChar = True
      Size = 2
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'PAIS'
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    object SQLDADOSCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object SQLDADOSNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 250
    end
    object SQLDADOSDDI: TSmallintField
      FieldName = 'DDI'
    end
    object SQLDADOSSIGLA: TStringField
      FieldName = 'SIGLA'
      FixedChar = True
      Size = 2
    end
  end
end
