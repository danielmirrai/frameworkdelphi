inherited ObjectDaoDirectiveMethod: TObjectDaoDirectiveMethod
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_DIRECTIVE_METHOD'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_DIRECTIVE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_METHOD'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosID_DIRECTIVE_METHOD: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID_DIRECTIVE_METHOD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_DIRECTIVE: TIntegerField
      DisplayLabel = 'C'#243'digo Diretiva'
      FieldName = 'ID_DIRECTIVE'
      Required = True
    end
    object CDSDadosID_METHOD: TIntegerField
      DisplayLabel = 'C'#243'digo M'#233'todo'
      FieldName = 'ID_METHOD'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_DIRECTIVEMETHOD'
    object SQLDADOSID_DIRECTIVE_METHOD: TIntegerField
      FieldName = 'ID_DIRECTIVE_METHOD'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object SQLDADOSID_DIRECTIVE: TIntegerField
      FieldName = 'ID_DIRECTIVE'
      Required = True
    end
    object SQLDADOSID_METHOD: TIntegerField
      FieldName = 'ID_METHOD'
      Required = True
    end
  end
end
