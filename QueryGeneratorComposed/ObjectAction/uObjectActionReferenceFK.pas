unit uObjectActionReferenceFK;

interface

uses
  uObjectAction, uObjectDaoReferenceFK, Classes, Forms, SysUtils, uConstantReferenceFK,
  uObjectActionFields, uDMRTTI, uConstantUtils, uDMUtils;

type
  TProcBoolean = procedure (const valor: Boolean = False) of object;
          
  TRecordBackup = record
    Recno: Integer;
    Alias, Filter: string;
    Filtered: Boolean;
    ListaField: String;
  end;

  TRecordSelectDB = record
    sOldTabela: string;
    ReferenceIsInnerJoin, OwnerReferenceIsInnerJoin: Boolean;
    FBackupPK: TRecordBackup;
    FBackupFK: TRecordBackup;
  end;

  TObjectActionReferenceFK = Class(TObjectAction)
  private
    FScriptIsView: Boolean;
    FIncludeOnlyFieldDCOfReference: Boolean;
    FNivelJoinWichSubTables: Integer;
  protected                          
    procedure SetNivelJoinWichSubTables(const Value: Integer);
    procedure SetIncludeOnlyFieldDCOfReference(const Value: Boolean);
    procedure SetScriptIsView(const Value: Boolean);
  public
    FObjectDaoReferenceFK: TObjectDaoReferenceFK;
    FObjectActionFields: TObjectActionFields;

    property NivelJoinWichSubTables: Integer read FNivelJoinWichSubTables write SetNivelJoinWichSubTables;
    property IncludeOnlyFieldDCOfReference: Boolean read FIncludeOnlyFieldDCOfReference write SetIncludeOnlyFieldDCOfReference;
    property ScriptIsView: Boolean read FScriptIsView write SetScriptIsView;
    procedure AfterConstruction; override;
    procedure GeneratorSQL;
  end;
  
implementation

procedure TObjectActionReferenceFK.AfterConstruction;
begin
  inherited;
  FObjectDaoReferenceFK := GetObjectDao as TObjectDaoReferenceFK;
  FObjectActionFields := ListObjectActionChildren.Add(TObjectActionFields) as TObjectActionFields;
end;

procedure TObjectActionReferenceFK.GeneratorSQL;

var
  FListRecordSelectDB: array of TRecordSelectDB;         
  sAliasPK, sOldTabela, sAliasReference: string;
  oListField, oListAliasField, oListTableField: TStringList;
  bCanAddDisplayFieldOfReference, ReferenceIsInnerJoin, OwnerReferenceIsInnerJoin: Boolean;
  sSQLFrom, sSQLJoin, sSQLWhere, sSQLOrder: string;

  FileReturn, ListaFieldFK, ListaFieldReferenceFK, ListaAlias: TStringList;

  procedure ClearSQL;
  var
    NameFile: string;
  begin             
    if FileReturn.Count > 0 then
    begin
      NameFile := ExtractFilePath(Application.ExeName) + 'DB\' + TDMUtils.Iif(ScriptIsView, 'View\', '') +
        TDMUtils.Iif(IncludeOnlyFieldDCOfReference, 'DC\', 'FULL\') + IntToStr(NivelJoinWichSubTables) + '\'
        + sOldTabela + '.SQL';
      TDMUtils.WriteFile(NameFile, FileReturn, True);
      FileReturn.Clear;
    end;
    OwnerReferenceIsInnerJoin := True;
    ReferenceIsInnerJoin := True;
    sSQLFrom := '';
    sSQLJoin := '';
    sSQLWhere := '';
    sSQLOrder := '';
    sAliasPK := '';
    sAliasReference := '';
    bCanAddDisplayFieldOfReference := True;
    ListaAlias.Clear;
    oListField.Clear;
    oListAliasField.Clear;
    oListTableField.Clear;
  end;

  function GetNomeDCField: String;
  var
    IndexPos: Smallint;
  begin
    Result := FObjectDaoReferenceFK.CDSDadosFIELDNAMEORIGEM.AsString;
    IndexPos := Pos('_', Result);
    if IndexPos < 0 then
      IndexPos := Pos('CODIGO', Result);

    if IndexPos >= 0 then
      Result := Copy(Result, IndexPos + 1, Length(Result));

    Result := 'DC_' + Result;
  end;


  procedure AddSQLField(const aAlias: string; const IsDescriptionFK: BOolean = False);
  begin
    oListField.Add(FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString);
    oListTableField.Add(aAlias);

    if IsDescriptionFK then
      oListAliasField.Add(GetNomeDCField)
    else
      oListAliasField.Add(FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString);
  end;

  function IsCommandoFirebird(const aAlias: string): Boolean;
  begin
    Result := TDMUtils.InString(aAlias, ['end', 'if','else','then', 'for', 'do', 'begin']);
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
    SetLength(FListRecordSelectDB, Length(FListRecordSelectDB) + 1);

    FRecordSelectDB.FBackupPK.Filtered := FObjectDaoReferenceFK.CDSDados.Filtered;
    FRecordSelectDB.FBackupPK.Filter := FObjectDaoReferenceFK.CDSDados.Filter;
    FRecordSelectDB.FBackupPK.Recno := FObjectDaoReferenceFK.CDSDados.Recno;
    FRecordSelectDB.FBackupPK.ListaField := ListaFieldReferenceFK.Text;
    FRecordSelectDB.FBackupPK.Alias := sAliasPK;

    FRecordSelectDB.FBackupFK.Filtered := FObjectActionFields.FObjectDaoFields.CDSDados.Filtered;
    FRecordSelectDB.FBackupFK.Filter := FObjectActionFields.FObjectDaoFields.CDSDados.Filter;
    FRecordSelectDB.FBackupFK.Recno := FObjectActionFields.FObjectDaoFields.CDSDados.Recno;
    FRecordSelectDB.FBackupFK.ListaField := ListaFieldFK.Text;
    FRecordSelectDB.FBackupFK.Alias := sAliasReference;

    FRecordSelectDB.sOldTabela := sOldTabela;
    FRecordSelectDB.OwnerReferenceIsInnerJoin := OwnerReferenceIsInnerJoin;
    FRecordSelectDB.ReferenceIsInnerJoin := ReferenceIsInnerJoin;
    FListRecordSelectDB[Length(FListRecordSelectDB) -1] := FRecordSelectDB;
  end;

  procedure RevertBackup;
  var
    FRecordSelectDB: TRecordSelectDB;
  begin
    FRecordSelectDB := FListRecordSelectDB[Length(FListRecordSelectDB) -1];
                                                                               
    FObjectDaoReferenceFK.CDSDados.Filtered := False;
    FObjectActionFields.FObjectDaoFields.CDSDados.Filter := FRecordSelectDB.FBackupFK.Filter;
    FObjectActionFields.FObjectDaoFields.CDSDados.Filtered := FRecordSelectDB.FBackupFK.Filtered;
    TDMUtils.SetRecno(FObjectActionFields.FObjectDaoFields.CDSDados, FRecordSelectDB.FBackupFK.Recno);
    ListaFieldFK.Text := FRecordSelectDB.FBackupFK.ListaField;
    sAliasReference := FRecordSelectDB.FBackupFK.Alias;
    
    FObjectDaoReferenceFK.CDSDados.Filtered := FRecordSelectDB.FBackupPK.Filtered;
    FObjectDaoReferenceFK.CDSDados.Filter := FRecordSelectDB.FBackupPK.Filter;
    TDMUtils.SetRecno(FObjectDaoReferenceFK.CDSDados, FRecordSelectDB.FBackupPK.Recno);
    ListaFieldReferenceFK.Text := FRecordSelectDB.FBackupPK.ListaField;
    sAliasPK := FRecordSelectDB.FBackupPK.Alias;

    OwnerReferenceIsInnerJoin := FRecordSelectDB.OwnerReferenceIsInnerJoin;
    ReferenceIsInnerJoin := FRecordSelectDB.ReferenceIsInnerJoin;
    sOldTabela := FRecordSelectDB.sOldTabela;       
    SetLength(FListRecordSelectDB, Length(FListRecordSelectDB) - 1);
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
    FObjectDaoReferenceFK.CDSDados.Open;
    FObjectActionFields.FObjectDaoFields.CDSDados.Open;
  end;

  procedure AddJoins;
  var
    i: Integer;
  begin
    if (ListaFieldFK.IndexOf(FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString) >= 0) then
    begin
      bCanAddDisplayFieldOfReference := True;

      ReferenceIsInnerJoin := OwnerReferenceIsInnerJoin and (TDMUtils.VarToInt(FObjectActionFields.FObjectDaoFields.CDSDadosNULLFLAG.AsVariant) = 1);
      if ReferenceIsInnerJoin then
        sSQLJoin := sSQLJoin + #13 + 'INNER JOIN '
      else
        sSQLJOin := sSQLJoin + #13 + 'LEFT JOIN ';

      sSQLJOin := sSQLJOin + FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString + ' ' + sAliasReference + ' on ';

      for i := 0 to ListaFieldFK.Count - 1 do
      begin
        if i > 0 then
          sSQLJoin := sSQLJoin + ' and ';

        sSQLJoin := sSQLJoin + Format('(%s.%s = %s.%s)',
          [sAliasReference, ListaFieldReferenceFK.Strings[i], sAliasPK, ListaFieldFK.Strings[i]]);
      end;
    end;
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

    psNewSQL := psNewSQL + psNameField;
    psNewListAliasSQL := psNewListAliasSQL + psAliasField;

    if (psAliasField <> psNameField) then
      psNewSQL := psNewSQL + ' as ' + psAliasField;
  end;

  procedure FormataSQL;
  var
    sNewSQLFK, sNewSQLPK, sListAliasFieldPK, sListAliasFieldFK,
    sNameField, sAliasTable: String;
    i: Integer;
  begin
    sNewSQLPK := EmptyStr;
    sNewSQLFK := EmptyStr;
    sListAliasFieldFK := EmptyStr;
    sListAliasFieldPK := EmptyStr;
    for i := 0 to oListField.Count -1 do
    begin
      sNameField := oListAliasField.Strings[i];
      sAliasTable := oListTableField.Strings[i];
      if oListTableField.Strings[i] = sAliasPK then
      begin
        AddListaFields(sNewSQLPK, sListAliasFieldPK, sAliasTable, oListAliasField.Strings[i], oListField.Strings[i]);
      end
      else
      begin
        oListAliasField.Strings[i] := EmptyStr;
        oListAliasField.Strings[i] := GetAliasFieldInSQL(sAliasTable, sNameField);
        AddListaFields(sNewSQLFK, sListAliasFieldFK, sAliasTable, oListAliasField.Strings[i], oListField.Strings[i]);
      end;
      if (i mod 10) = 0 then
      begin
        if TDMUtils.ExistValue(sNewSQLPK) then
          sNewSQLPK := sNewSQLPK + #13;     
        if TDMUtils.ExistValue(sNewSQLFK) then
          sNewSQLFK := sNewSQLFK + #13;
      end;
    end;

    if oListField.Count = 0 then
      Exit;
    if TDMUtils.ExistValue(sNewSQLFK) then
    begin
      TDMUtils.AddIfExistValue(sNewSQLPK, ', ');
      sNewSQLPK :=sNewSQLPK + sNewSQLFK;
    end;

    if ScriptIsView then
    begin
      FileReturn.Add('CREATE OR ALTER VIEW VIEW' + FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString);
      FileReturn.Add('(');

      if TDMUtils.ExistValue(sListAliasFieldFK) then
      begin
        TDMUtils.AddIfExistValue(sListAliasFieldPK, ', ');
        sListAliasFieldPK := sListAliasFieldPK + sListAliasFieldFK;
      end;
      FileReturn.Add(sListAliasFieldPK);
      FileReturn.Add(')');
      FileReturn.Add('AS');
    end;

    FileReturn.Text := FileReturn.Text + 'select ' + sNewSQLPK + ' ' + sSQLFrom + sSQLJoin;

    if ScriptIsView then
      FileReturn.Strings[FileReturn.Count - 1] := FileReturn.Strings[FileReturn.Count - 1] + ';';
  end;

  procedure ValidateTable(const nCurrentNivel: Integer; const OnlyJoin: Boolean = False);

    procedure ValidateFields;
    begin
      FObjectActionFields.FObjectDaoFields.CDSDados.First;
      while not FObjectActionFields.FObjectDaoFields.CDSDados.Eof do
      begin
        if (FObjectActionFields.FObjectDaoFields.CDSDadosTABLENAME.AsString = FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString) then
        begin
          if (sOldTabela <> FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString) then
            AddSQLField(sAliasPK);
          AddJoins;
        end
        else
        if (FObjectActionFields.FObjectDaoFields.CDSDadosTABLENAME.AsString = FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString) then
        begin
          if (FObjectActionFields.FObjectDaoFields.CDSDadosFIELDNAME.AsString <> FObjectDaoReferenceFK.CDSDadosFIELDNAMEREFERENCE.AsString) then
          begin
            if bCanAddDisplayFieldOfReference and TDMUtils.CompareIgnoreCase(FObjectActionFields.FObjectDaoFields.CDSDadosDCFIELDTYPE.AsString, 'VARCHAR') then
            begin
              bCanAddDisplayFieldOfReference := False;
              AddSQLField(sAliasReference, True);
            end
            else
            if not IncludeOnlyFieldDCOfReference then
              AddSQLField(sAliasReference, False);
          end;
        end;
        FObjectActionFields.FObjectDaoFields.CDSDados.Next;
      end;
    end;

    procedure AddSubTables;  
    var
      sTableReference: string;
    begin
      if (FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString <> FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString) and
        (NivelJoinWichSubTables <> 0) and (((NivelJoinWichSubTables = -1) or ((nCurrentNivel > 0) and
      (NivelJoinWichSubTables > 1) and (nCurrentNivel < NivelJoinWichSubTables)))) then
      begin
        NewBackup;
        OwnerReferenceIsInnerJoin := ReferenceIsInnerJoin;
        sTableReference := FObjectDaoReferenceFK.CDSDadosTABLEREFERENCE.AsString;

        FObjectDaoReferenceFK.CDSDados.Filtered := False;
        FObjectDaoReferenceFK.CDSDados.Filter := 'TABLEORIGEM = ' + QuotedStr(sTableReference);
        FObjectDaoReferenceFK.CDSDados.Filtered := True;
        FObjectDaoReferenceFK.CDSDados.First;
        while not FObjectDaoReferenceFK.CDSDados.Eof do
        begin         
          ValidateTable(nCurrentNivel + 1, True);
          FObjectDaoReferenceFK.CDSDados.Next;
        end;       
        RevertBackup;
      end;
    end;
  begin
    if (sOldTabela <> FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString) then
    begin
      if not OnlyJoin then
      begin
        if not TDMUtils.IsEmpty(sOldTabela) then
          FormataSQL;
        ClearSQL;
        sAliasPK := GetAlias(FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString);
        sSQLFrom := 'from ' + FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString + ' as ' + sAliasPK;
      end
      else
        sAliasPK := sAliasReference;
    end;       

    sAliasReference := GetAlias(FObjectDaoReferenceFK.CDSDadosFIELDNAMEORIGEM.AsString);
    ListaFieldFK.Text := FObjectDaoReferenceFK.CDSDadosFIELDNAMEORIGEM.AsString;
    TDMUtils.ExplodeStr(ListaFieldFK, ';');

    ListaFieldReferenceFK.Text := FObjectDaoReferenceFK.CDSDadosFIELDNAMEREFERENCE.AsString;
    TDMUtils.ExplodeStr(ListaFieldReferenceFK, ';');
         
    if ListaFieldReferenceFK.Count <> ListaFieldFK.Count then
      raise Exception.Create('FK Invalida');

    ValidateFields;
    AddSubTables;    
    sOldTabela := FObjectDaoReferenceFK.CDSDadosTABLEORIGEM.AsString;
  end;

  procedure ValidateTables;
  begin
    FObjectDaoReferenceFK.CDSDados.First;
    while not FObjectDaoReferenceFK.CDSDados.Eof do
    begin
      ValidateTable(1, False);
      FObjectDaoReferenceFK.CDSDados.Next;
    end;
  end;
begin
  inherited;

  FObjectDao.CDSDados.Open;
  FObjectActionFields.FObjectDaoFields.CDSDados.Open;

  ListaAlias := TStringList.Create;
  ListaFieldFK := TStringList.Create;
  ListaFieldReferenceFK := TStringList.Create;
  oListField := TStringList.Create;
  oListAliasField := TStringList.Create;
  oListTableField := TStringList.Create;
  FileReturn := TStringList.Create;
  SetLength(FListRecordSelectDB, 0);
  sOldTabela := '';
  try
    OpenQuery;
    ClearSQL;
    ValidateTables;
    FormataSQL;   
    ClearSQL;
  finally
    TDMUtils.DestroyObject(ListaFieldFK);
    TDMUtils.DestroyObject(ListaAlias);
    TDMUtils.DestroyObject(ListaFieldReferenceFK);
    TDMUtils.DestroyObject(oListField);
    TDMUtils.DestroyObject(oListAliasField);
    TDMUtils.DestroyObject(oListTableField);
    TDMUtils.DestroyObject(FileReturn);
  end;
end;


procedure TObjectActionReferenceFK.SetIncludeOnlyFieldDCOfReference(
  const Value: Boolean);
begin
  FIncludeOnlyFieldDCOfReference := Value;
end;

procedure TObjectActionReferenceFK.SetNivelJoinWichSubTables(
  const Value: Integer);
begin
  FNivelJoinWichSubTables := Value;
end;

procedure TObjectActionReferenceFK.SetScriptIsView(const Value: Boolean);
begin
  FScriptIsView := Value;
end;

initialization
  DMRTTI.RegisterClass(TObjectActionReferenceFK);

end.
