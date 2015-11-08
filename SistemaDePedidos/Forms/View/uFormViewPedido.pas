unit uFormViewPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantPedido,
  Dialogs, uFormViewModel, uFormAddPedido, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls, Menus;

type
  TFormViewPedido = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddPedido: TFormAddPedido;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewPedido }

procedure TFormViewPedido.AfterConstruction;
begin
  inherited;
  FFormAddPedido := GetFormAddModel as TFormAddPedido;
end;

initialization

RegisterClass(TFormViewPedido);

end.
