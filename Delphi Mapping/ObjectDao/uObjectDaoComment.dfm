inherited ObjectDaoComment: TObjectDaoComment
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'DATA'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'ID_TYPE_COMMENT'
        DataType = ftInteger
      end>
    object CDSDadosID: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosDATA: TStringField
      DisplayLabel = 'Dados'
      FieldName = 'DATA'
      Size = 500
    end
    object CDSDadosID_TYPE_COMMENT: TIntegerField
      FieldName = 'ID_TYPE_COMMENT'
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_COMMENT'
    object SQLDADOSID: TIntegerField
      FieldName = 'ID'
      Required = True
    end
    object SQLDADOSDATA: TStringField
      FieldName = 'DATA'
      Size = 500
    end
    object SQLDADOSID_TYPE_COMMENT: TIntegerField
      FieldName = 'ID_TYPE_COMMENT'
    end
  end
end
