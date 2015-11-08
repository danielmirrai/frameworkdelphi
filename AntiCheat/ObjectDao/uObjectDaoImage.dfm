inherited ObjectDaoImage: TObjectDaoImage
  inherited CDSDados: TClientDataSet
    Active = True
    FieldDefs = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
      end
      item
        Name = 'ID_SECAO'
        DataType = ftInteger
      end
      item
        Name = 'DATA'
        DataType = ftDateTime
      end
      item
        Name = 'ID_PARTIDA'
        DataType = ftInteger
      end>
    Left = 33
    Data = {
      5A0000009619E0BD0100000018000000040000000000030000005A0006434F44
      49474F04000100000000000849445F534543414F040001000000000004444154
      4108000800000000000A49445F5041525449444104000100000000000000}
    object CDSDadosCODIGO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object CDSDadosID_SECAO: TIntegerField
      DisplayLabel = 'Usu'#225'rio'
      FieldName = 'ID_SECAO'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object CDSDadosDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      ProviderFlags = [pfInUpdate]
      Required = True
    end
    object CDSDadosID_PARTIDA: TIntegerField
      FieldName = 'ID_PARTIDA'
    end
  end
  inherited DSDados: TDataSource
    Top = 35
  end
end
