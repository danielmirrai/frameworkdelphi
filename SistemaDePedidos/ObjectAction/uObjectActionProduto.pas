unit uObjectActionProduto;

interface

uses
  uObjectAction, uObjectDaoProduto, Classes, Forms, SysUtils, uConstantProduto,
  uConstantUtils, uDMUtils, uObjectActionPessoa;

type
  TObjectActionProduto = Class(TObjectAction)
  public
    FObjectDaoProduto: TObjectDaoProduto;
    FObjectActionEmpresa: TObjectActionPessoa;   
    FObjectActionItemPedido: TObjectAction;
    procedure AfterConstruction; override;
    procedure CreateObjectLookup; override;
  end;

implementation

uses uObjectActionItemPedido;

procedure TObjectActionProduto.AfterConstruction;
begin                 
  FObjectActionEmpresa := nil;   
  FObjectActionItemPedido := nil;
  inherited;
  FObjectDaoProduto := GetObjectDao as TObjectDaoProduto;
end;

procedure TObjectActionProduto.CreateObjectLookup;
begin
  inherited;
  FObjectActionEmpresa := GetObjectActionLookup(TObjectActionPessoa) as TObjectActionPessoa;
  FObjectActionItemPedido := GetObjectActionLookup(TObjectActionItemPedido) as TObjectActionItemPedido;
end;

initialization

RegisterClass(TObjectActionProduto);

end.
