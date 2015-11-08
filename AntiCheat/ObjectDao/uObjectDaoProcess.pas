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

unit uObjectDaoProcess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,MidasLib,
  Dialogs, uObjectDao, DB, DBClient;

type
  TObjectDaoProcess = class(TObjectDao)
    CDSDadosMEMORIA_RAM_UTILIZADA: TIntegerField;
    CDSDadosNOME_USUARIO_AMBIENTE: TStringField;
    CDSDadosCPU_UTILIZADO: TIntegerField;
    CDSDadosNOME_PROCESSO: TStringField;
    CDSDadosDESCRICAO: TStringField;
    CDSDadosFINALIZAR: TBooleanField;
    CDSDadosID_SECAO: TIntegerField;
    CDSDadosDIRETORIO: TStringField;
    CDSDadosHASH: TStringField;
    CDSDadosEMPRESA: TStringField;
    CDSDadosVERSAO_ARQUIVO: TStringField;
    CDSDadosNOME_INTERNO: TStringField;
    CDSDadosCOPYRIGHT: TStringField;
    CDSDadosNOME_ORIGINAL: TStringField;
    CDSDadosPRODUTO: TStringField;
    CDSDadosVERSAO_PRODUTO: TStringField;
    CDSDadosCOMENTARIOS: TStringField;
    CDSDadosATRIBUTOS: TStringField;
    CDSDadosTIPO: TStringField;
    CDSDadosOS: TStringField;
    CDSDadosMD5: TStringField;
  private
    { Private declarations }

  protected
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TObjectDaoProcess);

end.
