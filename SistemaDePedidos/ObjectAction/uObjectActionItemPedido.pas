unit uObjectActionItemPedido;

interface

uses
  uObjectAction, uObjectDaoItemPedido, Classes, Forms, SysUtils, uConstantItemPedido,
  uConstantUtils, uDMUtils, uObjectActionProduto;

type
  TObjectActionItemPedido = Class(TObjectAction)
  public
    FObjectDaoItemPedido: TObjectDaoItemPedido;

    FObjectActionPedido: TObjectAction;
    FObjectActionProduto: TObjectActionProduto;
    procedure AfterConstruction; override; 
    procedure CreateObjectLookup; override;
  end;

implementation

uses uObjectActionPedido;

procedure TObjectActionItemPedido.AfterConstruction;
begin         
  FObjectActionPedido := nil;
  FObjectActionProduto := nil;
  inherited;
  FObjectDaoItemPedido := GetObjectDao as TObjectDaoItemPedido;
end;

procedure TObjectActionItemPedido.CreateObjectLookup;
begin
  inherited;

  FObjectActionPedido := GetObjectActionLookup(TObjectActionPedido) as TObjectActionPedido;
  FObjectActionProduto := GetObjectActionLookup(TObjectActionProduto) as TObjectActionProduto;
end;

initialization

RegisterClass(TObjectActionItemPedido);

end.
