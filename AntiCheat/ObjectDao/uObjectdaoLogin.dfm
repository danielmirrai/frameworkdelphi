inherited ObjectDaoLogin: TObjectDaoLogin
  inherited CDSDados: TClientDataSet
    Active = True
    FieldDefs = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
      end
      item
        Name = 'USUARIO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'SENHA'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'NOME'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'CLA'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ID_SECAO'
        DataType = ftInteger
      end
      item
        Name = 'EQUIPE'
        DataType = ftInteger
      end
      item
        Name = 'LOGGED'
        DataType = ftBoolean
      end>
    OnNewRecord = CDSDadosNewRecord
    Data = {
      BF0000009619E0BD010000001800000008000000000003000000BF0006434F44
      49474F0400010000000000075553554152494F01004900000001000557494454
      4802000200C8000553454E4841010049000000010005574944544802000200C8
      00044E4F4D45010049000000010005574944544802000200C80003434C410100
      49000000010005574944544802000200C8000849445F534543414F0400010000
      000000064551554950450400010000000000064C4F4747454402000300000000
      000000}
    object CDSDadosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
    end
    object CDSDadosUSUARIO: TStringField
      Tag = 1
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'USUARIO'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 200
    end
    object CDSDadosSENHA: TStringField
      Tag = 2
      DisplayLabel = 'Senha'
      FieldName = 'SENHA'
      ProviderFlags = [pfInUpdate]
      Required = True
      Size = 200
    end
    object CDSDadosNOME: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'NOME'
      Size = 200
    end
    object CDSDadosCLA: TStringField
      DisplayLabel = 'Cl'#227
      FieldName = 'CLA'
      Size = 200
    end
    object CDSDadosSECAO: TIntegerField
      DisplayLabel = 'Se'#231#227'o'
      FieldName = 'ID_SECAO'
    end
    object CDSDadosEQUIPE: TIntegerField
      FieldName = 'EQUIPE'
    end
    object CDSDadosLOGGED: TBooleanField
      FieldName = 'LOGGED'
    end
  end
  inherited DSDados: TDataSource
    Top = 35
  end
end
