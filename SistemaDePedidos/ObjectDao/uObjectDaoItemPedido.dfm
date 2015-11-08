inherited ObjectDaoItemPedido: TObjectDaoItemPedido
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NUMERO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_PRODUTO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_PEDIDO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'QUANTIDADE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'FL_CANCELADO'
        DataType = ftSmallint
      end
      item
        Name = 'VALOR_ACRESCIMO'
        DataType = ftFloat
      end
      item
        Name = 'VALOR_DESCONTO'
        DataType = ftFloat
      end
      item
        Name = 'VALOR_UNITARIO'
        DataType = ftFloat
      end
      item
        Name = 'DC_PEDIDO'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'DC_PRODUTO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 250
      end>
    object CDSDadosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Required = True
    end
    object CDSDadosNUMERO: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
      Required = True
    end
    object CDSDadosCODIGO_PRODUTO: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'CODIGO_PRODUTO'
      Required = True
    end
    object CDSDadosCODIGO_PEDIDO: TIntegerField
      DisplayLabel = 'Pedido'
      FieldName = 'CODIGO_PEDIDO'
      Required = True
    end
    object CDSDadosQUANTIDADE: TIntegerField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      Required = True
    end
    object CDSDadosFL_CANCELADO: TSmallintField
      DisplayLabel = 'Cancelado'
      FieldName = 'FL_CANCELADO'
    end
    object CDSDadosVALOR_ACRESCIMO: TFloatField
      DisplayLabel = 'Valor Acrescimo'
      FieldName = 'VALOR_ACRESCIMO'
    end
    object CDSDadosVALOR_DESCONTO: TFloatField
      DisplayLabel = 'Valor Desconto'
      FieldName = 'VALOR_DESCONTO'
    end
    object CDSDadosVALOR_UNITARIO: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALOR_UNITARIO'
    end
    object CDSDadosDC_PEDIDO: TStringField
      FieldName = 'DC_PEDIDO'
      Size = 250
    end
    object CDSDadosDC_PRODUTO: TStringField
      FieldName = 'DC_PRODUTO'
      Required = True
      Size = 250
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 
      'select i.*, p.descricao as dc_pedido, d.nome as dc_produto from ' +
      'item_pedido i'#13#10'inner join pedido p on p.codigo = i.codigo_pedido' +
      #13#10'inner join produto d on d.codigo = i.codigo_produto'
    CommandType = ctQuery
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    object SQLDADOSCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Required = True
    end
    object SQLDADOSNUMERO: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
      Required = True
    end
    object SQLDADOSCODIGO_PRODUTO: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'CODIGO_PRODUTO'
      Required = True
    end
    object SQLDADOSCODIGO_PEDIDO: TIntegerField
      DisplayLabel = 'Pedido'
      FieldName = 'CODIGO_PEDIDO'
      Required = True
    end
    object SQLDADOSQUANTIDADE: TIntegerField
      DisplayLabel = 'Quant.'
      FieldName = 'QUANTIDADE'
      Required = True
    end
    object SQLDADOSFL_CANCELADO: TSmallintField
      DisplayLabel = 'Cancelado'
      FieldName = 'FL_CANCELADO'
    end
    object SQLDADOSVALOR_ACRESCIMO: TFloatField
      DisplayLabel = 'Valor Acr'#233'scimo'
      FieldName = 'VALOR_ACRESCIMO'
    end
    object SQLDADOSVALOR_DESCONTO: TFloatField
      DisplayLabel = 'Valor Desconto'
      FieldName = 'VALOR_DESCONTO'
    end
    object SQLDADOSVALOR_UNITARIO: TFloatField
      DisplayLabel = 'Valor Unit'#225'rio'
      FieldName = 'VALOR_UNITARIO'
    end
    object SQLDADOSDC_PEDIDO: TStringField
      FieldName = 'DC_PEDIDO'
      Size = 250
    end
    object SQLDADOSDC_PRODUTO: TStringField
      FieldName = 'DC_PRODUTO'
      Required = True
      Size = 250
    end
  end
end
