inherited ObjectDaoArrayOf: TObjectDaoArrayOf
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_ARRAY_OF'
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
        Name = 'ID_CLASS'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_TYPE'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosID_ARRAY_OF: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_ARRAY_OF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosID_CLASS: TIntegerField
      DisplayLabel = 'Class'
      FieldName = 'ID_CLASS'
      Required = True
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_ARRAYOF'
    object SQLDADOSID_ARRAY_OF: TIntegerField
      FieldName = 'ID_ARRAY_OF'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSID_CLASS: TIntegerField
      FieldName = 'ID_CLASS'
      Required = True
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
  end
end
