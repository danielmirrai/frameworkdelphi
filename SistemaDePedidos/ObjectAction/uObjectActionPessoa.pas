unit uObjectActionPessoa;

interface

uses
  uObjectAction, uObjectDaoPessoa, Classes, Forms, SysUtils, uConstantPessoa,
  uConstantUtils, uDMUtils, uObjectActionEndereco, uObjectActionTipoPessoa;

type
  TObjectActionPessoa = Class(TObjectAction)
  public
    FObjectDaoPessoa: TObjectDaoPessoa;
    FObjectActionEndereco: TObjectActionEndereco;  
    FObjectActionTipoPessoa: TObjectActionTipoPessoa;  
    procedure AfterConstruction; override;  
    procedure CreateObjectLookup; override;
  end;

implementation
                 
procedure TObjectActionPessoa.AfterConstruction;
begin
  FObjectActionEndereco := nil;       
  FObjectActionTipoPessoa := nil;
  inherited;
  FObjectDaoPessoa := GetObjectDao as TObjectDaoPessoa;
end;

procedure TObjectActionPessoa.CreateObjectLookup;
begin
  inherited;

  FObjectActionEndereco := GetObjectActionLookup(TObjectActionEndereco) as TObjectActionEndereco;
  FObjectActionTipoPessoa := GetObjectActionLookup(TObjectActionTipoPessoa) as TObjectActionTipoPessoa;
end;

initialization

RegisterClass(TObjectActionPessoa);

end.
