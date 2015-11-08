unit uObjectActionPedido;

interface

uses
  uObjectAction, uObjectDaoPedido, Classes, Forms, SysUtils, uConstantPedido,
  uConstantUtils, uDMUtils, uObjectActionPessoa, uObjectActionEndereco, uObjectActionSituacaoPedido,
  uObjectActionItemPedido;

type
  TObjectActionPedido = Class(TObjectAction)
  public
    FObjectDaoPedido: TObjectDaoPedido;

    FObjectActionEnderecoCliente: TObjectActionEndereco;
    FObjectActionSituacaoPedido: TObjectActionSituacaoPedido;    
    FObjectActionItemPedido: TObjectActionItemPedido;
    FObjectActionVendedor: TObjectActionPessoa;
    FObjectActionCliente: TObjectActionPessoa;
    FObjectActionEmpresa: TObjectActionPessoa;
    procedure AfterConstruction; override;     
    procedure CreateObjectLookup; override;
  end;

implementation

procedure TObjectActionPedido.AfterConstruction;
begin            
  FObjectActionCliente := nil;
  FObjectActionEnderecoCliente := nil; 
  FObjectActionVendedor := nil; 
  FObjectActionSituacaoPedido := nil; 
  FObjectActionEmpresa := nil; 
  FObjectActionItemPedido := nil;

  inherited;
  FObjectDaoPedido := GetObjectDao as TObjectDaoPedido;
end;

procedure TObjectActionPedido.CreateObjectLookup;
begin
  inherited;
  FObjectActionEnderecoCliente := GetObjectActionLookup(TObjectActionEndereco) as TObjectActionEndereco;
  FObjectActionSituacaoPedido := GetObjectActionLookup(TObjectActionSituacaoPedido) as TObjectActionSituacaoPedido;
  FObjectActionItemPedido := GetObjectActionLookup(TObjectActionItemPedido) as TObjectActionItemPedido;
 
  FObjectActionCliente := ListObjectActionChildren.Add(TObjectActionPessoa) as TObjectActionPessoa;
  FObjectActionVendedor := ListObjectActionChildren.Add(TObjectActionPessoa) as TObjectActionPessoa;
  FObjectActionEmpresa := ListObjectActionChildren.Add(TObjectActionPessoa) as TObjectActionPessoa;
end;

initialization

RegisterClass(TObjectActionPedido);

end.
