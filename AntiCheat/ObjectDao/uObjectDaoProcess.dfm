inherited ObjectDaoProcess: TObjectDaoProcess
  Left = 484
  Top = 242
  inherited CDSDados: TClientDataSet
    Active = True
    FieldDefs = <
      item
        Name = 'MEMORIA_RAM_UTILIZADA'
        DataType = ftInteger
      end
      item
        Name = 'NOME_USUARIO_AMBIENTE'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'CPU_UTILIZADO'
        DataType = ftInteger
      end
      item
        Name = 'NOME_PROCESSO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'FINALIZAR'
        DataType = ftBoolean
      end
      item
        Name = 'ID_SECAO'
        DataType = ftInteger
      end
      item
        Name = 'HASH'
        DataType = ftString
        Size = 32
      end
      item
        Name = 'DIRETORIO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'EMPRESA'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'VERSAO_ARQUIVO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'NOME_INTERNO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'COPYRIGHT'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'NOME_ORIGINAL'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'PRODUTO'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'VERSAO_PRODUTO'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'COMENTARIOS'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'ATRIBUTOS'
        DataType = ftString
        Size = 200
      end
      item
        Name = 'TIPO'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'OS'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'MD5'
        DataType = ftString
        Size = 32
      end>
    Data = {
      770200009619E0BD0100000018000000150000000000030000007702154D454D
      4F5249415F52414D5F5554494C495A4144410400010000000000154E4F4D455F
      5553554152494F5F414D4249454E544501004900000001000557494454480200
      0200C8000D4350555F5554494C495A41444F04000100000000000D4E4F4D455F
      50524F434553534F010049000000010005574944544802000200C80009444553
      43524943414F010049000000010005574944544802000200C8000946494E414C
      495A415202000300000000000849445F534543414F0400010000000000044841
      534801004900000001000557494454480200020020000944495245544F52494F
      010049000000010005574944544802000200C80007454D505245534101004900
      0000010005574944544802000200C8000E56455253414F5F4152515549564F01
      004900000001000557494454480200020014000C4E4F4D455F494E5445524E4F
      010049000000010005574944544802000200C80009434F505952494748540100
      49000000010005574944544802000200C8000D4E4F4D455F4F524947494E414C
      010049000000010005574944544802000200C8000750524F4455544F01004900
      0000010005574944544802000200C8000E56455253414F5F50524F4455544F01
      004900000001000557494454480200020014000B434F4D454E544152494F5301
      0049000000010005574944544802000200C80009415452494255544F53010049
      000000010005574944544802000200C800045449504F01004900000001000557
      49445448020002006400024F5301004900000001000557494454480200020064
      00034D443501004900000001000557494454480200020020000000}
    object CDSDadosNOME_PROCESSO: TStringField
      FieldName = 'NOME_PROCESSO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 200
    end
    object CDSDadosDESCRICAO: TStringField
      FieldName = 'DESCRICAO'
      Size = 200
    end
    object CDSDadosMEMORIA_RAM_UTILIZADA: TIntegerField
      FieldName = 'MEMORIA_RAM_UTILIZADA'
    end
    object CDSDadosNOME_USUARIO_AMBIENTE: TStringField
      FieldName = 'NOME_USUARIO_AMBIENTE'
      Size = 200
    end
    object CDSDadosCPU_UTILIZADO: TIntegerField
      FieldName = 'CPU_UTILIZADO'
    end
    object CDSDadosFINALIZAR: TBooleanField
      FieldName = 'FINALIZAR'
    end
    object CDSDadosID_SECAO: TIntegerField
      FieldName = 'ID_SECAO'
    end
    object CDSDadosDIRETORIO: TStringField
      DisplayLabel = 'Diret'#243'rio'
      FieldName = 'DIRETORIO'
      Size = 200
    end
    object CDSDadosHASH: TStringField
      FieldName = 'HASH'
      Size = 32
    end
    object CDSDadosEMPRESA: TStringField
      FieldName = 'EMPRESA'
      Size = 200
    end
    object CDSDadosVERSAO_ARQUIVO: TStringField
      FieldName = 'VERSAO_ARQUIVO'
    end
    object CDSDadosNOME_INTERNO: TStringField
      FieldName = 'NOME_INTERNO'
      Size = 200
    end
    object CDSDadosCOPYRIGHT: TStringField
      FieldName = 'COPYRIGHT'
      Size = 200
    end
    object CDSDadosNOME_ORIGINAL: TStringField
      FieldName = 'NOME_ORIGINAL'
      Size = 200
    end
    object CDSDadosPRODUTO: TStringField
      FieldName = 'PRODUTO'
      Size = 200
    end
    object CDSDadosVERSAO_PRODUTO: TStringField
      FieldName = 'VERSAO_PRODUTO'
    end
    object CDSDadosCOMENTARIOS: TStringField
      FieldName = 'COMENTARIOS'
      Size = 200
    end
    object CDSDadosATRIBUTOS: TStringField
      FieldName = 'ATRIBUTOS'
      Size = 200
    end
    object CDSDadosTIPO: TStringField
      FieldName = 'TIPO'
      Size = 100
    end
    object CDSDadosOS: TStringField
      FieldName = 'OS'
      Size = 100
    end
    object CDSDadosMD5: TStringField
      FieldName = 'MD5'
      Size = 32
    end
  end
  inherited DSDados: TDataSource
    Top = 37
  end
end
