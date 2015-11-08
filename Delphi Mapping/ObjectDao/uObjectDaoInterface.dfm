inherited ObjectDaoInterface: TObjectDaoInterface
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_INTERFACE'
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
        Name = 'ID_OWNER'
        DataType = ftInteger
      end>
    object CDSDadosID_INTERFACE: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_INTERFACE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      DisplayWidth = 200
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
      Required = True
    end
    object CDSDadosID_OWNER: TIntegerField
      DisplayLabel = 'Owner'
      FieldName = 'ID_OWNER'
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_INTERFACE'
    object SQLDADOSID_INTERFACE: TIntegerField
      FieldName = 'ID_INTERFACE'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
    object SQLDADOSID_OWNER: TIntegerField
      FieldName = 'ID_OWNER'
    end
  end
end
