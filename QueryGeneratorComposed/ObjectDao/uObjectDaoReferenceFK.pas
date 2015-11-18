unit uObjectDaoReferenceFK;

interface

uses
  SysUtils, Classes, uObjectDao, DB, 
  uDMClasses, FMTBcd, Provider, SqlExpr, DBClient, uObjectDaoAplicacaoQuery;

type
  TObjectDaoReferenceFK = class(TObjectDao)
    SQLDADOSTABLEORIGEM: TStringField;
    SQLDADOSINDEXORIGEM: TStringField;
    SQLDADOSFIELDNAMEORIGEM: TStringField;
    SQLDADOSTABLEREFERENCE: TStringField;
    SQLDADOSINDEXREFERENCE: TStringField;
    SQLDADOSFIELDNAMEREFERENCE: TStringField;
    SQLDADOSCONSTRAINT_TYPE: TStringField;
    CDSDadosTABLEORIGEM: TStringField;
    CDSDadosINDEXORIGEM: TStringField;
    CDSDadosFIELDNAMEORIGEM: TStringField;
    CDSDadosTABLEREFERENCE: TStringField;
    CDSDadosINDEXREFERENCE: TStringField;
    CDSDadosFIELDNAMEREFERENCE: TStringField;
    CDSDadosCONSTRAINT_TYPE: TStringField;
  private
    { Private declarations }

  public
    { Public declarations }
  end;
  
implementation

{%CLASSGROUP 'Controls.TControl'}

{$R *.dfm}

{ TObjectDaoReferenceFK }

initialization
  DMClasses.RegisterClass(TObjectDaoReferenceFK);


end.