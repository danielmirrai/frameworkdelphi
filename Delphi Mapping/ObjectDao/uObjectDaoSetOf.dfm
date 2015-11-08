inherited ObjectDaoSetOf: TObjectDaoSetOf
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_SET_OF'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_TYPE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        Attributes = [faRequired]
        DataType = ftString
        Size = 200
      end
      item
        Name = 'VALUE_SETOF'
        Attributes = [faRequired]
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ID_VALUE_TYPE'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosID_SET_OF: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_SET_OF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosID_VALUE_TYPE: TIntegerField
      DisplayLabel = 'Type Value'
      FieldName = 'ID_VALUE_TYPE'
      Required = True
    end
    object CDSDadosVALUE_SETOF: TStringField
      DisplayLabel = 'Value'
      FieldName = 'VALUE_SETOF'
      Required = True
      Size = 200
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_SETOF'
    object SQLDADOSID_SET_OF: TIntegerField
      FieldName = 'ID_SET_OF'
      Required = True
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSVALUE_SETOF: TStringField
      FieldName = 'VALUE_SETOF'
      Required = True
      Size = 200
    end
    object SQLDADOSID_VALUE_TYPE: TIntegerField
      FieldName = 'ID_VALUE_TYPE'
      Required = True
    end
  end
end
