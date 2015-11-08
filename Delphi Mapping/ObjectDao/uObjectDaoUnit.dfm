inherited ObjectDaoUnit: TObjectDaoUnit
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_UNIT'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'MD5'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'FILEPATH'
        Attributes = [faRequired]
        DataType = ftString
        Size = 500
      end
      item
        Name = 'NAME'
        Attributes = [faRequired]
        DataType = ftString
        Size = 200
      end>
    object CDSDadosID_UNIT: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_UNIT'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosMD5: TStringField
      FieldName = 'MD5'
      Size = 32
    end
    object CDSDadosFILEPATH: TStringField
      DisplayLabel = 'File path'
      FieldName = 'FILEPATH'
      Required = True
      Size = 500
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_UNIT'
    object SQLDADOSID_UNIT: TIntegerField
      FieldName = 'ID_UNIT'
      Required = True
    end
    object SQLDADOSMD5: TStringField
      FieldName = 'MD5'
      Size = 32
    end
    object SQLDADOSFILEPATH: TStringField
      FieldName = 'FILEPATH'
      Required = True
      Size = 500
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
  end
end
