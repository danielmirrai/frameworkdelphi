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

unit uObjectDaoImage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,MidasLib,
  Dialogs, uObjectDao, DB, DBClient;

type
  TObjectDaoImage = class(TObjectDao)
    CDSDadosCODIGO: TIntegerField;
    CDSDadosID_SECAO: TIntegerField;
    CDSDadosDATA: TDateTimeField;
    CDSDadosID_PARTIDA: TIntegerField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

initialization
  RegisterClass(TObjectDaoImage);
end.
