unit uObjectActionPais;

interface

uses
  uObjectAction, uObjectDaoPais, Classes, Forms, SysUtils, uConstantPais,
  uConstantUtils, uDMUtils, uObjectActionEstado;

type
  TObjectActionPais = Class(TObjectAction)
  public
    FObjectDaoPais: TObjectDaoPais;    
    FObjectActionEstado: TObjectActionEstado;
    procedure AfterConstruction; override;   
    procedure CreateObjectLookup; override;
  end;

implementation

procedure TObjectActionPais.AfterConstruction;
begin
  inherited;                      
  FObjectActionEstado := nil;
  FObjectDaoPais := GetObjectDao as TObjectDaoPais;
end;

procedure TObjectActionPais.CreateObjectLookup;
begin
  inherited;
  FObjectActionEstado := GetObjectActionLookup(TObjectActionEstado) as TObjectActionEstado;

end;

initialization

RegisterClass(TObjectActionPais);

end.
