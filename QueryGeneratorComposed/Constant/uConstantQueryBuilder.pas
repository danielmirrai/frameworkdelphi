unit uConstantQueryBuilder;

interface

uses Windows, Classes, Graphics, Controls;

type
  TProcBoolean = procedure (const valor: Boolean = False) of object;

  TConfigUserTabelasJoin = record
    TabelaPrincipal,
    FKComCampoObrigatorio, FKComCampoNaoObrigatorio,
    FKVinculadaAFKComCampoObrigatorio, FKVinculadaAFKComCampoNaoObrigatorio,
    FRelacao1Para1, FRelacao1ParaN, FRelacaoNParaN: Boolean;
  end;

  TConfigUserColunasShow = record
    FNotNul, FPK, FFK, FUnique, FDataTypeTexto,
    FDataTypeBlob, FDataTypeNumerico, FDataTypeMonetario, FDataTypeBoleano, FDataTypeData,
    FTodosDaTabelaPrincipal, FTodosDaTabelaFK, FTodosDaTabelaVinculadaFK,
    FSomenteCampoDescricaoDaPK, FSomenteCampoDescricaoDaFK, FSomenteCampoDescricaoDaVinculadaFK: Boolean;
    FPKDaFK, FPKDaVinculadaFK, FTodosOsOutros: Boolean;
  end;

  TConfigUserConsultaPersonalizada = record
    FSelect, FJoin, FWhere, FGroupBy, FHaving, FOrderBy: String;
  end;

  TConfigUserTipoScript = (tcSelect, tcView);//, tcInsert, tcUpdate, tcDelete

  TConfigUserCampoCalculado = record
    Ativo: Boolean;
//    AgruparPorAno: Boolean;
  end;
  
  TConfigUser = record
    FTabelasJoin: TConfigUserTabelasJoin;
    FColunasShow: TConfigUserColunasShow;
    FNivelJoinComSubTabelas: Integer;
    FConsultaPersonalizada: TConfigUserConsultaPersonalizada;
    FTipoScript: TConfigUserTipoScript;
    FCampoCalculado: TConfigUserCampoCalculado;
  end;

  TListConfigUser = array of TConfigUser;      
  TRecordBackup = record
    Recno: Integer;
    Alias, Filter: string;
    Filtered, CanAddDisplayFieldOfReference: Boolean;
    ListaField: String;
  end;

  TRecordSelectDB = record
    sOldTabela: string;
    ReferenceIsInnerJoin, OwnerReferenceIsInnerJoin, OwnerPermiteIncluirFK, PermiteIncluirFK: Boolean;
    FBackupPK: TRecordBackup;
    FBackupFK: TRecordBackup;
  end;

implementation

end.
