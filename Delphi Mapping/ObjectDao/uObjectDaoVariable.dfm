inherited ObjectDaoVariable: TObjectDaoVariable
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_VARIABLE'
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
        Name = 'DEFAULT_VAR'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'IS_PARAM'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'VALUE_VAR'
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
        Name = 'IS_STATIC'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ID_TYPE_VALUE'
        Attributes = [faRequired]
        DataType = ftString
        Size = 200
      end
      item
        Name = 'TYPE_MODIFY'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'IS_RETURN'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'INDEX_VAR'
        DataType = ftInteger
      end>
    Left = 39
    object CDSDadosID_VARIABLE: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_VARIABLE'
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
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE_VALUE'
      Required = True
      Size = 200
    end
    object CDSDadosTYPE_MODIFY: TStringField
      DisplayLabel = 'Type Modify'
      FieldName = 'TYPE_MODIFY'
    end
    object CDSDadosDEFAULT_VAR: TStringField
      DisplayLabel = 'Default'
      FieldName = 'DEFAULT_VAR'
      Size = 200
    end
    object CDSDadosVALUE_VAR: TStringField
      DisplayLabel = 'Value'
      FieldName = 'VALUE_VAR'
      Size = 200
    end
    object CDSDadosINDEX_VAR: TIntegerField
      DisplayLabel = 'Index'
      FieldName = 'INDEX_VAR'
    end
    object CDSDadosIS_PARAM: TStringField
      DisplayLabel = 'Is param'
      FieldName = 'IS_PARAM'
      FixedChar = True
      Size = 1
    end
    object CDSDadosIS_STATIC: TStringField
      DisplayLabel = 'Is static'
      FieldName = 'IS_STATIC'
      FixedChar = True
      Size = 1
    end
    object CDSDadosIS_RETURN: TStringField
      DisplayLabel = 'Is Return'
      FieldName = 'IS_RETURN'
      FixedChar = True
      Size = 1
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_VARIABLE'
    object SQLDADOSID_VARIABLE: TIntegerField
      FieldName = 'ID_VARIABLE'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSDEFAULT_VAR: TStringField
      FieldName = 'DEFAULT_VAR'
      Size = 200
    end
    object SQLDADOSIS_PARAM: TStringField
      FieldName = 'IS_PARAM'
      FixedChar = True
      Size = 1
    end
    object SQLDADOSVALUE_VAR: TStringField
      FieldName = 'VALUE_VAR'
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
    object SQLDADOSIS_STATIC: TStringField
      FieldName = 'IS_STATIC'
      FixedChar = True
      Size = 1
    end
    object SQLDADOSID_TYPE_VALUE: TStringField
      FieldName = 'ID_TYPE_VALUE'
      Required = True
      Size = 200
    end
    object SQLDADOSTYPE_MODIFY: TStringField
      FieldName = 'TYPE_MODIFY'
    end
    object SQLDADOSIS_RETURN: TStringField
      FieldName = 'IS_RETURN'
      FixedChar = True
      Size = 1
    end
    object SQLDADOSINDEX_VAR: TIntegerField
      FieldName = 'INDEX_VAR'
    end
  end
end
