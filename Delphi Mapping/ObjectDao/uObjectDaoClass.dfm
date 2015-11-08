inherited ObjectDaoClass: TObjectDaoClass
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_CLASS'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ID_TYPE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'IS_ABSTRACT'
        Attributes = [faFixed]
        DataType = ftString
        Size = 1
      end
      item
        Name = 'ID_OWNER'
        DataType = ftString
        Size = 200
      end>
    Left = 33
    Top = 63
    object CDSDadosID_CLASS: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_CLASS'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Size = 200
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
      Required = True
    end
    object CDSDadosID_OWNER: TStringField
      DisplayLabel = 'Owner'
      FieldName = 'ID_OWNER'
      Size = 200
    end
    object CDSDadosIS_ABSTRACT: TStringField
      DisplayLabel = 'Is Abstract'
      FieldName = 'IS_ABSTRACT'
      FixedChar = True
      Size = 1
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_CLASS'
    Top = 16
    object SQLDADOSID_CLASS: TIntegerField
      FieldName = 'ID_CLASS'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Size = 200
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
    object SQLDADOSIS_ABSTRACT: TStringField
      FieldName = 'IS_ABSTRACT'
      FixedChar = True
      Size = 1
    end
    object SQLDADOSID_OWNER: TStringField
      FieldName = 'ID_OWNER'
      Size = 200
    end
  end
end
