unit uFormViewProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantProduto,
  Dialogs, uFormViewModel, uFormAddProduto, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFormViewProduto = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddProduto: TFormAddProduto;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewProduto }

procedure TFormViewProduto.AfterConstruction;
begin
  inherited;
  FFormAddProduto := GetFormAddModel as TFormAddProduto;
end;

initialization

RegisterClass(TFormViewProduto);

end.
