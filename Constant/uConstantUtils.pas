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

unit uConstantUtils;

interface

uses
  Forms;

const
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



resourcestring
  sCST_NameProject = 'WicTalk Messager';
  sCST_Alert = 'Alert';
  sCST_Error = 'Error';
  sCST_Information = 'Information';

  sCST_ErrorSavingImage = 'Error saving image!';
  sCST_BeginDrive = ':\';
  sCST_MessageError = 'Error: ';
  sCST_Space = ' ';
  sCST_TraceSpaces = ' - ';
  sCST_NameLog = 'log.txt';
  sCST_TitleLog = 'Log Software';
  cHashKey = 'admin';
  cSiteCaptureIP = 'http://meuip.datahouse.com.br';

  cComAcento = 'àâêôûãõáéíóúçüÀÂÊÔÛÃÕÁÉÍÓÚÇÜ©£';
  cSemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU  ';

const
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
    NameSystem := 'System';

  Result := 'Software\' + NameSystem + '\' + aForm.Name + '\' + PathRegistry;
end;

end.
