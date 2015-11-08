inherited ObjectDaoDispinterface: TObjectDaoDispinterface
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_DISPINTERFACE'
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
    object CDSDadosID_DISPINTERFACE: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_DISPINTERFACE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object CDSDadosID_OWNER: TIntegerField
      DisplayLabel = 'Owner'
      FieldName = 'ID_OWNER'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_DISPINTERFACE'
    object SQLDADOSID_DISPINTERFACE: TIntegerField
      FieldName = 'ID_DISPINTERFACE'
      Required = True
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Required = True
      Size = 200
    end
    object SQLDADOSID_OWNER: TIntegerField
      FieldName = 'ID_OWNER'
      Required = True
    end
  end
end
