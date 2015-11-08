inherited ObjectDaoRecord: TObjectDaoRecord
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_RECORD'
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftInteger
      end
      item
        Name = 'ID_TYPE'
        DataType = ftInteger
      end>
    object CDSDadosID_RECORD: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_RECORD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosNAME: TIntegerField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Required = True
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_RECORD'
    object SQLDADOSID_RECORD: TIntegerField
      FieldName = 'ID_RECORD'
      Required = True
    end
    object SQLDADOSNAME: TIntegerField
      FieldName = 'NAME'
      Required = True
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
  end
end
