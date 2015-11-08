inherited ObjectDaoProduto: TObjectDaoProduto
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
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'BARCODE'
        DataType = ftInteger
      end
      item
        Name = 'VALOR_UNITARIO'
        DataType = ftInteger
      end
      item
        Name = 'OBSERVACAO'
        DataType = ftMemo
        Size = 1
      end
      item
        Name = 'FL_ATIVO'
        DataType = ftSmallint
      end
      item
        Name = 'CODIGO_EMPRESA'
        Attributes = [faRequired]
        DataType = ftSmallint
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
    object CDSDadosDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 250
    end
    object CDSDadosBARCODE: TIntegerField
      DisplayLabel = 'Barcode'
      FieldName = 'BARCODE'
    end
    object CDSDadosVALOR_UNITARIO: TIntegerField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALOR_UNITARIO'
    end
    object CDSDadosOBSERVACAO: TMemoField
      DisplayLabel = 'Observa'#231#227'o'
      FieldName = 'OBSERVACAO'
      BlobType = ftMemo
      Size = 1
    end
    object CDSDadosFL_ATIVO: TSmallintField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
    end
    object CDSDadosCODIGO_EMPRESA: TSmallintField
      DisplayLabel = 'Empresa'
      FieldName = 'CODIGO_EMPRESA'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'PRODUTO'
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
    object SQLDADOSDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 250
    end
    object SQLDADOSBARCODE: TIntegerField
      FieldName = 'BARCODE'
    end
    object SQLDADOSVALOR_UNITARIO: TIntegerField
      FieldName = 'VALOR_UNITARIO'
    end
    object SQLDADOSOBSERVACAO: TMemoField
      FieldName = 'OBSERVACAO'
      BlobType = ftMemo
      Size = 1
    end
    object SQLDADOSFL_ATIVO: TSmallintField
      FieldName = 'FL_ATIVO'
    end
    object SQLDADOSCODIGO_EMPRESA: TSmallintField
      FieldName = 'CODIGO_EMPRESA'
      Required = True
    end
  end
end
