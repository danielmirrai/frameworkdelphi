unit uFormViewItemPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantItemPedido,
  Dialogs, uFormViewModel, uFormAddItemPedido, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls, Menus;

type
  TFormViewItemPedido = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddItemPedido: TFormAddItemPedido;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewItemPedido }

procedure TFormViewItemPedido.AfterConstruction;
begin
  inherited;
  FFormAddItemPedido := GetFormAddModel as TFormAddItemPedido;
end;

initialization

RegisterClass(TFormViewItemPedido);

end.
