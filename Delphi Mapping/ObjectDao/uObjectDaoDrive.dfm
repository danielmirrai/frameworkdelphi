inherited ObjectDaoDrive: TObjectDaoDrive
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_DRIVE'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NAME'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ID_COMPUTER_SO'
        Attributes = [faRequired]
        DataType = ftInteger
      end>
    object CDSDadosID_DRIVE: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ID_DRIVE'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosNAME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NAME'
      Size = 200
    end
    object CDSDadosID_COMPUTER_SO: TIntegerField
      DisplayLabel = 'Computer SO'
      FieldName = 'ID_COMPUTER_SO'
      Required = True
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'PC_DRIVE'
    object SQLDADOSID_DRIVE: TIntegerField
      FieldName = 'ID_DRIVE'
      Required = True
    end
    object SQLDADOSNAME: TStringField
      FieldName = 'NAME'
      Size = 200
    end
    object SQLDADOSID_COMPUTER_SO: TIntegerField
      FieldName = 'ID_COMPUTER_SO'
      Required = True
    end
  end
end
