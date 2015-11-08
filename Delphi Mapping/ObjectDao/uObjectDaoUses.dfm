inherited ObjectDaoUses: TObjectDaoUses
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_USES'
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
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    Left = 32
    Top = 58
    object CDSDadosID_USES: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_USES'
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
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_USES'
    object SQLDADOSID_USES: TIntegerField
      FieldName = 'ID_USES'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSID_VISIBILITY_UNIT: TIntegerField
      FieldName = 'ID_VISIBILITY_UNIT'
      Required = True
    end
  end
end
