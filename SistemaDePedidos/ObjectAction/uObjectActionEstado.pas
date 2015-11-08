unit uObjectActionEstado;

interface

uses
  uObjectAction, uObjectDaoEstado, Classes, Forms, SysUtils, uConstantEstado,
  uConstantUtils, uDMUtils, uObjectActionCidade;

type
  TObjectActionEstado = Class(TObjectAction)
  public
    FObjectDaoEstado: TObjectDaoEstado;   
    FObjectActionPais: TObjectAction;     
    FObjectActionCidade: TObjectActionCidade;
    procedure AfterConstruction; override;    
    procedure CreateObjectLookup; override;
  end;

implementation

uses uFactoryObject, uObjectActionPais;

procedure TObjectActionEstado.AfterConstruction;
begin                                       
  FObjectActionPais := nil;
  FObjectActionCidade := nil;
  inherited;
  FObjectDaoEstado := GetObjectDao as TObjectDaoEstado;
end;

procedure TObjectActionEstado.CreateObjectLookup;
begin
  inherited;
  FObjectActionCidade := GetObjectActionLookup(TObjectActionCidade) as TObjectActionCidade;
  FObjectActionPais := GetObjectActionLookup(TObjectActionPais) as TObjectActionPais;
end;

initialization

RegisterClass(TObjectActionEstado);

end.
