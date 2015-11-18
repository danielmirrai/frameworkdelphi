unit uFrameLookupModel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  uDMClasses, uDMUtilsdao, Graphics, Controls, uObjectAction, Forms, DB, DBClient, Dialogs,
  StdCtrls, Mask, DBCtrls, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxButtons, cxControls, cxContainer, cxEdit,
  dxSkinsCore, dxSkinBlack, cxTextEdit, cxDBEdit, dxSkinsDefaultPainters;

type
  TFrameLookupModel = class(TFrame)
    edtID: TcxDBTextEdit;
    edtDC: TcxDBTextEdit;
    btnSearch: TcxButton;
    lblTitle: TLabel;
    procedure edtDCExit(Sender: TObject);
    procedure OnExitEdt(poDBEdit: TcxDBTextEdit; const pbUpdateDB: Boolean = True);
    procedure btnSearchClick(Sender: TObject);
    procedure FrameResize(Sender: TObject);
    procedure edtIDExit(Sender: TObject);
  private
    FFieldID, FFIeldDC: TFieldDataLink;
    FObjectActionSearch: TObjectAction;
    FObjectActionOrigem: TObjectAction;
    FCanLoadData: Boolean;
    FOldValueDC: String;
    FOldValueID: Integer;
  protected
    procedure UpdateOldValue;
    function ChangeValue: Boolean;
    procedure LoadData;
    procedure SetOldValueDC(const Value: String); Virtual;
    procedure SetOldValueID(const Value: Integer); Virtual;
    function GetOldValueDC: String; Virtual;
    function GetOldValueID: Integer; Virtual;
    function GetCanLoadData: Boolean; Virtual;
    procedure SetCanLoadData(const Value: Boolean); Virtual;
    procedure SetDataSource(const Value: TDataSource); Virtual;
    procedure SetFieldDC(const Value: String); Virtual;
    procedure SetFieldID(const Value: String); Virtual;
    procedure SetObjectActionOrigem(const Value: TObjectAction); Virtual;
    procedure SetObjectActionSearch(const Value: TObjectAction); Virtual;
    procedure SetTitle(const Value: String); Virtual;
    function GetDataSource: TDataSource; Virtual;
    function GetFieldDC: String; Virtual;
    function GetFieldID: String; Virtual;
    function GetTitle: String; Virtual;
    function GetObjectActionOrigem: TObjectAction; Virtual;
    function GetObjectActionSearch: TObjectAction; Virtual;
    function ComponentLoading: Boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure Clear; Virtual;
    procedure UpdateSize; Virtual;
    constructor Create(AOwner: TComponent); Override;
    destructor Destroy; Override;
    property ObjectActionOrigem: TObjectAction read GetObjectActionOrigem write SetObjectActionOrigem;
    property ObjectActionSearch: TObjectAction read GetObjectActionSearch write SetObjectActionSearch;

    property OldValueID: Integer read GetOldValueID write SetOldValueID;
    property OldValueDC: String read GetOldValueDC write SetOldValueDC;
  published
    property Title: String read GetTitle write SetTitle;
    property DataSource: TDataSource read GetDataSource write SetDataSource default nil;
    property DataField: String read GetFieldID write SetFieldID;
    property DataFieldDC: String read GetFieldDC write SetFieldDC;
    property CanLoadData: Boolean read GetCanLoadData write SetCanLoadData default True;
  end;

implementation

{$R *.dfm}

uses uDMUtils, uFactoryObject, uFormAddModel;

{ TFrameLookupModel }

procedure TFrameLookupModel.btnSearchClick(Sender: TObject);
begin
  LoadData;
  TFactoryObject.OpenSearch(FObjectActionSearch, FObjectActionOrigem, DataField, DataFieldDC);
  UpdateOldValue;
end;

function TFrameLookupModel.ChangeValue: Boolean;
begin
  Result  := ((Assigned(edtID.DataBinding.DataSource) and Assigned(edtID.DataBinding.DataSource.DataSet) and
    (FOldValueID <> edtID.DataBinding.DataSource.DataSet.FieldByName(edtID.DataBinding.DataField).AsInteger)) or
    (Assigned(edtDC.DataBinding.DataSource) and Assigned(edtDC.DataBinding.DataSource.DataSet) and
    (FOldValueDC <> edtDC.DataBinding.DataSource.DataSet.FieldByName(edtDC.DataBinding.DataField).AsString)));
end;

constructor TFrameLookupModel.Create(AOwner: TComponent);
begin
  ObjectActionOrigem := nil;
  ObjectActionSearch := nil;
  FOldValueDC := '';
  FOldValueID := 0;
  FCanLoadData := True;
  FFieldID := TFieldDataLink.Create;
  FFieldID.Control := self;
  FFIeldDC := TFieldDataLink.Create;
  FFIeldDC.Control := self;
  inherited;
end;

destructor TFrameLookupModel.Destroy;
begin
  ObjectActionOrigem := nil;
  ObjectActionSearch := nil;
  TDMUtils.DestroyObject(FFieldID);
  TDMUtils.DestroyObject(FFIeldDC);
  inherited;
end;

procedure TFrameLookupModel.Clear;
begin
  TDMUtilsDao.SetValorField(edtDC.DataBinding.DataSource.DataSet.FindField(edtDC.DataBinding.DataField), '');
  TDMUtilsDao.SetValorField(edtID.DataBinding.DataSource.DataSet.FindField(edtID.DataBinding.DataField), '');
  UpdateOldValue;
end;

procedure TFrameLookupModel.edtDCExit(Sender: TObject);
begin              
  OnExitEdt(edtDC, False);
end;

procedure TFrameLookupModel.FrameResize(Sender: TObject);
begin
  if not ComponentLoading then
    UpdateSize;
end;

function TFrameLookupModel.GetCanLoadData: Boolean;
begin
  Result := FCanLoadData;
end;

function TFrameLookupModel.GetDataSource: TDataSource;
begin
  Result := FFieldID.DataSource;
end;

function TFrameLookupModel.GetFieldDC: String;
begin
  Result := FFieldDC.FieldName;
end;

function TFrameLookupModel.GetFieldID: String;
begin
  Result := FFieldID.FieldName;
end;

function TFrameLookupModel.GetObjectActionOrigem: TObjectAction;
begin
  Result := FObjectActionOrigem;
end;

function TFrameLookupModel.GetObjectActionSearch: TObjectAction;
begin
  Result := FObjectActionSearch;
end;

function TFrameLookupModel.GetOldValueDC: String;
begin
  Result := FOldValueDC;
end;

function TFrameLookupModel.GetOldValueID: Integer;
begin
  Result := FOldValueID;
end;

function TFrameLookupModel.GetTitle: String;
begin
  Result := lblTitle.Caption;
end;

procedure TFrameLookupModel.LoadData;
var
  bOldCanAutoLoad: Boolean;
begin
  if (not CanLoadData) or (not Assigned(FObjectActionSearch)) then
    Exit;

  CanLoadData := False;
  if  FObjectActionSearch.FObjectDao.ExistData then
    Exit;
  bOldCanAutoLoad := FObjectActionSearch.CanAutoLoad;
  try
    FObjectActionSearch.CanAutoLoad := True;
    FObjectActionSearch.Load;
  finally
    FObjectActionSearch.CanAutoLoad := bOldCanAutoLoad;
  end;
end;

procedure TFrameLookupModel.SetCanLoadData(const Value: Boolean);
begin
  FCanLoadData := Value;
end;

procedure TFrameLookupModel.SetDataSource(const Value: TDataSource);
begin
  FFieldID.DataSource := Value;
  FFIeldDC.DataSource := Value;
  edtID.DataBinding.DataSource := Value;
  edtDC.DataBinding.DataSource := Value;
  if ((not ComponentLoading) and Assigned(Value)) then
    SetFieldID(DataField);
end;

procedure TFrameLookupModel.SetFieldDC(const Value: String);
begin
  if Assigned(FFieldDC) then
    FFieldDC.FieldName := Value;
  edtDC.DataBinding.DataField := Value;
end;

procedure TFrameLookupModel.SetFieldID(const Value: String);
var
  OldFieldName: string;

  procedure UpdateLabel;
  var
    FieldIDOld, FieldIDNew: TFIeld;
  begin
    if (TDMUtils.IsEmpty(Value) or (not (Assigned(edtID.DataBinding.DataSource) and
      Assigned(edtID.DataBinding.DataSource.DataSet)))) then
      Exit;

    FieldIDOld := nil;
    FieldIDNew := edtID.DataBinding.DataSource.DataSet.FindField(Value);
    if not Assigned(FieldIDNew) then
      Exit;

    if TDMUtils.ExistValue(OldFieldName) and (OldFieldName <> Value) then
      FieldIDOld := edtID.DataBinding.DataSource.DataSet.FindField(OldFieldName);
    
    if TDMUtils.IsEmpty(Title) or
      (Assigned(FieldIDOld) and (Title = FieldIDOld.DisplayLabel)) then
      Title := FieldIDNew.DisplayLabel;
  end;
begin
  OldFieldName := edtID.DataBinding.DataField; 
  if Assigned(FFieldID) and (FFieldID.FieldName <> Value) then
    FFieldID.FieldName := Value;
    
  if (edtID.DataBinding.DataField <> Value) then
    edtID.DataBinding.DataField := Value;

  if not ComponentLoading then
    UpdateLabel;      
end;

procedure TFrameLookupModel.SetObjectActionOrigem(const Value: TObjectAction);
begin
  FObjectActionOrigem := Value;
  if not Assigned(FObjectActionOrigem) then
    Exit;
  DataSource := FObjectActionOrigem.FObjectDao.DSDados;
end;

procedure TFrameLookupModel.SetObjectActionSearch(const Value: TObjectAction);
begin
  FObjectActionSearch := Value;

  if ((not Assigned(ObjectActionOrigem)) and Assigned(Owner) and (Owner is TFormAddModel)) then
    ObjectActionOrigem := TFormAddModel(Owner).FObjectAction;

  if not Assigned(FObjectActionSearch) then
    Exit;

  if TDMUtils.IsEmpty(DataField) then
    DataField := FObjectActionSearch.FObjectDao.FieldID.FieldName;
  if TDMUtils.IsEmpty(DataFieldDC) then
  begin
    DataFieldDC := 'CC_' + FObjectActionSearch.FObjectDao.FieldDC.FieldName;
    if Assigned(ObjectActionOrigem) then
    begin
      if not Assigned(ObjectActionOrigem.FObjectDao.CDSDados.FindField(DataField)) then
      begin
        edtDC.DataBinding.DataSource := FObjectActionSearch.FObjectDao.CDSDados.DataSource;
        DataFieldDC := FObjectActionSearch.FObjectDao.FieldDC.FieldName;
      end;
    end;
  end;
end;

procedure TFrameLookupModel.SetOldValueDC(const Value: String);
begin
  FOldValueDC := Value;
end;

procedure TFrameLookupModel.SetOldValueID(const Value: Integer);
begin
  FOldValueID := Value;
end;

procedure TFrameLookupModel.SetTitle(const Value: String);
begin
  if (lblTitle.Caption <> Value) then
  begin
    lblTitle.Caption := Value;
    if not ComponentLoading then
      UpdateSize;
  end;
end;

procedure TFrameLookupModel.UpdateOldValue;
begin
  FOldValueID := edtID.DataBinding.DataSource.DataSet.FieldByName(edtID.DataBinding.DataField).AsInteger;
  FOldValueDC := edtDC.DataBinding.DataSource.DataSet.FieldByName(edtDC.DataBinding.DataField).AsString;
end;

procedure TFrameLookupModel.UpdateSize;
begin
  edtID.Left := lblTitle.Left + lblTitle.Width + 6;
  edtDC.Left := edtID.Left + edtID.Width + 6;
                                              
  btnSearch.Left := (Self.Width - btnSearch.Width - 4);

  edtDC.Width := btnSearch.Left - edtDC.Left - 6;
end;

function TFrameLookupModel.ComponentLoading: Boolean;
begin
  Result := (csLoading in Self.ComponentState) or (csReading in Self.ComponentState);
end;

procedure TFrameLookupModel.OnExitEdt(poDBEdit: TcxDBTextEdit; const pbUpdateDB: Boolean);
begin
  if ComponentLoading or (not ChangeValue) then
    Exit;

  if TDMUtils.IsEmpty(poDBEdit.DataBinding.DataSource.DataSet.FindField(poDBEdit.DataBinding.DataField)) then
  begin
    Clear;
    Exit;
  end;

  LoadData;
  TFactoryObject.UpdateLookupSearch(FObjectActionSearch, FObjectActionOrigem, DataField, DataFieldDC, pbUpdateDB);
  UpdateOldValue;
end;

procedure TFrameLookupModel.edtIDExit(Sender: TObject);
begin
  OnExitEdt(edtID, True);
end;

initialization
DMClasses.RegisterClass(TFrameLookupModel);
end.