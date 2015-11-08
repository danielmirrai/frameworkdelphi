inherited ObjectDaoPlayers: TObjectDaoPlayers
  inherited CDSDados: TClientDataSet
    Active = True
    FieldDefs = <
      item
        Name = 'LOGIN'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'CLA'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'DATA_INICIO'
        DataType = ftDateTime
      end>
    Data = {
      600000009619E0BD0100000018000000030000000000030000006000054C4F47
      494E010049000000010005574944544802000200C80003434C41010049000000
      010005574944544802000200C8000B444154415F494E4943494F080008000000
      00000000}
    object CDSDadosLOGIN: TStringField
      DisplayLabel = 'Usu'#225'rio'
      DisplayWidth = 30
      FieldName = 'LOGIN'
      Size = 200
    end
    object CDSDadosCLA: TStringField
      DisplayLabel = 'Cl'#227
      DisplayWidth = 20
      FieldName = 'CLA'
      Size = 200
    end
    object CDSDadosDATA_INICIO: TDateTimeField
      DisplayLabel = 'Data In'#237'cio'
      DisplayWidth = 18
      FieldName = 'DATA_INICIO'
    end
  end
  inherited DSDados: TDataSource
    Top = 35
  end
end
