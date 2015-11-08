inherited ObjectDaoType: TObjectDaoType
  OnCreate = DataModuleCreate
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_TYPE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_VISIBILITY_UNIT'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_TYPE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_VISIBILITY_UNIT: TIntegerField
      DisplayLabel = 'Unit'
      FieldName = 'ID_VISIBILITY_UNIT'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_TYPE'
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
    object SQLDADOSID_VISIBILITY_UNIT: TIntegerField
      FieldName = 'ID_VISIBILITY_UNIT'
      Required = True
    end
  end
end
