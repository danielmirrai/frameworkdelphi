inherited ObjectDaoVisibilityUnit: TObjectDaoVisibilityUnit
  Height = 216
  Width = 387
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_VISIBILITY_UNIT'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_UNIT'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'IS_PUBLIC'
        Attributes = [faRequired, faFixed]
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    object CDSDadosID_VISIBILITY_UNIT: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_VISIBILITY_UNIT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_UNIT: TIntegerField
      DisplayLabel = 'Unit'
      FieldName = 'ID_UNIT'
      Required = True
    end
    object CDSDadosIS_PUBLIC: TStringField
      FieldName = 'IS_PUBLIC'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_VISIBILITYUNIT'
    Left = 25
    object SQLDADOSID_VISIBILITY_UNIT: TIntegerField
      FieldName = 'ID_VISIBILITY_UNIT'
      Required = True
    end
    object SQLDADOSID_UNIT: TIntegerField
      FieldName = 'ID_UNIT'
      Required = True
    end
    object SQLDADOSIS_PUBLIC: TStringField
      FieldName = 'IS_PUBLIC'
      Required = True
      FixedChar = True
      Size = 1
    end
  end
end
