unit uObjectActionQueryBuilder;

interface

uses
  Variants, uObjectAction, uObjectActionCustom,  Classes, Forms, SysUtils, uConstantReferenceFK, uObjectActionReferenceFK,
  DB, DBClient, uConstantQueryBuilder, uObjectActionFields, uDMString, uDMClasses, uConstantUtils, uDMUtils;

type
  TObjectActionQueryBuilder = Class(TObjectActionCustom)
  private                                
    FIncludeOnlyFieldDCOfReference: BOolean;
  protected
    procedure SetIncludeOnlyFieldDCOfReference(const Value: Boolean);
  public
    FObjectActionReferenceFK: TObjectActionReferenceFK;
    FConfigUser: TConfigUser;

    procedure AfterConstruction; override;
    procedure GeneratorSQL(const SomenteTabelaAtual: Boolean = False);
    class function GetDirSQL: String;
  end;
  
implementation

uses TypInfo, StrUtils, uObjectDaoReferenceFK;

procedure TObjectActionQueryBuilder.AfterConstruction;
begin
  inherited;                                                         
  FObjectActionReferenceFK := ListObjectActionChildren.Add(TObjectActionReferenceFK) as TObjectActionReferenceFK;
end;



function ExisteCaracter(const aTexto: string; const aCaratecteres: array of char): Boolean;
var
  i, i2: Integer;
begin
  Result := False;
  for i := 1 to Length(aTexto) do
  begin
    for i2 := 0 to Length(aCaratecteres) -1 do
    begin
      Result :=  aTexto[i] = aCaratecteres[i2];
      if Result then
        Exit;
    end;
  end;
end;
    
function RemoveFormatacaoNomeTabela(const aNomeTabela: String): String;
begin
  Result := StringReplace(aNomeTabela, '"', '', [rfReplaceAll]);
end;

function FormataNomeTabela(const aNomeTabela: String): String;
begin
  Result := aNomeTabela;
  if ExisteCaracter(Result, [' ', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9']) then
    Result := '"' + Result + '"';
end;

function IsCommandoFirebird(const aAlias: string): Boolean;
begin
  Result := TDMUtils.InString(aAlias, ['end', 'if','else','then', 'for', 'do', 'begin']);
end;

function GetNomeDCField(const aNomeField: string): String;
var
  IndexPos: Smallint;
begin
  Result := aNomeField;
  IndexPos := Pos('_', Result);
  if IndexPos < 0 then
    IndexPos := Pos('CODIGO', Result);

  if IndexPos >= 0 then
    Result := Copy(Result, IndexPos + 1, Length(Result));

  Result := 'DC_' + Result;
end;

class function TObjectActionQueryBuilder.GetDirSQL: String;
begin
  Result := ExtractFilePath(Application.ExeName) + 'DB\';
end;

procedure TObjectActionQueryBuilder.GeneratorSQL(const SomenteTabelaAtual: Boolean);

var
  FLastRecordSelectDB: array of TRecordSelectDB;         
  sAliasPK, sOldTabela, sAliasReference: string;
  NomeTabelaOwner, oListField, oListAliasField, oListaAliasDaTabelaField: TStringList;
  PermiteIncluirFK, OwnerPermiteIncluirFK, bCanAddDisplayFieldOfReferenceFK, bCanAddDisplayFieldOfReferencePK,
  ReferenceIsInnerJoin, OwnerReferenceIsInnerJoin: Boolean;
  sSQLFrom, sSQLJoin, sSQLWhere, sSQLOrder: string;
  FCloneDataSetReference: TClientDataSet;
  FileReturn, ListaFieldFK, ListaFieldReferenceFK, ListaAlias: TStringList;
          
  function FieldIsNotNull: Boolean;
  begin
    Result := (TDMUtils.VarToInt(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosNULLFLAG.AsVariant) = 1);
  end;

  function ValidaReferenciaCampo(const NomeTabela, NomeField, TipoConstraint: String): Boolean;
  var
    TempListaFieldFK: TStringList;
  begin
    Result := False;
    if FCloneDataSetReference.Locate('TABLEORIGEM;CONSTRAINT_TYPE', VarArrayOf([NomeTabela,TipoConstraint]),
      [loCaseInsensitive]) then
    begin
      TempListaFieldFK := TStringList.Create;
      try
        TempListaFieldFK.Text := FCloneDataSetReference.FieldByName('FIELDNAMEORIGEM').AsString;
        TDMUtils.ExplodeStr(TempListaFieldFK, ';');
        Result := TempListaFieldFK.IndexOf(NomeField) > -1;
      finally
        FreeAndNil(TempListaFieldFK);
      end;
    end;
  end;

  function IsPK(const NomeTabela, NomeField: String): Boolean;
  begin
    Result := ValidaReferenciaCampo(NomeTabela, NomeField, 'PRIMARY KEY');
  end;      

  function IsUniqui(const NomeTabela, NomeField: String): Boolean;
  begin
    Result := ValidaReferenciaCampo(NomeTabela, NomeField, 'UNIQUE');
  end;

  function IsPKorUnique(const NomeTabela, NomeField: String): Boolean;
  begin
    Result := IsPK(NomeTabela, NomeField) or
               IsUniqui(NomeTabela, NomeField);
  end;

  function IsFK(const NomeTabela, NomeField: String): Boolean;
  begin
    Result := ValidaReferenciaCampo(NomeTabela, NomeField, 'FOREIGN KEY');
  end;

  procedure LimparDirSQL;
  begin
    TDMUtils.DeleteDir(GetDirSQL);
  end;

  function GetNomeFileSQL: String;
  begin
    Result := GetDirSQL + sOldTabela + '.SQL';
  end;

  procedure ClearSQL;
  var
    NameFile: string;
  begin
    if FileReturn.Count > 0 then
    begin
      NameFile := GetNomeFileSQL;
      TDMUtils.DeleteLineEmpty(FileReturn);
      TDMUtils.DelimiterMaxLengthLine(FileReturn, [','],  100);
      TDMUtils.WriteFile(NameFile, FileReturn, True);
      FileReturn.Clear;
    end;
    OwnerReferenceIsInnerJoin := True;
    OwnerPermiteIncluirFK := True;
    ReferenceIsInnerJoin := True;
    PermiteIncluirFK := False;
    sSQLFrom := '';
    sSQLJoin := '';
    sSQLWhere := '';
    sSQLOrder := '';
    sAliasPK := '';
    sAliasReference := '';
    bCanAddDisplayFieldOfReferenceFK := True;
    bCanAddDisplayFieldOfReferencePK := True;
    ListaAlias.Clear;
    oListField.Clear;
    oListAliasField.Clear;
    oListaAliasDaTabelaField.Clear;
    SetLength(FLastRecordSelectDB, 0);
    NomeTabelaOwner.Clear;
  end;
               


  function EhTipoNumerico: Boolean;
  begin       
    Result := TDMUtils.InString(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosDCFIELDTYPE.AsString,
     ['INT64', 'INTEGER', 'SMALLINT', 'BIGINT']);
  end;

  function EhTipoBlob: Boolean;
  begin
    Result := TDMUtils.InString(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosDCFIELDTYPE.AsString,
     ['BLOB']);
  end;

  function EhTipoData: Boolean;
  begin       
    Result := TDMUtils.InString(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosDCFIELDTYPE.AsString,
     ['DATE', 'TIME', 'TIMESTAMP']); 
  end;      
  
  function EhTipoMonetario: Boolean;
  begin     
    Result := TDMUtils.InString(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosDCFIELDTYPE.AsString,
     ['D_FLOAT', 'DOUBLE', 'FLOAT', 'NUMERIC', 'DOUBLE PRECISION']);

  end;

  function EhTipoBoleano: Boolean;
  begin
    Result := TDMUtils.CompareIgnoreCase(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELD_SOURCE.AsString, 'BOOLEAN');
  end;

  function EhTipoTexto: Boolean;
  begin
    Result := TDMUtils.InString(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosDCFIELDTYPE.AsString,
     ['CHAR', 'VARCHAR', 'CSTRING']);
  end;

  procedure AddSQLField(const aAlias: string; const EhTabelaVinculada: Boolean; const IsDescription: BOolean = False; const EhColunaDaFK: Boolean=False);
  begin
    if (((not FConfigUser.FColunasShow.FNotNul) and FieldIsNotNull) or

        ((not FConfigUser.FColunasShow.FPK) and
          IsPK(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosTABLENAME.AsString,
            FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString)) or

        ((not FConfigUser.FColunasShow.FFK) and
          IsFK(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosTABLENAME.AsString,
            FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString)) or

        ((not FConfigUser.FColunasShow.FUnique) and
          IsUniqui(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosTABLENAME.AsString,
            FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString)) or

        ((not FConfigUser.FColunasShow.FDataTypeTexto) and EhTipoTexto) or
        ((not FConfigUser.FColunasShow.FDataTypeBlob) and EhTipoBlob) or
        ((not FConfigUser.FColunasShow.FDataTypeData) and EhTipoData) or
        ((not FConfigUser.FColunasShow.FDataTypeMonetario) and EhTipoMonetario) or
        ((not FConfigUser.FColunasShow.FDataTypeBoleano) and EhTipoBoleano) or
        ((not FConfigUser.FColunasShow.FDataTypeNumerico) and EhTipoNumerico) or

        ((not FConfigUser.FColunasShow.FTodosDaTabelaPrincipal) and (not EhColunaDaFK) and (not EhTabelaVinculada)) or
        ((not FConfigUser.FColunasShow.FTodosDaTabelaFK) and EhColunaDaFK and (not EhTabelaVinculada)) or
        ((not FConfigUser.FColunasShow.FTodosDaTabelaVinculadaFK) and EhTabelaVinculada) or

        ((not FConfigUser.FColunasShow.FPKDaFK) and EhColunaDaFK and (not EhTabelaVinculada) and
          IsPK(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosTABLENAME.AsString,
            FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString)) or
              
        ((not FConfigUser.FColunasShow.FPKDaVinculadaFK) and EhColunaDaFK and EhTabelaVinculada and
          IsPK(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosTABLENAME.AsString,
            FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString)) 
          ) then
      Exit;      

    oListField.Add(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString);
    oListaAliasDaTabelaField.Add(aAlias);

    if IsDescription and EhColunaDaFK then
      oListAliasField.Add(GetNomeDCField(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosFIELDNAMEORIGEM.AsString))
    else
      oListAliasField.Add(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString);
  end;

  function ValidaAlias(const aTable, aAlias: String; aIndexFinal: Smallint): string;
  var
    nCount: Integer;
    TempResult: String;
  begin
    Result := aAlias;
    while (ListaAlias.IndexOf(Result) > -1) and (Length(aTable) > aIndexFinal) do
    begin
      Result := Result + aTable[aIndexFinal];

      Inc(aIndexFinal);
    end;

    TempResult := Result;
    nCount := 1;
    while (ListaAlias.IndexOf(TempResult) > -1) or IsCommandoFirebird(TempResult) do
    begin
      TempResult := Result + IntToStr(nCount);
      Inc(nCount);
    end;
    Result := TempResult;
    ListaAlias.Add(Result);
  end;

  procedure NewBackup;
  var
    FRecordSelectDB: TRecordSelectDB;
  begin        
    SetLength(FLastRecordSelectDB, Length(FLastRecordSelectDB) + 1);

    FRecordSelectDB.FBackupPK.Filtered := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Filtered;
    FRecordSelectDB.FBackupPK.Filter := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Filter;
    FRecordSelectDB.FBackupPK.Recno := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Recno;
    FRecordSelectDB.FBackupPK.ListaField := ListaFieldReferenceFK.Text;
    FRecordSelectDB.FBackupPK.Alias := sAliasPK;                       
    FRecordSelectDB.FBackupPK.CanAddDisplayFieldOfReference := bCanAddDisplayFieldOfReferencePK;
                          
    FRecordSelectDB.FBackupFK.Filtered := FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered;
    FRecordSelectDB.FBackupFK.Filter := FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filter;
    FRecordSelectDB.FBackupFK.Recno := FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Recno;
    FRecordSelectDB.FBackupFK.ListaField := ListaFieldFK.Text;
    FRecordSelectDB.FBackupFK.Alias := sAliasReference;
    FRecordSelectDB.FBackupFK.CanAddDisplayFieldOfReference := bCanAddDisplayFieldOfReferenceFK;

    FRecordSelectDB.sOldTabela := sOldTabela;
    FRecordSelectDB.OwnerReferenceIsInnerJoin := OwnerReferenceIsInnerJoin;
    FRecordSelectDB.ReferenceIsInnerJoin := ReferenceIsInnerJoin;
    FRecordSelectDB.PermiteIncluirFK := PermiteIncluirFK;                    
    FRecordSelectDB.OwnerPermiteIncluirFK := OwnerPermiteIncluirFK;

    FLastRecordSelectDB[Length(FLastRecordSelectDB) -1] := FRecordSelectDB;
  end;

  procedure RevertFiltroDataSet(const aDataSet: TDataSet; const aRecordBackup: TRecordBackup);
  begin
    if (aDataSet.Filtered <> aRecordBackup.Filtered) or (aDataSet.Filter <> aRecordBackup.Filter) then
    begin
      aDataSet.Filtered := False;
      aDataSet.Filter := aRecordBackup.Filter;
      aDataSet.Filtered := aRecordBackup.Filtered;
    end;
    TDMUtils.SetRecno(aDataSet, aRecordBackup.Recno);
  end;

  procedure RevertBackup;
  var
    FRecordSelectDB: TRecordSelectDB;
  begin
    FRecordSelectDB := FLastRecordSelectDB[Length(FLastRecordSelectDB) -1];

    RevertFiltroDataSet(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados, FRecordSelectDB.FBackupFK);
    ListaFieldFK.Text := FRecordSelectDB.FBackupFK.ListaField;
    sAliasReference := FRecordSelectDB.FBackupFK.Alias;                      
    bCanAddDisplayFieldOfReferenceFK := FRecordSelectDB.FBackupFK.CanAddDisplayFieldOfReference;
                                                                  
    RevertFiltroDataSet(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados, FRecordSelectDB.FBackupPK);
    ListaFieldReferenceFK.Text := FRecordSelectDB.FBackupPK.ListaField;
    sAliasPK := FRecordSelectDB.FBackupPK.Alias;                                                        
    bCanAddDisplayFieldOfReferencePK := FRecordSelectDB.FBackupPK.CanAddDisplayFieldOfReference;

    OwnerReferenceIsInnerJoin := FRecordSelectDB.OwnerReferenceIsInnerJoin;
    OwnerPermiteIncluirFK := FRecordSelectDB.OwnerPermiteIncluirFK;

    ReferenceIsInnerJoin := FRecordSelectDB.ReferenceIsInnerJoin;                
    PermiteIncluirFK := FRecordSelectDB.PermiteIncluirFK;
    sOldTabela := FRecordSelectDB.sOldTabela;       
    SetLength(FLastRecordSelectDB, Length(FLastRecordSelectDB) - 1);
  end;

  function GetAlias(const aTable: string): string;
  var
    nIndexChar: Integer;
    sTableTmp: string;
  begin
    Result := EmptyStr;
    if TDMUtils.IsEmpty(aTable) then
      Exit;
    try
      Result := aTable[1];
      sTableTmp := aTable;
      nIndexChar := Pos('_', sTableTmp);
      while (nIndexChar > 0) do
      begin
        Result := Result + aTable[nIndexChar + 1];
        sTableTmp := Copy(sTableTmp, nIndexChar + 1, Length(sTableTmp));
        nIndexChar := Pos('_', sTableTmp);
      end;

      if (Length(aTable) >= 2) and (Length(Result) < 2) then
      begin
        Result := Result + aTable[2];
        if (Length(aTable) >= 3) then
          Result := Result + aTable[3];
      end;
    finally
      Result := ValidaAlias(aTable, Result, 4);
    end;
  end;

  procedure OpenQuery;
  begin
    if not FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Active then
      FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Open;
    if not FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Active then
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Open;
      
    FCloneDataSetReference.CloneCursor(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados, True, False);
  end;

  function GetAliasFieldInSQL(const psAliasTable, psNameField: string): string;
  var
    nCount: Integer;
  begin
    nCount := 0;
    Result := psNameField;
    while oListAliasField.IndexOf(Result) > -1 do
    begin
      Result := psAliasTable + '_' + psNameField;
      if nCount > 0 then
        Result := Result + IntToStr(nCount);

      Inc(nCount);
    end;
  end;

  procedure AddListaFields(var psNewSQL, psNewListAliasSQL: String; const psAliasTable, psAliasField, psNameField: String);
  begin
    TDMUtils.AddIfExistValue(psNewSQL, ', ');
    TDMUtils.AddIfExistValue(psNewListAliasSQL, ', ');

    if TDMUtils.ExistValue(psAliasTable) then
      psNewSQL := psNewSQL + psAliasTable + '.';

    psNewSQL := psNewSQL + FormataNomeTabela(psNameField);
    psNewListAliasSQL := psNewListAliasSQL + FormataNomeTabela(psAliasField);

    if (psAliasField <> psNameField) then
      psNewSQL := psNewSQL + ' as ' + FormataNomeTabela(psAliasField);
  end;

  procedure FormataSQL;
  var
    sNewSQLFK, sNewSQLPK, sListAliasFieldPK, sListAliasFieldFK,
    sNameField, sAliasTable: String;

    procedure ColunasDOSQL;
    var
      i: Integer;
    begin
      for i := 0 to oListField.Count -1 do
      begin
        sNameField := oListAliasField.Strings[i];
        sAliasTable := oListaAliasDaTabelaField.Strings[i];

        if oListaAliasDaTabelaField.Strings[i] = sAliasPK then
          //Adiciona coluna da PK no SQL
          AddListaFields(sNewSQLPK, sListAliasFieldPK, sAliasTable, oListAliasField.Strings[i], oListField.Strings[i])
        else
        begin
          oListAliasField.Strings[i] := EmptyStr;
          oListAliasField.Strings[i] := GetAliasFieldInSQL(sAliasTable, sNameField); //Renomeia coluna caso exista outra com mesmo nome

          //Adiciona coluna da FK no SQL
          AddListaFields(sNewSQLFK, sListAliasFieldFK, sAliasTable, oListAliasField.Strings[i], oListField.Strings[i]);
        end;
      end;
    end;

    procedure AgregaColunasPKeFK;
    begin
      if TDMUtils.ExistValue(sNewSQLFK) then
      begin
        TDMUtils.AddIfExistValue(sNewSQLPK, ', ');
        sNewSQLPK := sNewSQLPK + sNewSQLFK;
      end;
    end;

    procedure GerarSQLParaSelect;
    begin 
      FileReturn.Text := FileReturn.Text + 'select ' + Trim(Trim(FConfigUser.FConsultaPersonalizada.FSelect) + ' ' + sNewSQLPK);
      FileReturn.Text := FileReturn.Text + #13 + sSQLFrom;        
      if TDMUtils.ExistValue(sSQLJoin) then
        FileReturn.Text := FileReturn.Text + #13 + sSQLJoin;

      if TDMUtils.ExistValue(FConfigUser.FConsultaPersonalizada.FJoin) then
        FileReturn.Text := FileReturn.Text + #13 + FConfigUser.FConsultaPersonalizada.FJoin;

      if TDMUtils.ExistValue(FConfigUser.FConsultaPersonalizada.FWhere) then
        FileReturn.Text := FileReturn.Text + #13 + 'where ' + FConfigUser.FConsultaPersonalizada.FWhere;
      if TDMUtils.ExistValue(FConfigUser.FConsultaPersonalizada.FGroupBy) then
        FileReturn.Text := FileReturn.Text + #13 + 'group by ' + FConfigUser.FConsultaPersonalizada.FGroupBy;
      if TDMUtils.ExistValue(FConfigUser.FConsultaPersonalizada.FHaving) then
        FileReturn.Text := FileReturn.Text + #13 + 'having ' + FConfigUser.FConsultaPersonalizada.FHaving;
      if TDMUtils.ExistValue(FConfigUser.FConsultaPersonalizada.FOrderBy) then
        FileReturn.Text := FileReturn.Text + #13 + 'order by ' + FConfigUser.FConsultaPersonalizada.FOrderBy;
    end;
    
    procedure GerarSQLParaView;
    begin
      FileReturn.Add('CREATE OR ALTER VIEW VIEW' + FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString);
      FileReturn.Add('(');

      if TDMUtils.ExistValue(sListAliasFieldFK) then
      begin
        TDMUtils.AddIfExistValue(sListAliasFieldPK, ', ');
        sListAliasFieldPK := sListAliasFieldPK + sListAliasFieldFK;
      end;
      FileReturn.Add(sListAliasFieldPK);
      FileReturn.Add(')');
      FileReturn.Add('AS');
      GerarSQLParaSelect;
      FileReturn.Text := Trim(FileReturn.Text) + ';';
    end;
  begin
    sNewSQLPK := EmptyStr;
    sNewSQLFK := EmptyStr;
    sListAliasFieldFK := EmptyStr;
    sListAliasFieldPK := EmptyStr;

    ColunasDOSQL;


    if (oListField.Count = 0) then //Não existe coluna logo não temos select
    begin
      if not TDMUtils.ExistValue(sSQLFrom) then
        Exit;
        
      sNewSQLPK := '1 as CampoFake';
    end;

    AgregaColunasPKeFK;

    if (FConfigUser.FTipoScript = tcView) then
      GerarSQLParaView
    else
      GerarSQLParaSelect;
  end;

  procedure ValidateTable(const nCurrentNivel: Integer; const EhTabelaVinculada: Boolean; const EhEstruturaOwer: Boolean =False);

    function EhTabelaOwer(const aNomeTabela: string): Boolean;
    begin
      Result := (NomeTabelaOwner.IndexOf(aNomeTabela) >= 0);
    end;
    
    function IsRelacionamento1Para1: Boolean;
    var
      i: Integer;
    begin
      Result := (ListaFieldFK.Count > 0);
      for i := 0 to ListaFieldFK.Count - 1 do
      begin
        Result := Result and (IsPKorUnique(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString,
                      ListaFieldFK.Strings[i])
                 and
                  IsPKorUnique(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString,
                      ListaFieldReferenceFK.Strings[i]));
      end;
    end;
    
    procedure PermiteIncluirRelacao1Para1;
    begin
      if (not FConfigUser.FTabelasJoin.FRelacao1Para1) and IsRelacionamento1Para1 then
        PermiteIncluirFK := False;
    end;

    procedure PermiteIncluirRelacao1ParaN;
    begin
      if (not FConfigUser.FTabelasJoin.FRelacao1ParaN) then
        PermiteIncluirFK := PermiteIncluirFK and FConfigUser.FTabelasJoin.FRelacao1Para1 and IsRelacionamento1Para1;
    end;
    
    procedure AddJoins;
    var
      i: Integer;
      CampoEhObrigatorio: Boolean;
    begin
      if ((EhEstruturaOwer and (not (TDMUtils.ExistValue(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString) and
          not EhTabelaOwer(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString) and
         (ListaFieldFK.IndexOf(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString) >= 0)))) or
         
         ((not EhEstruturaOwer) and (not (TDMUtils.ExistValue(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString) and
        (not EhTabelaOwer(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString) and
         (ListaFieldFK.IndexOf(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString) >= 0)))))) then
        Exit;

      if (FConfigUser.FNivelJoinComSubTabelas = 0) then
      begin
        PermiteIncluirFK := False;
        Exit;
      end;

      CampoEhObrigatorio := FieldIsNotNull;

      ReferenceIsInnerJoin := OwnerReferenceIsInnerJoin and CampoEhObrigatorio;

      if EhTabelaVinculada then
        PermiteIncluirFK := ((FConfigUser.FTabelasJoin.FKVinculadaAFKComCampoObrigatorio and ReferenceIsInnerJoin) or
        (FConfigUser.FTabelasJoin.FKVinculadaAFKComCampoNaoObrigatorio and (not ReferenceIsInnerJoin)))
      else
        PermiteIncluirFK := ((FConfigUser.FTabelasJoin.FKComCampoObrigatorio and ReferenceIsInnerJoin) or
        (FConfigUser.FTabelasJoin.FKComCampoNaoObrigatorio and (not ReferenceIsInnerJoin)));

      PermiteIncluirRelacao1Para1;
      PermiteIncluirRelacao1ParaN;
      if not PermiteIncluirFK then
        Exit;
      
      if ReferenceIsInnerJoin then
        sSQLJoin := sSQLJoin + #13 + 'INNER JOIN '
      else
        sSQLJOin := sSQLJoin + #13 + 'LEFT JOIN ';

      bCanAddDisplayFieldOfReferencePK := True;
      bCanAddDisplayFieldOfReferenceFK := True;
      sSQLJOin := sSQLJOin + FormataNomeTabela(
        TDMUtils.IIf(EhEstruturaOwer, FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString,
          FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString)) + ' ' +
        sAliasReference + ' on ';

      for i := 0 to ListaFieldFK.Count - 1 do
      begin
        if i > 0 then
          sSQLJoin := sSQLJoin + ' and ';

        sSQLJoin := sSQLJoin + Format('(%s.%s = %s.%s)',
          [sAliasReference, ListaFieldReferenceFK.Strings[i],
          sAliasPK, ListaFieldFK.Strings[i]]);
      end;
    end;

    procedure AdicionaColunasPK;
    var
      bOldFiltered: Boolean;
      sOldFilter: string;

      procedure InternalAddSQLField;
      begin
        AddSQLField(TDMUtils.IIf(EhEstruturaOwer, sAliasReference, sAliasPK), EhTabelaVinculada, True, False);
      end;
    begin
      PermiteIncluirFK := False;
      bOldFiltered := FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered;
      sOldFilter := FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filter;
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered := False;
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filter := '(TABLENAME = ' + QuotedStr(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString) + ')';
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered := True;
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.First;

      while not FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Eof do
      begin
        //Eh PK
        if (FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosTABLENAME.AsString = FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString) then
        begin
          if ((EhEstruturaOwer or (not EhTabelaVinculada)) and (sOldTabela <> FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString)) then
          begin
            if bCanAddDisplayFieldOfReferencePK and TDMUtils.CompareIgnoreCase(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosDCFIELDTYPE.AsString, 'VARCHAR') then
            begin
              bCanAddDisplayFieldOfReferencePK := False;
              InternalAddSQLField;
            end
            else
            if (((not EhEstruturaOwer) and (not FConfigUser.FColunasShow.FSomenteCampoDescricaoDaPK)) or
               (EhEstruturaOwer and (not FConfigUser.FColunasShow.FSomenteCampoDescricaoDaVinculadaFK))) then
              InternalAddSQLField;
          end;

          if (not EhTabelaVinculada) or OwnerPermiteIncluirFK then
            AddJoins; //Adiciona inner joins
        end;
        FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Next;
      end;
      if bCanAddDisplayFieldOfReferencePK then
      begin
        FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.First;
        FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Next;
        if not FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Eof then
        begin
          bCanAddDisplayFieldOfReferencePK := False;
          InternalAddSQLField;
        end;
      end;

                                                                                                  
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered := False;    
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filter := sOldFilter;
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered := bOldFiltered;
    end;
    
    procedure AdicionaColunasFK;
    var
      bOldFiltered: Boolean;
      sOldFilter: string;
          
      procedure InternalAddSQLField;
      begin
          AddSQLField(sAliasReference, EhTabelaVinculada, True, True);
      end;
    begin
      if (not PermiteIncluirFK) or EhEstruturaOwer then
        Exit;
      bOldFiltered := FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered;
      sOldFilter := FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filter;
      
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered := False;
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filter := '(TABLENAME = ' + QuotedStr(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString) + ')';
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered := True;
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.First;
      
      while not FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Eof do
      begin
        if bCanAddDisplayFieldOfReferenceFK and TDMUtils.CompareIgnoreCase(FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDadosDCFIELDTYPE.AsString, 'VARCHAR') then
        begin
          bCanAddDisplayFieldOfReferenceFK := False;
          InternalAddSQLField;
        end
        else
         if ((EhTabelaVinculada and (not FConfigUser.FColunasShow.FSomenteCampoDescricaoDaVinculadaFK)) or
          ((not EhTabelaVinculada) and (not FConfigUser.FColunasShow.FSomenteCampoDescricaoDaFK))) then
          InternalAddSQLField;
        FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Next;
      end;
             
      if bCanAddDisplayFieldOfReferenceFK then
      begin
        FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.First;
        FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Next;
        if not FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Eof then
        begin         
          bCanAddDisplayFieldOfReferenceFK := False;
          InternalAddSQLField;
        end;
      end;
                                                                                           
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered := False;    
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filter := sOldFilter;
      FObjectActionReferenceFK.FObjectActionFields.FObjectDaoFields.CDSDados.Filtered := bOldFiltered;
    end;
          
    procedure ValidateFields;
    begin
      AdicionaColunasPK;
      AdicionaColunasFK;
    end;

    procedure AddSubTables;  
    var
      sTableReference: string;
      sTableOwner: string;
    begin
      if PermiteIncluirFK and
        (FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString <> FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString) and
        ((FConfigUser.FNivelJoinComSubTabelas <> 0) and
        ((FConfigUser.FNivelJoinComSubTabelas = -1) or ((nCurrentNivel > 0) and
         (FConfigUser.FNivelJoinComSubTabelas > 1) and (nCurrentNivel <= FConfigUser.FNivelJoinComSubTabelas)))) then
      begin   
        NewBackup;
        try
          OwnerReferenceIsInnerJoin := ReferenceIsInnerJoin;
          OwnerPermiteIncluirFK := PermiteIncluirFK;
          sTableOwner := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString;
          sTableReference := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString;

          if (EhTabelaOwer(sTableReference)) then
            Exit;
          FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Filtered := False;
          FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Filter := 'TABLEORIGEM = ' + QuotedStr(sTableReference);
          FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Filtered := True;
          FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.First;
          while not FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Eof do
          begin
            if ((FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosCONSTRAINT_TYPE.AsString = 'FOREIGN KEY') and
             (not EhTabelaOwer(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString))) then
            begin
              NewBackup;
              try
                NomeTabelaOwner.Add(sTableOwner);
                ValidateTable(nCurrentNivel + 1, True, EhEstruturaOwer);
              finally
                RevertBackup;
              end;
            end;
            FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Next;
          end;
        finally
          RevertBackup;
        end;
      end;
    end;

    procedure AddOwnerTables;

      procedure InternalExecutaOwner(const sTableOrigem: string);
      begin
        if (EhTabelaOwer(sTableOrigem) or (sOldTabela = sTableOrigem)) then
          Exit;
        FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Filtered := False;
        FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Filter := 'TABLEREFERENCE = ' + QuotedStr(sTableOrigem);
        FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Filtered := True;
        FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.First;
        while not FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Eof do
        begin
          if ((FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosCONSTRAINT_TYPE.AsString = 'FOREIGN KEY') and
            not EhTabelaOwer(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString)) then
          begin
            NewBackup;
            try
              OwnerReferenceIsInnerJoin := False;
              NomeTabelaOwner.Add(sTableOrigem);
              //Cuida loop infinito com subtables
              ValidateTable(nCurrentNivel + 1, True, True);
            finally
              RevertBackup;
            end;
          end;
          FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Next;
        end;
      end;
    begin
      if (FConfigUser.FTabelasJoin.FRelacaoNParaN and PermiteIncluirFK and
        (FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString <> FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString) and
        ((FConfigUser.FNivelJoinComSubTabelas <> 0) and
        ((FConfigUser.FNivelJoinComSubTabelas = -1) or ((nCurrentNivel > 0) and
         (FConfigUser.FNivelJoinComSubTabelas > 1) and (nCurrentNivel <= FConfigUser.FNivelJoinComSubTabelas))))) then
      begin
        NewBackup;
        try
          OwnerReferenceIsInnerJoin := ReferenceIsInnerJoin;
          OwnerPermiteIncluirFK := PermiteIncluirFK;
          InternalExecutaOwner(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString);
          InternalExecutaOwner(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString);
        finally
          RevertBackup;
        end;
      end;
    end;
  begin
    if not EhEstruturaOwer then
    begin
      if EhTabelaVinculada then
        sAliasPK := sAliasReference
      else
      if (sOldTabela <> FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString) then
      begin
        if not TDMUtils.IsEmpty(sOldTabela) then
          FormataSQL;
        TDMUtils.DeleteFile2(GetNomeFileSQL);
        ClearSQL;
        sAliasPK := GetAlias(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString);
        sSQLFrom := 'from ' + FormataNomeTabela(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString) + ' as ' + sAliasPK;
      end;
    end;

    if EhEstruturaOwer then
    begin           
      sAliasPK := sAliasReference;
      ListaFieldFK.Text := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosFIELDNAMEREFERENCE.AsString;
      ListaFieldReferenceFK.Text := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosFIELDNAMEORIGEM.AsString;
    end
    else
    begin
      ListaFieldFK.Text := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosFIELDNAMEORIGEM.AsString;
      ListaFieldReferenceFK.Text := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosFIELDNAMEREFERENCE.AsString;
    end;                         
    sAliasReference := GetAlias(FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosFIELDNAMEORIGEM.AsString);
    TDMUtils.ExplodeStr(ListaFieldFK, ';');
    TDMUtils.ExplodeStr(ListaFieldReferenceFK, ';');
   
    ValidateFields;
    AddSubTables;
    AddOwnerTables;
    sOldTabela := FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString;
  end;

  procedure ValidateTables;
  begin
    if SomenteTabelaAtual then
      ValidateTable(1, False)
    else
    begin
      FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.First;
      while not FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Eof do
      begin
      //  if FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString = 'PEDIDO' then
          ValidateTable(1, False);
        FObjectActionReferenceFK.FObjectDaoReferenceFK.CDSDados.Next;
      end;
    end;
    FormataSQL;
    ClearSQL;
  end;
begin
  inherited;
  SetLength(FLastRecordSelectDB, 0);
  ListaAlias := nil;
  ListaFieldFK := nil;
  ListaFieldReferenceFK := nil;
  oListField := nil;
  oListAliasField := nil;
  oListaAliasDaTabelaField := nil;
  FileReturn := nil;
  FCloneDataSetReference := nil;
  NomeTabelaOwner := nil;
  try
    NomeTabelaOwner := TStringList.Create;
    FCloneDataSetReference := TClientDataSet.Create(nil);
    ListaAlias := TStringList.Create;
    ListaFieldFK := TStringList.Create;
    ListaFieldReferenceFK := TStringList.Create;
    oListField := TStringList.Create;
    oListAliasField := TStringList.Create;
    oListaAliasDaTabelaField := TStringList.Create;
    FileReturn := TStringList.Create;         
    sOldTabela := ''; 
    if not SomenteTabelaAtual then
      LimparDirSQL;
    OpenQuery;
    ClearSQL;
    ValidateTables;
  finally
    TDMUtils.DestroyObject(ListaFieldFK);        
    TDMUtils.DestroyObject(NomeTabelaOwner);
    TDMUtils.DestroyObject(FCloneDataSetReference);          
    TDMUtils.DestroyObject(ListaAlias);
    TDMUtils.DestroyObject(ListaFieldReferenceFK);
    TDMUtils.DestroyObject(oListField);
    TDMUtils.DestroyObject(oListAliasField);
    TDMUtils.DestroyObject(oListaAliasDaTabelaField);
    TDMUtils.DestroyObject(FileReturn);
  end;
end;


procedure TObjectActionQueryBuilder.SetIncludeOnlyFieldDCOfReference(
  const Value: Boolean);
begin
  FIncludeOnlyFieldDCOfReference := Value;
end;

initialization
  DMClasses.RegisterClass(TObjectActionQueryBuilder);

end.
