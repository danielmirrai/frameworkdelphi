unit uFormViewCidade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  uConstantCidade,
  Dialogs, uFormViewModel, uFormAddCidade, DB,  
  ActnList, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TFormViewCidade = class(TFormViewModel)
  public
    { Public declarations }
    FFormAddCidade: TFormAddCidade;
    procedure AfterConstruction; override;
  end;

implementation

{$R *.dfm}
{ TFormViewCidade }

procedure TFormViewCidade.AfterConstruction;
begin
  inherited;
  FFormAddCidade := GetFormAddModel as TFormAddCidade;
end;

initialization

RegisterClass(TFormViewCidade);

end.
