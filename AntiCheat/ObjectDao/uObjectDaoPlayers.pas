unit uObjectDaoPlayers;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  MidasLib,
  Dialogs, uObjectDao, DB, DBClient;

type
  TObjectDaoPlayers = class(TObjectDao)
    CDSDadosLOGIN: TStringField;
    CDSDadosCLA: TStringField;
    CDSDadosDATA_INICIO: TDateTimeField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}


initialization
  RegisterClass(TObjectDaoPlayers);
  
end.
