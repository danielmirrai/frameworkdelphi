inherited ObjectDaoCommand: TObjectDaoCommand
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_COMMAND'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'COMMAND'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'SPECIFIC_NOT_COMMAND'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'COMMAND_FORMATTED'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'SPECIFIC_NOT_COMMAND_FORMATTED'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ID_TYPE_COMMAND'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosID_COMMAND: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_COMMAND'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosCOMMAND: TStringField
      DisplayLabel = 'Command'
      FieldName = 'COMMAND'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object CDSDadosSPECIFIC_NOT_COMMAND: TStringField
      DisplayLabel = 'Not Command'
      FieldName = 'SPECIFIC_NOT_COMMAND'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object CDSDadosCOMMAND_FORMATTED: TStringField
      DisplayLabel = 'Command Formatteed'
      FieldName = 'COMMAND_FORMATTED'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object CDSDadosSPECIFIC_NOT_COMMAND_FORMATTED: TStringField
      DisplayLabel = 'Not Command Formatted'
      FieldName = 'SPECIFIC_NOT_COMMAND_FORMATTED'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object CDSDadosID_TYPE_COMMAND: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE_COMMAND'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_COMMAND'
    object SQLDADOSID_COMMAND: TIntegerField
      FieldName = 'ID_COMMAND'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLDADOSCOMMAND: TStringField
      FieldName = 'COMMAND'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object SQLDADOSSPECIFIC_NOT_COMMAND: TStringField
      FieldName = 'SPECIFIC_NOT_COMMAND'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object SQLDADOSCOMMAND_FORMATTED: TStringField
      FieldName = 'COMMAND_FORMATTED'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object SQLDADOSSPECIFIC_NOT_COMMAND_FORMATTED: TStringField
      FieldName = 'SPECIFIC_NOT_COMMAND_FORMATTED'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
    object SQLDADOSID_TYPE_COMMAND: TIntegerField
      FieldName = 'ID_TYPE_COMMAND'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
  end
end
