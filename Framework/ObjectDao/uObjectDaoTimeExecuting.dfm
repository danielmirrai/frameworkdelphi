inherited ObjectDaoTimeExecuting: TObjectDaoTimeExecuting
  OnCreate = DataModuleCreate
  inherited CDSDados: TClientDataSet
    FieldDefs = <
      item
        Name = 'ID_TIME_EXECUTING'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'ID_UNIT'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'ID_CLASS'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'ID_FUNCTION'
        DataType = ftString
        Size = 500
      end
      item
        Name = 'TIME_EXECUTING'
        DataType = ftTime
      end
      item
        Name = 'ID_NIVEL'
        DataType = ftInteger
      end
      item
        Name = 'DATE_BEGIN'
        DataType = ftTimeStamp
      end
      item
        Name = 'DATE_END'
        DataType = ftTimeStamp
      end
      item
        Name = 'ID_OWNER'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'DEFAULT_ORDER'
      end
      item
        Name = 'CHANGEINDEX'
      end>
    IndexFieldNames = 'ID_TIME_EXECUTING;ID_NIVEL'
    OnCalcFields = CDSDadosCalcFields
    Top = 44
    object CDSDadosID_TIME_EXECUTING: TIntegerField
      DisplayLabel = 'ID'
      FieldName = 'ID_TIME_EXECUTING'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_UNIT: TStringField
      DisplayLabel = 'Unit'
      FieldName = 'ID_UNIT'
      Size = 500
    end
    object CDSDadosID_CLASS: TStringField
      DisplayLabel = 'Class'
      FieldName = 'ID_CLASS'
      Size = 500
    end
    object CDSDadosID_FUNCTION: TStringField
      DisplayLabel = 'Function'
      FieldName = 'ID_FUNCTION'
      Size = 500
    end
    object CDSDadosTIME_EXECUTING: TTimeField
      DisplayLabel = 'Time Executing'
      FieldKind = fkCalculated
      FieldName = 'TIME_EXECUTING'
      DisplayFormat = 'HH:MM:SS.ZZZ'
      Calculated = True
    end
    object CDSDadosID_NIVEL: TIntegerField
      DisplayLabel = 'Nivel'
      FieldName = 'ID_NIVEL'
    end
    object CDSDadosID_OWNER: TIntegerField
      DisplayLabel = 'Owner'
      FieldName = 'ID_OWNER'
    end
    object CDSDadosDATE_BEGIN: TSQLTimeStampField
      FieldName = 'DATE_BEGIN'
    end
    object CDSDadosDATE_END: TSQLTimeStampField
      FieldName = 'DATE_END'
    end
  end
  inherited SQLDADOS: TSQLDataSet
    CommandText = 'MP_TIMEEXECUTING'
    object SQLDADOSID_TIME_EXECUTING: TIntegerField
      FieldName = 'ID_TIME_EXECUTING'
      Required = True
    end
    object SQLDADOSID_UNIT: TStringField
      FieldName = 'ID_UNIT'
      Size = 500
    end
    object SQLDADOSID_CLASS: TStringField
      FieldName = 'ID_CLASS'
      Size = 500
    end
    object SQLDADOSID_FUNCTION: TStringField
      FieldName = 'ID_FUNCTION'
      Size = 500
    end
    object SQLDADOSTIME_EXECUTING: TTimeField
      FieldName = 'TIME_EXECUTING'
    end
    object SQLDADOSID_NIVEL: TIntegerField
      FieldName = 'ID_NIVEL'
    end
    object SQLDADOSDATE_BEGIN: TSQLTimeStampField
      FieldName = 'DATE_BEGIN'
    end
    object SQLDADOSDATE_END: TSQLTimeStampField
      FieldName = 'DATE_END'
    end
    object SQLDADOSID_OWNER: TIntegerField
      FieldName = 'ID_OWNER'
    end
  end
end
