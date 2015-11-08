
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

unit uConstantSystem;

interface

uses
  Classes, Forms, Windows,SysUtils, Messages, Dialogs, uDMCript, uConstantUtils;

const
  cNameSystem = 'Sytem';
  cHashKey = 'admin';
  cSiteCaptureIP = 'http://meuip.datahouse.com.br';
  cSiteDeveloper = 'http://www.danielmirrai.com.br';   
  cSiteCriarConta = 'http://www.danielmirrai.com.br/registro/jogador';
  cServerAPI = '1516EF1DDA7ADB608E53D054DF2AF26BE363FF468ADF7B9AC90B4B4D9D2366F555F516'; //'Usar o cript.exe para encriptografar http://www.danielmirrai.com.br/api/'

type
  TVendor = array [0..11] of char;

  TConstantSystem = class
    private

    public
      class procedure SetUserActive(const Value: Integer);
      class procedure SetPasswordUserActive(const Value: String);
      class procedure SetGameActive(const Value: Integer);
      class procedure SetSectionActive(const Value: Integer);
      class procedure SetTeamActive(const Value: Integer);
      class function GetUserActive: Integer;
      class function GetPasswordUserActive: String;
      class function GetTeamActive: Integer;
      class function GetUserActiveFormat: string;
      class function GetGameActive: Integer;
      class function GetGameActiveFormat: string;
      class function GetSectionActive: Integer;
      class function GetSectionActiveFormat: string;
      class function GetRegistryPath(aForm: TForm): string;
      class function GetSiteAPIListGame: string;
      class function GetSiteAPISetGame: string;
      class function GetSiteAPIPlayers: string;
      class function GetSiteAPILogin: string;
      class function GetSiteAPILogout: string;
      class function GetSiteAPIProcess: string;
      class function GetSiteAPIImage: string;
  end;
var
  FUserActive, FGameActive, FSectionActive, FTeamActive: Integer;
  FPasswordUserActive: String;
implementation

uses uDMUtils, MD5;

{ TCostanteSystem }

class function TConstantSystem.GetGameActive: Integer;
begin
  Result := FGameActive;
end;

class function TConstantSystem.GetGameActiveFormat: string;
begin
  Result := TDMUtils.FormatValue('000000', TConstantSystem.GetGameActive);
end;

class function TConstantSystem.GetPasswordUserActive: String;
begin
  Result := FPasswordUserActive;
end;

class function TConstantSystem.GetRegistryPath(aForm: TForm): string;
begin
  Result := 'Software\' + cNameSystem + '\' + aForm.Name + '\'+ TDMUtils.IntToStr2(FUserActive) + '\';
end;

class function TConstantSystem.GetSectionActive: Integer;
begin
  Result := FSectionActive;
end;

class function TConstantSystem.GetSectionActiveFormat: string;
begin
  Result := TDMUtils.FormatValue('000000', TConstantSystem.GetSectionActive);
end;

class function TConstantSystem.GetSiteAPIImage: string;
begin
  Result := TDMCript.Decrypt(cServerAPI) + 'gravaimagens';
end;

class function TConstantSystem.GetSiteAPIListGame: string;
begin
  Result := TDMCript.Decrypt(cServerAPI) + 'listapartidas';
end;

class function TConstantSystem.GetSiteAPILogin: string;
begin
  Result := TDMCript.Decrypt(cServerAPI) + 'login';
end;

class function TConstantSystem.GetSiteAPILogout: string;
begin
  Result := TDMCript.Decrypt(cServerAPI) + 'logout';
end;

class function TConstantSystem.GetSiteAPIPlayers: string;
begin
  Result := TDMCript.Decrypt(cServerAPI) + 'listajogadores';
end;

class function TConstantSystem.GetSiteAPIProcess: string;
begin
  Result := TDMCript.Decrypt(cServerAPI) + 'gravaprocessos';
end;

class function TConstantSystem.GetSiteAPISetGame: string;
begin
  Result := TDMCript.Decrypt(cServerAPI) + 'selecionapartida';
end;

class function TConstantSystem.GetTeamActive: Integer;
begin
  Result := FTeamActive;
end;

class function TConstantSystem.GetUserActive: Integer;
begin
  Result := FUserActive;
end;

class function TConstantSystem.GetUserActiveFormat: string;
begin
  Result := TDMUtils.FormatValue('000000', TConstantSystem.GetUserActive);
end;

class procedure TConstantSystem.SetGameActive(const Value: Integer);
begin
  FGameActive := Value;
end;

class procedure TConstantSystem.SetPasswordUserActive(const Value: String);
begin
  FPasswordUserActive := Value;  
end;

class procedure TConstantSystem.SetSectionActive(const Value: Integer);
begin
  FSectionActive := Value;
end;

class procedure TConstantSystem.SetTeamActive(const Value: Integer);
begin
  FTeamActive := Value;
end;

class procedure TConstantSystem.SetUserActive(const Value: Integer);
begin
  FUserActive := Value;
  FPasswordUserActive := sCST_EmptyStr;
end;

end.
