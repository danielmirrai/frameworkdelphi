unit uObjectActionGame;

interface
uses
  uObjectAction, uObjectDaoGame, SysUtils, classes, XMLDoc,
  MidasLib, uInterfaceXMLListGame, uDMUtils, XMLIntf, uDMHTTP;

type
  TObjectActionGame = class(TObjectAction)
  private
  protected
  public 
    FDMHTTP: TDMHTTP;
    procedure Refresh; Override;
    function LocateGameActive: Boolean;
    function GetListGame: Boolean;
    function SetGameActive(aID: Integer): Boolean;

    function GetObjectDao: TObjectDaoGame; Reintroduce;
    procedure GetListGameXML(aListXML: IXMLPartidasType); overload;
    procedure GetListGameXML(aXML: String); overload;
    procedure SaveListGameXML(aFileName: String); overload;
    function SetListGameXML(aFileName: string = ''): String;

    procedure AfterConstruction; override;
    procedure BeforeDestruction; override;

  end;
implementation

uses uConstantSystem, uDMUtilsMessage, uInterfaceXMLErro, uInterfaceXMLSucesso;


{ TObjectActionGame }

procedure TObjectActionGame.AfterConstruction;
begin
  inherited;
  FDMHTTP := TDMHTTP.Create(nil);
end;

procedure TObjectActionGame.BeforeDestruction;
begin
  TDMUtils.DestroyObject(FDMHTTP);
  inherited;
end;

procedure TObjectActionGame.GetListGameXML(aListXML: IXMLPartidasType);
var
  vXML: IXMLPARTIDAType;
  vIndex: Integer;
begin
  try
    GetObjectDao.CDSDados.DisableControls;
    GetObjectDao.CDSDados.EmptyDataSet;
    for vIndex := 0 to aListXML.Partida.Count -1 do
    begin
      vXML := aListXML.Partida.Items[vIndex];
      GetObjectDao.CDSDados.Insert;
      GetObjectDao.CDSDadosID_PARTIDA.AsInteger   := vXML.Get_ID;
      GetObjectDao.CDSDadosCODIGO.AsString        := vXML.Get_CODIGO;
      GetObjectDao.CDSDadosDESCRICAO.AsString     := vXML.Get_DESCRICAO;
      GetObjectDao.CDSDados.Post;
      vXML := nil;
    end;
    GetObjectDao.CDSDados.First;
  finally
    GetObjectDao.CDSDados.EnableControls;
  end;
end;

procedure TObjectActionGame.GetListGameXML(aXML: String);
var
  vDocXML: IXMLDocument;
  vListXML: IXMLPartidasType;
begin
  try
    vDocXML.LoadFromXML(aXML);
    vListXML := GetPARTIDAS(vDocXML);
    GetListGameXML(vListXML);
  finally
    vListXML  := nil;
    vDocXML   := nil;
  end;
end;

procedure TObjectActionGame.SaveListGameXML(aFileName: String);
var
  vListXML: IXMLPartidasType;
begin
  try
    vListXML := LoadPARTIDAS(aFileName);
    GetListGameXML(vListXML);
  finally
    vListXML := nil;
  end;
end;

function TObjectActionGame.GetObjectDao: TObjectDaoGame;
begin
  Result := TObjectDaoGame(inherited GetObjectDao);
end;

function TObjectActionGame.LocateGameActive: Boolean;
begin
  Result := False;
  if (TConstantSystem.GetGameActive > 0) then
    Result := GetObjectDao.CDSDados.Locate(GetObjectDao.CDSDadosID_PARTIDA.FieldName, TConstantSystem.GetGameActive, []);
end;

procedure TObjectActionGame.Refresh;
begin
  inherited;
  GetListGame;
end;

function TObjectActionGame.GetListGame: Boolean;
var
  vReturn: String;
  vXMLPartidas: IXMLPartidasType;
  vXMLErro: IXMLErroType;
  vXML: TXMLDocument;
begin
    try
      Result := False;
      TConstantSystem.SetGameActive(0);
      FDMHTTP.Clear;
      FDMHTTP.URL := TConstantSystem.GetSiteAPIListGame;
      FDMHTTP.AddFieldParams('EQUIPE',TConstantSystem.GetTeamActive, True);

      vReturn := FDMHTTP.SendPOST;

      if (not TDMUtils.IsEmpty(vReturn)) then
      begin
        vXML    := TDMUtils.GetXML(vReturn);

        if TDMUtils.LocateStr('<partida>', vReturn) then
        begin
          vXMLPartidas := Getpartidas(vXML);
          if (UpperCase(vXMLPartidas.CalculaHash) <> UpperCase(vXMLPartidas.Hash)) then
          begin
            Result := False;                            
            TDMUtils.MyException('Partida: Hash invalido!'+#13+
            'Enviado: '+ UpperCase(vXMLPartidas.CalculaHash)+#13+
            'Recebido: '+ UpperCase(vXMLPartidas.Hash), True);
          end
          else
          begin
            Result := True;
            GetListGameXML(vXMLPartidas);
          end;
        end
        else
        begin
          vXMLErro := GetErro(vXML);
          if (UpperCase(vXMLErro.CalculaHash) <> UpperCase(vXMLErro.Hash)) then
          begin
            Result := False;
            TDMUtils.MyException('Partida: Hash invalido!'+#13+
              'Enviado: '+ UpperCase(vXMLErro.CalculaHash)+#13+
              'Recebido: '+ UpperCase(vXMLErro.Hash), True);
          end
          else
          begin
            TDMUtils.MyException('Partida: '+TDMUtils.IntToStr2(vXMLErro.Codigo) + vXMLErro.Mensagem, true);
          end;
        end;
      end
      else
        TDMUtils.MyException('Erro ao listar partidas!', True);
    except
        Result := False;
        TDMUtils.MyException('Erro ao listar partidas!'+#13+#10+'Retorno: '+vReturn, true);
        exit;
    end;
end;

function TObjectActionGame.SetGameActive(aID: Integer): Boolean;
var
  vReturn: String;
  vXMLSucesso: IXMLSucessoType;
  vXMLErro: IXMLErroType;
  vXML: TXMLDocument;
begin
  try
    try
      Result := False;
      TConstantSystem.SetGameActive(0);
      if (aID > 0) then
      begin
        Result := True;
        FDMHTTP.Clear;
        FDMHTTP.URL := TConstantSystem.GetSiteAPISetGame;
        FDMHTTP.AddFieldParams('ID_PARTIDA', aID, True);
        FDMHTTP.AddFieldParams('SESS_ID', TConstantSystem.GetSectionActive);
        //FDMHTTP.AddHash;
        vReturn := FDMHTTP.SendPOST;

        if (not TDMUtils.IsEmpty(vReturn)) then
        begin
          vXML := TXMLDocument.Create(nil);
          vXML.LoadFromXML(vReturn);
          vXML.Active := True;
          if TDMUtils.LocateStr('<sucesso>', vReturn) then
          begin
            vXMLSucesso := Getsucesso(vXML);
            if (UpperCase(vXMLSucesso.CalculaHash) <> UpperCase(vXMLSucesso.Hash)) then
            begin
              Result := False;
              TDMUtils.MyException('Seleciona Partida: Hash invalido!'+#13+
              'Enviado: '+ UpperCase(vXMLSucesso.CalculaHash)+#13+
              'Recebido: '+ UpperCase(vXMLSucesso.Hash), true);
            end
            else
            begin
              Result := True;
              TConstantSystem.SetGameActive(GetObjectDao.CDSDadosID_PARTIDA.AsInteger);
              TDMUtils.MyException('Partida selecionada com sucesso!'+#13+
                                            'Usuário: '+GetObjectDao.CDSDadosID_PARTIDA.AsString+' - '+GetObjectDao.CDSDadosCODIGO.AsString+' - '+GetObjectDao.CDSDadosDESCRICAO.AsString);
            end;
          end
          else
          begin
            vXMLErro := GetErro(vXML);
            if (UpperCase(vXMLErro.CalculaHash) <> UpperCase(vXMLErro.Hash)) then
            begin
              Result := False;
              TDMUtils.MyException('Seleciona Partida: Hash invalido!'+#13+
                'Enviado: '+ UpperCase(vXMLErro.CalculaHash)+#13+
                'Recebido: '+ UpperCase(vXMLErro.Hash), True);
            end
            else
            begin
              TDMUtils.MyException('Seleciona Partida: '+TDMUtils.IntToStr2(vXMLErro.Codigo) + vXMLErro.Mensagem, True);
            end;
          end;
        end
        else
          TDMUtils.MyException('Erro ao seleciona partida!', True);
      end;
    except
        Result := False;
        TDMUtils.MyException('Erro ao seleciona partida!'+#13+#10+'Retorno: '+vReturn, True);
        exit;
    end;
  finally
  end;
end;

function TObjectActionGame.SetListGameXML(aFileName: string = ''): String;
var
  vListXML: IXMLPARTIDASType;
  vXML: IXMLPARTIDAType;
begin
  try
    try
      GetObjectDao.CDSDados.DisableControls;
      vListXML := NewPARTIDAS;
      GetObjectDao.CDSDados.First;
      while not GetObjectDao.CDSDados.Eof do
      begin
        vXML := nil;
        vXML := vListXML.Partida.Add;
        vXML.Set_ID(GetObjectDao.CDSDadosID_PARTIDA.AsInteger);
        vXML.Set_DESCRICAO(GetObjectDao.CDSDadosDESCRICAO.AsString);
        vXML.Set_CODIGO(GetObjectDao.CDSDadosCODIGO.AsString);
        GetObjectDao.CDSDados.Next;
      end;
      vListXML.Set_HASH(vListXML.CalculaHash);
      Result := FormatXMLData(vListXML.XML);

      if not TDMUtils.IsEmpty(aFileName) then
      begin
        TDMUtils.DeleteFile2(aFileName);
        vListXML.SaveToFile(aFileName);
      end;
    except
        Result := '';
        TDMUtils.MyException('Erro ao gerar lista de partidas!', True);
    end;
  finally
    GetObjectDao.CDSDados.EnableControls;
  end;
end;

initialization
  RegisterClass(TObjectActionGame);
  
end.
