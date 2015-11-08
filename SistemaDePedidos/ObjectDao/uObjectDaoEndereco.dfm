inherited ObjectDaoEndereco: TObjectDaoEndereco
  Width = 213
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_PESSOA'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TIPO_ENDERECO'
        Attributes = [faRequired]
        DataType = ftSmallint
      end
      item
        Name = 'CEP'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CODIGO_CIDADE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'BAIRRO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 250
      end
      item
        Name = 'RUA'
        Attributes = [faRequired]
        DataType = ftString
        Size = 250
      end
      item
        Name = 'NUMERO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_BLOCO'
        DataType = ftInteger
      end
      item
        Name = 'NUMERO_APARTAMENTO'
        DataType = ftInteger
      end
      item
        Name = 'OBSERVACAO'
        DataType = ftString
        Size = 250
      end>
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'ENDERECO'
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    object SQLDADOSCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object intgrfldSQLDADOSCODIGO_PESSOA: TIntegerField
      FieldName = 'CODIGO_PESSOA'
      Required = True
    end
    object SQLDADOSTIPO_ENDERECO: TSmallintField
      FieldName = 'TIPO_ENDERECO'
      Required = True
    end
    object strngfldSQLDADOSCEP: TStringField
      FieldName = 'CEP'
    end
    object intgrfldSQLDADOSCODIGO_CIDADE: TIntegerField
      FieldName = 'CODIGO_CIDADE'
      Required = True
    end
    object strngfldSQLDADOSBAIRRO: TStringField
      FieldName = 'BAIRRO'
      Required = True
      Size = 250
    end
    object strngfldSQLDADOSRUA: TStringField
      FieldName = 'RUA'
      Required = True
      Size = 250
    end
    object intgrfldSQLDADOSNUMERO: TIntegerField
      FieldName = 'NUMERO'
      Required = True
    end
    object intgrfldSQLDADOSNUMERO_BLOCO: TIntegerField
      FieldName = 'NUMERO_BLOCO'
    end
    object intgrfldSQLDADOSNUMERO_APARTAMENTO: TIntegerField
      FieldName = 'NUMERO_APARTAMENTO'
    end
    object strngfldSQLDADOSOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 250
    end
  end
end
