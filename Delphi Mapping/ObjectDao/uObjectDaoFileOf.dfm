inherited ObjectDaoFileOf: TObjectDaoFileOf
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_FILE_OF'
        DataType = ftInteger
      end
      item
        Name = 'ID_TYPE'
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ID_CLASS'
        DataType = ftString
        Size = 200
      end>
    object CDSDadosID_FILE_OF: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_FILE_OF'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosID_CLASS: TStringField
      DisplayLabel = 'Class'
      FieldName = 'ID_CLASS'
      Required = True
      Size = 200
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_FILEOF'
    object SQLDADOSID_FILE_OF: TIntegerField
      FieldName = 'ID_FILE_OF'
      Required = True
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSID_CLASS: TStringField
      FieldName = 'ID_CLASS'
      Required = True
      Size = 200
    end
  end
end
