unit uFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uFormModel, Menus, uFormModelCustom, ActnList, ExtCtrls,
  uFrameLookupModel, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinFoggy, dxSkinGlassOceans, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSharp, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinXmas2008Blue, cxPropertiesStore, cxGroupBox, StdCtrls,
  FMTBcd, DB, SqlExpr;

type
  
  TProcBoolean = procedure (const valor: Boolean = False) of object;

  TRecordSelectDB = record
    nBookmakerCDSField, nBookmakerCDSTable: Pointer;
    sAliasPK, sOldTabela, sAliasReference, sFilterCDSField, sFilterCDSTable: string;
    sFilteredCDSFIeld, sFilteredCDSTable: Boolean;
  end;
  
  TFormPrincipal = class(TFormModel)
    MainMenu1: TMainMenu;
    actViewPedido: TAction;
    actAddPedido: TAction;
    mnuPedido: TMenuItem;
    mnuCadastrodePedidos: TMenuItem;
    btn1: TButton;
    mmo1: TMemo;
    procedure actAddPedidoExecute(Sender: TObject);
    procedure actViewPedidoExecute(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses
  uFormViewModel, DBClient, Provider, uFactoryObject, uFormViewPedido, uFormAddPedido,
  uObjectDaoAplicacaoPedidos, uObjectDaoApplication, uDMUtils;

{$R *.dfm}

procedure TFormPrincipal.actAddPedidoExecute(Sender: TObject);
begin
  TFormAddPedido.OpenFormAdd;
end;

procedure TFormPrincipal.actViewPedidoExecute(Sender: TObject);
begin
  TFormViewPedido.OpenView;
end;

procedure TFormPrincipal.btn1Click(Sender: TObject);
var
  FListRecordSelectDB: array of TRecordSelectDB;         
  sAliasPK, sOldTabela, sAliasReference: string;
  SQLTabelas, SQLFields: TSQLDataSet;           
  PVDTabelas, PVDFields: TProvider;
  CDSTabelas, CDSFields: TClientDataSet;
  oListField, oListAliasField, oListTableField: TStringList;

  sSQLFrom, sSQLJoin, sSQLWhere, sSQLOrder: string;

  ListaFieldFK, ListaFieldReferenceFK, ListaAlias: TStringList;
  bCanAddFieldReference, bIncludeOnlyFieldDCReferene, bScriptView: Boolean;
  bNivelJoinWichSubTables: Integer;
  procedure ClearSQL;
  begin
    sSQLFrom := '';
    sSQLJoin := '';
    sSQLWhere := '';
    sSQLOrder := '';
    sAliasPK := '';
    sAliasReference := '';
    bCanAddFieldReference := True;
    ListaAlias.Clear;
    oListField.Clear;
    oListAliasField.Clear;
    oListTableField.Clear;
  end;

  function GetNomeDCField: String;
  var
    IndexPos: Smallint;
  begin
    Result := CDSTabelas.FieldByName('FIELDNAMEORIGEM').AsString;
    IndexPos := Pos('_', Result);
    if IndexPos < 0 then
      IndexPos := Pos('CODIGO', Result);
                                 
    if IndexPos >= 0 then
      Result := Copy(Result, IndexPos + 1, Length(Result));
      
    Result := 'DC_' + Result;
  end;


  procedure AddSQLField(const aAlias: string; const IsDescriptionFK: BOolean = False);
  begin      
    oListField.Add(CDSFields.FieldByName('FIELDNAME').AsString);
    oListTableField.Add(aAlias);
    
    if IsDescriptionFK then
      oListAliasField.Add(GetNomeDCField)
    else
      oListAliasField.Add(CDSFields.FieldByName('FIELDNAME').AsString);
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
    FRecordSelectDB := FListRecordSelectDB[Length(FListRecordSelectDB) -1];
    FRecordSelectDB.nBookmakerCDSField := CDSFields.GetBookmark;
    FRecordSelectDB.nBookmakerCDSTable := CDSTabelas.GetBookmark;
    FRecordSelectDB.sAliasPK := sAliasPK;
    FRecordSelectDB.sOldTabela := sOldTabela;
  end;

  procedure RevertBackup;
  var
    FRecordSelectDB: TRecordSelectDB;
  begin
    FRecordSelectDB := FListRecordSelectDB[Length(FListRecordSelectDB) -1];
    sAliasPK := FRecordSelectDB.sAliasPK;
    sOldTabela := FRecordSelectDB.sOldTabela;    
    if CDSTabelas.BookmarkValid(FRecordSelectDB.nBookmakerCDSTable) then
      CDSTabelas.GotoBookmark(FRecordSelectDB.nBookmakerCDSTable);
    CDSTabelas.FreeBookmark(FRecordSelectDB.nBookmakerCDSTable);
    
    if CDSFields.BookmarkValid(FRecordSelectDB.nBookmakerCDSField) then
      CDSFields.GotoBookmark(FRecordSelectDB.nBookmakerCDSField);
    CDSFields.FreeBookmark(FRecordSelectDB.nBookmakerCDSField);
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
  var
    i: Integer;
  begin
    SQLTabelas.SQLConnection := ObjectDaoApplication.FBConnection;
    SQLTabelas.CommandText := 'select TABLEORIGEM, INDEXORIGEM, FIELDNAMEORIGEM, ' +
    ' TABLEREFERENCE, INDEXREFERENCE, FIELDNAMEREFERENCE, CONSTRAINT_TYPE from SHOWDBDEPENDENCE ' + 'where CONSTRAINT_TYPE = ''FOREIGN KEY''';
    SQLTabelas.CommandType := ctQuery;
    SQLTabelas.GetMetadata := False;
    CDSTabelas.SetProvider(PVDTabelas);
    CDSTabelas.ProviderName := 'PVDTabelas'; 
    SQLTabelas.Open;
    CDSTabelas.FieldDefs.Update;
    for i := 0 to CDSTabelas.FieldDefs.Count - 1 do
      CDSTabelas.FieldDefs[i].CreateField(CDSTabelas);

    CDSTabelas.CreateDataSet;
    CDSTabelas.Open;
                         
    CDSFields.SetProvider(PVDFields);
    SQLFields.SQLConnection := ObjectDaoApplication.FBConnection;
    SQLFields.CommandText := 'select TABLENAME, FIELDNAME, NULLFLAG, FIELDTYPE, DCFIELDTYPE from SHOWLISTFIELDDB';
    SQLFields.CommandType := ctQuery;
    SQLFields.GetMetadata := False;
    CDSFields.FieldDefs.Update;
    for i := 0 to CDSFields.FieldDefs.Count - 1 do
      CDSFields.FieldDefs[i].CreateField(CDSFields);
    CDSFields.CreateDataSet;
    CDSFields.Open;
  end;

  procedure AddJoins;
  var
    i: Integer;
  begin
    if (ListaFieldFK.IndexOf(CDSFields.FieldByName('FIELDNAME').AsString) >= 0) then
    begin
      bCanAddFieldReference := True;
      if TDMUtils.ExistValue(sSQLJoin) then
        sSQLJoin := sSQLJoin + #13;

      if (TDMUtils.VarToInt(CDSFields.FieldByName('NULLFLAG').AsVariant) = 1) then
        sSQLJoin := sSQLJoin + ' INNER JOIN '
      else
        sSQLJOin := sSQLJoin + ' LEFT JOIN ';

      sSQLJOin := sSQLJOin + CDSTabelas.FieldByName('TABLEREFERENCE').AsString + ' ' + sAliasReference + ' on ';

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
    end;

    if oListField.Count = 0 then
      Exit;
    if TDMUtils.ExistValue(sNewSQLFK) then
    begin
      TDMUtils.AddIfExistValue(sNewSQLPK, ', ');
      sNewSQLPK :=sNewSQLPK + sNewSQLFK;
    end;
    mmo1.Lines.Add('');

    if bScriptView then
    begin
      mmo1.Lines.Add('CREATE OR ALTER VIEW VIEW' + CDSTabelas.FieldByName('TABLEORIGEM').AsString);
      mmo1.Lines.Add('(');
        
      if TDMUtils.ExistValue(sListAliasFieldFK) then
      begin
        TDMUtils.AddIfExistValue(sListAliasFieldPK, ', ');
        sListAliasFieldPK := sListAliasFieldPK + sListAliasFieldFK;
      end;                
      mmo1.Lines.Add(sListAliasFieldPK);
      mmo1.Lines.Add(')');
      mmo1.Lines.Add('AS');
    end;

    mmo1.Lines.Add('select ' + sNewSQLPK + ' ' + sSQLFrom);
    mmo1.Lines.Add(sSQLJoin);
     
    if bScriptView then     
      mmo1.Lines.Strings[mmo1.Lines.Count - 1] := mmo1.Lines.Strings[mmo1.Lines.Count - 1] + ';';
  end;

  procedure ValidateTable(const OnlyJoin: Boolean = False);
    procedure ValidateFields;
    var
      sTableReference: string;
    begin
      CDSFields.First;
      while not CDSFields.Eof do
      begin
        if (CDSFields.FieldByName('TABLENAME').AsString = CDSTabelas.FieldByName('TABLEORIGEM').AsString) then
        begin
          if (sOldTabela <> CDSTabelas.FieldByName('TABLEORIGEM').AsString) then
            AddSQLField(sAliasPK);
          AddJoins;
        end;

        if (CDSFields.FieldByName('TABLENAME').AsString = CDSTabelas.FieldByName('TABLEREFERENCE').AsString) then
        begin
          if (CDSFields.FieldByName('FIELDNAME').AsString <> CDSTabelas.FieldByName('FIELDNAMEREFERENCE').AsString) then
          begin
            if bCanAddFieldReference and TDMUtils.CompareIgnoreCase(CDSFields.FieldByName('DCFIELDTYPE').AsString, 'VARCHAR') then
            begin
              bCanAddFieldReference := False;
              AddSQLField(sAliasReference, True);
            end
            else
            if not bIncludeOnlyFieldDCReferene then
              AddSQLField(sAliasReference, False);
          end;
          
          if (bNivelJoinWichSubTables > 1) then
          begin
            NewBackup;
            sTableReference := CDSTabelas.FieldByName('TABLEREFERENCE').AsString;
            CDSTabelas.First;
            while not CDSTabelas.Eof do
            begin
              if (sTableReference = CDSTabelas.FieldByName('TABLEORIGEM').AsString) then
                ValidateTable(True);
              CDSTabelas.Next;
            end;         
            RevertBackup;
          end;
        end;
        CDSFields.Next;
      end;
    end;
  begin
    if (sOldTabela <> CDSTabelas.FieldByName('TABLEORIGEM').AsString) then
    begin
      if not OnlyJoin then
      begin
        if not TDMUtils.IsEmpty(sOldTabela) then
          FormataSQL;
        ClearSQL;
      end;
      sAliasPK := GetAlias(CDSTabelas.FieldByName('TABLEORIGEM').AsString);
      if not OnlyJoin then
        sSQLFrom := 'from ' + CDSTabelas.FieldByName('TABLEORIGEM').AsString + ' as ' + sAliasPK;
    end;
                                              
    sAliasReference := GetAlias(CDSTabelas.FieldByName('FIELDNAMEORIGEM').AsString);
    ListaFieldFK.Text := CDSTabelas.FieldByName('FIELDNAMEORIGEM').AsString;
    TDMUtils.ExplodeStr(ListaFieldFK, ';');

    ListaFieldReferenceFK.Text := CDSTabelas.FieldByName('FIELDNAMEREFERENCE').AsString;
    TDMUtils.ExplodeStr(ListaFieldReferenceFK, ';');

    if ListaFieldReferenceFK.Count <> ListaFieldFK.Count then
      raise Exception.Create('FK Invalida');
        
    ValidateFields;

    sOldTabela := CDSTabelas.FieldByName('TABLEORIGEM').AsString;
  end;

  procedure ValidateTables;
  begin
    CDSTabelas.First;
    while not CDSTabelas.Eof do
    begin
      ValidateTable(False);   
      CDSTabelas.Next;
    end;
  end;
begin
  inherited;

  bIncludeOnlyFieldDCReferene := False;
  bScriptView := True;
  bNivelJoinWichSubTables := 2;
  SQLTabelas := TSQLDataSet.Create(nil);
  SQLFields := TSQLDataSet.Create(nil);

  PVDTabelas := TProvider.Create(nil);
  PVDTabelas.Name := 'PVDTabelas';
  PVDTabelas.DataSet := SQLTabelas;
  PVDFields := TProvider.Create(nil);
  PVDFields.Name := 'PVDFields';
  PVDFields.DataSet := SQLFields;

  CDSTabelas := TClientDataSet.Create(nil);
  CDSFields := TClientDataSet.Create(nil);

  ListaAlias := TStringList.Create;
  ListaFieldFK := TStringList.Create;
  ListaFieldReferenceFK := TStringList.Create;
  oListField := TStringList.Create;
  oListAliasField := TStringList.Create;
  oListTableField := TStringList.Create;
  SetLength(FListRecordSelectDB, 0);
  try
    OpenQuery;
    ClearSQL;
    ValidateTables;
    FormataSQL;
  finally
    TDMUtils.DestroyObject(CDSTabelas);
    TDMUtils.DestroyObject(CDSFields);
    TDMUtils.DestroyObject(SQLTabelas);
    TDMUtils.DestroyObject(SQLFields);
    TDMUtils.DestroyObject(PVDTabelas);
    TDMUtils.DestroyObject(PVDFields);
    TDMUtils.DestroyObject(ListaFieldFK);
    TDMUtils.DestroyObject(ListaAlias);
    TDMUtils.DestroyObject(ListaFieldReferenceFK);  
    TDMUtils.DestroyObject(oListField);
    TDMUtils.DestroyObject(oListAliasField);
    TDMUtils.DestroyObject(oListTableField);
  end;
end;

end.




