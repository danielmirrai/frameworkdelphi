unit uObjectActionSituacaoPedido;

interface

uses
  uObjectAction, uObjectDaoSituacaoPedido, Classes, Forms, SysUtils, uConstantSituacaoPedido,
  uConstantUtils, uDMUtils;

type
  TObjectActionSituacaoPedido = Class(TObjectAction)
  public
    FObjectDaoSituacaoPedido: TObjectDaoSituacaoPedido;     
    FObjectActionPedido: TObjectAction;   

    procedure AfterConstruction; override; 
    procedure CreateObjectLookup; override;
  end;

implementation

uses uObjectActionPedido;

procedure TObjectActionSituacaoPedido.AfterConstruction;
begin
  FObjectActionPedido := nil;
  inherited;
  FObjectDaoSituacaoPedido := GetObjectDao as TObjectDaoSituacaoPedido;
end;

procedure TObjectActionSituacaoPedido.CreateObjectLookup;
begin
  inherited;
  FObjectActionPedido := GetObjectActionLookup(TObjectActionPedido) as TObjectActionPedido;
  
end;

initialization

RegisterClass(TObjectActionSituacaoPedido);

end.
