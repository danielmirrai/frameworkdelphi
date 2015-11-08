inherited ObjectDaoCidade: TObjectDaoCidade
  Left = 371
  Top = 307
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
        Name = 'CODIGO_ESTADO'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object intgrfldCDSDadosCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object strngfldCDSDadosNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 250
    end
    object intgrfldCDSDadosCODIGO_ESTADO: TIntegerField
      FieldName = 'CODIGO_ESTADO'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    GetMetadata = False
    CommandText = 'CIDADE'
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    object SQLDADOSCODIGO: TIntegerField
      FieldName = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInKey]
      Required = True
    end
    object SQLDADOSNOME: TStringField
      FieldName = 'NOME'
      Required = True
      Size = 250
    end
    object SQLDADOSCODIGO_ESTADO: TIntegerField
      FieldName = 'CODIGO_ESTADO'
      Required = True
    end
  end
end
