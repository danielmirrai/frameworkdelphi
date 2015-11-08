unit uObjectActionPlayers;

interface
uses
  uInterfaceXMLPlayers, uObjectAction, Classes, SysUtils, XMLDoc, uObjectDaoPlayers,
  uDMHTTP, Windows, ExtCtrls, uConstantPlayers, XMLIntf;

  type
    TObjectActionPlayers = Class(TObjectAction)

    private
      FTimeCaptura: TTimer;
      procedure TimerOnTimer(Sender: TObject);
    protected
    public 
      FDMHTTP: TDMHTTP;
      function SendPlayers: Boolean;
      procedure Refresh; Override;
      function GetObjectDao: TObjectDaoPlayers; Reintroduce;

      procedure GetListPlayersXML(aListXML: IXMLJOGADORES_ONLINEType); overload;
      procedure GetListPlayersXML(aXML: String); overload;
      function SetListPlayersXML(aFileName: string = ''): TStringList;
      procedure SaveListGameXML(aFileName: String); overload;
      procedure AfterConstruction; override;
      procedure BeforeDestruction; override;
      procedure Disable;
      procedure Active;
    End;
implementation

uses uInterfaceXMLErro, uConstantSystem, uDMUtilsMessage,
  uDMUtils;

{ TObjectActionPlayers }

procedure TObjectActionPlayers.Active;
begin
  FTimeCaptura.Enabled := True;
end;

procedure TObjectActionPlayers.AfterConstruction;
begin
  inherited;
  FDMHTTP := TDMHTTP.Create(nil);

  FTimeCaptura          := TTimer.Create(nil);
  FTimeCaptura.OnTimer  := TimerOnTimer;
  FTimeCaptura.Interval := cTimeCapturePlayers;
  Disable;
end;

procedure TObjectActionPlayers.BeforeDestruction;
begin
  inherited;

end;

procedure TObjectActionPlayers.Disable;
begin
  FTimeCaptura.Enabled := False;
end;

procedure TObjectActionPlayers.GetListPlayersXML(
  aListXML: IXMLJOGADORES_ONLINEType);
var
  vXML: IXMLJOGADOR_INFOType;
  vIndex: Integer;
begin
  try
    GetObjectDao.CDSDados.DisableControls;
    GetObjectDao.CDSDados.EmptyDataSet;
    for vIndex := 0 to aListXML.JOGADOR_INFO.Count -1 do
    begin
      vXML := aListXML.JOGADOR_INFO.Items[vIndex];
      GetObjectDao.CDSDados.Insert;
      GetObjectDao.CDSDadosLOGIN.AsString            := vXML.Get_login;
      GetObjectDao.CDSDadosCLA.AsString              := vXML.Get_Cla;
      GetObjectDao.CDSDadosDATA_INICIO.AsDateTime    := TDMUtils.StrToDateTime2('YYYY-MM-DD HH:MM:SS', vXML.Get_Data_Inicio);
      GetObjectDao.CDSDados.Post;
      vXML := nil;
    end;
    GetObjectDao.CDSDados.First;
  finally
    GetObjectDao.CDSDados.EnableControls;
  end;
end;

procedure TObjectActionPlayers.GetListPlayersXML(aXML: String);
var
  vDocXML: IXMLDocument;
  vListXML: IXMLJogadores_onlineType;
begin
  try
    vDocXML.LoadFromXML(aXML);
    vListXML := Getjogadores_online(vDocXML);
    GetListPlayersXML(vListXML);
  finally
    vListXML  := nil;
    vDocXML   := nil;
  end;
end;

function TObjectActionPlayers.GetObjectDao: TObjectDaoPlayers;
begin
  Result := TObjectDaoPlayers(inherited GetObjectDao);
end;

procedure TObjectActionPlayers.Refresh;
begin
  if FTimeCaptura.Enabled then
    SendPlayers;
  inherited;
end;

procedure TObjectActionPlayers.SaveListGameXML(aFileName: String);
var
  vListXML: IXMLJogadores_onlineType;
begin
  try
    vListXML := Loadjogadores_online(aFileName);
    GetListPlayersXML(vListXML);
  finally
    vListXML := nil;
  end;
end;

function TObjectActionPlayers.SendPlayers: Boolean;
var
  vReturn: String;
  vXMLJOGADORES: IXMLJOGADORES_ONLINEType;
  vXMLErro: IXMLErroType;
  vXML: TXMLDocument;
  vOldActive: Boolean;
begin
  vOldActive := FTimeCaptura.Enabled;
  try
    try
      Result := False;
      if (vOldActive and (TConstantSystem.GetGameActive > 0)) then
      begin
        Disable;
        FDMHTTP.Clear;
        FDMHTTP.URL := TConstantSystem.GetSiteAPIPlayers;
        FDMHTTP.AddFieldParams('ID_PARTIDA', TConstantSystem.GetGameActive, True);
        //FDMHTTP.AddHash;
        vReturn := FDMHTTP.SendPOST;

        if (not TDMUtils.IsEmpty(vReturn)) then
        begin
          vXML    := TDMUtils.GetXML(vReturn);

          if TDMUtils.LocateStr('<JOGADORES_ONLINE>', vReturn) then
          begin
            vXMLJOGADORES := GetJOGADORES_ONLINE(vXML);
            if (UpperCase(vXMLJOGADORES.CalculaHash) <> UpperCase(vXMLJOGADORES.Hash)) then
            begin
              Result := False;
              TDMUtils.MyException('Erro ao enviar lista jogadores: Hash invalido!'+#13+
              'Enviado: '+ UpperCase(vXMLJOGADORES.CalculaHash)+#13+
              'Recebido: '+ UpperCase(vXMLJOGADORES.Hash));
            end
            else
            begin
              Result := True;
              GetListPlayersXML(vXMLJOGADORES);
              TDMUtils.MyException('Jogadores listados com sucesso!');
            end;
          end
          else
          begin
            vXMLErro := GetErro(vXML);
            if (UpperCase(vXMLErro.CalculaHash) <> UpperCase(vXMLErro.Hash)) then
            begin
              Result := False;
              TDMUtils.MyException('Erro ao enviar lista jogadores: Hash invalido!'+#13+
                'Enviado: '+ UpperCase(vXMLErro.CalculaHash)+#13+
                'Recebido: '+ UpperCase(vXMLErro.Hash));
            end
            else
            begin
              TDMUtils.MyException('Erro ao enviar lista jogadores: '+TDMUtils.IntToStr2(vXMLErro.Codigo) + vXMLErro.Mensagem);
            end;
          end;
        end
        else
          TDMUtils.MyException('Erro ao enviar lista jogadores!');
      end;
    except
        Result := False;
        TDMUtils.MyException('Erro ao enviar lista jogadores!');
        exit;
    end;
  finally
    if vOldActive then
      active;
  end;
end;

function TObjectActionPlayers.SetListPlayersXML(aFileName: string): TStringList;
var
  vListXML: IXMLJOGADORES_ONLINEType;
  vXML: IXMLJOGADOR_INFOType;
begin
  Result := TStringList.Create;
  Result.Clear;
  try
    try
      GetObjectDao.CDSDados.DisableControls;
      vListXML := NewJOGADORES_ONLINE;

      GetObjectDao.CDSDados.First;

      while not GetObjectDao.CDSDados.Eof do
      begin
        vXML := vListXML.JOGADOR_INFO.Add;
        vXML.Set_LOGIN(GetObjectDao.CDSDadosLOGIN.AsString);
        vXML.Set_CLA(GetObjectDao.CDSDadosCLA.AsString);
        vXML.Set_DATA_INICIO(TDMUtils.FormatDateTime2(GetObjectDao.CDSDadosDATA_INICIO.AsDateTime));
        GetObjectDao.CDSDados.Next;
      end;

      vListXML.Set_HASH(vListXML.CalculaHash);

      Result.Text := TDMUtils.FormatXMLData2(vListXML.XML);

      if not TDMUtils.IsEmpty(aFileName) then
      begin
        TDMUtils.DeleteFile2(aFileName);
        vListXML.SaveToFile(aFileName);
      end;
    except
        Result.Clear;
        TDMUtils.MyException('Erro ao gerar lista de jogadores online!');
        exit;
    end;
  finally
    GetObjectDao.CDSDados.EnableControls;
  end;
end;

procedure TObjectActionPlayers.TimerOnTimer(Sender: TObject);
begin
  SendPlayers;
end;

initialization
  Classes.RegisterClass(TObjectActionPlayers);

end.
