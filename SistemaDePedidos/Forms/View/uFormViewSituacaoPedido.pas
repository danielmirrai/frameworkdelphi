unit uFormViewSituacaoPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantSituacaoPedido,
  Dialogs, uFormViewModel, uFormAddSituacaoPedido, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFormViewSituacaoPedido = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddSituacaoPedido: TFormAddSituacaoPedido;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewSituacaoPedido }

procedure TFormViewSituacaoPedido.AfterConstruction;
begin
  inherited;
  FFormAddSituacaoPedido := GetFormAddModel as TFormAddSituacaoPedido;
end;

initialization

RegisterClass(TFormViewSituacaoPedido);

end.
