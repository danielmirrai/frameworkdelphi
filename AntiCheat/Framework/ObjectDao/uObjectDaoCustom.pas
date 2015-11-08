{ *********************************************************** }
{ }
{ Developed by Daniel Mirrai }
{ }
{ Programador Delphi Sênior }
{ E-mail: danielmirrai@gmail.com }
{ Skype: danielmirrai }
{ Fones: +55 (51) 9413-3725 / 3111-2388 }
{ http://www.linkedin.com/in/danielmirrai }
{ https://www.facebook.com/danielmirrai }
{ svn checkout http://mirraiframework.googlecode.com/svn/ }
{ *********************************************************** }
unit uObjectDaoCustom;

interface

uses
  Classes, DB, DBClient, MidasLib, uDMUtils, uDMUtilsDao;

type
  TObjectDaoCustom = class(TDataModule)
    CDSDados: TClientDataSet;
    DSDados: TDataSource;
    procedure CDSDadosAfterInsert(DataSet: TDataSet);
    procedure CDSDadosAfterOpen(DataSet: TDataSet);
    procedure CDSDadosBeforeCancel(DataSet: TDataSet);
    procedure CDSDadosBeforeDelete(DataSet: TDataSet);
  private
    FFieldIDOwner: TField;
    FFieldID: TField;
    FNextID: Integer;
    procedure SetFieldID(const Value: TField);
    procedure SetFieldIDOwner(const Value: TField);
    procedure SetNextID(const Value: Integer);
  protected
    { Private declarations }

    FActiveAutoGenetorID: Boolean;

    procedure SetActiveAutoGenetorID(const Value: Boolean); virtual;
    procedure SetNewID; virtual;
    procedure GetFirstAutoID; virtual;
    procedure CancelFieldID;

    function GetFieldID: TField;
    function GetFieldIDOwner: TField;
  public
    { Public declarations }
    /// <summary>
    /// Atualiza informações
    /// </summary>
    procedure Refresh; virtual;

    /// <summary>
    /// Limpa dataset
    /// </summary>
    procedure Clear; Virtual;

    procedure BeforeDestruction; override;
    procedure AfterConstruction; override;
    function GetIDOwner: Integer;
    /// <summary>
    /// Gera próximo ID
    /// </summary>
    function IncAutoIncrement(aQtdeInc: Integer = 1): Integer; virtual;

    /// <summary>
    /// Pode gerar automático ID
    /// </summary>
    property ActiveAutoGenetorID: Boolean read FActiveAutoGenetorID
      write SetActiveAutoGenetorID;
    property FieldID: TField read GetFieldID write SetFieldID;
    property FieldIDOwner: TField read GetFieldIDOwner write SetFieldIDOwner;
    property NextID: Integer read FNextID write SetNextID;
  end;

implementation

{$R *.dfm}

uses uConstantUtils;

{ TObjectDaoCustom }

procedure TObjectDaoCustom.AfterConstruction;
begin
  inherited;
  FNextID := nCST_Zero;
  FActiveAutoGenetorID := True;
  FFieldID := nil;
  FFieldIDOwner := nil;
end;

procedure TObjectDaoCustom.BeforeDestruction;
begin
  inherited;
end;

procedure TObjectDaoCustom.CancelFieldID;
var
  oField: TField;
begin
  oField := GetFieldID;
  if Assigned(oField) and (FNextID = oField.AsInteger) then
    Dec(FNextID);
end;

procedure TObjectDaoCustom.CDSDadosAfterInsert(DataSet: TDataSet);
begin
  inherited;
  SetNewID;
end;

procedure TObjectDaoCustom.CDSDadosAfterOpen(DataSet: TDataSet);
begin
  inherited;
  GetFirstAutoID;
end;

procedure TObjectDaoCustom.CDSDadosBeforeCancel(DataSet: TDataSet);
begin
  if CDSDados.State = dsInsert then
    CancelFieldID;
  inherited;
end;

procedure TObjectDaoCustom.CDSDadosBeforeDelete(DataSet: TDataSet);
begin
  CancelFieldID;
  inherited;
end;

procedure TObjectDaoCustom.Clear;
begin

end;

function TObjectDaoCustom.GetFieldID: TField;
begin
  if not Assigned(FFieldID) then
    FFieldID := TDMUtilsDao.GetFieldID(CDSDados);
  Result := FFieldID;
end;

function TObjectDaoCustom.GetFieldIDOwner: TField;
begin
  if ((not Assigned(FFieldIDOwner)) and assigned(CDSDados.MasterSource)) then
    FFieldIDOwner := TDMUtilsDao.GetFieldID(CDSDados.MasterSource.DataSet);
  Result := FFieldIDOwner;
end;

procedure TObjectDaoCustom.GetFirstAutoID;
var
  oField: TField;
  sOldFieldName: String;
  nOldRecno: Integer;
begin
  FNextID := nCST_Zero;

  if not ActiveAutoGenetorID or TDMUtils.IsEmpty(CDSDados) then
    Exit;

  oField := GetFieldID;
  if not Assigned(oField) then
    Exit;

  sOldFieldName := CDSDados.IndexFieldNames;
  nOldRecno := CDSDados.RecNo;
  CDSDados.IndexFieldNames := oField.FieldName;
  try
    CDSDados.Last;
    FNextID := oField.AsInteger;
  finally
    CDSDados.IndexFieldNames := sOldFieldName;
    CDSDados.RecNo := nOldRecno;
  end;
end;

function TObjectDaoCustom.GetIDOwner: Integer;
begin
  Result := nCST_Zero;
  if Assigned(FFieldIDOwner) and Assigned(FFieldIDOwner.DataSet) then
    Result := FFieldIDOwner.AsInteger;
end;

function TObjectDaoCustom.IncAutoIncrement(aQtdeInc: Integer): Integer;
begin
  FNextID := FNextID + aQtdeInc;
  Result := FNextID;
end;

procedure TObjectDaoCustom.Refresh;
begin

end;

procedure TObjectDaoCustom.SetActiveAutoGenetorID(const Value: Boolean);
begin
  FActiveAutoGenetorID := Value;
end;

procedure TObjectDaoCustom.SetFieldID(const Value: TField);
begin
  FFieldID := Value;
end;

procedure TObjectDaoCustom.SetFieldIDOwner(const Value: TField);
begin
  FFieldIDOwner := Value;
end;

procedure TObjectDaoCustom.SetNewID;
var
  oField: TField;
begin
  if not ActiveAutoGenetorID then
    Exit;
  oField := GetFieldID;
  if Assigned(oField) then
    oField.AsInteger := IncAutoIncrement;
end;

procedure TObjectDaoCustom.SetNextID(const Value: Integer);
begin
  FNextID := Value;
end;

initialization

RegisterClass(TObjectDaoCustom);

end.
