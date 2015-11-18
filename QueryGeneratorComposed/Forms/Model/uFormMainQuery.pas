unit uFormMainQuery;

interface

uses
  Windows, Messages, uFormMain, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, Menus, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinBlack,
  dxSkinsDefaultPainters, StdCtrls, cxLabel, cxTextEdit, cxButtons, SqlExpr,
  Provider, Contnrs, uObjectDaoApplication,
  uConstantQueryBuilder, cxGroupBox, uObjectActionQueryBuilder, cxCheckListBox,
  ShellAPI, Math, cxMaskEdit, cxDropDownEdit, cxCheckBox;

type 
  TMetodoAgregador =  procedure (var poCOnfig: TConfigUser; const Valor: Variant) of object;
  TFormMainQuery = class(TFormMain)
    imFormViewFields: TMenuItem;
    imFormViewReferenceFK: TMenuItem;
    cxFundo: TcxGroupBox;
    cxNivelJoins: TcxLabel;
    actGeneretorSQL: TAction;
    actFullScript: TAction;
    lstColunasExibidas: TcxCheckListBox;
    cxLabel2: TcxLabel;
    lstTabelasExibir: TcxCheckListBox;
    cxTabelasJoins: TcxLabel;
    cxLabel4: TcxLabel;
    cxPersonalizacaoQuery: TcxGroupBox;
    mmoSQLUserSelect: TMemo;
    lblSelect: TLabel;
    lbl1: TLabel;
    mmoSQLUserJoin: TMemo;
    lbl2: TLabel;
    lbl5: TLabel;
    mmoSQLUserWhere: TMemo;
    lbl3: TLabel;
    lblWhere: TLabel;
    lblOrderBy: TLabel;
    mmoSQLUserOrderBy: TMemo;
    lbl4: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    mmoSQLUserGroupBy: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    mmoSQLUserHaving: TMemo;
    cxRodape: TcxGroupBox;
    btnTodos: TcxButton;
    btnGeneretorSQL: TcxButton;
    actTestaScripts: TAction;
    btnTestaScripts: TcxButton;
    cbbNiveisJoin: TcxComboBox;
    edtNivelJoinComSubTabelas: TcxTextEdit;
    lstCalculados: TcxCheckListBox;
    lbl6: TLabel;
    cbbTipoScript: TcxComboBox;
    chkAbrirSQLGerado: TcxCheckBox;
    actAbrirSQLGerados: TAction;
    procedure imFormViewFieldsClick(Sender: TObject);
    procedure imFormViewReferenceFKClick(Sender: TObject);
    procedure actGeneretorSQLExecute(Sender: TObject);
    procedure actFullScriptExecute(Sender: TObject);
    procedure actTestaScriptsExecute(Sender: TObject);
    procedure cbbNiveisJoinPropertiesChange(Sender: TObject);
    procedure cbbNiveisJoinExit(Sender: TObject);
    procedure edtNivelJoinComSubTabelasKeyPress(Sender: TObject;
      var Key: Char);
    procedure edtNivelJoinComSubTabelasExit(Sender: TObject);
    procedure edtNivelJoinComSubTabelasPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    procedure AtualizaNivelJoin;
    procedure AtualizaComboNivelJoin;
    procedure AbrirArquivosSQLGerados;
  public
    { Public declarations }
  end;

implementation

uses uFormViewFields, uFormViewReferenceFK, uFactoryObject, uDMUtils;
{$R *.dfm}

procedure TFormMainQuery.imFormViewFieldsClick(Sender: TObject);
begin
  inherited;
  TFormViewFields.OpenView;
end;

procedure TFormMainQuery.imFormViewReferenceFKClick(Sender: TObject);
begin
  inherited;
  TFormViewReferenceFK.OpenView;
end;

procedure TFormMainQuery.actGeneretorSQLExecute(Sender: TObject);
var
  aObjectActionQueryBuilder: TObjectActionQueryBuilder;

  procedure ParserParametrosTabelasJoins;         
  var
    index: Integer;

    function GetCheck: Boolean;
    begin
      Result := lstTabelasExibir.Items[index].Checked;
      Inc(index);
    end;
  begin    
    index := 0;
    aObjectActionQueryBuilder.FConfigUser.FTabelasJoin.TabelaPrincipal := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FTabelasJoin.FKComCampoObrigatorio := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FTabelasJoin.FKComCampoNaoObrigatorio := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FTabelasJoin.FKVinculadaAFKComCampoObrigatorio := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FTabelasJoin.FKVinculadaAFKComCampoNaoObrigatorio := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FTabelasJoin.FRelacao1Para1 := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FTabelasJoin.FRelacao1ParaN := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FTabelasJoin.FRelacaoNParaN := GetCheck;
  end;

  procedure ParserParametrosColunasShow;
  var
    index: Integer;

    function GetCheck: Boolean;
    begin
      Result := lstColunasExibidas.Items[index].Checked;
      Inc(index);
    end;
  begin
    index := 0;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FNotNul := GetCheck;    
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FPK := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FFK := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FUnique := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FDataTypeTexto := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FDataTypeBlob := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FDataTypeNumerico := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FDataTypeMonetario := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FDataTypeBoleano := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FDataTypeData := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FTodosDaTabelaPrincipal := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FTodosDaTabelaFK := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FTodosDaTabelaVinculadaFK := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FSomenteCampoDescricaoDaPK := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FSomenteCampoDescricaoDaFK := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FSomenteCampoDescricaoDaVinculadaFK := GetCheck;     
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FPKDaFK := GetCheck;                          
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FPKDaVinculadaFK := GetCheck;
    aObjectActionQueryBuilder.FConfigUser.FColunasShow.FTodosOsOutros := GetCheck;
  end;

  procedure ParserParametrosConsultaPersonalizada;
  begin
    aObjectActionQueryBuilder.FConfigUser.FConsultaPersonalizada.FSelect := mmoSQLUserSelect.Lines.Text;
    aObjectActionQueryBuilder.FConfigUser.FConsultaPersonalizada.FJoin := mmoSQLUserJoin.Lines.Text;
    aObjectActionQueryBuilder.FConfigUser.FConsultaPersonalizada.FWhere := mmoSQLUserWhere.Lines.Text;
    aObjectActionQueryBuilder.FConfigUser.FConsultaPersonalizada.FGroupBy := mmoSQLUserGroupBy.Lines.Text;
    aObjectActionQueryBuilder.FConfigUser.FConsultaPersonalizada.FHaving := mmoSQLUserHaving.Lines.Text;
    aObjectActionQueryBuilder.FConfigUser.FConsultaPersonalizada.FOrderBy := mmoSQLUserOrderBy.Lines.Text;
  end;
  
  procedure ParserParametros;
  begin
    ParserParametrosTabelasJoins;  
    ParserParametrosColunasShow;
    ParserParametrosConsultaPersonalizada;
    aObjectActionQueryBuilder.FConfigUser.FNivelJoinComSubTabelas := edtNivelJoinComSubTabelas.editvalue;
    aObjectActionQueryBuilder.FConfigUser.FTipoScript := TConfigUserTipoScript(cbbTipoScript.itemindex);
    aObjectActionQueryBuilder.FConfigUser.FCampoCalculado.Ativo := lstCalculados.Enabled;
  end;
  
begin
  inherited;

  aObjectActionQueryBuilder := TFactoryObject.CreateComponent(TObjectActionQueryBuilder) as TObjectActionQueryBuilder;
  try
    ParserParametros;
    aObjectActionQueryBuilder.GeneratorSQL;
  finally
    aObjectActionQueryBuilder.Free;
  end;
  ShowMessage('Pronto!'); 
  actTestaScripts.Execute;
  if chkAbrirSQLGerado.Checked then
    AbrirArquivosSQLGerados;       
end;

procedure TFormMainQuery.actFullScriptExecute(Sender: TObject);
var
  i, i2, i3: Integer; 
{  FConfigUser: TConfigUser;

  TConfigUser = record
    FTabelasJoin: TConfigUserTabelasJoin;
    FColunasShow: TConfigUserColunasShow;
    FNivelJoinComSubTabelas: Integer;
    FConsultaPersonalizada: TConfigUserConsultaPersonalizada;
    FTipoScript: TConfigUserTipoScript;
    FCampoCalculado: TConfigUserCampoCalculado;
  end;

  TConfigUserTabelasJoin = record
    TabelaPrincipal,
    FKComCampoObrigatorio, FKComCampoNaoObrigatorio,
    FKVinculadaAFKComCampoObrigatorio, FKVinculadaAFKComCampoNaoObrigatorio: Boolean;
  end;
  
  TConfigUserColunasShow = record
    FNotNul, FPK, FFK, FUnique, FDataTypeTexto,
    FDataTypeBlob, FDataTypeNumerico, FDataTypeMonetario, FDataTypeBoleano, FDataTypeData,
    FTodosDaTabelaPrincipal, FTodosDaTabelaFK, FTodosDaTabelaVinculadaFK,
    FSomenteCampoDescricaoDaPK, FSomenteCampoDescricaoDaFK, FSomenteCampoDescricaoDaVinculadaFK: Boolean;
    FPKDaFK, FPKDaVinculadaFK, FTodosOsOutros: Boolean;
  end; 
  TConfigUserTipoScript = (tcSelect, tcView);//, tcInsert, tcUpdate, tcDelete

  }            
var
  ListConfigUser: TListConfigUser;

  procedure AddPossibilidade(const valor: array of Variant);
  var
    ListConfigUserTemp: TListConfigUser;
    aConfigUserTemp, aConfigUser: TConfigUser;
    i, i2: Integer;
  begin
    SetLength(ListConfigUserTemp, 0);
    for i := 0 to Length(ListConfigUser) -1 do
    begin
      aConfigUser := ListConfigUser[Length(ListConfigUser) - 1];
      for i2 := 0 to Length(valor) -1 do
      begin
        SetLength(ListConfigUserTemp, Length(ListConfigUserTemp) + 1);
        aConfigUserTemp := ListConfigUserTemp[Length(ListConfigUserTemp) - 1];   
        Initialize(aConfigUserTemp);
        aConfigUserTemp.FNivelJoinComSubTabelas := valor[i2];
      end;
    end;
  end;

begin
  inherited;
  LockWindowUpdate(Self.Handle);
  try
    SetLength(ListConfigUser, 1);       
    Initialize(ListConfigUser[Length(ListConfigUser) - 1]);
    AddPossibilidade([-1, 0, 1, 2, 3, 4]);
    for i := 0 to 2 do
    begin
      for i2 := 0 to 2 do
      begin
        for i3 := -1 to 2 do
        begin
          actGeneretorSQL.Execute;
        end;
      end;
    end;
  finally
    LockWindowUpdate(0);
  end;
end;

procedure TFormMainQuery.actTestaScriptsExecute(Sender: TObject);
var
  oListaArquivos, oDadosArquivo: TStringList;
  i: Integer;
  TempSQLDataSet: TSQLDataSet;
  ListaErro: String;
  Resultado: Integer;
begin
  inherited;
  ListaErro := EmptyStr;
  oDadosArquivo := nil;    
  TempSQLDataSet := nil;
  oListaArquivos := TStringList.Create;
  try
    TempSQLDataSet := TSQLDataSet.Create(nil);
    TempSQLDataSet.SQLConnection := ObjectDaoApplication.FBConnection;
    TempSQLDataSet.CommandType := ctQuery;
    oDadosArquivo := TStringList.Create;
    TDMUtils.ListFileDir(TObjectActionQueryBuilder.GetDirSQL, oListaArquivos, ['sql'], true);
    for i := 0 to oListaArquivos.Count -1 do
    begin
      oDadosArquivo.Clear;
      oDadosArquivo.LoadFromFile(oListaArquivos.Strings[i]);
      try
        TempSQLDataSet.CommandText := oDadosArquivo.Text;
        Resultado := TempSQLDataSet.ExecSQL();
        TempSQLDataSet.Close;
        if Resultado <> 0 then
          ListaErro := ListaErro + #13 + Format('Erro %d no arquivo %s', [Resultado, oListaArquivos.Strings[i]]);
      except
        on e: Exception do
        begin
          ListaErro := ListaErro + #13 + Format('Exceção %s no arquivo %s', [e.message, oListaArquivos.Strings[i]]);
          Continue;
        end;
      end;
    end;
  finally
    FreeAndNil(oDadosArquivo);
    FreeAndNil(oListaArquivos);  
    FreeAndNil(TempSQLDataSet);
    if TDMUtils.existValue(ListaErro) then
      ShowMessage(ListaErro)
    else
      Showmessage('Nenhum erro encontrado!');
  end;
end;

procedure TFormMainQuery.AtualizaNivelJoin;
var
  oOldOnChange: TNotifyEvent;
begin
  oOldOnChange := edtNivelJoinComSubTabelas.Properties.OnChange;
  try
    edtNivelJoinComSubTabelas.Properties.OnChange := nil;
    edtNivelJoinComSubTabelas.Text := IntToStr(cbbNiveisJoin.ItemIndex -1);
  finally
    edtNivelJoinComSubTabelas.Properties.OnChange := oOldOnChange;
  end;
end;

procedure TFormMainQuery.cbbNiveisJoinPropertiesChange(Sender: TObject);
begin
  inherited;
  AtualizaNivelJoin;
end;

procedure TFormMainQuery.cbbNiveisJoinExit(Sender: TObject);
begin
  inherited;
  AtualizaNivelJoin;
end;

procedure TFormMainQuery.AtualizaComboNivelJoin;
var
  nNewIndex: Integer;
  oOldOnChange: TNotifyEvent;
begin
  nNewIndex := TDMUtils.StrToInt2(edtNivelJoinComSubTabelas.Text) + 1;
  oOldOnChange := cbbNiveisJoin.Properties.OnChange;
  try
    cbbNiveisJoin.Properties.OnChange := nil;
    if (cbbNiveisJoin.Properties.Items.Count > nNewIndex) then
      cbbNiveisJoin.ItemIndex := nNewIndex
    else
      cbbNiveisJoin.ItemIndex := cbbNiveisJoin.Properties.Items.Count-1;
  finally
    cbbNiveisJoin.Properties.OnChange := oOldOnChange;
  end;
end;

procedure TFormMainQuery.edtNivelJoinComSubTabelasKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  if not (key in ['0'..'9']) then
    key := #0;
end;

procedure TFormMainQuery.edtNivelJoinComSubTabelasExit(Sender: TObject);
begin
  inherited;
  AtualizaComboNivelJoin;
end;

procedure TFormMainQuery.edtNivelJoinComSubTabelasPropertiesChange(
  Sender: TObject);
begin
  inherited;

  AtualizaComboNivelJoin;
end;

procedure TFormMainQuery.AbrirArquivosSQLGerados;
var
  oListaArquivos: TStringList;
  i: Integer;
begin
  inherited;
  oListaArquivos := TStringList.Create;
  try
    TDMUtils.ListFileDir(TObjectActionQueryBuilder.GetDirSQL, oListaArquivos, ['sql'], true);
    for i := 0 to oListaArquivos.Count -1 do
    begin
      TDMUtils.OpenSite(oListaArquivos.Strings[i]);
    end;
  finally
    FreeAndNil(oListaArquivos);
  end;
end;

end.
