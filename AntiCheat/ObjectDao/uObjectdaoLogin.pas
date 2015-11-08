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

unit uObjectdaoLogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,MidasLib,
  Dialogs, uObjectDao, DB, DBClient;

type
  TObjectDaoLogin = class(TObjectDao)
    CDSDadosCODIGO: TIntegerField;
    CDSDadosUSUARIO: TStringField;
    CDSDadosSENHA: TStringField;
    CDSDadosNOME: TStringField;
    CDSDadosCLA: TStringField;
    CDSDadosSECAO: TIntegerField;
    CDSDadosEQUIPE: TIntegerField;
    CDSDadosLOGGED: TBooleanField;
    procedure CDSDadosNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    procedure AfterConstruction; override;
    { Public declarations }

  end;

var
  ObjectDaoLogin: TObjectDaoLogin;

implementation

{$R *.dfm}

{ TObjectDaoLogin }

procedure TObjectDaoLogin.AfterConstruction;
begin
  inherited;

end;

procedure TObjectDaoLogin.CDSDadosNewRecord(DataSet: TDataSet);
begin
  inherited;
  CDSDadosLOGGED.AsBoolean := False;
end;

initialization
  RegisterClass(TObjectDaoLogin);
end.
