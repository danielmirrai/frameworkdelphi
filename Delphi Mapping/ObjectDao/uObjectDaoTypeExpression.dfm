inherited ObjectDaoTypeExpression: TObjectDaoTypeExpression
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_TYPE_EXPRESSION'
        DataType = ftInteger
      end
      item
        Name = 'ID_TYPE'
        DataType = ftInteger
      end
      item
        Name = 'DATA'
        DataType = ftString
        Size = 200
      end>
    object CDSDadosID_TYPE_EXPRESSION: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_TYPE_EXPRESSION'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_TYPE: TIntegerField
      DisplayLabel = 'Type'
      FieldName = 'ID_TYPE'
      Required = True
    end
    object CDSDadosDATA: TStringField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Required = True
      Size = 200
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_TYPEEXPRESSION'
    object SQLDADOSID_TYPE_EXPRESSION: TIntegerField
      FieldName = 'ID_TYPE_EXPRESSION'
      Required = True
    end
    object SQLDADOSID_TYPE: TIntegerField
      FieldName = 'ID_TYPE'
      Required = True
    end
    object SQLDADOSDATA: TStringField
      FieldName = 'DATA'
      Required = True
      Size = 200
    end
  end
end
