{***********************************************************}
{                                                           }
{             Desenvolvido por Daniel Mirrai                }
{                                                           }
{              Programador Delphi Sênior                    }
{             E-mail: danielmirrai@gmail.com                }
{                   Skype: danielmirrai                     }
{          Fones: +55 (51) 9413-3725 / 3111-2388            }
{         http://www.linkedin.com/in/danielmirrai           }
{          https://www.facebook.com/danielmirrai            }
{***********************************************************}

unit uObjectActionLogin;

interface
uses
  MidasLib,uObjectAction, uDMHTTP, uObjectDaoLogin, Windows, Classes, SysUtils, XMLDoc;

type
  TObjectActionLogin = class(TObjectAction)

    public
      FObjectDaoLogin: TObjectDaoLogin;
      FDMHTTP: TDMHTTP;
      function Logouf: Boolean;
      procedure Login;
      function LocateUserActive: Boolean;
      function GetObjectDao: TObjectDaoLogin; Reintroduce;

      procedure BeforeDestruction; override;
      procedure AfterConstruction; override;

  end;
implementation

uses uDMUtils, uDMInfoComputer, uDMUtilsMessage, uConstantSystem,
  uInterfaceXMLLogin, uInterfaceXMLErro, uFactoryObject, IdHTTP;


{ TObjectActionLogin }

procedure TObjectActionLogin.AfterConstruction;
begin
  inherited;
  FDMHTTP               := TDMHTTP.Create(nil);
  FObjectDaoLogin := GetObjectDao;
  TConstantSystem.SetUserActive(0);
end;

procedure TObjectActionLogin.BeforeDestruction;
begin
  Logouf;
  TDMUtils.DestroyObject(FDMHTTP);
  inherited;
end;

function TObjectActionLogin.GetObjectDao: TObjectDaoLogin;
begin
  Result := TObjectDaoLogin(inherited GetObjectDao);
end;

function TObjectActionLogin.Logouf: Boolean;
var
  vReturn: string;
begin 
  Result := True;
  Edit;
  FObjectDaoLogin.CDSDadosLOGGED.AsBoolean := False;
  Save;

  try
    try
      if (TConstantSystem.GetSectionActive > 0) then
      begin
        FObjectDaoLogin.CDSDados.First;
        FDMHTTP.Clear;
        FDMHTTP.URL := TConstantSystem.GetSiteAPILogout;
        FDMHTTP.AddFieldParams('SESS_ID',TConstantSystem.GetSectionActive, True);
        vReturn := FDMHTTP.SendPOST;
        Result  := TDMUtils.LocateStr('DESCONECTADO COM SUCESSO', UpperCase(vReturn));
      end;
    except
        Result := False;
        raise Exception.Create('Erro ao efetuar logout!'+#13+#10+
            'Retorno: '+vReturn);
        exit;
    end;
  finally
    TConstantSystem.SetUserActive(0);
    TConstantSystem.SetSectionActive(0);
  end;
end;

function TObjectActionLogin.LocateUserActive: Boolean;
begin
  Result := False;
  if (TConstantSystem.getUserActive > 0) then
    Result := FObjectDaoLogin.CDSDados.Locate(FObjectDaoLogin.CDSDadosCODIGO.FieldName, TConstantSystem.GetUserActive, []);
end;

procedure TObjectActionLogin.Login;
var
  vReturn: String;
  vXMLJogador: IXMLJogadorType;
  vXMLErro: IXMLErroType;
  vXML: TXMLDocument;
begin
  Edit;
  FObjectDaoLogin.CDSDadosLOGGED.AsBoolean := False;
  Save;
    try
      TConstantSystem.SetUserActive(0);
      TConstantSystem.SetSectionActive(0);
      TConstantSystem.SetGameActive(0);
      TConstantSystem.SetTeamActive(0);
      FObjectDaoLogin.CDSDados.First;
      FDMHTTP.Clear;
      FDMHTTP.URL := TConstantSystem.GetSiteAPILogin;

      FObjectDaoLogin.CDSDados.First;
      FDMHTTP.AddFieldParams('LOGIN',FObjectDaoLogin.CDSDadosUSUARIO.AsString, True);
      FDMHTTP.AddFieldParams('SENHA', FObjectDaoLogin.CDSDadosSENHA.AsString);
      FDMHTTP.AddFieldParams('VERSAO_EXE','1.2');
      FDMHTTP.AddFieldParams('ENDERECO_MAC', TDMInfoComputer.GetAdress_MAC);
      FDMHTTP.AddFieldParams('ENDERECO_IP', TDMInfoComputer.GetAdress_IP_Rede);
      FDMHTTP.AddFieldParams('NOME_PROCESSADOR', TDMInfoComputer.GetName_Processor);
      FDMHTTP.AddFieldParams('NOME_PLACA_VIDEO', TDMInfoComputer.GetName_VideoCard);
      FDMHTTP.AddFieldParams('PLACA_MAE', TDMInfoComputer.GetMotherboard);
      FDMHTTP.AddFieldParams('ID_PLACA_MAE', TDMUtils.IntToStr2(TDMInfoComputer.GetID_Motherboard));
      FDMHTTP.AddFieldParams('MEMORIA_RAM', TDMUtils.IntToStr2(TDMInfoComputer.GetMemory_RAM_MB));
      FDMHTTP.AddFieldParams('SISTEMA_OPERACIONAL', TDMInfoComputer.GetSO);
      FDMHTTP.AddFieldParams('NOME_COMPUTADOR', TDMInfoComputer.GetNameComputer);

      vReturn := FDMHTTP.SendPOST;
      if (not TDMUtils.IsEmpty(vReturn)) then
      begin
        vXML    := TDMUtils.GetXML(vReturn);

        if TDMUtils.LocateStr('<jogador>', vReturn) then
        begin
          vXMLJogador := Getjogador(vXML);
          if (UpperCase(vXMLJogador.CalculaHash) <> UpperCase(vXMLJogador.Hash)) then
          begin
            raise Exception.Create('Erro ao efetuar login: Hash invalido!'+#13+
            'Enviado: '+ UpperCase(vXMLJogador.CalculaHash)+#13+
            'Recebido: '+ UpperCase(vXMLJogador.Hash));
          end
          else
          begin
            Edit;
            FObjectDaoLogin.CDSDadosLOGGED.AsBoolean := True;
            FObjectDaoLogin.CDSDadosCODIGO.AsInteger   := vXMLJogador.Id;
            FObjectDaoLogin.CDSDadosNOME.AsString      := vXMLJogador.Nome;
            FObjectDaoLogin.CDSDadosCLA.AsString       := vXMLJogador.Cla;
            FObjectDaoLogin.CDSDadosEQUIPE.AsInteger   := TDMUtils.StrToInt2(vXMLJogador.Equipe);
            FObjectDaoLogin.CDSDadosSECAO.AsInteger    := vXMLJogador.Sessid;
            FObjectDaoLogin.CDSDadosCODIGO.AsInteger   := vXMLJogador.Id;
            Save;

            TConstantSystem.SetUserActive(FObjectDaoLogin.CDSDadosCODIGO.AsInteger);
            TConstantSystem.SetPasswordUserActive(FObjectDaoLogin.CDSDadosSENHA.ASString);
            TConstantSystem.SetSectionActive(FObjectDaoLogin.CDSDadosSECAO.AsInteger);
            TConstantSystem.SetTeamActive(FObjectDaoLogin.CDSDadosEQUIPE.AsInteger);
{            raise Exception.Create('Login efetuado com sucesso!'+#13+
                                          'Usuário: '+FObjectDaoLogin.CDSDadosCODIGO.AsString+' - '+FObjectDaoLogin.CDSDadosUSUARIO.AsString);}
          end;
        end
        else
        begin
          vXMLErro := GetErro(vXML);
          if (UpperCase(vXMLErro.CalculaHash) <> UpperCase(vXMLErro.Hash)) then
          begin
            raise Exception.Create('Erro ao efetuar login: Hash invalido!'+#13+
              'Enviado: '+ UpperCase(vXMLErro.CalculaHash)+#13+
              'Recebido: '+ UpperCase(vXMLErro.Hash));
          end
          else
          begin
            raise Exception.Create('Login: '+TDMUtils.IntToStr2(vXMLErro.Codigo) +' - '+ vXMLErro.Mensagem);
          end;
        end;
      end
      else
        raise Exception.Create('Erro ao efetuar login!');
    except
      raise Exception.Create('Erro ao efetuar login!'+#13+#10+
          'Retorno: '+vReturn);
    end;
end;

initialization
  RegisterClass(TObjectActionLogin);
  
end.
