inherited ObjectDaoObjectOf: TObjectDaoObjectOf
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_OBJECTOF'
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
        Name = 'IS_FUNCTION'
        DataType = ftInteger
      end
      item
        Name = 'IS_STATIC'
        DataType = ftInteger
      end
      item
        Name = 'ID_TYPE'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosID_OBJECTOF: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_OBJECTOF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosIS_FUNCTION: TIntegerField
      DisplayLabel = 'Is Function'
      FieldName = 'IS_FUNCTION'
    end
    object CDSDadosIS_STATIC: TIntegerField
      DisplayLabel = 'Is Static'
      FieldName = 'IS_STATIC'
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_OBJECTOF'
    object SQLDADOSID_OBJECTOF: TIntegerField
      FieldName = 'ID_OBJECTOF'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSIS_FUNCTION: TIntegerField
      FieldName = 'IS_FUNCTION'
    end
    object SQLDADOSIS_STATIC: TIntegerField
      FieldName = 'IS_STATIC'
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
  end
end
