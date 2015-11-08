inherited ObjectDaoGame: TObjectDaoGame
  inherited CDSDados: TClientDataSet
    Active = True
    FieldDefs = <
      item
        Name = 'ID_PARTIDA'
        DataType = ftInteger
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 20
      end>
    Data = {
      660000009619E0BD01000000180000000300000000000300000066000A49445F
      5041525449444104000100000000000944455343524943414F01004900000001
      0005574944544802000200C80006434F4449474F010049000000010005574944
      54480200020014000000}
    object CDSDadosCODIGO: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
    end
    object CDSDadosID_PARTIDA: TIntegerField
      DisplayLabel = 'ID Partida'
      FieldName = 'ID_PARTIDA'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object CDSDadosDESCRICAO: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 100
      FieldName = 'DESCRICAO'
      ProviderFlags = [pfInUpdate]
      Size = 200
    end
  end
  inherited DSDados: TDataSource
    Top = 35
  end
end
