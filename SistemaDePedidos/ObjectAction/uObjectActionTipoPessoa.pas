unit uObjectActionTipoPessoa;

interface

uses
  uObjectAction, uObjectDaoTipoPessoa, Classes, Forms, SysUtils, uConstantTipoPessoa,
  uConstantUtils, uDMUtils, uObjectActionTipo;

type
  TObjectActionTipoPessoa = Class(TObjectAction)
  public
    FObjectDaoTipoPessoa: TObjectDaoTipoPessoa;  
    FObjectActionTipo: TObjectActionTipo;
    FObjectActionPessoa: TObjectAction;
    procedure AfterConstruction; override;   
    procedure CreateObjectLookup; override;
  end;

implementation
               
uses uFactoryObject, uObjectActionPessoa;

procedure TObjectActionTipoPessoa.AfterConstruction;
begin                        
  FObjectActionTipo := nil;
  FObjectActionPessoa := nil;
  inherited;
  FObjectDaoTipoPessoa := GetObjectDao as TObjectDaoTipoPessoa;
end;

procedure TObjectActionTipoPessoa.CreateObjectLookup;
begin
  inherited;

  FObjectActionTipo := GetObjectActionLookup(TObjectActionTipo) as TObjectActionTipo;
  FObjectActionPessoa := GetObjectActionLookup(TObjectActionPessoa) as TObjectActionPessoa;
end;

initialization

RegisterClass(TObjectActionTipoPessoa);

end.
