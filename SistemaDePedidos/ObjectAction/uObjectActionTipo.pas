unit uObjectActionTipo;

interface

uses
  uObjectAction, uObjectDaoTipo, Classes, Forms, SysUtils, uConstantTipo,
  uConstantUtils, uDMUtils;

type
  TObjectActionTipo = Class(TObjectAction)
  public
    FObjectDaoTipo: TObjectDaoTipo;
    FObjectActionTipoPessoa: TObjectAction;
    procedure AfterConstruction; override;  
    procedure CreateObjectLookup; override;
  end;

implementation
   
uses uFactoryObject, uObjectActionTipoPessoa;

procedure TObjectActionTipo.AfterConstruction;
begin                        
  FObjectActionTipoPessoa := nil;
  inherited;
  FObjectDaoTipo := GetObjectDao as TObjectDaoTipo;
end;

procedure TObjectActionTipo.CreateObjectLookup;
begin
  inherited;
  FObjectActionTipoPessoa := GetObjectActionLookup(TObjectActionTipoPessoa) as TObjectActionTipoPessoa;
  
end;

initialization

RegisterClass(TObjectActionTipo);

end.
