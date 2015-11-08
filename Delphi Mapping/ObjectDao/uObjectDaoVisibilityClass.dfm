inherited ObjectDaoVisibilityClass: TObjectDaoVisibilityClass
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_VISIBILITY_CLASS'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_CLASS'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_VISIBILITY'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'CDSDadosIndex1'
      end
      item
        Name = 'CDSDadosIndex2'
      end>
    object CDSDadosID_VISIBILITY_CLASS: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_VISIBILITY_CLASS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_CLASS: TIntegerField
      DisplayLabel = 'Class'
      FieldName = 'ID_CLASS'
      Required = True
    end
    object CDSDadosID_VISIBILITY: TIntegerField
      DisplayLabel = 'Visibility'
      FieldName = 'ID_VISIBILITY'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_VISIBILITYCLASS'
    object SQLDADOSID_VISIBILITY_CLASS: TIntegerField
      FieldName = 'ID_VISIBILITY_CLASS'
      Required = True
    end
    object SQLDADOSID_CLASS: TIntegerField
      FieldName = 'ID_CLASS'
      Required = True
    end
    object SQLDADOSID_VISIBILITY: TIntegerField
      FieldName = 'ID_VISIBILITY'
      Required = True
    end
  end
end
