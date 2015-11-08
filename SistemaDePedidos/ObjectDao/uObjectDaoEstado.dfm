inherited ObjectDaoEstado: TObjectDaoEstado
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NOME'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'UF'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 2
      end
      item
        Name = 'CODIGO_PAIS'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Required = True
    end
    object CDSDadosNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 250
    end
    object CDSDadosUF: TStringField
      FieldName = 'UF'
      Required = True
      FixedChar = True
      Size = 2
    end
    object CDSDadosCODIGO_PAIS: TIntegerField
      DisplayLabel = 'Pa'#237's'
      FieldName = 'CODIGO_PAIS'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'ESTADO'
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    object SQLDADOSCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object SQLDADOSNOME: TStringField
      FieldName = 'NOME'
      Size = 250
    end
    object SQLDADOSUF: TStringField
      FieldName = 'UF'
      Required = True
      FixedChar = True
      Size = 2
    end
    object SQLDADOSCODIGO_PAIS: TIntegerField
      FieldName = 'CODIGO_PAIS'
      Required = True
    end
  end
end
