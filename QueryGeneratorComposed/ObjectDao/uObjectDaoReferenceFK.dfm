inherited ObjectDaoReferenceFK: TObjectDaoReferenceFK
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'TABLEORIGEM'
        DataType = ftString
        Size = 93
      end
      item
        Name = 'INDEXORIGEM'
        DataType = ftString
        Size = 93
      end
      item
        Name = 'FIELDNAMEORIGEM'
        DataType = ftString
        Size = 93
      end
      item
        Name = 'TABLEREFERENCE'
        DataType = ftString
        Size = 93
      end
      item
        Name = 'INDEXREFERENCE'
        DataType = ftString
        Size = 93
      end
      item
        Name = 'FIELDNAMEREFERENCE'
        DataType = ftString
        Size = 93
      end
      item
        Name = 'CONSTRAINT_TYPE'
        DataType = ftString
        Size = 11
      end>
    object CDSDadosTABLEORIGEM: TStringField
      FieldName = 'TABLEORIGEM'
      Size = 93
    end
    object CDSDadosINDEXORIGEM: TStringField
      FieldName = 'INDEXORIGEM'
      Size = 93
    end
    object CDSDadosFIELDNAMEORIGEM: TStringField
      FieldName = 'FIELDNAMEORIGEM'
      Size = 93
    end
    object CDSDadosTABLEREFERENCE: TStringField
      FieldName = 'TABLEREFERENCE'
      Size = 93
    end
    object CDSDadosINDEXREFERENCE: TStringField
      FieldName = 'INDEXREFERENCE'
      Size = 93
    end
    object CDSDadosFIELDNAMEREFERENCE: TStringField
      FieldName = 'FIELDNAMEREFERENCE'
      Size = 93
    end
    object CDSDadosCONSTRAINT_TYPE: TStringField
      FieldName = 'CONSTRAINT_TYPE'
      Size = 11
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 
      'select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, TABLEREFERENCE' +
      ', INDEXREFERENCE, FIELDNAMEREFERENCE, CONSTRAINT_TYPE from SHOWD' +
      'BDEPENDENCE where CONSTRAINT_TYPE = '#39'FOREIGN KEY'#39
    CommandType = ctQuery
    object SQLDADOSTABLEORIGEM: TStringField
      FieldName = 'TABLEORIGEM'
      Size = 93
    end
    object SQLDADOSINDEXORIGEM: TStringField
      FieldName = 'INDEXORIGEM'
      Size = 93
    end
    object SQLDADOSFIELDNAMEORIGEM: TStringField
      FieldName = 'FIELDNAMEORIGEM'
      Size = 93
    end
    object SQLDADOSTABLEREFERENCE: TStringField
      FieldName = 'TABLEREFERENCE'
      Size = 93
    end
    object SQLDADOSINDEXREFERENCE: TStringField
      FieldName = 'INDEXREFERENCE'
      Size = 93
    end
    object SQLDADOSFIELDNAMEREFERENCE: TStringField
      FieldName = 'FIELDNAMEREFERENCE'
      Size = 93
    end
    object SQLDADOSCONSTRAINT_TYPE: TStringField
      FieldName = 'CONSTRAINT_TYPE'
      Size = 11
    end
  end
end
