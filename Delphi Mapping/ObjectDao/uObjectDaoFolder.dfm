inherited ObjectDaoFolder: TObjectDaoFolder
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_FOLDER'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'FOLDER_PATH'
        Attributes = [faRequired]
        DataType = ftString
        Size = 500
      end
      item
        Name = 'ID_FOLDER_OWNER'
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        Attributes = [faRequired]
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ID_DRIVE'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosID_FOLDER: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID_FOLDER'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosFOLDER_PATH: TStringField
      DisplayLabel = 'Diret'#243'rio'
      FieldName = 'FOLDER_PATH'
      Required = True
      Size = 500
    end
    object CDSDadosID_FOLDER_OWNER: TIntegerField
      DisplayLabel = 'Owner'
      FieldName = 'ID_FOLDER_OWNER'
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosID_DRIVE: TIntegerField
      DisplayLabel = 'Drive'
      FieldName = 'ID_DRIVE'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'PC_FOLDER'
    object SQLDADOSID_FOLDER: TIntegerField
      FieldName = 'ID_FOLDER'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLDADOSFOLDER_PATH: TStringField
      FieldName = 'FOLDER_PATH'
      Required = True
      Size = 500
    end
    object SQLDADOSID_FOLDER_OWNER: TIntegerField
      FieldName = 'ID_FOLDER_OWNER'
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSID_DRIVE: TIntegerField
      FieldName = 'ID_DRIVE'
      Required = True
    end
  end
end
