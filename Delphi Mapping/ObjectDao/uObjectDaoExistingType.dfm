inherited ObjectDaoExistingType: TObjectDaoExistingType
  OnCreate = DataModuleCreate
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_EXISTING_TYPE'
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
        Name = 'ID_OWNER'
        Attributes = [faRequired]
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ID_TYPE'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosID_Existing_Type: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_Existing_Type'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosID_OWNER: TStringField
      DisplayLabel = 'Owner'
      FieldName = 'ID_OWNER'
      Required = True
      Size = 200
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_EXISTINGTYPE'
    object SQLDADOSID_EXISTING_TYPE: TIntegerField
      FieldName = 'ID_EXISTING_TYPE'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSID_OWNER: TStringField
      FieldName = 'ID_OWNER'
      Required = True
      Size = 200
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
  end
end
