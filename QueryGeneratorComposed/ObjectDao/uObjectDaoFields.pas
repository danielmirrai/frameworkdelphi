unit uObjectDaoFields;

interface

uses
  uDMRTTI, SysUtils, Classes, uObjectDaoAplicacaoQuery, uObjectDao, DB, DBClient, FMTBcd, Provider, SqlExpr;

type
  TObjectDaoFields = class(TObjectDao)
    SQLDADOSTABLENAME: TStringField;
    SQLDADOSFIELDNAME: TStringField;
    SQLDADOSNULLFLAG: TStringField;
    SQLDADOSFIELDTYPE: TStringField;
    SQLDADOSDCFIELDTYPE: TStringField;
    CDSDadosTABLENAME: TStringField;
    CDSDadosFIELDNAME: TStringField;
    CDSDadosNULLFLAG: TStringField;
    CDSDadosFIELDTYPE: TStringField;
    CDSDadosDCFIELDTYPE: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;
  
implementation

{%CLASSGROUP 'Controls.TControl'}

{$R *.dfm}

{ TObjectDaoFields }

initialization
  DMRTTI.RegisterClass(TObjectDaoFields);


end.