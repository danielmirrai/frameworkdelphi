inherited ObjectDaoTipoPessoa: TObjectDaoTipoPessoa
  Left = 577
  Top = 265
  Height = 149
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_TIPO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_PESSOA'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Required = True
    end
    object CDSDadosCODIGO_TIPO: TIntegerField
      DisplayLabel = 'Tipo'
      FieldName = 'CODIGO_TIPO'
      Required = True
    end
    object CDSDadosCODIGO_PESSOA: TIntegerField
      DisplayLabel = 'Pessoa'
      FieldName = 'CODIGO_PESSOA'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    GetMetadata = False
    CommandText = 'TIPO_PESSOA'
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    object SQLDADOSCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object SQLDADOSCODIGO_TIPO: TIntegerField
      FieldName = 'CODIGO_TIPO'
      Required = True
    end
    object SQLDADOSCODIGO_PESSOA: TIntegerField
      FieldName = 'CODIGO_PESSOA'
      Required = True
    end
  end
end
