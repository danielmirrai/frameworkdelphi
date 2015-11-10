inherited ObjectDaoFields: TObjectDaoFields
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'TABLENAME'
        DataType = ftString
        Size = 93
      end
      item
        Name = 'FIELDNAME'
        DataType = ftString
        Size = 93
      end
      item
        Name = 'NULLFLAG'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'FIELDTYPE'
        DataType = ftString
        Size = 6
      end
      item
        Name = 'DCFIELDTYPE'
        DataType = ftString
        Size = 9
      end>
    object CDSDadosTABLENAME: TStringField
      FieldName = 'TABLENAME'
      Size = 93
    end
    object CDSDadosFIELDNAME: TStringField
      FieldName = 'FIELDNAME'
      Size = 93
    end
    object CDSDadosNULLFLAG: TStringField
      FieldName = 'NULLFLAG'
      Size = 6
    end
    object CDSDadosFIELDTYPE: TStringField
      FieldName = 'FIELDTYPE'
      Size = 6
    end
    object CDSDadosDCFIELDTYPE: TStringField
      FieldName = 'DCFIELDTYPE'
      Size = 9
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 
      'select TABLENAME, FIELDNAME, NULLFLAG, FIELDTYPE, DCFIELDTYPE fr' +
      'om SHOWLISTFIELDDB'
    CommandType = ctQuery
    SQLConnection = ObjectDaoAplicacaoQuery.FBConnection
    object SQLDADOSTABLENAME: TStringField
      FieldName = 'TABLENAME'
      Size = 93
    end
    object SQLDADOSFIELDNAME: TStringField
      FieldName = 'FIELDNAME'
      Size = 93
    end
    object SQLDADOSNULLFLAG: TStringField
      FieldName = 'NULLFLAG'
      Size = 6
    end
    object SQLDADOSFIELDTYPE: TStringField
      FieldName = 'FIELDTYPE'
      Size = 6
    end
    object SQLDADOSDCFIELDTYPE: TStringField
      FieldName = 'DCFIELDTYPE'
      Size = 9
    end
  end
end
