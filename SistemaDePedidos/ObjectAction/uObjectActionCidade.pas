unit uObjectActionCidade;

interface

uses
  uObjectAction, uObjectDaoCidade, Classes, Forms, SysUtils, uConstantCidade,
  uConstantUtils, uDMUtils;

type
  TObjectActionCidade = Class(TObjectAction)
  public
    FObjectDaoCidade: TObjectDaoCidade;
    FObjectActionEstado: TObjectAction;
    procedure AfterConstruction; override;
    procedure CreateObjectLookup; override;
  end;

implementation

uses uFactoryObject, uObjectActionEstado;

procedure TObjectActionCidade.AfterConstruction;
begin                               
  FObjectActionEstado := nil;
  inherited;
  FObjectDaoCidade := GetObjectDao as TObjectDaoCidade;
end;

procedure TObjectActionCidade.CreateObjectLookup;
begin
  inherited;

  FObjectActionEstado := GetObjectActionLookup(TObjectActionEstado) as TObjectActionEstado;
end;

initialization

RegisterClass(TObjectActionCidade);

end.
