unit uDBConvert;

interface

uses SysUtils, Db, DBClient, Classes, TypInfo, uDMUtils, uObjectAction;

type
  TDBConvert = class
  private
    FObjectAction: TObjectAction;
    procedure SetObjectAction(const Value: TObjectAction);
    procedure DefinePK(oField: TField; oScript: TStringList);
    procedure DefineSequence(oScript: TStringList);
    procedure DefineFK(poScript: TStringList);
    function GetNameTable(poObject: TObjectAction): string;
  public
    NameTable: String;
    SufixTable: string;

    procedure ExporteScriptCreateDB;
    function GetNameFieldTypeDB(poField: TFieldType): string;
    procedure AfterConstruction; override;
    property ObjectAction: TObjectAction read FObjectAction
      write SetObjectAction;

  end;

implementation

uses uConstantUtils;

{ TDBConvert }

procedure TDBConvert.AfterConstruction;
begin
  inherited;
  NameTable := sCST_EmptyStr;
  SufixTable := 'MP_';
  FObjectAction := nil;
end;

procedure TDBConvert.DefineSequence(oScript: TStringList);
begin
  oScript.Add('CREATE SEQUENCE GEN_' + NameTable + '_ID;');
end;

procedure TDBConvert.DefineFK(poScript: TStringList);
const
  sCST_FK = 'alter table %s add constraint FK_%s_1 foreign key (%s)' + #13 +
    'references %s(%s) on delete CASCADE' + #13 +
    'on update CASCADE using index FK_%s;';
var
  sNameTableOwner: string;
begin
  if not(Assigned(ObjectAction.FObjectDao.CDSDados.MasterSource) and
    Assigned(FObjectAction.ObjectActionOwner)) then
    Exit;
  sNameTableOwner := GetNameTable(FObjectAction.ObjectActionOwner);
  poScript.Add(Format(sCST_FK, [NameTable, NameTable,
    ObjectAction.FObjectDao.CDSDados.MasterFields, sNameTableOwner,
    ObjectAction.FObjectDao.CDSDados.MasterFields, sNameTableOwner,
    sNameTableOwner]));
end;

procedure TDBConvert.DefinePK(oField: TField; oScript: TStringList);
begin
  oScript.Add('ALTER TABLE ' + NameTable + ' ADD CONSTRAINT PK_' + NameTable +
    ' PRIMARY KEY (' + oField.FieldName + ');');
end;

procedure TDBConvert.ExporteScriptCreateDB;
var
  nPrecision, nIndex: Integer;
  oField: TField;
  oScript, oTable: TStringList;
begin
  oTable := TStringList.Create;
  oScript := TStringList.Create;
  try
    for nIndex := 0 to ObjectAction.FObjectDao.CDSDados.Fields.Count - 1 do
    begin
      oField := ObjectAction.FObjectDao.CDSDados.Fields[nIndex];

      if oTable.Count > 0 then
        oTable.Strings[nIndex - 1] := oTable.Strings[nIndex - 1] + ',';
      nPrecision := 0;
      if (oField is TFloatField) then
        nPrecision := TFloatField(oField).Precision;
      oTable.Add(oField.FieldName + ' ' + GetNameFieldTypeDB(oField.DataType) +
        ' ' + TDMUtils.IIf(TDMUtils.ExistValue(oField.Size),
        '(' + IntToStr(oField.Size) + TDMUtils.IIf(TDMUtils.ExistValue
        (nPrecision), ', ' + IntToStr(nPrecision)) + ')') +
        TDMUtils.IIf(oField.Required, 'NOT NULL'));

      if (pfInKey in oField.ProviderFlags) then
      begin
        DefinePK(oField, oScript);
        DefineSequence(oScript);
      end;
    end;
    oTable.Text := (Format('CREATE TABLE %s (', [NameTable])) + oTable.Text;
    oTable.Add(');');
    DefineFK(oScript);
    oTable.Add(oScript.Text);
    TDMUtils.WriteFile('C:\db\' + NameTable + '.txt', oTable, True);
  finally
    TDMUtils.DestroyObject(oTable);
    TDMUtils.DestroyObject(oScript);
  end;
end;

function TDBConvert.GetNameFieldTypeDB(poField: TFieldType): string;
begin
  Result := GetEnumName(TypeInfo(TFieldType), Integer(poField));
  Result := Copy(Result, 3, Length(Result));
  case poField of
    ftSmallint:
      Result := 'SMALLINT';
    ftWord, ftInteger:
      Result := 'INTEGER';
    ftLargeint:
      Result := 'BIGINT';

    ftFloat, ftCurrency:
      Result := 'DOUBLE PRECISION';

    ftDate:
      Result := 'DATE';
    ftTime:
      Result := 'TIME';
    ftDateTime, ftTimeStamp:
      Result := 'TIMESTAMP';
    ftFixedChar:
      Result := 'CHAR';
    ftString, ftWideString:
      Result := 'VARCHAR';
    ftBlob, ftMemo:
      Result := 'BLOB';
    ftBoolean:
      Result := 'BOOLEAN';
  end;
end;

function TDBConvert.GetNameTable(poObject: TObjectAction): string;
begin
  Result := sCST_EmptyStr;
  if Assigned(poObject) then
    Result := SufixTable + UpperCase(Copy(poObject.ClassName,
      Length(TObjectAction.ClassName) + 1, Length(poObject.ClassName)))
end;

procedure TDBConvert.SetObjectAction(const Value: TObjectAction);
begin
  FObjectAction := Value;
  NameTable := GetNameTable(Value);
end;

end.
