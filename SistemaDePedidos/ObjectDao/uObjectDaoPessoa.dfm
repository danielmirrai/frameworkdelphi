inherited ObjectDaoPessoa: TObjectDaoPessoa
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
        Name = 'RAZAO_SOCIAL'
        DataType = ftString
        Size = 250
      end
      item
        Name = 'CPF'
        Attributes = [faFixed]
        DataType = ftString
        Size = 11
      end
      item
        Name = 'CNPJ'
        Attributes = [faFixed]
        DataType = ftString
        Size = 14
      end
      item
        Name = 'TELEFONE'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'EMAIL'
        DataType = ftString
        Size = 100
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
    object CDSDadosNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Required = True
      Size = 250
    end
    object CDSDadosRAZAO_SOCIAL: TStringField
      DisplayLabel = 'Raz'#227'o Social'
      FieldName = 'RAZAO_SOCIAL'
      Size = 250
    end
    object CDSDadosCPF: TStringField
      FieldName = 'CPF'
      FixedChar = True
      Size = 11
    end
    object CDSDadosCNPJ: TStringField
      FieldName = 'CNPJ'
      FixedChar = True
      Size = 14
    end
    object CDSDadosTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
    end
    object CDSDadosEMAIL: TStringField
      DisplayLabel = 'E-mail'
      FieldName = 'EMAIL'
      Size = 100
    end
    object CDSDadosFL_ATIVO: TSmallintField
      DisplayLabel = 'Ativo'
      FieldName = 'FL_ATIVO'
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'PESSOA'
    SQLConnection = ObjectDaoAplicacaoPedidos.FBConnection
    object SQLDADOSCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      Required = True
    end
    object SQLDADOSNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Required = True
      Size = 250
    end
    object SQLDADOSRAZAO_SOCIAL: TStringField
      DisplayLabel = 'Raz'#227'o Social'
      FieldName = 'RAZAO_SOCIAL'
      Size = 250
    end
    object SQLDADOSCPF: TStringField
      FieldName = 'CPF'
      FixedChar = True
      Size = 11
    end
    object SQLDADOSCNPJ: TStringField
      FieldName = 'CNPJ'
      FixedChar = True
      Size = 14
    end
    object SQLDADOSTELEFONE: TStringField
      DisplayLabel = 'Telefone'
      FieldName = 'TELEFONE'
    end
    object SQLDADOSEMAIL: TStringField
      FieldName = 'EMAIL'
      Size = 100
    end
    object SQLDADOSFL_ATIVO: TSmallintField
      FieldName = 'FL_ATIVO'
    end
  end
end
