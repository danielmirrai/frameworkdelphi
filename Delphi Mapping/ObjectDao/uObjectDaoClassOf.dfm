inherited ObjectDaoClassOf: TObjectDaoClassOf
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_CLASS_OF'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_TYPE'
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
        Name = 'ID_CLASS'
        DataType = ftString
        Size = 200
      end>
    object CDSDadosID_CLASS_OF: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_CLASS_OF'
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
    object CDSDadosID_CLASS: TStringField
      DisplayLabel = 'Class'
      FieldName = 'ID_CLASS'
      Size = 200
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_CLASSOF'
    object SQLDADOSID_CLASS_OF: TIntegerField
      FieldName = 'ID_CLASS_OF'
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
    object SQLDADOSID_CLASS: TStringField
      FieldName = 'ID_CLASS'
      Size = 200
    end
  end
end
