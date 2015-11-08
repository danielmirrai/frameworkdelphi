inherited ObjectDaoPedido: TObjectDaoPedido
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'CODIGO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'NUMERO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DATA_EMISSAO'
        Attributes = [faRequired]
        DataType = ftTimeStamp
      end
      item
        Name = 'DATA_VENCIMENTO'
        DataType = ftTimeStamp
      end
      item
        Name = 'DATA_ENTREGA'
        DataType = ftTimeStamp
      end
      item
        Name = 'CODIGO_CLIENTE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_ENDERECO_CLIENTE'
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_VENDEDOR'
        DataType = ftInteger
      end
      item
        Name = 'PERC_COMISSAO_VERDEDOR'
        DataType = ftInteger
      end
      item
        Name = 'VALOR_TOTAL'
        Attributes = [faRequired]
        DataType = ftFloat
      end
      item
        Name = 'NFE'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'OBSERVACAO'
        DataType = ftMemo
        Size = 1
      end
      item
        Name = 'DC_CLIENTE'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'DC_VENDEDOR'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'DC_SITUACAO'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'CODIGO_SITUACAO_PEDIDO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CODIGO_EMPRESA'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'DESCRICAO'
      Size = 250
    end
    object CDSDadosNUMERO: TIntegerField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'NUMERO'
      Required = True
    end
    object CDSDadosDATA_EMISSAO: TSQLTimeStampField
      DisplayLabel = 'Data Emiss'#227'o'
      FieldName = 'DATA_EMISSAO'
    end
    object CDSDadosDATA_VENCIMENTO: TSQLTimeStampField
      DisplayLabel = 'Data Vencimento'
      FieldName = 'DATA_VENCIMENTO'
    end
    object CDSDadosDATA_ENTREGA: TSQLTimeStampField
      DisplayLabel = 'Data Entrega'
      FieldName = 'DATA_ENTREGA'
    end
    object CDSDadosCODIGOCLIENTE: TIntegerField
      DisplayLabel = 'Cliente'
      FieldName = 'CODIGO_CLIENTE'
      Required = True
    end
    object CDSDadosCODIGO_ENDERECO_CLIENTE: TIntegerField
      DisplayLabel = 'Endere'#231'o'
      FieldName = 'CODIGO_ENDERECO_CLIENTE'
    end
    object CDSDadosCODIGO_VENDEDOR: TIntegerField
      DisplayLabel = 'Vendedor'
      FieldName = 'CODIGO_VENDEDOR'
    end
    object CDSDadosPERC_COMISSAO_VERDEDOR: TIntegerField
      DisplayLabel = 'Perc. Comiss'#227'o'
      FieldName = 'PERC_COMISSAO_VERDEDOR'
    end
    object CDSDadosVALOR_TOTAL: TFloatField
      DisplayLabel = 'Valor Total'
      FieldName = 'VALOR_TOTAL'
    end
    object CDSDadosNFE: TStringField
      FieldName = 'NFE'
      Size = 250
    end
    object CDSDadosOBSERVACAO: TMemoField
      DisplayLabel = 'Observa'#231#227'o'
      FieldName = 'OBSERVACAO'
      BlobType = ftMemo
      Size = 1
    end
    object CDSDadosDC_CLIENTE: TStringField
      FieldName = 'DC_CLIENTE'
      Size = 250
    end
    object CDSDadosDC_VENDEDOR: TStringField
      FieldName = 'DC_VENDEDOR'
      Size = 250
    end
    object CDSDadosDC_SITUACAO: TStringField
      FieldName = 'DC_SITUACAO'
      Size = 250
    end
    object intgrfldCDSDadosCODIGO_SITUACAO_PEDIDO: TIntegerField
      DisplayLabel = 'Situa'#231#227'o'
      FieldName = 'CODIGO_SITUACAO_PEDIDO'
      Required = True
    end
    object intgrfldCDSDadosCODIGO_EMPRESA: TIntegerField
      DisplayLabel = 'Empresa'
      FieldName = 'CODIGO_EMPRESA'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 
      'select p.*, coalesce(s.nome, s.razao_social) as dc_cliente, coal' +
      'esce(v.nome, v.razao_social) as dc_vendedor,'#13#10'sp.descricao as dc' +
      '_situacao from pedido p'#13#10'inner join pessoa s on s.codigo = p.cod' +
      'igo_cliente'#13#10'left join pessoa v on v.codigo = p.codigo_vendedor ' +
      '  '#13#10'left join situacao_pedido sp on sp.codigo = p.CODIGO_SITUACA' +
      'O_PEDIDO'#13#10
    CommandType = ctQuery
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    Top = 16
    object SQLDADOSCODIGO: TIntegerField
      FieldName = 'CODIGO'
      Required = True
    end
    object SQLDADOSDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 250
    end
    object SQLDADOSNUMERO: TIntegerField
      FieldName = 'NUMERO'
      Required = True
    end
    object SQLDADOSDATA_EMISSAO: TSQLTimeStampField
      FieldName = 'DATA_EMISSAO'
      Required = True
    end
    object SQLDADOSDATA_VENCIMENTO: TSQLTimeStampField
      FieldName = 'DATA_VENCIMENTO'
    end
    object SQLDADOSDATA_ENTREGA: TSQLTimeStampField
      FieldName = 'DATA_ENTREGA'
    end
    object SQLDADOSCODIGOCLIENTE: TIntegerField
      FieldName = 'CODIGO_CLIENTE'
      Required = True
    end
    object SQLDADOSCODIGO_ENDERECO_CLIENTE: TIntegerField
      FieldName = 'CODIGO_ENDERECO_CLIENTE'
    end
    object SQLDADOSCODIGO_VENDEDOR: TIntegerField
      FieldName = 'CODIGO_VENDEDOR'
    end
    object SQLDADOSPERC_COMISSAO_VERDEDOR: TIntegerField
      FieldName = 'PERC_COMISSAO_VERDEDOR'
    end
    object SQLDADOSVALOR_TOTAL: TFloatField
      FieldName = 'VALOR_TOTAL'
      Required = True
    end
    object SQLDADOSNFE: TStringField
      FieldName = 'NFE'
      Size = 250
    end
    object SQLDADOSOBSERVACAO: TMemoField
      FieldName = 'OBSERVACAO'
      BlobType = ftMemo
      Size = 1
    end
    object SQLDADOSDC_CLIENTE: TStringField
      FieldName = 'DC_CLIENTE'
      Size = 250
    end
    object SQLDADOSDC_VENDEDOR: TStringField
      FieldName = 'DC_VENDEDOR'
      Size = 250
    end
    object SQLDADOSDC_SITUACAO: TStringField
      FieldName = 'DC_SITUACAO'
      Size = 250
    end
    object intgrfldSQLDADOSCODIGO_SITUACAO_PEDIDO: TIntegerField
      FieldName = 'CODIGO_SITUACAO_PEDIDO'
      Required = True
    end
    object intgrfldSQLDADOSCODIGO_EMPRESA: TIntegerField
      FieldName = 'CODIGO_EMPRESA'
      Required = True
    end
  end
end
