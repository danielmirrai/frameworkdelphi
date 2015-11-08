inherited ObjectDaoConst: TObjectDaoConst
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_CONST'
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
        Name = 'VALUE_CONST'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ID_METHOD'
        DataType = ftInteger
      end
      item
        Name = 'ID_VISIBILITY_CLASS'
        DataType = ftInteger
      end
      item
        Name = 'ID_VISIBILITY_UNIT'
        DataType = ftInteger
      end
      item
        Name = 'ID_TYPE_VALUE'
        DataType = ftString
        Size = 200
      end>
    Left = 29
    Top = 49
    object CDSDadosID_CONST: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_CONST'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosID_METHOD: TIntegerField
      DisplayLabel = 'Method'
      FieldName = 'ID_METHOD'
    end
    object CDSDadosID_VISIBILITY_CLASS: TIntegerField
      DisplayLabel = 'Class'
      FieldName = 'ID_VISIBILITY_CLASS'
    end
    object CDSDadosID_VISIBILITY_UNIT: TIntegerField
      DisplayLabel = 'Unit'
      FieldName = 'ID_VISIBILITY_UNIT'
    end
    object CDSDadosID_TYPE_VALUE: TStringField
      DisplayLabel = 'Type Value'
      FieldName = 'ID_TYPE_VALUE'
      Size = 200
    end
    object CDSDadosVALUE_CONST: TStringField
      DisplayLabel = 'Value'
      FieldName = 'VALUE_CONST'
      Size = 200
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_CONST'
    object SQLDADOSID_CONST: TIntegerField
      FieldName = 'ID_CONST'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSVALUE_CONST: TStringField
      FieldName = 'VALUE_CONST'
      Size = 200
    end
    object SQLDADOSID_METHOD: TIntegerField
      FieldName = 'ID_METHOD'
    end
    object SQLDADOSID_VISIBILITY_CLASS: TIntegerField
      FieldName = 'ID_VISIBILITY_CLASS'
    end
    object SQLDADOSID_VISIBILITY_UNIT: TIntegerField
      FieldName = 'ID_VISIBILITY_UNIT'
    end
    object SQLDADOSID_TYPE_VALUE: TStringField
      FieldName = 'ID_TYPE_VALUE'
      Size = 200
    end
  end
end
