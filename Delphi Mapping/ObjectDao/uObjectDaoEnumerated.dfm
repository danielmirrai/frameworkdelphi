inherited ObjectDaoEnumerated: TObjectDaoEnumerated
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_ENUMERATED'
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 200
      end>
    object CDSDadosID_ENUMERATED: TIntegerField
      DisplayLabel = 'Id'
      FieldName = 'ID_ENUMERATED'
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Name'
      FieldName = 'NAME'
      Size = 200
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_ENUMERATED'
    object SQLDADOSID_ENUMERATED: TIntegerField
      FieldName = 'ID_ENUMERATED'
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Size = 200
    end
  end
end
