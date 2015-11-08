unit uObjectActionEndereco;

interface

uses
  uObjectAction, uObjectDaoEndereco, Classes, Forms, SysUtils, uConstantEndereco,
  uConstantUtils, uDMUtils, uObjectActionCidade;

type
  TObjectActionEndereco = Class(TObjectAction)
  public
    FObjectDaoEndereco: TObjectDaoEndereco;
    FObjectActionCidade: TObjectActionCidade;    
    FObjectActionPessoa: TObjectAction;
    procedure AfterConstruction; override;    
    procedure CreateObjectLookup; override;
  end;

implementation

uses uObjectActionPessoa;

procedure TObjectActionEndereco.AfterConstruction;
begin                     
  FObjectActionCidade := nil;        
  FObjectActionPessoa := nil;
  inherited;                   
  FObjectDaoEndereco := GetObjectDao as TObjectDaoEndereco;
end;

procedure TObjectActionEndereco.CreateObjectLookup;
begin
  inherited;
  FObjectActionCidade := GetObjectActionLookup(TObjectActionCidade) as TObjectActionCidade;
  FObjectActionPessoa := GetObjectActionLookup(TObjectActionPessoa) as TObjectActionPessoa;
end;

initialization

RegisterClass(TObjectActionEndereco);

end.
