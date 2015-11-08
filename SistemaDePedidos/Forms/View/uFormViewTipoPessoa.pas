unit uFormViewTipoPessoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantTipoPessoa,
  Dialogs, uFormViewModel, uFormAddTipoPessoa, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFormViewTipoPessoa = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddTipoPessoa: TFormAddTipoPessoa;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewTipoPessoa }

procedure TFormViewTipoPessoa.AfterConstruction;
begin
  inherited;
  FFormAddTipoPessoa := GetFormAddModel as TFormAddTipoPessoa;
end;

initialization

RegisterClass(TFormViewTipoPessoa);

end.
