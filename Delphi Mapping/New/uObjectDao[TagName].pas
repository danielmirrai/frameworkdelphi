unit uObjectDao[TagName];

interface

uses
  System.SysUtils, System.Classes, uObjectDao, Data.DB, Datasnap.DBClient;

type
  TObjectDao[TagName] = class(TObjectDao)
  private
    { Private declarations }

  public
    { Public declarations }
  end;
  
implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TObjectDao[TagName] }

initialization
  RegisterClass(TObjectDao[TagName]);


end.
