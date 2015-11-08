inherited ObjectDaoMethod: TObjectDaoMethod
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_METHOD'
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
        Name = 'ID_VISIBILITY_UNIT'
        DataType = ftInteger
      end
      item
        Name = 'ID_VISIBILITY_CLASS'
        DataType = ftInteger
      end
      item
        Name = 'IS_FUNCTION'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'IS_STATIC'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end>
    Left = 32
    Top = 59
    object CDSDadosID_METHOD: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_METHOD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosID_VISIBILITY_UNIT: TIntegerField
      DisplayLabel = 'Unit'
      FieldName = 'ID_VISIBILITY_UNIT'
    end
    object CDSDadosID_VISIBILITY_CLASS: TIntegerField
      DisplayLabel = 'Class'
      FieldName = 'ID_VISIBILITY_CLASS'
    end
    object CDSDadosIS_STATIC: TStringField
      DisplayLabel = 'Is Static'
      FieldName = 'IS_STATIC'
      FixedChar = True
      Size = 1
    end
    object CDSDadosIS_FUNCTION: TStringField
      DisplayLabel = 'Is Function'
      FieldName = 'IS_FUNCTION'
      FixedChar = True
      Size = 1
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_METHOD'
    object SQLDADOSID_METHOD: TIntegerField
      FieldName = 'ID_METHOD'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSID_VISIBILITY_UNIT: TIntegerField
      FieldName = 'ID_VISIBILITY_UNIT'
    end
    object SQLDADOSID_VISIBILITY_CLASS: TIntegerField
      FieldName = 'ID_VISIBILITY_CLASS'
    end
    object SQLDADOSIS_FUNCTION: TStringField
      FieldName = 'IS_FUNCTION'
      FixedChar = True
      Size = 1
    end
    object SQLDADOSIS_STATIC: TStringField
      FieldName = 'IS_STATIC'
      FixedChar = True
      Size = 1
    end
  end
end
