{***********************************************************}
{                                                           }
{             Desenvolvido por Daniel Mirrai                }
{                                                           }
{                Senior Delphi Programmer                   }
{             E-mail: danielmirrai@gmail.com                }
{                   Skype: danielmirrai                     }
{          Phones: +55 (51) 9413-3725 / 3111-2388           }
{         http://www.linkedin.com/in/danielmirrai           }
{          https://www.facebook.com/danielmirrai            }
{***********************************************************}

unit uConstantAntiCheat;

interface

uses
  Forms;

resourcestring
  sCST_EmptyStr = '';
  sCST_Space = ' ';
  sCST_Open = 'open';
  sCST_ErroDeletingFile = 'Erro ao excluir o arquivo!';
  sCST_ErroDeletingDirectory = 'Erro ao excluir diretório.';
  sCST_ErroWritingFile = 'Erro ao gravar no arquivo!';
  sCST_ErrorGettingFileSize = 'Erro ao obter o tamanho do arquivo!';
  sCST_ErrorWritingDataToFile = 'Erro ao gravar dados no arquivo!';
  sCST_ErrorCreatingFilePermission = 'Erro na criação de permissão de arquivo!';
  sCST_FormatExtended = '###,##0.00';
  sCST_FormatDate = 'dd/mm/yyyy';    
  sCST_FormatDateTime = 'dd/mm/yyyy hh:mm:ss.ZZZZ';
  sCST_FormatTime = 'dd/mm/yyyy hh:mm:ss.ZZZZ';
  sCST_ErrorIn = 'Erro em ';
  sCST_ErroExecutingFile = 'Erro ao executar o arquivo!';
  sCST_NameProject = 'Gamer';
  sCST_Alert = 'Alerta';
  sCST_Error = 'Erro';
  sCST_Information = 'Informação';
  sCST_ErroValidateField = 'Erro ao campo validar';
  sCST_IsRequired = ' é obrigatário!';
  sCST_The = 'O';
  sCST_An = 'A';
  sCST_ErrorListPlayers = 'Erro ao listar jogadores online!';

  sCST_ErrorSavingImage = 'Erro ao salvar imagem!';
  sCST_BeginDrive = ':\';
  sCST_MessageError = 'Erro: ';
  sCST_TraceSpaces = ' - ';
  sCST_NameLog = 'log.txt';
  sCST_TitleLog = 'Log Software';
  cHashKey = 'admin';
  cSiteCaptureIP = 'http://meuip.datahouse.com.br';
  sCST_System = 'System';
  sCST_Software = 'Software';
  sCST_Backslash = '\';
  sCST_Bar = '/';

  cComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ©£';
  cSemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';

const
  sCST_FontTahoma = 'Tahoma';
  nCST_Zero = 0;
  nCST_One = 1;
  nCST_two = 2;
  nCST_Three = 3;
  nCST_Four = 4;
  nCST_Five = 5;
  nCST_Six = 6;
  nCST_Seven = 7;
  nCST_Eigth = 8;
  nCST_Nine = 9;
  nCST_Ten = 10;
  nCST_ExplodeBits = 1024;
  //Lista de caracteres especiais
  cCaracterEspeciais: array[1..38] of string = ('á', 'à', 'ã', 'â', 'ä', 'Á', 'À', 'Ã', 'Â', 'Ä',
    'é', 'è', 'É', 'È', 'í', 'ì', 'Í', 'Ì',
    'ó', 'ò', 'ö', 'õ', 'ô', 'Ó', 'Ò', 'Ö', 'Õ', 'Ô',
    'ú', 'ù', 'ü', 'Ú', 'Ù', 'Ü', 'ç', 'Ç', 'ñ', 'Ñ');
  //Lista de caracteres para troca
  cCaracterTroca: array[1..38] of string = ('a', 'a', 'a', 'a', 'a', 'A', 'A', 'A', 'A', 'A',
    'e', 'e', 'E', 'E', 'i', 'i', 'I', 'I',
    'o', 'o', 'o', 'o', 'o', 'O', 'O', 'O', 'O', 'O',
    'u', 'u', 'u', 'u', 'u', 'u', 'c', 'C', 'n', 'N');
  //Lista de Caracteres Extras
  cCaracterExtra: array[1..30] of string = ('@', '#', '$', '%', '¨', '&', '*',
    '*', '~', '^', '´', 'ß', 'µ', 'þ',
    '`', '¨', 'æ', 'Æ', 'ø', '£', 'Ø',
    'ƒ', 'ª', 'º', '¿', '®', '½', '¼',
    'ý', 'Ý');

type
  TConstantUtils = class
  public
    class function GetRegistryPath(aForm: TForm): string;
  end;

var
  PathRegistry: string;
  NameSystem: string;

implementation

uses uDMUtils;
{ TConstantUtils }

class function TConstantUtils.GetRegistryPath(aForm: TForm): string;
begin
  if TDMUtils.IsEmpty(NameSystem) then
    NameSystem := sCST_System;
  Result := sCST_Software + sCST_Backslash + NameSystem + sCST_Backslash + aForm.Name + sCST_Backslash + PathRegistry;
end;

end.
