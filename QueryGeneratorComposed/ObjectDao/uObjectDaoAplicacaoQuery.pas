unit uObjectDaoAplicacaoQuery;

interface

uses
  SysUtils, Classes, uObjectDao, uObjectDaoApplication, DB, DBClient, FMTBcd, Provider, SqlExpr,
  uDMRTTI, DBXpress, ImgList, Controls;

type
  TObjectDaoAplicacaoQuery = class(TObjectDaoApplication)
  private
    { Private declarations }

  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Controls.TControl' }

{$R *.dfm}
{ TObjectDaoAplicacaoQuery }

initialization

DMRTTI.RegisterClass(TObjectDaoAplicacaoQuery);

end.