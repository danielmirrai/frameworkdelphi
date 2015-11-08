inherited ObjectDaoTipo: TObjectDaoTipo
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
    object CDSDadosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Required = True
    end
    object CDSDadosDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Required = True
      Size = 250
    end
    object CDSDadosFL_ATIVO: TSmallintField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'TIPO'
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    object SQLDADOSCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object SQLDADOSDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Required = True
      Size = 250
    end
    object SQLDADOSFL_ATIVO: TSmallintField
      FieldName = 'FL_ATIVO'
    end
  end
end
